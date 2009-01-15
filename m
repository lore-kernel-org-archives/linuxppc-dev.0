Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <32db977796782e4d132edb123a64b2437e5ea830.1232001793.git.michael@ellerman.id.au>
In-Reply-To: <e3520e2f9806d4f6e4b30587b6d29176e583833d.1232001793.git.michael@ellerman.id.au>
References: <e3520e2f9806d4f6e4b30587b6d29176e583833d.1232001793.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/4] powerpc: Remove printk-only progress implementations
Date: Thu, 15 Jan 2009 17:43:19 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Several platforms implement ppc_md.progress as a simple printk. Now that
we have the ppc_progress() wrapper which falls back to printk if no
routine is specified, we can remove all the printk-only progress
implementations.

This leaves us with iSeries_progress(), rtas_progress() and udbg_progress().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/celleb_setup.c |    7 -------
 arch/powerpc/platforms/cell/qpace_setup.c  |    6 ------
 arch/powerpc/platforms/cell/setup.c        |    6 ------
 arch/powerpc/platforms/maple/setup.c       |    7 -------
 arch/powerpc/platforms/pasemi/setup.c      |    7 -------
 arch/powerpc/platforms/ps3/setup.c         |    6 ------
 6 files changed, 0 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/platforms/cell/celleb_setup.c b/arch/powerpc/platforms/cell/celleb_setup.c
index 07c234f..5a5d9f3 100644
--- a/arch/powerpc/platforms/cell/celleb_setup.c
+++ b/arch/powerpc/platforms/cell/celleb_setup.c
@@ -87,11 +87,6 @@ static int __init celleb_machine_type_hack(char *ptr)
 
 __setup("celleb_machine_type_hack=", celleb_machine_type_hack);
 
-static void celleb_progress(char *s, unsigned short hex)
-{
-	printk("*** %04x : %s\n", hex, s ? s : "");
-}
-
 static void __init celleb_setup_arch_common(void)
 {
 	/* init to some ~sane value until calibrate_delay() runs */
@@ -213,7 +208,6 @@ define_machine(celleb_beat) {
 	.get_rtc_time		= beat_get_rtc_time,
 	.set_rtc_time		= beat_set_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= celleb_progress,
 	.power_save		= beat_power_save,
 	.nvram_size		= beat_nvram_get_size,
 	.nvram_read		= beat_nvram_read,
@@ -240,7 +234,6 @@ define_machine(celleb_native) {
 	.get_rtc_time		= rtas_get_rtc_time,
 	.set_rtc_time		= rtas_set_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= celleb_progress,
 	.pci_probe_mode 	= celleb_pci_probe_mode,
 	.pci_setup_phb		= celleb_setup_phb,
 	.init_IRQ		= celleb_init_IRQ_native,
diff --git a/arch/powerpc/platforms/cell/qpace_setup.c b/arch/powerpc/platforms/cell/qpace_setup.c
index be84e6a..6a37361 100644
--- a/arch/powerpc/platforms/cell/qpace_setup.c
+++ b/arch/powerpc/platforms/cell/qpace_setup.c
@@ -56,11 +56,6 @@ static void qpace_show_cpuinfo(struct seq_file *m)
 	of_node_put(root);
 }
 
-static void qpace_progress(char *s, unsigned short hex)
-{
-	printk("*** %04x : %s\n", hex, s ? s : "");
-}
-
 static int __init qpace_publish_devices(void)
 {
 	int node;
@@ -142,7 +137,6 @@ define_machine(qpace) {
 	.halt			= rtas_halt,
 	.get_boot_time		= rtas_get_boot_time,
 	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= qpace_progress,
 	.init_IRQ		= iic_init_IRQ,
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 5930536..ca2661e 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -76,11 +76,6 @@ static void cell_show_cpuinfo(struct seq_file *m)
 	of_node_put(root);
 }
 
-static void cell_progress(char *s, unsigned short hex)
-{
-	printk("*** %04x : %s\n", hex, s ? s : "");
-}
-
 static void cell_fixup_pcie_rootcomplex(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
@@ -285,7 +280,6 @@ define_machine(cell) {
 	.get_rtc_time		= rtas_get_rtc_time,
 	.set_rtc_time		= rtas_set_rtc_time,
 	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= cell_progress,
 	.init_IRQ       	= cell_init_irq,
 	.pci_setup_phb		= cell_setup_phb,
 };
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index bfd60e4..92f8eef 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -288,12 +288,6 @@ static void __init maple_init_IRQ(void)
 	of_node_put(root);
 }
 
-static void __init maple_progress(char *s, unsigned short hex)
-{
-	printk("*** %04x : %s\n", hex, s ? s : "");
-}
-
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -332,6 +326,5 @@ define_machine(maple) {
        	.set_rtc_time		= maple_set_rtc_time,
        	.get_rtc_time		= maple_get_rtc_time,
       	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= maple_progress,
 	.power_save		= power4_idle,
 };
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index c64fb5b..bcc1ac8 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -245,12 +245,6 @@ static __init void pas_init_IRQ(void)
 	of_node_put(root);
 }
 
-static void __init pas_progress(char *s, unsigned short hex)
-{
-	printk("[%04x] : %s\n", hex, s ? s : "");
-}
-
-
 static int pas_machine_check_handler(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
@@ -440,6 +434,5 @@ define_machine(pasemi) {
 	.restart		= pas_restart,
 	.get_boot_time		= pas_get_boot_time,
 	.calibrate_decr		= generic_calibrate_decr,
-	.progress		= pas_progress,
 	.machine_check_exception = pas_machine_check_handler,
 };
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index 35f3e85..5c4dc38 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -222,11 +222,6 @@ static void __init ps3_setup_arch(void)
 	DBG(" <- %s:%d\n", __func__, __LINE__);
 }
 
-static void __init ps3_progress(char *s, unsigned short hex)
-{
-	printk("*** %04x : %s\n", hex, s ? s : "");
-}
-
 static int __init ps3_probe(void)
 {
 	unsigned long htab_size;
@@ -274,7 +269,6 @@ define_machine(ps3) {
 	.get_rtc_time			= ps3_get_rtc_time,
 	.set_dabr			= ps3_set_dabr,
 	.calibrate_decr			= ps3_calibrate_decr,
-	.progress			= ps3_progress,
 	.restart			= ps3_restart,
 	.power_off			= ps3_power_off,
 	.halt				= ps3_halt,
-- 
1.5.5
