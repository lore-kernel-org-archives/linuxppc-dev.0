Return-Path: <rsushko@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5F138681C2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Nov 2005 01:53:16 +1100 (EST)
From: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="=-UCeA0tMpibMPflbmLAPF"
Date: Mon, 21 Nov 2005 17:26:03 +0300
Message-Id: <1132583163.11785.42.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Subject: [PATCH 2/3] ppc32: PCIX support for Yucca board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-UCeA0tMpibMPflbmLAPF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch adds PCI-X support for Yucca board

Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>

--=-UCeA0tMpibMPflbmLAPF
Content-Disposition: attachment; filename=yucca_pcix_support.patch
Content-Type: text/x-patch; name=yucca_pcix_support.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
--- a/arch/ppc/platforms/4xx/yucca.c
+++ b/arch/ppc/platforms/4xx/yucca.c
@@ -58,6 +58,25 @@ extern bd_t __res;
 
 static struct ibm44x_clocks clocks __initdata;
 
+unsigned char ppc4xx_uic_ext_irq_cfg[] __initdata = {
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ15: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ14: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ13: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ12: PCI-X slot */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ11: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ10: EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ9:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ8:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ7:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ6:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ5:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ4:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ3:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ2:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ1:  EXT */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* IRQ0:  EXT */
+};
+
 static void __init
 yucca_calibrate_decr(void)
 {
@@ -80,13 +99,83 @@ yucca_show_cpuinfo(struct seq_file *m)
 	return 0;
 }
 
-static enum {
-	HOSE_UNKNOWN,
+static void __init yucca_set_emacdata(void)
+{
+	struct ocp_def *def;
+	struct ocp_func_emac_data *emacdata;
+
+	/* Set phy_map, phy_mode, and mac_addr for the EMAC */
+	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
+	emacdata = def->additions;
+	emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
+	emacdata->phy_mode = PHY_MODE_GMII;
+	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
+}
+
+enum yucca_hoses {
 	HOSE_PCIX,
 	HOSE_PCIE0,
 	HOSE_PCIE1,
-	HOSE_PCIE2
-} hose_type[4];
+	HOSE_PCIE2,
+	HOSE_MAX
+};
+
+static enum yucca_hoses hose_type[4];
+
+#define is_pcix_hose(_hs_) ((_hs_) == HOSE_PCIX)
+#define is_pcie_hose(_hs_) (((_hs_) >= HOSE_PCIE0) && ((_hs_) <= HOSE_PCIE2))
+#define pcie_hose_num(_hs_) ((_hs_) - HOSE_PCIE0)
+
+#define PCIX_READW(offset) \
+        (readw((void *)((u32)pcix_reg_base+offset)))
+
+#define PCIX_WRITEW(value, offset) \
+        (writew(value, (void *)((u32)pcix_reg_base+offset)))
+
+#define PCIX_WRITEL(value, offset) \
+        (writel(value, (void *)((u32)pcix_reg_base+offset)))
+
+static void __init
+ppc440spe_setup_pcix(struct pci_controller *hose)
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
+        PCIX_WRITEL(hose->mem_space.start, PCIX0_POM0LAL);
+        PCIX_WRITEL(0x00000000, PCIX0_POM0PCIAH);
+        PCIX_WRITEL(hose->mem_space.start, PCIX0_POM0PCIAL);
+        PCIX_WRITEL(~(hose->mem_space.end - hose->mem_space.start) | 1 ,
+                        PCIX0_POM0SA);
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
 
 static inline int
 yucca_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
