Date: Wed, 30 Jun 2004 08:00:19 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Pegasos 2 support patch ...
Message-ID: <20040630060019.GA22053@pegasos>
References: <20040629165029.GA13468@pegasos> <20040629204230.GA15900@pegasos> <1088564249.1906.14.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <1088564249.1906.14.camel@gaston>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

On Tue, Jun 29, 2004 at 09:57:29PM -0500, Benjamin Herrenschmidt wrote:
>
> > Another solution would be to test before doing the translate call, maybe
> > this would be more elegant ?
>
> Yup, if you know it will be broken, don't bother calling it,
> and please, avoid the over-long line :)

Ok, this is then the final patch, i hope it is now correct.

The only part missing is the via82cxxx patch, where may i best find help
on how to best solve this ? I wrote the maintainer listed in the patch,
but never got a reply.

Friendly,

Sven Luther

--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="pegasos.diff"

diff -ur kernel-source-2.6.7.orig/arch/ppc/platforms/chrp_pci.c kernel-source-2.6.7.peg2/arch/ppc/platforms/chrp_pci.c
--- kernel-source-2.6.7.orig/arch/ppc/platforms/chrp_pci.c	2004-06-16 07:20:26.000000000 +0200
+++ kernel-source-2.6.7.peg2/arch/ppc/platforms/chrp_pci.c	2004-06-29 18:10:43.000000000 +0200
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
diff -ur kernel-source-2.6.7.orig/arch/ppc/platforms/chrp_setup.c kernel-source-2.6.7.peg2/arch/ppc/platforms/chrp_setup.c
--- kernel-source-2.6.7.orig/arch/ppc/platforms/chrp_setup.c	2004-06-16 07:19:52.000000000 +0200
+++ kernel-source-2.6.7.peg2/arch/ppc/platforms/chrp_setup.c	2004-06-29 18:10:44.000000000 +0200
@@ -214,6 +214,37 @@
 	}
 }

+void pegasos_set_l2cr(void)
+{
+	struct device_node *root = find_path_device("/");
+	char *machine;
+	struct device_node *np;
+	int l2cr_value;
+
+	/* On Pegasos, enable the l2 cache if needed, as the OF forgets it */
+	if (root == NULL)
+		return;
+	machine = get_property(root, "model", NULL);
+	if (machine == NULL)
+		return;
+	if (strncmp(machine, "Pegasos", 7) == 0) {
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
@@ -236,6 +267,9 @@
 	/* Lookup PCI host bridges */
 	chrp_find_bridges();

+	/* On pegasos, enable the L2 cache if not already done by OF */
+	pegasos_set_l2cr();
+
 #ifndef CONFIG_PPC64BRIDGE
 	/*
 	 *  Temporary fixes for PCI devices.
@@ -387,6 +421,8 @@
 #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(XMON)
 	struct device_node *kbd;
 #endif
+	struct device_node *root = find_path_device ("/");
+	char *machine;

 	for (np = find_devices("pci"); np != NULL; np = np->next) {
 		unsigned int *addrp = (unsigned int *)
@@ -400,16 +436,20 @@
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
+	machine = get_property(root, "model", NULL);
+	if (strncmp(machine, "Pegasos", 7) != 0) {
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
@@ -450,6 +490,8 @@
 chrp_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	  unsigned long r6, unsigned long r7)
 {
+	struct device_node *root = find_path_device ("/");
+	char *machine;
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* take care of initrd if we have one */
 	if ( r6 )
@@ -469,7 +511,11 @@
 	ppc_md.show_cpuinfo   = chrp_show_cpuinfo;
 	ppc_md.irq_canonicalize = chrp_irq_canonicalize;
 	ppc_md.init_IRQ       = chrp_init_IRQ;
-	ppc_md.get_irq        = openpic_get_irq;
+	machine = get_property(root, "model", NULL);
+	if (strncmp(machine, "Pegasos", 7) == 0)
+		ppc_md.get_irq        = i8259_irq;
+	else
+		ppc_md.get_irq        = openpic_get_irq;

 	ppc_md.init           = chrp_init2;

diff -ur kernel-source-2.6.7.orig/arch/ppc/platforms/chrp_time.c kernel-source-2.6.7.peg2/arch/ppc/platforms/chrp_time.c
--- kernel-source-2.6.7.orig/arch/ppc/platforms/chrp_time.c	2004-06-16 07:18:57.000000000 +0200
+++ kernel-source-2.6.7.peg2/arch/ppc/platforms/chrp_time.c	2004-06-29 18:10:44.000000000 +0200
@@ -41,6 +41,8 @@
 	int base;

 	rtcs = find_compatible_devices("rtc", "pnpPNP,b00");
+	if (rtcs == NULL)
+		rtcs = find_compatible_devices("rtc", "ds1385-rtc");
 	if (rtcs == NULL || rtcs->addrs == NULL)
 		return 0;
 	base = rtcs->addrs[0].address;
diff -ur kernel-source-2.6.7.orig/arch/ppc/syslib/prom_init.c kernel-source-2.6.7.peg2/arch/ppc/syslib/prom_init.c
--- kernel-source-2.6.7.orig/arch/ppc/syslib/prom_init.c	2004-06-16 07:20:24.000000000 +0200
+++ kernel-source-2.6.7.peg2/arch/ppc/syslib/prom_init.c	2004-06-30 07:51:49.975232432 +0200
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
+		 * address calculated above is * correct, so let's use
+		 * it directly.
+		 */
+	} else if (offset == 0) {
+		/* If we are already running at 0xc0000000, we assume we were
+	 	* loaded by an OF bootloader which did set a BAT for us.
+	 	* This breaks OF translate so we force phys to be 0.
+	 	*/
 		prom_print("(already at 0xc0000000) phys=0\n");
 		phys = 0;
 	} else if ((int) call_prom("getprop", 4, 1, prom_chosen, "mmu",

--3V7upXqbjpZ4EhLz--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
