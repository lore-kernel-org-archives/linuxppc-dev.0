Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C853C67A6F
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jan 2005 16:49:22 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 16:48:57 +1100
Message-Id: <1106545738.5210.23.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Sven Luther <luther@gluck.debian.org>
Subject: [PATCH] ppc32: Add support for Pegasos machines
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

This patch, mostly from Sven Luther and reworked by me, adds support for
Pegasos machines to the ppc32 arch. The patch contains all of the arch
code. I'll send separately a few driver changes as well.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-work/arch/ppc/syslib/prom_init.c
===================================================================
--- linux-work.orig/arch/ppc/syslib/prom_init.c	2005-01-24 11:42:36.000000000 +1100
+++ linux-work/arch/ppc/syslib/prom_init.c	2005-01-24 15:45:43.000000000 +1100
@@ -810,6 +810,9 @@
 	char *p, *d;
  	unsigned long phys;
 	void *result[3];
+	char model[32];
+	phandle node;
+	int rc;
 
  	/* Default */
  	phys = (unsigned long) &_stext;
@@ -866,11 +869,20 @@
 
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
Index: linux-work/arch/ppc/platforms/chrp_pci.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/chrp_pci.c	2005-01-24 11:42:35.000000000 +1100
+++ linux-work/arch/ppc/platforms/chrp_pci.c	2005-01-24 15:52:23.000000000 +1100
@@ -97,8 +97,10 @@
 rtas_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		 int len, u32 *val)
 {
+	struct pci_controller *hose = bus->sysdata;
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
-		| ((bus->number & 0xff) << 16);
+		| (((bus->number - hose->first_busno) & 0xff) << 16)
+		| (hose->index << 24);
         unsigned long ret = ~0UL;
 	int rval;
 
@@ -111,8 +113,10 @@
 rtas_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 		  int len, u32 val)
 {
+	struct pci_controller *hose = bus->sysdata;
 	unsigned long addr = (offset & 0xff) | ((devfn & 0xff) << 8)
-		| ((bus->number & 0xff) << 16);
+		| (((bus->number - hose->first_busno) & 0xff) << 16)
+		| (hose->index << 24);
 	int rval;
 
 	rval = call_rtas("write-pci-config", 3, 1, NULL, addr, len, val);
@@ -186,6 +190,22 @@
 	iounmap(reg);
 }
 
+/* Marvell Discovery II based Pegasos 2 */
+static void __init setup_peg2(struct pci_controller *hose, struct device_node *dev)
+{
+	struct device_node *root = find_path_device("/");
+	struct device_node *rtas;
+
+	rtas = of_find_node_by_name (root, "rtas");
+	if (rtas) {
+		hose->ops = &rtas_pci_ops;
+	} else {
+		printk ("RTAS supporting Pegasos OF not found, please upgrade"
+			" your firmware\n");
+	}
+	pci_assign_all_busses = 1;
+}
+
 void __init
 chrp_find_bridges(void)
 {
@@ -195,7 +215,7 @@
 	struct pci_controller *hose;
 	unsigned int *dma;
 	char *model, *machine;
-	int is_longtrail = 0, is_mot = 0;
+	int is_longtrail = 0, is_mot = 0, is_pegasos = 0;
 	struct device_node *root = find_path_device("/");
 
 	/*
@@ -207,6 +227,10 @@
 	if (machine != NULL) {
 		is_longtrail = strncmp(machine, "IBM,LongTrail", 13) == 0;
 		is_mot = strncmp(machine, "MOT", 3) == 0;
+		if (strncmp(machine, "Pegasos2", 8) == 0)
+			is_pegasos = 2;
+		else if (strncmp(machine, "Pegasos", 7) == 0)
+			is_pegasos = 1;
 	}
 	for (dev = root->child; dev != NULL; dev = dev->sibling) {
 		if (dev->type == NULL || strcmp(dev->type, "pci") != 0)
@@ -257,6 +281,10 @@
 			hose->ops = &gg2_pci_ops;
 			hose->cfg_data = p;
 			gg2_pci_config_base = p;
+		} else if (is_pegasos == 1) {
+			setup_indirect_pci(hose, 0xfec00cf8, 0xfee00cfc);
+		} else if (is_pegasos == 2) {
+			setup_peg2(hose, dev);
 		} else {
 			printk("No methods for %s (model %s), using RTAS\n",
 			       dev->full_name, model);
@@ -275,5 +303,7 @@
 		}
 	}
 
-	ppc_md.pcibios_fixup = chrp_pcibios_fixup;
+	/* Do not fixup interrupts from OF tree on pegasos */
+	if (is_pegasos != 0)
+		ppc_md.pcibios_fixup = chrp_pcibios_fixup;
 }
Index: linux-work/arch/ppc/platforms/chrp_time.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/chrp_time.c	2005-01-24 11:42:35.000000000 +1100
+++ linux-work/arch/ppc/platforms/chrp_time.c	2005-01-24 15:43:37.000000000 +1100
@@ -41,6 +41,8 @@
 	int base;
 
 	rtcs = find_compatible_devices("rtc", "pnpPNP,b00");
+	if (rtcs == NULL)
+		rtcs = find_compatible_devices("rtc", "ds1385-rtc");
 	if (rtcs == NULL || rtcs->addrs == NULL)
 		return 0;
 	base = rtcs->addrs[0].address;
