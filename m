Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 8B40067C3C
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 18:59:18 +1000 (EST)
Date: Sun, 8 Oct 2006 10:59:13 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Roy Zang <tie-fei.zang@freescale.com>, Paul Mackeras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] fix compile warnings in mpc7448_hpc2
Message-ID: <20061008085913.GA19422@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c: In function 'mpc7448_hpc2_fixup_irq':
arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c:114: warning: passing argument 1 of 'find_slot_by_devfn' discards qualifiers from pointer target type

make interrupt_map as const

make local functions static, which leads to:
arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c:264: warning: 'mpc7448_hpc2_halt' defined but not used
add currently unused halt and power_off functions to machdep.


Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -63,7 +63,7 @@ extern void _nmask_and_or_msr(unsigned l
 extern void tsi108_pci_int_init(void);
 extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
 
-int mpc7448_hpc2_exclude_device(u_char bus, u_char devfn)
+static int mpc7448_hpc2_exclude_device(u_char bus, u_char devfn)
 {
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -74,7 +74,7 @@ int mpc7448_hpc2_exclude_device(u_char b
 /*
  * find pci slot by devfn in interrupt map of OF tree
  */
-u8 find_slot_by_devfn(unsigned int *interrupt_map, unsigned int devfn)
+static u8 find_slot_by_devfn(const unsigned int *interrupt_map, unsigned int devfn)
 {
 	int i;
 	unsigned int tmp;
@@ -89,7 +89,7 @@ u8 find_slot_by_devfn(unsigned int *inte
 /*
  * Scans the interrupt map for pci device
  */
-void mpc7448_hpc2_fixup_irq(struct pci_dev *dev)
+static void mpc7448_hpc2_fixup_irq(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
 	struct device_node *node;
@@ -121,7 +121,7 @@ void mpc7448_hpc2_fixup_irq(struct pci_d
 }
 /* temporary pci irq map fixup*/
 
-void __init mpc7448_hpc2_pcibios_fixup(void)
+static void __init mpc7448_hpc2_pcibios_fixup(void)
 {
 	struct pci_dev *dev = NULL;
 	for_each_pci_dev(dev) {
@@ -238,13 +238,13 @@ static void __init mpc7448_hpc2_init_IRQ
 	of_node_put(tsi_pic);
 }
 
-void mpc7448_hpc2_show_cpuinfo(struct seq_file *m)
+static void mpc7448_hpc2_show_cpuinfo(struct seq_file *m)
 {
 	seq_printf(m, "vendor\t\t: Freescale Semiconductor\n");
 	seq_printf(m, "machine\t\t: MPC7448hpc2\n");
 }
 
-void mpc7448_hpc2_restart(char *cmd)
+static void mpc7448_hpc2_restart(char *cmd)
 {
 	local_irq_disable();
 
@@ -254,13 +254,13 @@ void mpc7448_hpc2_restart(char *cmd)
 	for (;;) ;		/* Spin until reset happens */
 }
 
-void mpc7448_hpc2_power_off(void)
+static void mpc7448_hpc2_power_off(void)
 {
 	local_irq_disable();
 	for (;;) ;		/* No way to shut power off with software */
 }
 
-void mpc7448_hpc2_halt(void)
+static void mpc7448_hpc2_halt(void)
 {
 	mpc7448_hpc2_power_off();
 }
@@ -302,6 +302,8 @@ define_machine(mpc7448_hpc2){
 	.get_irq 		= mpic_get_irq,
 	.pcibios_fixup 		= mpc7448_hpc2_pcibios_fixup,
 	.restart 		= mpc7448_hpc2_restart,
+	.power_off		= mpc7448_hpc2_power_off,
+	.halt			= mpc7448_hpc2_halt,
 	.calibrate_decr 	= generic_calibrate_decr,
 	.machine_check_exception= mpc7448_machine_check_exception,
 	.progress 		= udbg_progress,
