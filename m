Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D349567B8D
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 14:16:39 +1000 (EST)
Subject: [PATCH] powerpc: Add briq support to CHRP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 14:16:28 +1000
Message-Id: <1151986588.13828.46.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The support for Briq machines has been floating around as patches for
ages. This cleans it up and adds it once for all.

Some of this is based on initial code provided by Karsten Jeppesen
<karsten@jeppesens.com> and
mostly rewritten from scratch by me.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-irq-work/arch/powerpc/platforms/chrp/pci.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/chrp/pci.c	2006-07-04 13:30:58.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/chrp/pci.c	2006-07-04 13:52:04.000000000 +1000
@@ -257,7 +257,7 @@
 		else
 			printk(KERN_INFO "PCI buses %d..%d",
 			       bus_range[0], bus_range[1]);
-		printk(" controlled by %s", dev->type);
+		printk(" controlled by %s", dev->full_name);
 		if (!is_longtrail)
 			printk(" at %llx", (unsigned long long)r.start);
 		printk("\n");
@@ -289,6 +289,19 @@
 			setup_indirect_pci(hose, 0xfec00cf8, 0xfee00cfc);
 		} else if (is_pegasos == 2) {
 			setup_peg2(hose, dev);
+		} else if (!strncmp(model, "IBM,CPC710", 10)) {
+			setup_indirect_pci(hose,
+					   r.start + 0x000f8000,
+					   r.start + 0x000f8010);
+			if (index == 0) {
+				dma = get_property(dev, "system-dma-base",&len);
+				if (dma && len >= sizeof(*dma)) {
+					dma = (unsigned int *)
+						(((unsigned long)dma) +
+						len - sizeof(*dma));
+						pci_dram_offset = *dma;
+				}
+			}
 		} else {
 			printk("No methods for %s (model %s), using RTAS\n",
 			       dev->full_name, model);
@@ -306,8 +319,29 @@
 			printk("pci_dram_offset = %lx\n", pci_dram_offset);
 		}
 	}
+}
+
+/* SL82C105 IDE Control/Status Register */
+#define SL82C105_IDECSR                0x40
+
+/* Fixup for Winbond ATA quirk, required for briq */
+void chrp_pci_fixup_winbond_ata(struct pci_dev *sl82c105)
+{
+	u8 progif;
 
-	/* Do not fixup interrupts from OF tree on pegasos */
-	if (is_pegasos)
-		ppc_md.pcibios_fixup = NULL;
+	/* If non-briq machines need that fixup too, please speak up */
+	if (!machine_is(chrp) || _chrp_type != _CHRP_briq)
+		return;
+
+	if ((sl82c105->class & 5) != 5) {
+		printk("W83C553: Switching SL82C105 IDE to PCI native mode\n");
+		/* Enable SL82C105 PCI native IDE mode */
+		pci_read_config_byte(sl82c105, PCI_CLASS_PROG, &progif);
+		pci_write_config_byte(sl82c105, PCI_CLASS_PROG, progif | 0x05);
+		sl82c105->class |= 0x05;
+		/* Disable SL82C105 second port */
+		pci_write_config_word(sl82c105, SL82C105_IDECSR, 0x0003);
+	}
 }
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_82C105,
+		chrp_pci_fixup_winbond_ata);
Index: linux-irq-work/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/platforms/chrp/setup.c	2006-07-04 13:32:41.000000000 +1000
+++ linux-irq-work/arch/powerpc/platforms/chrp/setup.c	2006-07-04 13:40:23.000000000 +1000
@@ -74,6 +74,9 @@
 
 extern unsigned long loops_per_jiffy;
 
+/* To be replaced by RTAS when available */
+static unsigned int *briq_SPOR;
+
 #ifdef CONFIG_SMP
 extern struct smp_ops_t chrp_smp_ops;
 #endif
@@ -92,6 +95,15 @@
 	"Disabled", "Write-Through", "Copy-Back", "Transparent Mode"
 };
 
