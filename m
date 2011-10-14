Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A6A79B6F99
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 18:52:55 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p9E7qqsD015075
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 02:52:52 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Setup secondary cores PIR with hard SMP id
Date: Fri, 14 Oct 2011 02:52:51 -0500
Message-Id: <1318578771-16865-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Normally logical and hard cpu ID are the same, however in same cases like
on the P3060 they may differ.  Where the logical is 0..5, the hard id
goes 0,1,4..7.  This can causes issues for places we utilize PIR to index
into array like in debug exception handlers for finding the exception
stack.

Move to setting up PIR with hard_smp_processor_id fixes the issue.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/smp.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index d6e4746..190d111 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -48,10 +48,11 @@ smp_85xx_kick_cpu(int nr)
 	const u64 *cpu_rel_addr;
 	__iomem u32 *bptr_vaddr;
 	struct device_node *np;
-	int n = 0;
+	int n = 0, hw_cpu = get_hard_smp_processor_id(nr);
 	int ioremappable;
 
-	WARN_ON (nr < 0 || nr >= NR_CPUS);
+	WARN_ON(nr < 0 || nr >= NR_CPUS);
+	WARN_ON(hw_cpu < 0 || hw_cpu >= NR_CPUS);
 
 	pr_debug("smp_85xx_kick_cpu: kick CPU #%d\n", nr);
 
@@ -79,7 +80,7 @@ smp_85xx_kick_cpu(int nr)
 
 	local_irq_save(flags);
 
-	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, nr);
+	out_be32(bptr_vaddr + BOOT_ENTRY_PIR, hw_cpu);
 #ifdef CONFIG_PPC32
 	out_be32(bptr_vaddr + BOOT_ENTRY_ADDR_LOWER, __pa(__early_start));
 
@@ -88,7 +89,7 @@ smp_85xx_kick_cpu(int nr)
 				(ulong)(bptr_vaddr + SIZE_BOOT_ENTRY));
 
 	/* Wait a bit for the CPU to ack. */
-	while ((__secondary_hold_acknowledge != nr) && (++n < 1000))
+	while ((__secondary_hold_acknowledge != hw_cpu) && (++n < 1000))
 		mdelay(1);
 #else
 	smp_generic_kick_cpu(nr);
-- 
1.7.3.4