@@ -100,7 +189,7 @@ yucca_map_irq(struct pci_dev *dev, unsig
 		 *	  A   B   C   D
 		 */
 		{
-			{ 81, -1, -1, -1 },	/* IDSEL 1 - PCIX0 Slot 0 */
+			{ 49, -1, -1, -1 },	/* IDSEL 1 - PCIX0 Slot 0 */
 		};
 		const long min_idsel = 1, max_idsel = 1, irqs_per_slot = 4;
 		return PCI_IRQ_TABLE_LOOKUP;
@@ -141,25 +230,16 @@ yucca_map_irq(struct pci_dev *dev, unsig
 	return -1;
 }
 
-static void __init yucca_set_emacdata(void)
-{
-	struct ocp_def *def;
-	struct ocp_func_emac_data *emacdata;
-
-	/* Set phy_map, phy_mode, and mac_addr for the EMAC */
-	def = ocp_get_one_device(OCP_VENDOR_IBM, OCP_FUNC_EMAC, 0);
-	emacdata = def->additions;
-	emacdata->phy_map = 0x00000001;	/* Skip 0x00 */
-	emacdata->phy_mode = PHY_MODE_GMII;
-	memcpy(emacdata->mac_addr, __res.bi_enetaddr, 6);
-}
-
 static int __init yucca_pcie_card_present(int port)
 {
    void __iomem *pcie_fpga_base;
    u16 reg;
 
    pcie_fpga_base = ioremap64(YUCCA_FPGA_REG_BASE, YUCCA_FPGA_REG_SIZE);
+   if (!pcie_fpga_base) {
+              printk(KERN_ERR "FPGA remap filed\n");
+              return 0;
+   }
    reg = in_be16(pcie_fpga_base + FPGA_REG1C);
    iounmap(pcie_fpga_base);
 
@@ -240,35 +320,44 @@ yucca_setup_hoses(void)
 {
 	struct pci_controller *hose;
 	char name[20];
+        enum yucca_hoses hs;
         int bus_no = 0;
-	int i;
 
-	for (i = 0; i <= 2; ++i) {
-		if (!yucca_pcie_card_present(i))
-			continue;
-
-		printk(KERN_INFO "PCIE%d: card present\n", i);
-		yucca_setup_pcie_fpga_rootpoint(i);
-		if (ppc440spe_init_pcie_rootport(i)) {
-			printk(KERN_WARNING "PCIE%d: initialization failed\n", i);
-			continue;
-		}
+	for (hs = HOSE_PCIX; hs < HOSE_MAX; ++hs) {
+                if (is_pcie_hose(hs)) {
+                        if (!yucca_pcie_card_present(pcie_hose_num(hs)))
+                                continue;
+
+                        printk(KERN_INFO "PCIE%d: card present\n",
+                                        pcie_hose_num(hs));
+
+                        yucca_setup_pcie_fpga_rootpoint(pcie_hose_num(hs));
+                        if (ppc440spe_init_pcie_rootport(pcie_hose_num(hs))) {
+                                printk(KERN_ERR "PCIE%d: initialization "
+                                                "failed\n", pcie_hose_num(hs));
+                                continue;
+                        }
+                }
 
 		hose = pcibios_alloc_controller();
+
 		if (!hose)
 			return;
 
-		sprintf(name, "PCIE%d host bridge", i);
+		sprintf(name, "PCI%s%d host bridge",
+                                is_pcix_hose(hs) ? "X" : "E",
+                                is_pcie_hose(hs) ?  pcie_hose_num(hs) : 0
+                                );
 		pci_init_resource(&hose->io_resource,
 				  YUCCA_PCIX_LOWER_IO,
 				  YUCCA_PCIX_UPPER_IO,
 				  IORESOURCE_IO,
 				  name);
 
-		hose->mem_space.start = YUCCA_PCIE_LOWER_MEM +
-			i * YUCCA_PCIE_MEM_SIZE;
+		hose->mem_space.start = YUCCA_PCIX_LOWER_MEM +
+			hs * YUCCA_PCIX_MEM_SIZE;
 		hose->mem_space.end   = hose->mem_space.start +
-			YUCCA_PCIE_MEM_SIZE - 1;
+			YUCCA_PCIX_MEM_SIZE - 1;
 
 		pci_init_resource(&hose->mem_resources[0],
 				  hose->mem_space.start,
@@ -278,9 +367,24 @@ yucca_setup_hoses(void)
 
 		hose->first_busno = bus_no;
 		hose->last_busno  = 0xFF;
-		hose_type[hose->index] = HOSE_PCIE0 + i;
+		hose_type[hose->index] = hs;
+
+                if (is_pcix_hose(hs)) {
+         	        hose->io_space.start = YUCCA_PCIX_LOWER_IO;
+                	hose->io_space.end = YUCCA_PCIX_UPPER_IO;
+               	        isa_io_base =
+		                (unsigned long)
+                                        ioremap64(PCIX0_IO_BASE, PCIX_IO_SIZE);
+	                hose->io_base_virt = (void *)isa_io_base;
+
+                        ppc440spe_setup_pcix(hose);
+
+    	                setup_indirect_pci(hose, PCIX0_CFGA, PCIX0_CFGD);
+                        hose->set_cfg_type = 1;
+                } else {
+		        ppc440spe_setup_pcie(hose, pcie_hose_num(hs));
+                }
 
-		ppc440spe_setup_pcie(hose, i);
 		hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
                 bus_no = hose->last_busno + 1;
                 printk(KERN_INFO "%s: resources allocated\n", name);
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -557,12 +557,19 @@
 #define PCIX1_CFGD		0x1ec00004UL
 #define PCIX2_CFGD		0x2ec00004UL
 
+#if defined (CONFIG_440SPE)
+#define PCIX0_IO_BASE		0x0000000C08000000ULL
+#else
 #define PCIX0_IO_BASE		0x0000000908000000ULL
 #define PCIX1_IO_BASE		0x0000000908000000ULL
 #define PCIX2_IO_BASE		0x0000000908000000ULL
+#endif
+
 #define PCIX_IO_SIZE		0x00010000
 
-#ifdef CONFIG_440SP
+#if defined (CONFIG_440SPE)
+#define PCIX0_REG_BASE		0x0000000c0ec80000ULL
+#elif defined(CONFIG_440SP)
 #define PCIX0_REG_BASE		0x000000090ec80000ULL
 #else
 #define PCIX0_REG_BASE		0x000000020ec80000ULL

--=-UCeA0tMpibMPflbmLAPF--