+static const char *chrp_names[] = {
+	"Unknown",
+	"","","",
+	"Motorola",
+	"IBM or Longtrail",
+	"Genesi Pegasos",
+	"Total Impact Briq"
+};
+
 void chrp_show_cpuinfo(struct seq_file *m)
 {
 	int i, sdramen;
@@ -229,6 +241,14 @@
 	}
 }
 
+static void briq_restart(char *cmd)
+{
+	local_irq_disable();
+	if (briq_SPOR)
+		out_be32(briq_SPOR, 0);
+	for(;;);
+}
+
 void __init chrp_setup_arch(void)
 {
 	struct device_node *root = find_path_device ("/");
@@ -245,11 +265,16 @@
 		_chrp_type = _CHRP_IBM;
 	} else if (machine && strncmp(machine, "MOT", 3) == 0) {
 		_chrp_type = _CHRP_Motorola;
+	} else if (machine && strncmp(machine, "TotalImpact,BRIQ-1", 18) == 0) {
+		_chrp_type = _CHRP_briq;
+		/* Map the SPOR register on briq and change the restart hook */
+		briq_SPOR = (unsigned int *)ioremap(0xff0000e8, 4);
+		ppc_md.restart = briq_restart;
 	} else {
 		/* Let's assume it is an IBM chrp if all else fails */
 		_chrp_type = _CHRP_IBM;
 	}
-	printk("chrp type = %x\n", _chrp_type);
+	printk("chrp type = %x [%s]\n", _chrp_type, chrp_names[_chrp_type]);
 
 	rtas_initialize();
 	if (rtas_token("display-character") >= 0)
Index: linux-irq-work/include/asm-powerpc/processor.h
===================================================================
--- linux-irq-work.orig/include/asm-powerpc/processor.h	2006-07-04 13:30:58.000000000 +1000
+++ linux-irq-work/include/asm-powerpc/processor.h	2006-07-04 13:32:41.000000000 +1000
@@ -32,6 +32,7 @@
 #define _CHRP_Motorola	0x04	/* motorola chrp, the cobra */
 #define _CHRP_IBM	0x05	/* IBM chrp, the longtrail and longtrail 2 */
 #define _CHRP_Pegasos	0x06	/* Genesi/bplan's Pegasos and Pegasos2 */
+#define _CHRP_briq	0x07	/* TotalImpact's briQ */
 
 #if defined(__KERNEL__) && defined(CONFIG_PPC32)
 
Index: linux-irq-work/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-irq-work.orig/arch/powerpc/kernel/prom_init.c	2006-07-04 13:32:41.000000000 +1000
+++ linux-irq-work/arch/powerpc/kernel/prom_init.c	2006-07-04 13:32:41.000000000 +1000
@@ -2033,16 +2033,22 @@
 #endif
 
 #ifdef CONFIG_PPC_CHRP
-/* Pegasos lacks the "ranges" property in the isa node */
+/* Pegasos and BriQ lacks the "ranges" property in the isa node */
 static void __init fixup_device_tree_chrp(void)
 {
 	phandle isa;
 	u32 isa_ranges[6];
+	u32 rloc = 0x01006000; /* IO space; PCI device = 12 */
 	char *name;
 	int rc;
 
 	name = "/pci@80000000/isa@c";
 	isa = call_prom("finddevice", 1, 1, ADDR(name));
+	if (!PHANDLE_VALID(isa)) {
+		name = "/pci@ff500000/isa@6";
+		isa = call_prom("finddevice", 1, 1, ADDR(name));
+		rloc = 0x01003000; /* IO space; PCI device = 6 */
+	}
 	if (!PHANDLE_VALID(isa))
 		return;
 
@@ -2054,7 +2060,7 @@
 
 	isa_ranges[0] = 0x1;
 	isa_ranges[1] = 0x0;
-	isa_ranges[2] = 0x01006000;
+	isa_ranges[2] = rloc;
 	isa_ranges[3] = 0x0;
 	isa_ranges[4] = 0x0;
 	isa_ranges[5] = 0x00010000;
