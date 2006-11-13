Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6430E67D13
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 14:46:05 +1100 (EST)
Date: Mon, 13 Nov 2006 14:46:04 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iSeries: fix sysfs.c for combined build
Message-Id: <20061113144604.237d3862.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/sysfs.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index cda21a2..22123a0 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -200,10 +200,9 @@ static void register_cpu_online(unsigned
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 	struct sys_device *s = &c->sysdev;
 
-#ifndef CONFIG_PPC_ISERIES
-	if (cpu_has_feature(CPU_FTR_SMT))
+	if (!firmware_has_feature(FW_FEATURE_ISERIES) &&
+			cpu_has_feature(CPU_FTR_SMT))
 		sysdev_create_file(s, &attr_smt_snooze_delay);
-#endif
 
 	/* PMC stuff */
 
@@ -242,10 +241,9 @@ static void unregister_cpu_online(unsign
 
 	BUG_ON(c->no_control);
 
-#ifndef CONFIG_PPC_ISERIES
-	if (cpu_has_feature(CPU_FTR_SMT))
+	if (!firmware_has_feature(FW_FEATURE_ISERIES) &&
+			cpu_has_feature(CPU_FTR_SMT))
 		sysdev_remove_file(s, &attr_smt_snooze_delay);
-#endif
 
 	/* PMC stuff */
 
-- 
1.4.3.3
