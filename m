Return-Path: <mgreer@mvista.com>
Date: Mon, 3 Dec 2007 22:49:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 6/7] powerpc: Remove redundant power_off and halt routines
Message-ID: <20071204054911.GG27862@mag.az.mvista.com>
References: <20071204053736.GA27862@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071204053736.GA27862@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Remove platform-specific power_off and halt routines, and ppc_md
initializations that are not necessary.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/platforms/embedded6xx/holly.c        |   12 ------------
 arch/powerpc/platforms/embedded6xx/linkstation.c  |    7 -------
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   11 -----------
 arch/powerpc/platforms/iseries/setup.c            |    1 -
 arch/powerpc/platforms/maple/setup.c              |    6 ------
 arch/powerpc/platforms/powermac/setup.c           |    7 -------
 6 files changed, 44 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index b6de2b5..70cfd37 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -253,18 +253,6 @@ void holly_restart(char *cmd)
 	for (;;) ;
 }
 
-void holly_power_off(void)
-{
-	local_irq_disable();
-	/* No way to shut power off with software */
-	for (;;) ;
-}
-
-void holly_halt(void)
-{
-	holly_power_off();
-}
-
 /*
  * Called very early, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/embedded6xx/linkstation.c b/arch/powerpc/platforms/embedded6xx/linkstation.c
index 8792840..3382eef 100644
--- a/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ b/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -162,12 +162,6 @@ static void linkstation_power_off(void)
 	/* NOTREACHED */
 }
 
-static void linkstation_halt(void)
-{
-	linkstation_power_off();
-	/* NOTREACHED */
-}
-
 static void linkstation_show_cpuinfo(struct seq_file *m)
 {
 	seq_printf(m, "vendor\t\t: Buffalo Technology\n");
@@ -195,6 +189,5 @@ define_machine(linkstation){
 	.show_cpuinfo 		= linkstation_show_cpuinfo,
 	.get_irq 		= mpic_get_irq,
 	.restart 		= linkstation_restart,
-	.halt	 		= linkstation_halt,
 	.calibrate_decr 	= generic_calibrate_decr,
 };
diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index a2c04b9..557a6fe 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -179,17 +179,6 @@ void mpc7448_hpc2_restart(char *cmd)
 	for (;;) ;		/* Spin until reset happens */
 }
 
-void mpc7448_hpc2_power_off(void)
-{
-	local_irq_disable();
-	for (;;) ;		/* No way to shut power off with software */
-}
-
-void mpc7448_hpc2_halt(void)
-{
-	mpc7448_hpc2_power_off();
-}
-
 /*
  * Called very early, device-tree isn't unflattened
  */
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 362084e..0eabbc3 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -650,7 +650,6 @@ define_machine(iseries) {
 	.init_early	= iSeries_init_early,
 	.pcibios_fixup	= iSeries_pci_final_fixup,
 	.restart	= mf_reboot,
-	.halt		= mf_power_off,
 	.get_boot_time	= iSeries_get_boot_time,
 	.set_rtc_time	= iSeries_set_rtc_time,
 	.get_rtc_time	= iSeries_get_rtc_time,
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index d0eb901..ac5f99a 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -151,11 +151,6 @@ static void maple_power_off(void)
 	printk(KERN_EMERG "Maple: Manual Power-Down Required\n");
 }
 
-static void maple_halt(void)
-{
-	maple_power_off();
-}
-
 #ifdef CONFIG_SMP
 struct smp_ops_t maple_smp_ops = {
 	.probe		= smp_mpic_probe,
@@ -329,7 +324,6 @@ define_machine(maple_md) {
 	.pci_irq_fixup		= maple_pci_irq_fixup,
 	.pci_get_legacy_ide_irq	= maple_pci_get_legacy_ide_irq,
 	.restart		= maple_restart,
-	.halt			= maple_halt,
        	.get_boot_time		= maple_get_boot_time,
        	.set_rtc_time		= maple_set_rtc_time,
        	.get_rtc_time		= maple_get_rtc_time,
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 8429002..002b0b4 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -499,12 +499,6 @@ static void pmac_power_off(void)
 	}
 }
 
-static void
-pmac_halt(void)
-{
-	pmac_power_off();
-}
-
 /* 
  * Early initialization.
  */
@@ -677,7 +671,6 @@ define_machine(powermac) {
 	.get_irq		= NULL,	/* changed later */
 	.pci_irq_fixup		= pmac_pci_irq_fixup,
 	.restart		= pmac_restart,
-	.halt			= pmac_halt,
 	.time_init		= pmac_time_init,
 	.get_boot_time		= pmac_get_boot_time,
 	.set_rtc_time		= pmac_set_rtc_time,
