Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5035B67C0D
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 16:16:13 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id k9Q6G6rU031831
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 01:16:07 -0500
Subject: [PATCH] powerpc: Make pci_read_irq_line the default:
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 26 Oct 2006 16:16:05 +1000
Message-Id: <1161843365.5299.21.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch reworks the way IRQs are fixed up on PCI for arch powerpc.

It makes pci_read_irq_line() called by default in the PCI code for
devices that are probed, and add an optional per-device fixup in
ppc_md for platforms that really need to correct what they obtain
from pci_read_irq_line().

It also removes ppc_md.irq_bus_setup which was only used by pSeries
and should not be needed anymore.

I've also removed the pSeries s7a workaround as it can't work with
the current interrupt code anyway. I'm trying to get one of these
machines working so I can test a proper fix for that problem.

I also haven't updated the old-style fixup code from 85xx_cds.c
because it's actually buggy :) It assigns pci_dev->irq hard coded
numbers which is no good with the new IRQ mapping code. It should
at least use irq_create_mapping(NULL, hard_coded_number); and possibly
also set_irq_type() to set them as level low.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

The patch is only very lightly compile tested on a couple of platforms,
I would appreciate if Freescale folks could test on various 8xxx setups
to make sure I didn't break anything. Thanks !

BTW. The diffstat is cool :)

 arch/powerpc/kernel/pci_32.c                      |    9 ++++
 arch/powerpc/kernel/pci_64.c                      |    8 ++-
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |   13 ------
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |    3 -
 arch/powerpc/platforms/83xx/mpc834x_sys.c         |    3 -
 arch/powerpc/platforms/83xx/mpc83xx.h             |    1
 arch/powerpc/platforms/83xx/pci.c                 |    9 ----
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |   11 -----
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |   10 ----
 arch/powerpc/platforms/cell/setup.c               |    9 ----
 arch/powerpc/platforms/chrp/chrp.h                |    1
 arch/powerpc/platforms/chrp/pci.c                 |    9 ----
 arch/powerpc/platforms/chrp/setup.c               |    1
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   16 ++-----
 arch/powerpc/platforms/maple/maple.h              |    2
 arch/powerpc/platforms/maple/pci.c                |   45 ++++++++--------------
 arch/powerpc/platforms/maple/setup.c              |    2
 arch/powerpc/platforms/pasemi/pasemi.h            |    1
 arch/powerpc/platforms/pasemi/pci.c               |    8 ---
 arch/powerpc/platforms/pasemi/setup.c             |    1
 arch/powerpc/platforms/powermac/pci.c             |   35 ++++++-----------
 arch/powerpc/platforms/powermac/pmac.h            |    2
 arch/powerpc/platforms/powermac/setup.c           |    2
 arch/powerpc/platforms/pseries/pci.c              |   35 -----------------
 arch/powerpc/platforms/pseries/setup.c            |    1
 include/asm-powerpc/machdep.h                     |    2
 include/asm-powerpc/ppc-pci.h                     |    1
 27 files changed, 57 insertions(+), 183 deletions(-)


Index: linux-work/arch/powerpc/kernel/pci_32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2006-10-23 14:41:37.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci_32.c	2006-10-26 15:52:15.000000000 +1000
@@ -1338,6 +1338,7 @@ void __init pcibios_fixup_bus(struct pci
 	struct pci_controller *hose = (struct pci_controller *) bus->sysdata;
 	unsigned long io_offset;
 	struct resource *res;
+	struct pci_device *dev;
 	int i;
 
 	io_offset = (unsigned long)hose->io_base_virt - isa_io_base;
@@ -1390,8 +1391,16 @@ void __init pcibios_fixup_bus(struct pci
 		}
 	}
 
+	/* Platform specific bus fixups */
 	if (ppc_md.pcibios_fixup_bus)
 		ppc_md.pcibios_fixup_bus(bus);
