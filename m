Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 495932BF18
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jan 2005 22:59:40 +1100 (EST)
Date: Sun, 9 Jan 2005 12:59:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050109115935.GA19249@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: status of pegasos2 support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys, could we please get some definit comments on the Pegasos2 support?

We've been carring it around forever in the Debian tree and it's been
making no progress at all.


#! /bin/sh -e 
##
## All lines beginning with `## DP:' are a description of the patch.
## DP: Description: Add Pegasos 1 and 2 support.
## DP: Patch author: Sven Luther <luther@debian.org>
## DP: Upstream status: submitted and approved.

. $(dirname $0)/DPATCH

@DPATCH@
diff -urN kernel-source-2.6.8.orig/arch/ppc/kernel/ppc_ksyms.c kernel-source-2.6.8/arch/ppc/kernel/ppc_ksyms.c
--- kernel-source-2.6.8.orig/arch/ppc/kernel/ppc_ksyms.c	2004-08-14 07:37:41.000000000 +0200
+++ kernel-source-2.6.8/arch/ppc/kernel/ppc_ksyms.c	2004-12-26 11:50:48.234758552 +0100
@@ -96,6 +96,9 @@
 EXPORT_SYMBOL(_prep_type);
 EXPORT_SYMBOL(ucSystemType);
 #endif
+#if defined(CONFIG_PPC_MULTIPLATFORM)
+EXPORT_SYMBOL(_chrp_type);
+#endif
 
 #if !defined(__INLINE_BITOPS)
 EXPORT_SYMBOL(set_bit);
diff -urN kernel-source-2.6.8.orig/arch/ppc/platforms/chrp_pci.c kernel-source-2.6.8/arch/ppc/platforms/chrp_pci.c
--- kernel-source-2.6.8.orig/arch/ppc/platforms/chrp_pci.c	2004-12-26 12:03:07.438382520 +0100
+++ kernel-source-2.6.8/arch/ppc/platforms/chrp_pci.c	2004-12-26 12:02:26.819557520 +0100
@@ -97,8 +97,9 @@
 rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		 int len, u32 *val)
 {
+	struct pci_controller *hose = bus->sysdata;
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
-		| ((bus->number & 0xff) << 16);
+		| (((bus->number - hose->first_busno) & 0xff) << 16) | (pci_domain_nr(bus) << 24);
         unsigned long ret = ~0UL;
 	int rval;
 
@@ -111,8 +112,9 @@
 rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		  int len, u32 val)
 {
+	struct pci_controller *hose = bus->sysdata;
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
-		| ((bus->number & 0xff) << 16);
+		| (((bus->number - hose->first_busno) & 0xff) << 16) | (pci_domain_nr(bus) << 24);
 	int rval;
 
 	rval = call_rtas("write-pci-config", 3, 1, NULL, addr, len, val);
@@ -186,6 +188,26 @@
 	iounmap(reg);
 }
 
