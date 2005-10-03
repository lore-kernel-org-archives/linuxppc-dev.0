Return-Path: <rsushko@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 39EA56842F
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Oct 2005 18:36:13 +1000 (EST)
Received: from mephisto.spb.rtsoft.ru ([10.149.0.1])
	by buildserver.ru.mvista.com (8.11.6/8.11.6) with ESMTP id j938a9t18108
	for <linuxppc-embedded@ozlabs.org>; Mon, 3 Oct 2005 13:36:09 +0500
From: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="=-kzCX4LRIyHIJ9jGR8WnQ"
Date: Mon, 03 Oct 2005 12:36:08 +0400
Message-Id: <1128328568.21396.7.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Subject: [PATCH 2/3][PPC32] PCI-X support for Yucca
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-kzCX4LRIyHIJ9jGR8WnQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds PCIX support for Yucca PPC440SPe board. The patch is
implemented for Roland Dreier git tree for Yucca PPC440SPe board.

Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>

--=-kzCX4LRIyHIJ9jGR8WnQ
Content-Disposition: attachment; filename=yucca_pcix.patch
Content-Type: text/x-patch; name=yucca_pcix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
--- a/arch/ppc/platforms/4xx/yucca.c
+++ b/arch/ppc/platforms/4xx/yucca.c
@@ -86,19 +86,23 @@ yucca_map_irq(struct pci_dev *dev, unsig
 	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
 
 	/* PCIX */
-	if (hose->index == 3) {
+	if (hose->index == 0) {
 		static char pci_irq_table[][4] =
 		/*
 		 *	PCI IDSEL/INTPIN->INTLINE
 		 *	  A   B   C   D
 		 */
 		{
-			{ 81, -1, -1, -1 },	/* IDSEL 1 - PCIX0 Slot 0 */
+			{ 49, -1, -1, -1 },	/* IDSEL 1 - PCIX0 Slot 0 */
 		};
 		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
-		return PCI_IRQ_TABLE_LOOKUP;
+                mtdcr(DCRN_UIC_PR(UIC1), 
+                mfdcr(DCRN_UIC_PR(UIC1)) & ~0x00004000); /* Set PCI interrupt
+                                                            (EXT IRQ12) plarity
+                                                            to Negative */
+                return PCI_IRQ_TABLE_LOOKUP;
 	/* PCIE0 */
-	} else if (hose->index == 0) {
+	} else if (hose->index == 1) {
 		static char pci_irq_table[][4] =
 		/*
 		 *	PCI IDSEL/INTPIN->INTLINE
@@ -110,7 +114,7 @@ yucca_map_irq(struct pci_dev *dev, unsig
 		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
 		return PCI_IRQ_TABLE_LOOKUP;
 	/* PCIE1 */
-	} else if (hose->index == 1) {
+	} else if (hose->index == 2) {
 		static char pci_irq_table[][4] =
 		/*
 		 *	PCI IDSEL/INTPIN->INTLINE
@@ -122,7 +126,7 @@ yucca_map_irq(struct pci_dev *dev, unsig
 		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
 		return PCI_IRQ_TABLE_LOOKUP;
 	/* PCIE2 */
-	} else if (hose->index == 2) {
+	} else if (hose->index == 3) {
 		static char pci_irq_table[][4] =
 		/*
 		 *	PCI IDSEL/INTPIN->INTLINE
@@ -150,10 +154,123 @@ static void __init yucca_set_emacdata(vo
 	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
 }
 
+#define PCIX_READW(offset) \
+	(readw((void *)((u32)pcix_reg_base+offset)))
+
+#define PCIX_WRITEW(value, offset) \
+	(writew(value, (void *)((u32)pcix_reg_base+offset)))
+
+#define PCIX_WRITEL(value, offset) \
+	(writel(value, (void *)((u32)pcix_reg_base+offset)))
+
+static void __init
+yucca_setup_pcix(void)
+{
+	void *pcix_reg_base;
+
+        pcix_reg_base = ioremap64(PCIX0_REG_BASE, PCIX_REG_SIZE);
+
+        /* Disable all windows */
+        PCIX_WRITEL(0, PCIX0_POM0SA);
+        PCIX_WRITEL(0, PCIX0_POM1SA);
+        PCIX_WRITEL(0, PCIX0_POM2SA);
+        PCIX_WRITEL(0, PCIX0_PIM0SA);
+        PCIX_WRITEL(0, PCIX0_PIM0SAH);
+        PCIX_WRITEL(0, PCIX0_PIM1SA);
+        PCIX_WRITEL(0, PCIX0_PIM2SA);
+        PCIX_WRITEL(0, PCIX0_PIM2SAH);
+
+        /*
+         * Setup 512MB PLB->PCI outbound mem window
+         * (a_n000_0000->0_n000_0000)
+         * */
+        PCIX_WRITEL(0x0000000d, PCIX0_POM0LAH);
+        PCIX_WRITEL(0x80000000, PCIX0_POM0LAL);
+        PCIX_WRITEL(0x00000000, PCIX0_POM0PCIAH);
+        PCIX_WRITEL(0x80000000, PCIX0_POM0PCIAL);
+        PCIX_WRITEL(0xe0000001, PCIX0_POM0SA);
+
+        /* Setup 1GB PCI->PLB inbound memory window at 0, enable MSIs */
+        PCIX_WRITEL(0x00000000, PCIX0_PIM0LAH);
+        PCIX_WRITEL(0x00000000, PCIX0_PIM0LAL);
+        PCIX_WRITEL(0xc0000007, PCIX0_PIM0SA);
+        PCIX_WRITEL(0xffffffff, PCIX0_PIM0SAH);
+
+                /* Enable PCIX0 I/O, Mem, and Busmaster cycles */
+        PCIX_WRITEW(PCIX_READW(PCIX0_COMMAND) | PCI_COMMAND_MEMORY |
+                        PCI_COMMAND_MASTER, PCIX0_COMMAND);
+
+        iounmap(pcix_reg_base);
+	eieio();
+}
+
+static void __init
+yucca_setup_hose(struct pci_controller *hose,
+		int lower_mem,
+		int upper_mem,
+		int cfga,
+		int cfgd,
+		u64 pcix_io_base)
+{
+	char name[20];
+
+	sprintf(name, "PCIX%d host bridge", hose->index);
+
+	hose->pci_mem_offset = YUCCA_PCIX_MEM_OFFSET;
+
+	pci_init_resource(&hose->io_resource,
+			YUCCA_PCIX_LOWER_IO,
+			YUCCA_PCIX_UPPER_IO,
+			IORESOURCE_IO,
+			name);
+
+	pci_init_resource(&hose->mem_resources[0],
+			lower_mem,
+			upper_mem,
+			IORESOURCE_MEM,
+			name);
+
+	hose->io_space.start = YUCCA_PCIX_LOWER_IO;
+	hose->io_space.end = YUCCA_PCIX_UPPER_IO;
+	hose->mem_space.start = lower_mem;
+	hose->mem_space.end = upper_mem;
+	isa_io_base =
+		(unsigned long)ioremap64(pcix_io_base, PCIX_IO_SIZE);
+	hose->io_base_virt = (void *)isa_io_base;
+
+  	setup_indirect_pci(hose, cfga, cfgd);
+	hose->set_cfg_type = 1;
+}
+
+
 static void __init
 yucca_setup_hoses(void)
 {
+	struct pci_controller *hose;
+
+	/* Configure windows on the PCI-X host bridge */
+	yucca_setup_pcix();
+        
+	/* Allocate hoses for PCIX0 */
+	hose = pcibios_alloc_controller();
+	if (!hose)
+		return;
+
+	/* Setup PCIX0 */
+	hose->first_busno = 0;
+	hose->last_busno = 0xff;
+
+	yucca_setup_hose(hose,
+			YUCCA_PCIX_LOWER_MEM,
+			YUCCA_PCIX_UPPER_MEM,
+			PCIX0_CFGA,
+			PCIX0_CFGD,
+			PCIX0_IO_BASE);
+
+  	hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
 
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pci_map_irq = yucca_map_irq;
 }
 
 TODC_ALLOC();
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_GT64260)		+= gt64260_pic.o
 obj-$(CONFIG_LOPEC)		+= i8259.o pci_auto.o todc_time.o
 obj-$(CONFIG_HDPU)		+= pci_auto.o
 obj-$(CONFIG_LUAN)		+= indirect_pci.o pci_auto.o todc_time.o
+obj-$(CONFIG_YUCCA)		+= indirect_pci.o pci_auto.o
 obj-$(CONFIG_KATANA)		+= pci_auto.o
 obj-$(CONFIG_MV64360)		+= mv64360_pic.o
 obj-$(CONFIG_MV64X60)		+= mv64x60.o mv64x60_win.o indirect_pci.o
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -64,6 +64,11 @@
 #define	PPC44x_PCICFG_PAGE	0x0000000900000000ULL
 #define	PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
 #define	PPC44x_PCIMEM_PAGE	0x0000000a00000000ULL
+#elif defined(CONFIG_440SPE)
+#define	PPC44x_IO_PAGE		0x0000000400000000ULL
+#define	PPC44x_PCICFG_PAGE	0x0000000C00000000ULL
+#define	PPC44x_PCIIO_PAGE	PPC44x_PCICFG_PAGE
+#define	PPC44x_PCIMEM_PAGE	0x0000000D00000000ULL
 #elif defined(CONFIG_440EP)
 #define PPC44x_IO_PAGE		0x0000000000000000ULL
 #define PPC44x_PCICFG_PAGE	0x0000000000000000ULL
@@ -552,12 +557,19 @@
 #define PCIX1_CFGD		0x1ec00004UL
 #define PCIX2_CFGD		0x2ec00004UL
 
+#if defined (CONFIG_440SPE)
+#define PCIX0_IO_BASE		0x0000000C08000000ULL
+#else /* !CONFIG_440SPE */
 #define PCIX0_IO_BASE		0x0000000908000000ULL
 #define PCIX1_IO_BASE		0x0000000908000000ULL
 #define PCIX2_IO_BASE		0x0000000908000000ULL
+#endif /* CONFIG_440SPE */
+
 #define PCIX_IO_SIZE		0x00010000
 
-#ifdef CONFIG_440SP
+#if defined (CONFIG_440SPE)
+#define PCIX0_REG_BASE		0x0000000c0ec80000ULL
+#elif defefined(CONFIG_440SP)
 #define PCIX0_REG_BASE		0x000000090ec80000ULL
 #else
 #define PCIX0_REG_BASE		0x000000020ec80000ULL




--=-kzCX4LRIyHIJ9jGR8WnQ--