Index: linux-work/arch/ppc/platforms/chrp_setup.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/chrp_setup.c	2005-01-24 11:42:35.000000000 +1100
+++ linux-work/arch/ppc/platforms/chrp_setup.c	2005-01-24 16:01:01.000000000 +1100
@@ -37,6 +37,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
+#include <linux/module.h>
 
 #include <asm/io.h>
 #include <asm/pgtable.h>
@@ -68,6 +69,9 @@
 extern unsigned long pmac_find_end_of_memory(void);
 extern int of_show_percpuinfo(struct seq_file *, int);
 
+int _chrp_type;
+EXPORT_SYMBOL(_chrp_type);
+
 /*
  * XXX this should be in xmon.h, but putting it there means xmon.h
  * has to include <linux/interrupt.h> (to get irqreturn_t), which
@@ -214,8 +218,33 @@
 }
 
 
-void __init
-chrp_setup_arch(void)
+static void __init pegasos_set_l2cr(void)
+{
+	struct device_node *np;
+
+	/* On Pegasos, enable the l2 cache if needed, as the OF forgets it */
+	if (_chrp_type != _CHRP_Pegasos)
+		return;
+
+	/* Enable L2 cache if needed */
+	np = find_type_devices("cpu");
+	if (np != NULL) {
+		unsigned int *l2cr = (unsigned int *)
+			get_property (np, "l2cr", NULL);
+		if (l2cr == NULL) {
+			printk ("Pegasos l2cr : no cpu l2cr property found\n");
+			return;
+		}
+		if (!((*l2cr) & 0x80000000)) {
+			printk ("Pegasos l2cr : L2 cache was not active, "
+				"activating\n");
+			_set_L2CR(0);
+			_set_L2CR((*l2cr) | 0x80000000);
+		}
+	}
+}
+ 
+void __init chrp_setup_arch(void)
 {
 	struct device_node *device;
 
@@ -232,6 +261,9 @@
 #endif
 		ROOT_DEV = Root_SDA2; /* sda2 (sda1 is for the kernel) */
 
+	/* On pegasos, enable the L2 cache if not already done by OF */
+	pegasos_set_l2cr();
+
 	/* Lookup PCI host bridges */
 	chrp_find_bridges();
 
@@ -402,15 +434,17 @@
 
 	chrp_find_openpic();
 
-	prom_get_irq_senses(init_senses, NUM_8259_INTERRUPTS, NR_IRQS);
-	OpenPIC_InitSenses = init_senses;
-	OpenPIC_NumInitSenses = NR_IRQS - NUM_8259_INTERRUPTS;
-
-	openpic_init(NUM_8259_INTERRUPTS);
-	/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
-	openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
-			       i8259_irq);
+	if (OpenPIC_Addr) {
+		prom_get_irq_senses(init_senses, NUM_8259_INTERRUPTS, NR_IRQS);
+		OpenPIC_InitSenses = init_senses;
+		OpenPIC_NumInitSenses = NR_IRQS - NUM_8259_INTERRUPTS;
+
+		openpic_init(NUM_8259_INTERRUPTS);
+		/* We have a cascade on OpenPIC IRQ 0, Linux IRQ 16 */
+		openpic_hookup_cascade(NUM_8259_INTERRUPTS, "82c59 cascade",
+				       i8259_irq);
 
+	}
 	for (i = 0; i < NUM_8259_INTERRUPTS; i++)
 		irq_desc[i].handler = &i8259_pic;
 	i8259_init(chrp_int_ack);
@@ -450,6 +484,9 @@
 chrp_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	  unsigned long r6, unsigned long r7)
 {
+	struct device_node *root = find_path_device ("/");
+	char *machine = NULL;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* take care of initrd if we have one */
 	if ( r6 )
@@ -464,12 +501,29 @@
 	DMA_MODE_WRITE = 0x48;
 	isa_io_base = CHRP_ISA_IO_BASE;		/* default value */
 
+	if (root)
+		machine = get_property(root, "model", NULL);
+	if (machine && strncmp(machine, "Pegasos", 7) == 0) {
+		_chrp_type = _CHRP_Pegasos;
+	} else if (machine && strncmp(machine, "IBM", 3) == 0) {
+		_chrp_type = _CHRP_IBM;
+	} else if (machine && strncmp(machine, "MOT", 3) == 0) {
+		_chrp_type = _CHRP_Motorola;
+	} else {
+		/* Let's assume it is an IBM chrp if all else fails */
+		_chrp_type = _CHRP_IBM;
+	}
+
 	ppc_md.setup_arch     = chrp_setup_arch;
 	ppc_md.show_percpuinfo = of_show_percpuinfo;
 	ppc_md.show_cpuinfo   = chrp_show_cpuinfo;
+
 	ppc_md.irq_canonicalize = chrp_irq_canonicalize;
 	ppc_md.init_IRQ       = chrp_init_IRQ;
-	ppc_md.get_irq        = openpic_get_irq;
+	if (_chrp_type == _CHRP_Pegasos)
+		ppc_md.get_irq        = i8259_irq;
+	else
+		ppc_md.get_irq        = openpic_get_irq;
 
 	ppc_md.init           = chrp_init2;
 
Index: linux-work/include/asm-ppc/processor.h
===================================================================
--- linux-work.orig/include/asm-ppc/processor.h	2005-01-24 11:43:03.000000000 +1100
+++ linux-work/include/asm-ppc/processor.h	2005-01-24 15:39:17.000000000 +1100
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
