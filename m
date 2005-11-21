Return-Path: <rsushko@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 95966681C2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Nov 2005 01:53:13 +1100 (EST)
From: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: multipart/mixed; boundary="=-Yu1vU/hs5PcDom9CO5xL"
Date: Mon, 21 Nov 2005 17:25:52 +0300
Message-Id: <1132583152.11785.41.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Subject: [PATCH 1/3] ppc32: Fix  a few issues in Yucca PCIe functionality
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-Yu1vU/hs5PcDom9CO5xL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch includes following changes:

1) Fix wrong PCIe config space address calculation for slot #3 (Using an
signed integer for port numbering will cause wrong address accessing)
2) Fix the PCI bus numbering assignment. This will be an issues if more
than one PCI card is inserted.
3) Add verbose error checking.
4) Remove commented or unused lines.


Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>

--=-Yu1vU/hs5PcDom9CO5xL
Content-Disposition: attachment; filename=yucca_pcie_fix.patch
Content-Type: text/x-patch; name=yucca_pcie_fix.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
--- a/arch/ppc/platforms/4xx/yucca.c
+++ b/arch/ppc/platforms/4xx/yucca.c
@@ -240,13 +240,9 @@ yucca_setup_hoses(void)
 {
 	struct pci_controller *hose;
 	char name[20];
+        int bus_no = 0;
 	int i;
 
-	if (0 && ppc440spe_init_pcie()) {
-		printk(KERN_WARNING "PPC440SPe PCI Express initialization failed\n");
-		return;
-	}
-
 	for (i = 0; i <= 2; ++i) {
 		if (!yucca_pcie_card_present(i))
 			continue;
@@ -280,12 +276,14 @@ yucca_setup_hoses(void)
 				  IORESOURCE_MEM,
 				  name);
 
-		hose->first_busno = 0;
-		hose->last_busno  = 15;
+		hose->first_busno = bus_no;
+		hose->last_busno  = 0xFF;
 		hose_type[hose->index] = HOSE_PCIE0 + i;
 
 		ppc440spe_setup_pcie(hose, i);
 		hose->last_busno = pciauto_bus_scan(hose, hose->first_busno);
+                bus_no = hose->last_busno + 1;
+                printk(KERN_INFO "%s: resources allocated\n", name);
 	}
 
 	ppc_md.pci_swizzle = common_swizzle;
diff --git a/arch/ppc/syslib/ppc440spe_pcie.c b/arch/ppc/syslib/ppc440spe_pcie.c
--- a/arch/ppc/syslib/ppc440spe_pcie.c
+++ b/arch/ppc/syslib/ppc440spe_pcie.c
@@ -47,8 +47,6 @@ pcie_read_config(struct pci_bus *bus, un
 		break;
 	}
 
-	if (0) printk("%s: read %x(%d) @ %x\n", __func__, *val, len, offset);
-
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -93,9 +91,10 @@ enum {
 	LNKW_X8			= 0x8
 };
 
-static void check_error(void)
+static int check_error(void)
 {
 	u32 valPE0, valPE1, valPE2;
+        int err = 0;
 
 	/* SDR0_PEGPLLLCT1 reset */
 	if (!(valPE0 = SDR_READ(PESDR0_PLLLCT1) & 0x01000000)) {
@@ -111,6 +110,7 @@ static void check_error(void)
 	     !(valPE1 & 0x01000000) ||
 	     !(valPE2 & 0x01000000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rstgu error\n");
+                err = -1;
 	}
 
 	/* SDR0_PExRCSSET rstdl */
@@ -118,6 +118,7 @@ static void check_error(void)
 	     !(valPE1 & 0x00010000) ||
 	     !(valPE2 & 0x00010000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rstdl error\n");
+                err = -1;
 	}
 
 	/* SDR0_PExRCSSET rstpyn */
@@ -132,6 +133,7 @@ static void check_error(void)
 	     (valPE1 & 0x10000000) ||
 	     (valPE2 & 0x10000000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET hldplb error\n");
+                err = -1;
 	}
 
 	/* SDR0_PExRCSSET rdy */
@@ -139,6 +141,7 @@ static void check_error(void)
 	     (valPE1 & 0x00100000) ||
 	     (valPE2 & 0x00100000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rdy error\n");
+                err = -1;
 	}
 
 	/* SDR0_PExRCSSET shutdown */
@@ -146,7 +149,9 @@ static void check_error(void)
 	     (valPE1 & 0x00000100) ||
 	     (valPE2 & 0x00000100)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET shutdown error\n");
+                err = -1;
 	}
+        return err;
 }
 
 /*
@@ -157,33 +162,37 @@ int ppc440spe_init_pcie(void)
 	/* Set PLL clock receiver to LVPECL */
 	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) | 1 << 28);
 
-	check_error();
-
-	printk(KERN_INFO "PCIE initialization OK\n");
-
-	if (!(SDR_READ(PESDR0_PLLLCT2) & 0x10000))
-		printk(KERN_INFO "PESDR_PLLCT2 resistance calibration failed (0x%08x)\n",
+	if (check_error()) {
+                return -1;
+        }
+
+	if (!(SDR_READ(PESDR0_PLLLCT2) & 0x10000)) {
+		printk(KERN_INFO "PCIE: PESDR_PLLCT2 resistance calibration "
+                                "failed (0x%08x)\n",
 		       SDR_READ(PESDR0_PLLLCT2));
+                return -1;
+        }
 
 	/* De-assert reset of PCIe PLL, wait for lock */
 	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) & ~(1 << 24));
 	udelay(3);