+
+	/* Read default IRQs and fixup if necessary */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pci_read_irq_line(dev);
+		if (ppc_md.pci_irq_fixup)
+			ppc_md.pci_irq_fixup(dev);
+	}
 }
 
 char __init *pcibios_setup(char *str)
Index: linux-work/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/pci_64.c	2006-10-23 14:41:37.000000000 +1000
+++ linux-work/arch/powerpc/kernel/pci_64.c	2006-10-26 15:53:02.000000000 +1000
@@ -1223,8 +1223,12 @@ static void __devinit do_bus_setup(struc
 	list_for_each_entry(dev, &bus->devices, bus_list)
 		ppc_md.iommu_dev_setup(dev);
 
-	if (ppc_md.irq_bus_setup)
-		ppc_md.irq_bus_setup(bus);
+	/* Read default IRQs and fixup if necessary */
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pci_read_irq_line(dev);
+		if (ppc_md.pci_irq_fixup)
+			ppc_md.pci_irq_fixup(dev);
+	}
 }
 
 void __devinit pcibios_fixup_bus(struct pci_bus *bus)
Index: linux-work/arch/powerpc/platforms/pseries/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/pci.c	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pseries/pci.c	2006-10-26 15:53:31.000000000 +1000
@@ -29,8 +29,6 @@
 #include <asm/prom.h>
 #include <asm/ppc-pci.h>
 
