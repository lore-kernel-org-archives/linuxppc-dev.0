Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DE9E7B6EF7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2011 17:37:40 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id p286be9o009442
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:40 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p286beUM2416800
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:40 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p286bdEW005196
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2011 17:37:40 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 14/18] powerpc/pmac/smp: Fix CPU hotplug crashes on some
	machines
Date: Tue,  8 Mar 2011 17:37:26 +1100
Message-Id: <1299566250-10516-15-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some machines that use i2c to synchronize the timebases (such
as PowerMac7,2/7,3 G5 machines), hotplug CPU would crash when
putting back a new CPU online due to the underlying i2c bus being
closed.

This uses the newly added bringup_done() callback to move the close
along with other housekeeping calls, and adds a CPU notifier to
re-open the i2c bus around subsequent hotplug operations

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powermac/smp.c |   71 +++++++++++++++++++++++++-------
 1 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index 837989e..74a43c6 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -840,30 +840,68 @@ static void __devinit smp_core99_setup_cpu(int cpu_nr)
 
 	/* Setup openpic */
 	mpic_setup_this_cpu();
+}
 
-	if (cpu_nr == 0) {
-#ifdef CONFIG_PPC64
-		extern void g5_phy_disable_cpu1(void);
+#ifdef CONFIG_HOTPLUG_CPU
+static int smp_core99_cpu_notify(struct notifier_block *self,
+				 unsigned long action, void *hcpu)
+{
+	int rc;
 
-		/* Close i2c bus if it was used for tb sync */
+	switch(action) {
+	case CPU_UP_PREPARE:
+	case CPU_UP_PREPARE_FROZEN:
+		/* Open i2c bus if it was used for tb sync */
 		if (pmac_tb_clock_chip_host) {
-			pmac_i2c_close(pmac_tb_clock_chip_host);
-			pmac_tb_clock_chip_host	= NULL;
+			rc = pmac_i2c_open(pmac_tb_clock_chip_host, 1);
+			if (rc) {
+				pr_err("Failed to open i2c bus for time sync\n");
+				return notifier_from_errno(rc);
+			}
 		}
+		break;
+	case CPU_ONLINE:
+	case CPU_UP_CANCELED:
+		/* Close i2c bus if it was used for tb sync */
+		if (pmac_tb_clock_chip_host)
+			pmac_i2c_close(pmac_tb_clock_chip_host);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
 
-		/* If we didn't start the second CPU, we must take
-		 * it off the bus
-		 */
-		if (of_machine_is_compatible("MacRISC4") &&
-		    num_online_cpus() < 2)		
-			g5_phy_disable_cpu1();
-#endif /* CONFIG_PPC64 */
+static struct notifier_block __cpuinitdata smp_core99_cpu_nb = {
+	.notifier_call	= smp_core99_cpu_notify,
+};
+#endif /* CONFIG_HOTPLUG_CPU */
 
-		if (ppc_md.progress)
-			ppc_md.progress("core99_setup_cpu 0 done", 0x349);
+static void __init smp_core99_bringup_done(void)
+{
+#ifdef CONFIG_PPC64
+	extern void g5_phy_disable_cpu1(void);
+
+	/* Close i2c bus if it was used for tb sync */
+	if (pmac_tb_clock_chip_host)
+		pmac_i2c_close(pmac_tb_clock_chip_host);
+
+	/* If we didn't start the second CPU, we must take
+	 * it off the bus.
+	 */
+	if (of_machine_is_compatible("MacRISC4") &&
+	    num_online_cpus() < 2) {
+		set_cpu_present(1, false);
+		g5_phy_disable_cpu1();
 	}
-}
+#endif /* CONFIG_PPC64 */
 
+#ifdef CONFIG_HOTPLUG_CPU
+	register_cpu_notifier(&smp_core99_cpu_nb);
+#endif
+	if (ppc_md.progress)
+		ppc_md.progress("smp_core99_bringup_done", 0x349);
+}
 
 #ifdef CONFIG_HOTPLUG_CPU
 
@@ -940,6 +978,7 @@ static void pmac_cpu_die(void)
 struct smp_ops_t core99_smp_ops = {
 	.message_pass	= smp_mpic_message_pass,
 	.probe		= smp_core99_probe,
+	.bringup_done	= smp_core99_bringup_done,
 	.kick_cpu	= smp_core99_kick_cpu,
 	.setup_cpu	= smp_core99_setup_cpu,
 	.give_timebase	= smp_core99_give_timebase,
-- 
1.7.1