+/* Marvell Discovery II based Pegasos 2 */
+//#define PEGASOS_USE_PCI_DOMAINS
+
+static void __init
+setup_peg2(struct pci_controller *hose, struct device_node *dev)
+{
+	struct device_node *root = find_path_device("/");
+	struct device_node *rtas;
+
+	rtas = of_find_node_by_name (root, "rtas");
+	if (rtas) {
+		hose->ops = &rtas_pci_ops;
+	} else {
+		printk ("RTAS supporting Pegasos OF not found, please upgrade your firmware\n");
+	}
+#ifndef PEGASOS_USE_PCI_DOMAINS
+	pci_assign_all_busses = 1;
+#endif
+}
+
 void __init
 chrp_find_bridges(void)
 {
@@ -195,7 +217,7 @@
 	struct pci_controller *hose;
 	unsigned int *dma;
 	char *model, *machine;
-	int is_longtrail = 0, is_mot = 0;
+	int is_longtrail = 0, is_mot = 0, is_pegasos = 0;
 	struct device_node *root = find_path_device("/");
 
 	/*
@@ -207,6 +229,8 @@
 	if (machine != NULL) {
 		is_longtrail = strncmp(machine, "IBM,LongTrail", 13) == 0;
 		is_mot = strncmp(machine, "MOT", 3) == 0;
+		if (strncmp(machine, "Pegasos2", 8) == 0) is_pegasos = 2;
+		else if (strncmp(machine, "Pegasos", 7) == 0) is_pegasos = 1;
 	}
 	for (dev = root->child; dev != NULL; dev = dev->sibling) {
 		if (dev->type == NULL || strcmp(dev->type, "pci") != 0)
@@ -257,6 +281,10 @@
 			hose->cfg_data = (unsigned char *)
 				ioremap(GG2_PCI_CONFIG_BASE, 0x80000);
 			gg2_pci_config_base = (unsigned long) hose->cfg_data;
+		} else if (is_pegasos == 1) {
+			setup_indirect_pci(hose, 0xfec00cf8, 0xfee00cfc);
+		} else if (is_pegasos == 2) {
+			setup_peg2(hose, dev);
 		} else {
 			printk("No methods for %s (model %s), using RTAS\n",
 			       dev->full_name, model);
@@ -274,6 +302,9 @@
 			printk("pci_dram_offset = %lx\n", pci_dram_offset);
 		}
 	}
-
-	ppc_md.pcibios_fixup = chrp_pcibios_fixup;
+	
+	if (is_pegasos)
+		ppc_md.pcibios_fixup = NULL;
+	else
+		ppc_md.pcibios_fixup = chrp_pcibios_fixup;
 }
diff -urN kernel-source-2.6.8.orig/arch/ppc/platforms/chrp_setup.c kernel-source-2.6.8/arch/ppc/platforms/chrp_setup.c
--- kernel-source-2.6.8.orig/arch/ppc/platforms/chrp_setup.c	2004-12-26 12:03:07.440382216 +0100
+++ kernel-source-2.6.8/arch/ppc/platforms/chrp_setup.c	2004-12-26 12:01:39.050819472 +0100
@@ -68,6 +68,8 @@
 extern unsigned long pmac_find_end_of_memory(void);
 extern int of_show_percpuinfo(struct seq_file *, int);
 
+int _chrp_type;
+
 /*
  * XXX this should be in xmon.h, but putting it there means xmon.h
  * has to include <linux/interrupt.h> (to get irqreturn_t), which
@@ -214,6 +216,36 @@
 	}
 }
 
+void pegasos_set_l2cr(void)
+{
+	struct device_node *root = find_path_device("/");
+	char *machine;
+	struct device_node *np;
+
+	/* On Pegasos, enable the l2 cache if needed, as the OF forgets it */
+	if (root == NULL)
+		return;
+	machine = get_property(root, "model", NULL);
+	if (machine == NULL)
+		return;
+	if (_chrp_type == _CHRP_Pegasos) {
+		/* Enable L2 cache if needed */
+		np = find_type_devices("cpu");
+		if (np != NULL) {
+			unsigned int *l2cr = (unsigned int *)
+				get_property (np, "l2cr", NULL);
+			if (l2cr == NULL) {
+				printk ("Pegasos l2cr : no cpu l2cr property found\n");
+				return;
+			}
+			if (!((*l2cr) & 0x80000000)) {
+				printk ("Pegasos l2cr : L2 cache was not active, activating\n");
+				_set_L2CR(0);
+				_set_L2CR((*l2cr) | 0x80000000);
+			}
+		}
+	}
+}
 
 void __init
 chrp_setup_arch(void)
@@ -236,6 +268,9 @@
 	/* Lookup PCI host bridges */
 	chrp_find_bridges();
 
+	/* On pegasos, enable the L2 cache if not already done by OF */
+	pegasos_set_l2cr();
+
 #ifndef CONFIG_PPC64BRIDGE
 	/*
 	 *  Temporary fixes for PCI devices.
@@ -400,16 +435,19 @@
 	if (np == NULL)
 		printk(KERN_ERR "Cannot find PCI interrupt acknowledge address\n");
 
-	chrp_find_openpic();
-
-	prom_get_irq_senses(init_senses, NUM_8259_INTERRUPTS, NR_IRQS);
-	OpenPIC_InitSenses = init_senses;
-	OpenPIC_NumInitSenses = NR_IRQS - NUM_8259_INTERRUPTS;
-
-	openpic_init(NUM_8259_INTERRUPTS);
-	/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
-	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
+	/* Pegasos doesn't have openpic */
+	if (_chrp_type != _CHRP_Pegasos) {
+		chrp_find_openpic();
+
+		prom_get_irq_senses(init_senses, NUM_8259_INTERRUPTS, NR_IRQS);
+		OpenPIC_InitSenses = init_senses;
+		OpenPIC_NumInitSenses = NR_IRQS - NUM_8259_INTERRUPTS;
+
+		openpic_init(NUM_8259_INTERRUPTS);
+		/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
+		openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
 			       i8259_irq);
+	}
 
 	for (i = 0; i < NUM_8259_INTERRUPTS; i++)
 		irq_desc[i].handler = &i8259_pic;