-static int __devinitdata s7a_workaround = -1;
-
 #if 0
 void pcibios_name_device(struct pci_dev *dev)
 {
@@ -57,39 +55,6 @@ void pcibios_name_device(struct pci_dev 
 DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pcibios_name_device);
 #endif
 
-static void __devinit check_s7a(void)
-{
-	struct device_node *root;
-	const char *model;
-
-	s7a_workaround = 0;
-	root = of_find_node_by_path("/");
-	if (root) {
-		model = get_property(root, "model", NULL);
-		if (model && !strcmp(model, "IBM,7013-S7A"))
-			s7a_workaround = 1;
-		of_node_put(root);
-	}
-}
-
-void __devinit pSeries_irq_bus_setup(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	if (s7a_workaround < 0)
-		check_s7a();
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_read_irq_line(dev);
-		if (s7a_workaround) {
-			if (dev->irq > 16) {
-				dev->irq -= 3;
-				pci_write_config_byte(dev, PCI_INTERRUPT_LINE,
-					dev->irq);
-			}
-		}
-	}
-}
-
 static void __init pSeries_request_regions(void)
 {
 	if (!isa_io_base)
Index: linux-work/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pseries/setup.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pseries/setup.c	2006-10-26 15:53:59.000000000 +1000
@@ -553,7 +553,6 @@ define_machine(pseries) {
 	.log_error		= pSeries_log_error,
 	.pcibios_fixup		= pSeries_final_fixup,
 	.pci_probe_mode		= pSeries_pci_probe_mode,
-	.irq_bus_setup		= pSeries_irq_bus_setup,
 	.restart		= rtas_restart,
 	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
Index: linux-work/include/asm-powerpc/machdep.h
===================================================================
--- linux-work.orig/include/asm-powerpc/machdep.h	2006-10-09 12:03:34.000000000 +1000
+++ linux-work/include/asm-powerpc/machdep.h	2006-10-26 15:54:34.000000000 +1000
@@ -86,7 +86,6 @@ struct machdep_calls {
 	void		(*tce_flush)(struct iommu_table *tbl);
 	void		(*iommu_dev_setup)(struct pci_dev *dev);
 	void		(*iommu_bus_setup)(struct pci_bus *bus);
-	void		(*irq_bus_setup)(struct pci_bus *bus);
 #endif /* CONFIG_PPC64 */
 
 	int		(*probe)(void);
@@ -106,6 +105,7 @@ struct machdep_calls {
 	/* Called after scanning the bus, before allocating resources */
 	void		(*pcibios_fixup)(void);
 	int		(*pci_probe_mode)(struct pci_bus *);
+	void		(*pci_irq_fixup)(struct pci_dev *dev);
 
 	void		(*restart)(char *cmd);
 	void		(*power_off)(void);
Index: linux-work/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-work.orig/include/asm-powerpc/ppc-pci.h	2006-10-06 13:48:24.000000000 +1000
+++ linux-work/include/asm-powerpc/ppc-pci.h	2006-10-26 15:54:53.000000000 +1000
@@ -47,7 +47,6 @@ unsigned long get_phb_buid (struct devic
 
 /* From pSeries_pci.h */
 extern void pSeries_final_fixup(void);
-extern void pSeries_irq_bus_setup(struct pci_bus *bus);
 
 extern unsigned long pci_probe_only;
 
Index: linux-work/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/setup.c	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/setup.c	2006-10-26 15:55:21.000000000 +1000
@@ -80,14 +80,6 @@ static void cell_progress(char *s, unsig
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
-static void __init cell_pcibios_fixup(void)
-{
-	struct pci_dev *dev = NULL;
-
-	for_each_pci_dev(dev)
-		pci_read_irq_line(dev);
-}
-
 static void __init cell_init_irq(void)
 {
 	iic_init_IRQ();
@@ -180,7 +172,6 @@ define_machine(cell) {
 	.check_legacy_ioport	= cell_check_legacy_ioport,
 	.progress		= cell_progress,
 	.init_IRQ       	= cell_init_irq,
-	.pcibios_fixup		= cell_pcibios_fixup,
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
Index: linux-work/arch/powerpc/platforms/maple/maple.h
===================================================================
--- linux-work.orig/arch/powerpc/platforms/maple/maple.h	2006-01-14 14:43:22.000000000 +1100
+++ linux-work/arch/powerpc/platforms/maple/maple.h	2006-10-26 15:52:15.000000000 +1000
@@ -8,5 +8,5 @@ extern void maple_get_rtc_time(struct rt
 extern unsigned long maple_get_boot_time(void);
 extern void maple_calibrate_decr(void);
 extern void maple_pci_init(void);
-extern void maple_pcibios_fixup(void);
+extern void maple_pci_irq_fixup(struct pci_dev *dev);
 extern int maple_pci_get_legacy_ide_irq(struct pci_dev *dev, int channel);
Index: linux-work/arch/powerpc/platforms/maple/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/maple/pci.c	2006-10-13 17:23:48.000000000 +1000
+++ linux-work/arch/powerpc/platforms/maple/pci.c	2006-10-26 15:52:15.000000000 +1000
@@ -502,38 +502,29 @@ static int __init add_bridge(struct devi
 }
 
 
-void __init maple_pcibios_fixup(void)
+void __devinit maple_pci_irq_fixup(struct pci_dev *dev)
 {
-	struct pci_dev *dev = NULL;
+	DBG(" -> maple_pci_irq_fixup\n");
 
-	DBG(" -> maple_pcibios_fixup\n");
-
-	for_each_pci_dev(dev) {
-		/* Fixup IRQ for PCIe host */
-		if (u4_pcie != NULL && dev->bus->number == 0 &&
-		    pci_bus_to_host(dev->bus) == u4_pcie) {
-			printk(KERN_DEBUG "Fixup U4 PCIe IRQ\n");
-			dev->irq = irq_create_mapping(NULL, 1);
-			if (dev->irq != NO_IRQ)
-				set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
-			continue;
-		}
-
-		/* Hide AMD8111 IDE interrupt when in legacy mode so
-		 * the driver calls pci_get_legacy_ide_irq()
-		 */
-		if (dev->vendor == PCI_VENDOR_ID_AMD &&
-		    dev->device == PCI_DEVICE_ID_AMD_8111_IDE &&
-		    (dev->class & 5) != 5) {
-			dev->irq = NO_IRQ;
-			continue;
-		}
+	/* Fixup IRQ for PCIe host */
+	if (u4_pcie != NULL && dev->bus->number == 0 &&
+	    pci_bus_to_host(dev->bus) == u4_pcie) {
+		printk(KERN_DEBUG "Fixup U4 PCIe IRQ\n");
+		dev->irq = irq_create_mapping(NULL, 1);
+		if (dev->irq != NO_IRQ)
+			set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
+	}
 
-		/* For all others, map the interrupt from the device-tree */
-		pci_read_irq_line(dev);
+	/* Hide AMD8111 IDE interrupt when in legacy mode so
+	 * the driver calls pci_get_legacy_ide_irq()
+	 */
+	if (dev->vendor == PCI_VENDOR_ID_AMD &&
+	    dev->device == PCI_DEVICE_ID_AMD_8111_IDE &&
+	    (dev->class & 5) != 5) {
+		dev->irq = NO_IRQ;
 	}
 
-	DBG(" <- maple_pcibios_fixup\n");
+	DBG(" <- maple_pci_irq_fixup\n");
 }
 
 static void __init maple_fixup_phb_resources(void)
Index: linux-work/arch/powerpc/platforms/maple/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/maple/setup.c	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/maple/setup.c	2006-10-26 15:52:15.000000000 +1000
@@ -312,7 +312,7 @@ define_machine(maple_md) {
 	.setup_arch		= maple_setup_arch,
 	.init_early		= maple_init_early,
 	.init_IRQ		= maple_init_IRQ,
-	.pcibios_fixup		= maple_pcibios_fixup,
+	.pci_irq_fixup		= maple_pci_irq_fixup,
 	.pci_get_legacy_ide_irq	= maple_pci_get_legacy_ide_irq,
 	.restart		= maple_restart,
 	.power_off		= maple_power_off,
Index: linux-work/arch/powerpc/platforms/powermac/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pci.c	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/pci.c	2006-10-26 15:52:15.000000000 +1000
@@ -985,30 +985,23 @@ static int __init add_bridge(struct devi
 	return 0;
 }
 
-void __init pmac_pcibios_fixup(void)
+void __devinit pmac_pci_irq_fixup(struct pci_dev *dev)
 {
-	struct pci_dev* dev = NULL;
-
-	for_each_pci_dev(dev) {
-		/* Read interrupt from the device-tree */
-		pci_read_irq_line(dev);
-
 #ifdef CONFIG_PPC32
-		/* Fixup interrupt for the modem/ethernet combo controller.
-		 * on machines with a second ohare chip.
-		 * The number in the device tree (27) is bogus (correct for
-		 * the ethernet-only board but not the combo ethernet/modem
-		 * board). The real interrupt is 28 on the second controller
-		 * -> 28+32 = 60.
-		 */
-		if (has_second_ohare &&
-		    dev->vendor == PCI_VENDOR_ID_DEC &&
-		    dev->device == PCI_DEVICE_ID_DEC_TULIP_PLUS) {
-			dev->irq = irq_create_mapping(NULL, 60);
-			set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
-		}
-#endif /* CONFIG_PPC32 */
+	/* Fixup interrupt for the modem/ethernet combo controller.
+	 * on machines with a second ohare chip.
+	 * The number in the device tree (27) is bogus (correct for
+	 * the ethernet-only board but not the combo ethernet/modem
+	 * board). The real interrupt is 28 on the second controller
+	 * -> 28+32 = 60.
+	 */
+	if (has_second_ohare &&
+	    dev->vendor == PCI_VENDOR_ID_DEC &&
+	    dev->device == PCI_DEVICE_ID_DEC_TULIP_PLUS) {
+		dev->irq = irq_create_mapping(NULL, 60);
+		set_irq_type(dev->irq, IRQ_TYPE_LEVEL_LOW);
 	}
+#endif /* CONFIG_PPC32 */
 }
 
 #ifdef CONFIG_PPC64
Index: linux-work/arch/powerpc/platforms/powermac/pmac.h
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pmac.h	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/pmac.h	2006-10-26 15:52:15.000000000 +1000
@@ -20,7 +20,7 @@ extern void pmac_get_rtc_time(struct rtc
 extern int pmac_set_rtc_time(struct rtc_time *);
 extern void pmac_read_rtc_time(void);
 extern void pmac_calibrate_decr(void);
-extern void pmac_pcibios_fixup(void);
+extern void pmac_pci_irq_fixup(struct pci_dev *);
 extern void pmac_pci_init(void);
 extern unsigned long pmac_ide_get_base(int index);
 extern void pmac_ide_init_hwif_ports(hw_regs_t *hw,
Index: linux-work/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/setup.c	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/setup.c	2006-10-26 15:52:15.000000000 +1000
@@ -727,7 +727,7 @@ define_machine(powermac) {
 	.show_cpuinfo		= pmac_show_cpuinfo,
 	.init_IRQ		= pmac_pic_init,
 	.get_irq		= NULL,	/* changed later */
-	.pcibios_fixup		= pmac_pcibios_fixup,
+	.pci_irq_fixup		= pmac_pci_irq_fixup,
 	.restart		= pmac_restart,
 	.power_off		= pmac_power_off,
 	.halt			= pmac_halt,
Index: linux-work/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-work/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c	2006-10-26 15:52:15.000000000 +1000
@@ -89,7 +89,7 @@ u8 find_slot_by_devfn(unsigned int *inte
 /*
  * Scans the interrupt map for pci device
  */
-void mpc7448_hpc2_fixup_irq(struct pci_dev *dev)
+void __devinit mpc7448_hpc2_fixup_irq(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
 	struct device_node *node;
@@ -117,19 +117,13 @@ void mpc7448_hpc2_fixup_irq(struct pci_d
 		pin = 1;
 	pin--;
 	dev->irq  = interrupt[slot*4*7 + pin*7 + 5];
+
+	pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
+
 	DBG("TSI_PCI: dev->irq = 0x%x\n", dev->irq);
 }
 /* temporary pci irq map fixup*/
 
-void __init mpc7448_hpc2_pcibios_fixup(void)
-{
-	struct pci_dev *dev = NULL;
-	for_each_pci_dev(dev) {
-		mpc7448_hpc2_fixup_irq(dev);
-		pci_write_config_byte(dev, PCI_INTERRUPT_LINE, dev->irq);
-	}
-}
-
 static void __init mpc7448_hpc2_setup_arch(void)
 {
 	struct device_node *cpu;
@@ -300,7 +294,7 @@ define_machine(mpc7448_hpc2){
 	.init_IRQ 		= mpc7448_hpc2_init_IRQ,
 	.show_cpuinfo 		= mpc7448_hpc2_show_cpuinfo,
 	.get_irq 		= mpic_get_irq,
-	.pcibios_fixup 		= mpc7448_hpc2_pcibios_fixup,
+	.pci_irq_fixup 		= mpc7448_hpc2_fixup_irq,
 	.restart 		= mpc7448_hpc2_restart,
 	.calibrate_decr 	= generic_calibrate_decr,
 	.machine_check_exception= mpc7448_machine_check_exception,
Index: linux-work/arch/powerpc/platforms/pasemi/pasemi.h
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pasemi/pasemi.h	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pasemi/pasemi.h	2006-10-26 15:52:15.000000000 +1000
@@ -3,6 +3,5 @@
 
 extern unsigned long pas_get_boot_time(void);
 extern void pas_pci_init(void);
-extern void pas_pcibios_fixup(void);
 
 #endif /* _PASEMI_PASEMI_H */
Index: linux-work/arch/powerpc/platforms/pasemi/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pasemi/pci.c	2006-10-11 11:48:41.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pasemi/pci.c	2006-10-26 15:52:15.000000000 +1000
@@ -148,14 +148,6 @@ static int __init add_bridge(struct devi
 }
 
 
-void __init pas_pcibios_fixup(void)
-{
-	struct pci_dev *dev = NULL;
-
-	for_each_pci_dev(dev)
-		pci_read_irq_line(dev);
-}
-
 static void __init pas_fixup_phb_resources(void)
 {
 	struct pci_controller *hose, *tmp;
Index: linux-work/arch/powerpc/platforms/pasemi/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/pasemi/setup.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-work/arch/powerpc/platforms/pasemi/setup.c	2006-10-26 15:52:15.000000000 +1000
@@ -176,7 +176,6 @@ define_machine(pas) {
 	.init_early		= pas_init_early,
 	.init_IRQ		= pas_init_IRQ,
 	.get_irq		= mpic_get_irq,
-	.pcibios_fixup		= pas_pcibios_fixup,
 	.restart		= pas_restart,
 	.power_off		= pas_power_off,
 	.halt			= pas_halt,
Index: linux-work/arch/powerpc/platforms/82xx/mpc82xx_ads.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/82xx/mpc82xx_ads.c	2006-10-11 11:48:41.000000000 +1000
+++ linux-work/arch/powerpc/platforms/82xx/mpc82xx_ads.c	2006-10-26 15:52:15.000000000 +1000
@@ -515,16 +515,6 @@ static int m82xx_pci_exclude_device(u_ch
 		return PCIBIOS_SUCCESSFUL;
 }
 
-static void
-__init mpc82xx_pcibios_fixup(void)
-{
-	struct pci_dev *dev = NULL;
-
-	for_each_pci_dev(dev) {
-		pci_read_irq_line(dev);
-	}
-}
-
 void __init add_bridge(struct device_node *np)
 {
 	int len;
@@ -597,9 +587,6 @@ static void __init mpc82xx_ads_setup_arc
 		add_bridge(np);
 
 	of_node_put(np);
-	ppc_md.pci_map_irq = NULL;
-	ppc_md.pcibios_fixup = mpc82xx_pcibios_fixup;
-	ppc_md.pcibios_fixup_bus = NULL;
 #endif
 
 #ifdef  CONFIG_ROOT_NFS
Index: linux-work/arch/powerpc/platforms/83xx/mpc834x_itx.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/83xx/mpc834x_itx.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-work/arch/powerpc/platforms/83xx/mpc834x_itx.c	2006-10-26 15:52:15.000000000 +1000
@@ -122,7 +122,4 @@ define_machine(mpc834x_itx) {
 	.time_init		= mpc83xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-#ifdef CONFIG_PCI
-	.pcibios_fixup		= mpc83xx_pcibios_fixup,
-#endif
 };
Index: linux-work/arch/powerpc/platforms/83xx/mpc834x_sys.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/83xx/mpc834x_sys.c	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/83xx/mpc834x_sys.c	2006-10-26 15:52:15.000000000 +1000
@@ -137,7 +137,4 @@ define_machine(mpc834x_sys) {
 	.time_init		= mpc83xx_time_init,
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
-#ifdef CONFIG_PCI
-	.pcibios_fixup		= mpc83xx_pcibios_fixup,
-#endif
 };
Index: linux-work/arch/powerpc/platforms/83xx/mpc83xx.h
===================================================================
--- linux-work.orig/arch/powerpc/platforms/83xx/mpc83xx.h	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/83xx/mpc83xx.h	2006-10-26 15:52:15.000000000 +1000
@@ -11,7 +11,6 @@
 
 extern int add_bridge(struct device_node *dev);
 extern int mpc83xx_exclude_device(u_char bus, u_char devfn);
-extern void mpc83xx_pcibios_fixup(void);
 extern void mpc83xx_restart(char *cmd);
 extern long mpc83xx_time_init(void);
 
Index: linux-work/arch/powerpc/platforms/83xx/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/83xx/pci.c	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/83xx/pci.c	2006-10-26 15:52:15.000000000 +1000
@@ -45,15 +45,6 @@ int mpc83xx_exclude_device(u_char bus, u
 	return PCIBIOS_SUCCESSFUL;
 }
 
-void __init mpc83xx_pcibios_fixup(void)
-{
-	struct pci_dev *dev = NULL;
-
-	/* map all the PCI irqs */
-	for_each_pci_dev(dev)
-		pci_read_irq_line(dev);
-}
-
 int __init add_bridge(struct device_node *dev)
 {
 	int len;
Index: linux-work/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-work/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c	2006-10-26 15:52:15.000000000 +1000
@@ -398,15 +398,6 @@ mpc86xx_hpcn_show_cpuinfo(struct seq_fil
 }
 
 
-void __init mpc86xx_hpcn_pcibios_fixup(void)
-{
-	struct pci_dev *dev = NULL;
-
-	for_each_pci_dev(dev)
-		pci_read_irq_line(dev);
-}
-
-
 /*
  * Called very early, device-tree isn't unflattened
  */
@@ -461,7 +452,6 @@ define_machine(mpc86xx_hpcn) {
 	.setup_arch		= mpc86xx_hpcn_setup_arch,
 	.init_IRQ		= mpc86xx_hpcn_init_irq,
 	.show_cpuinfo		= mpc86xx_hpcn_show_cpuinfo,
-	.pcibios_fixup		= mpc86xx_hpcn_pcibios_fixup,
 	.get_irq		= mpic_get_irq,
 	.restart		= mpc86xx_restart,
 	.time_init		= mpc86xx_time_init,
Index: linux-work/arch/powerpc/platforms/chrp/chrp.h
===================================================================
--- linux-work.orig/arch/powerpc/platforms/chrp/chrp.h	2006-09-08 17:17:10.000000000 +1000
+++ linux-work/arch/powerpc/platforms/chrp/chrp.h	2006-10-26 15:52:15.000000000 +1000
@@ -9,4 +9,3 @@ extern long chrp_time_init(void);
 
 extern void chrp_find_bridges(void);
 extern void chrp_event_scan(unsigned long);
-extern void chrp_pcibios_fixup(void);
Index: linux-work/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/chrp/setup.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-work/arch/powerpc/platforms/chrp/setup.c	2006-10-26 15:52:15.000000000 +1000
@@ -598,7 +598,6 @@ define_machine(chrp) {
 	.init			= chrp_init2,
 	.show_cpuinfo		= chrp_show_cpuinfo,
 	.init_IRQ		= chrp_init_IRQ,
-	.pcibios_fixup		= chrp_pcibios_fixup,
 	.restart		= rtas_restart,
 	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
Index: linux-work/arch/powerpc/platforms/85xx/mpc85xx_ads.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/85xx/mpc85xx_ads.c	2006-10-09 12:03:33.000000000 +1000
+++ linux-work/arch/powerpc/platforms/85xx/mpc85xx_ads.c	2006-10-26 15:52:15.000000000 +1000
@@ -53,15 +53,6 @@ mpc85xx_exclude_device(u_char bus, u_cha
 	else
 		return PCIBIOS_SUCCESSFUL;
 }
-
-void __init
-mpc85xx_pcibios_fixup(void)
-{
-	struct pci_dev *dev = NULL;
-
-	for_each_pci_dev(dev)
-		pci_read_irq_line(dev);
-}
 #endif /* CONFIG_PCI */
 
 #ifdef CONFIG_CPM2
@@ -253,8 +244,6 @@ static void __init mpc85xx_ads_setup_arc
 #ifdef CONFIG_PCI
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		add_bridge(np);
-
-	ppc_md.pcibios_fixup = mpc85xx_pcibios_fixup;
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
Index: linux-work/arch/powerpc/platforms/chrp/pci.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/chrp/pci.c	2006-10-06 13:47:54.000000000 +1000
+++ linux-work/arch/powerpc/platforms/chrp/pci.c	2006-10-26 15:52:15.000000000 +1000
@@ -156,15 +156,6 @@ hydra_init(void)
 	return 1;
 }
 
-void __init
-chrp_pcibios_fixup(void)
-{
-	struct pci_dev *dev = NULL;
-
-	for_each_pci_dev(dev)
-		pci_read_irq_line(dev);
-}
-
 #define PRG_CL_RESET_VALID 0x00010000
 
 static void __init