+	printk(KERN_INFO "PCIE initialization OK\n");
 
 	return 0;
 }
 
-int ppc440spe_init_pcie_rootport(int port)
+int ppc440spe_init_pcie_rootport(u32 port)
 {
 	static int core_init;
 	void __iomem *utl_base;
+        int attempts;
 	u32 val = 0;
-	int i;
 
 	if (!core_init) {
+		if(ppc440spe_init_pcie()) {
+			return -1;
+                }
 		++core_init;
-		i = ppc440spe_init_pcie();
-		if (i)
-			return i;
 	}
 
 	/*
@@ -254,16 +263,11 @@ int ppc440spe_init_pcie_rootport(int por
 	case 2: val = SDR_READ(PESDR2_RCSSTS); break;
 	}
 
-	if (!(val & (1 << 20)))
-		printk(KERN_INFO "PCIE%d: PGRST inactive\n", port);
-	else
-		printk(KERN_WARNING "PGRST for PCIE%d failed %08x\n", port, val);
-
-	switch (port) {
-	case 0: printk(KERN_INFO "PCIE0: LOOP %08x\n", SDR_READ(PESDR0_LOOP)); break;
-	case 1: printk(KERN_INFO "PCIE1: LOOP %08x\n", SDR_READ(PESDR1_LOOP)); break;
-	case 2: printk(KERN_INFO "PCIE2: LOOP %08x\n", SDR_READ(PESDR2_LOOP)); break;
-	}
+	if (val & (1 << 20)) {
+		printk(KERN_WARNING "PGRST for PCIE%d failed %08x\n",
+                                port, val);
+                return -1;
+        }
 
 	/*
 	 * Map UTL registers at 0xc_1000_0n00
@@ -335,44 +339,47 @@ int ppc440spe_init_pcie_rootport(int por
 	/*
 	 * Check for VC0 active and assert RDY.
 	 */
+
+        attempts = 10;
 	switch (port) {
 	case 0:
-		if (!(SDR_READ(PESDR0_RCSSTS) & (1 << 16)))
-			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+                while(!(SDR_READ(PESDR0_RCSSTS) & (1 << 16))) {
+                        if (!(attempts--)) {
+                                printk(KERN_WARNING "PCIE0: VC0 not active\n");
+                                return -1;
+                        }
+                        mdelay(1000);
+                }
 		SDR_WRITE(PESDR0_RCSSET, SDR_READ(PESDR0_RCSSET) | 1 << 20);
-		break;
+                break;
 	case 1:
-		if (!(SDR_READ(PESDR1_RCSSTS) & (1 << 16)))
-			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+                while(!(SDR_READ(PESDR1_RCSSTS) & (1 << 16))) {
+                        if (!(attempts--)) {
+                                printk(KERN_WARNING "PCIE1: VC0 not active\n");
+                                return -1;
+                        }
+                        mdelay(1000);
+                }
 		SDR_WRITE(PESDR1_RCSSET, SDR_READ(PESDR1_RCSSET) | 1 << 20);
 		break;
 	case 2:
-		if (!(SDR_READ(PESDR2_RCSSTS) & (1 << 16)))
-			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+                while(!(SDR_READ(PESDR2_RCSSTS) & (1 << 16))) {
+                        if (!(attempts--)) {
+                                printk(KERN_WARNING "PCIE2: VC0 not active\n");
+                                return -1;
+                        }
+                        mdelay(1000);
+                }
 		SDR_WRITE(PESDR2_RCSSET, SDR_READ(PESDR2_RCSSET) | 1 << 20);
 		break;
 	}
 
-#if 0
-	/* Dump all config regs */
-	for (i = 0x300; i <= 0x320; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x340; i <= 0x353; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x370; i <= 0x383; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x3a0; i <= 0x3a2; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-	for (i = 0x3c0; i <= 0x3c3; ++i)
-		printk("[%04x] 0x%08x\n", i, SDR_READ(i));
-#endif
-
 	mdelay(100);
 
 	return 0;
 }
 
-void ppc440spe_setup_pcie(struct pci_controller *hose, int port)
+void ppc440spe_setup_pcie(struct pci_controller *hose, u32 port)
 {
 	void __iomem *mbase;
 
diff --git a/arch/ppc/syslib/ppc440spe_pcie.h b/arch/ppc/syslib/ppc440spe_pcie.h
--- a/arch/ppc/syslib/ppc440spe_pcie.h
+++ b/arch/ppc/syslib/ppc440spe_pcie.h
@@ -143,7 +143,7 @@
 #define PECFG_POM0LAH		0x384
 
 int ppc440spe_init_pcie(void);
-int ppc440spe_init_pcie_rootport(int port);
-void ppc440spe_setup_pcie(struct pci_controller *hose, int port);
+int ppc440spe_init_pcie_rootport(u32 port);
+void ppc440spe_setup_pcie(struct pci_controller *hose, u32 port);
 
 #endif /* __PPC_SYSLIB_PPC440SPE_PCIE_H */

--=-Yu1vU/hs5PcDom9CO5xL--