@@ -450,6 +488,8 @@
 chrp_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	  unsigned long r6, unsigned long r7)
 {
+	struct device_node *root = find_path_device ("/");
+	char *machine;
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* take care of initrd if we have one */
 	if ( r6 )
@@ -464,12 +504,27 @@
 	DMA_MODE_WRITE = 0x48;
 	isa_io_base = CHRP_ISA_IO_BASE;		/* default value */
 
+	machine = get_property(root, "model", NULL);
+	if (strncmp(machine, "Pegasos", 7) == 0) {
+		_chrp_type = _CHRP_Pegasos;
+	} else if (strncmp(machine, "IBM", 3) == 0) {
+		_chrp_type = _CHRP_IBM;
+	} else if (strncmp(machine, "MOT", 3) == 0) {
+		_chrp_type = _CHRP_Motorola;
+	} else {
+		/* Let's assume it is an IBM chrp if all else fails */
+		_chrp_type = _CHRP_IBM;
+	}
+	
 	ppc_md.setup_arch     = chrp_setup_arch;
 	ppc_md.show_percpuinfo = of_show_percpuinfo;
 	ppc_md.show_cpuinfo   = chrp_show_cpuinfo;
 	ppc_md.irq_canonicalize = chrp_irq_canonicalize;
 	ppc_md.init_IRQ       = chrp_init_IRQ;
-	ppc_md.get_irq        = openpic_get_irq;
+	if (_chrp_type == _CHRP_Pegasos)
+		ppc_md.get_irq        = i8259_irq;
+	else
+		ppc_md.get_irq        = openpic_get_irq;
 
 	ppc_md.init           = chrp_init2;
 
diff -urN kernel-source-2.6.8.orig/arch/ppc/platforms/chrp_time.c kernel-source-2.6.8/arch/ppc/platforms/chrp_time.c
--- kernel-source-2.6.8.orig/arch/ppc/platforms/chrp_time.c	2004-12-26 12:03:07.552365192 +0100
+++ kernel-source-2.6.8/arch/ppc/platforms/chrp_time.c	2004-11-24 22:47:24.000000000 +0100
@@ -41,6 +41,8 @@
 	int base;
 
 	rtcs = find_compatible_devices("rtc", "pnpPNP,b00");
+	if (rtcs == NULL)
+		rtcs = find_compatible_devices("rtc", "ds1385-rtc");
 	if (rtcs == NULL || rtcs->addrs == NULL)
 		return 0;
 	base = rtcs->addrs[0].address;
diff -urN kernel-source-2.6.8.orig/arch/ppc/syslib/prom_init.c kernel-source-2.6.8/arch/ppc/syslib/prom_init.c
--- kernel-source-2.6.8.orig/arch/ppc/syslib/prom_init.c	2004-12-26 12:03:07.672346952 +0100
+++ kernel-source-2.6.8/arch/ppc/syslib/prom_init.c	2004-12-26 11:58:49.597580280 +0100
@@ -794,6 +794,9 @@
 	char *p, *d;
  	unsigned long phys;
 	void *result[3];
+	char model[32];
+	phandle node;
+	int rc;
 
  	/* Default */
  	phys = (unsigned long) &_stext;
@@ -850,11 +853,20 @@
 
 	klimit = (char *) (mem - offset);
 
-	/* If we are already running at 0xc0000000, we assume we were
-	 * loaded by an OF bootloader which did set a BAT for us.
-	 * This breaks OF translate so we force phys to be 0.
-	 */
-	if (offset == 0) {
+	node = call_prom("finddevice", 1, 1, "/");
+	rc = call_prom("getprop", 4, 1, node, "model", model, sizeof(model));
+	if (rc > 0 && !strncmp (model, "Pegasos", 7)
+		&& strncmp (model, "Pegasos2", 8)) {
+		/* Pegasos 1 has a broken translate method in the OF,
+		 * and furthermore the BATs are mapped 1:1 so the phys
+		 * address calculated above is correct, so let's use
+		 * it directly.
+		 */
+	} else if (offset == 0) {
+		/* If we are already running at 0xc0000000, we assume we were
+	 	 * loaded by an OF bootloader which did set a BAT for us.
+	 	 * This breaks OF translate so we force phys to be 0.
+	 	 */
 		prom_print("(already at 0xc0000000) phys=0\n");
 		phys = 0;
 	} else if ((int) call_prom("getprop", 4, 1, prom_chosen, "mmu",
diff -urN kernel-source-2.6.8.orig/include/asm-ppc/processor.h kernel-source-2.6.8/include/asm-ppc/processor.h
--- kernel-source-2.6.8.orig/include/asm-ppc/processor.h	2004-08-14 07:36:11.000000000 +0200
+++ kernel-source-2.6.8/include/asm-ppc/processor.h	2004-12-26 13:50:25.909586120 +0100
@@ -34,6 +34,7 @@
 /* these are arbitrary */
 #define _CHRP_Motorola	0x04	/* motorola chrp, the cobra */
 #define _CHRP_IBM	0x05	/* IBM chrp, the longtrail and longtrail 2 */
+#define _CHRP_Pegasos	0x06	/* Genesi/bplan's Pegasos and Pegasos2 */
 
 #define _GLOBAL(n)\
 	.stabs __stringify(n:F-1),N_FUN,0,0,n;\
@@ -54,6 +55,7 @@
 
 /* what kind of prep workstation we are */
 extern int _prep_type;
+extern int _chrp_type;
 
 /*
  * This is used to identify the board type from a given PReP board
