Return-Path: <R58495@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 161472C00B0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Sep 2012 09:44:45 +1000 (EST)
Received: from mail198-co1 (localhost [127.0.0.1])	by
 mail198-co1-R.bigfish.com (Postfix) with ESMTP id 5B52CD00074	for
 <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2012 23:44:39 +0000 (UTC)
Received: from CO1EHSMHS018.bigfish.com (unknown [10.243.78.254])	by
 mail198-co1.bigfish.com (Postfix) with ESMTP id 2EF261C005D	for
 <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Sep 2012 23:44:38 +0000 (UTC)
From: York Sun <yorksun@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/mpc85xx: Change spin table to cached memory
Date: Sat, 29 Sep 2012 16:44:35 -0700
Message-ID: <1348962275-24052-1-git-send-email-yorksun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, kumar.gala@freescale.com, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ePAPR v1.1 requires the spin table to be in cached memory. So we need
to change the call argument of ioremap to enable cache and coherence.
We also flush the cache after writing to spin table to keep it compatible
with previous cache-inhibit spin table. Flushing before and after
accessing spin table is recommended by ePAPR.

Signed-off-by: York Sun <yorksun@freescale.com>
Acked-by: Timur Tabi <timur@freescale.com>
---
This patch applies to git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next branch.

 arch/powerpc/platforms/85xx/smp.c |   49 +++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 6fcfa12..148c2f2 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -128,6 +128,19 @@ static void __cpuinit smp_85xx_mach_cpu_die(void)
 }
 #endif
 
+static inline void flush_spin_table(void *spin_table)
+{
+	flush_dcache_range((ulong)spin_table,
+		(ulong)spin_table + sizeof(struct epapr_spin_table));
+}
+
+static inline u32 read_spin_table_addr_l(void *spin_table)
+{
+	flush_dcache_range((ulong)spin_table,
+		(ulong)spin_table + sizeof(struct epapr_spin_table));
+	return in_be32(&((struct epapr_spin_table *)spin_table)->addr_l);
+}
+
 static int __cpuinit smp_85xx_kick_cpu(int nr)
 {
 	unsigned long flags;
@@ -161,8 +174,8 @@ static int __cpuinit smp_85xx_kick_cpu(int nr)
 
 	/* Map the spin table */
 	if (ioremappable)
-		spin_table = ioremap(*cpu_rel_addr,
-				sizeof(struct epapr_spin_table));
+		spin_table = ioremap_prot(*cpu_rel_addr,
+			sizeof(struct epapr_spin_table), _PAGE_COHERENT);
 	else
 		spin_table = phys_to_virt(*cpu_rel_addr);
 
@@ -173,7 +186,16 @@ static int __cpuinit smp_85xx_kick_cpu(int nr)
 	generic_set_cpu_up(nr);
 
 	if (system_state == SYSTEM_RUNNING) {
+		/*
+		 * To keep it compatible with old boot program which uses
+		 * cache-inhibit spin table, we need to flush the cache
+		 * before accessing spin table to invalidate any staled data.
+		 * We also need to flush the cache after writing to spin
+		 * table to push data out.
+		 */
+		flush_spin_table(spin_table);
 		out_be32(&spin_table->addr_l, 0);
+		flush_spin_table(spin_table);
 
 		/*
 		 * We don't set the BPTR register here since it already points
@@ -181,9 +203,14 @@ static int __cpuinit smp_85xx_kick_cpu(int nr)
 		 */
 		mpic_reset_core(hw_cpu);
 
-		/* wait until core is ready... */
-		if (!spin_event_timeout(in_be32(&spin_table->addr_l) == 1,
-						10000, 100)) {
+		/*
+		 * wait until core is ready...
+		 * We need to invalidate the stale data, in case the boot
+		 * loader uses a cache-inhibited spin table.
+		 */
+		if (!spin_event_timeout(
+				read_spin_table_addr_l(spin_table) == 1,
+				10000, 100)) {
 			pr_err("%s: timeout waiting for core %d to reset\n",
 							__func__, hw_cpu);
 			ret = -ENOENT;
@@ -194,12 +221,10 @@ static int __cpuinit smp_85xx_kick_cpu(int nr)
 		__secondary_hold_acknowledge = -1;
 	}
 #endif
+	flush_spin_table(spin_table);
 	out_be32(&spin_table->pir, hw_cpu);
 	out_be32(&spin_table->addr_l, __pa(__early_start));
-
-	if (!ioremappable)
-		flush_dcache_range((ulong)spin_table,
-			(ulong)spin_table + sizeof(struct epapr_spin_table));
+	flush_spin_table(spin_table);
 
 	/* Wait a bit for the CPU to ack. */
 	if (!spin_event_timeout(__secondary_hold_acknowledge == hw_cpu,
@@ -213,13 +238,11 @@ out:
 #else
 	smp_generic_kick_cpu(nr);
 
+	flush_spin_table(spin_table);
 	out_be32(&spin_table->pir, hw_cpu);
 	out_be64((u64 *)(&spin_table->addr_h),
 	  __pa((u64)*((unsigned long long *)generic_secondary_smp_init)));
-
-	if (!ioremappable)
-		flush_dcache_range((ulong)spin_table,
-			(ulong)spin_table + sizeof(struct epapr_spin_table));
+	flush_spin_table(spin_table);
 #endif
 
 	local_irq_restore(flags);
-- 
1.7.9.5
