Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 41434B6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Apr 2011 15:47:32 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p3I5lQWT000804
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2011 00:47:27 -0500
Subject: [PATCH] powerpc/powermac: Build fix with SMP and CPU hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 18 Apr 2011 15:47:25 +1000
Message-ID: <1303105645.28876.153.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powermac/smp.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index a830c5e..bc5f0dc 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -842,6 +842,7 @@ static void __devinit smp_core99_setup_cpu(int cpu_nr)
 	mpic_setup_this_cpu();
 }
 
+#ifdef CONFIG_PPC64
 #ifdef CONFIG_HOTPLUG_CPU
 static int smp_core99_cpu_notify(struct notifier_block *self,
 				 unsigned long action, void *hcpu)
@@ -879,7 +880,6 @@ static struct notifier_block __cpuinitdata smp_core99_cpu_nb = {
 
 static void __init smp_core99_bringup_done(void)
 {
-#ifdef CONFIG_PPC64
 	extern void g5_phy_disable_cpu1(void);
 
 	/* Close i2c bus if it was used for tb sync */
@@ -894,14 +894,14 @@ static void __init smp_core99_bringup_done(void)
 		set_cpu_present(1, false);
 		g5_phy_disable_cpu1();
 	}
-#endif /* CONFIG_PPC64 */
-
 #ifdef CONFIG_HOTPLUG_CPU
 	register_cpu_notifier(&smp_core99_cpu_nb);
 #endif
+
 	if (ppc_md.progress)
 		ppc_md.progress("smp_core99_bringup_done", 0x349);
 }
+#endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_HOTPLUG_CPU
 
@@ -975,7 +975,9 @@ static void pmac_cpu_die(void)
 struct smp_ops_t core99_smp_ops = {
 	.message_pass	= smp_mpic_message_pass,
 	.probe		= smp_core99_probe,
+#ifdef CONFIG_PPC64
 	.bringup_done	= smp_core99_bringup_done,
+#endif
 	.kick_cpu	= smp_core99_kick_cpu,
 	.setup_cpu	= smp_core99_setup_cpu,
 	.give_timebase	= smp_core99_give_timebase,
