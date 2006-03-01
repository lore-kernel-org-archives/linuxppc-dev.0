Return-Path: <wfarnsworth@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id 2EBF267A5C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 10:50:23 +1100 (EST)
Subject: Re: [PATCH 3/6] PCIX fixes and enhancements for 440SP & Luan
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1141256859.25758.22.camel@rhino.az.mvista.com>
References: <1141256113.25761.14.camel@rhino.az.mvista.com>
	<1141256751.25761.19.camel@rhino.az.mvista.com>
	<1141256859.25758.22.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-F6Rwf1ZqSNScsl7Sds5z"
Message-Id: <1141257021.25761.26.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 01 Mar 2006 16:50:22 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-F6Rwf1ZqSNScsl7Sds5z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch allows each bridge on the 440SP to be configured for both
host and adapter mode.  Previously, PCIX0 was configured for adapter
mode only.

Also fixes PCIXn_IO_BASE for PCIX1 and 2.

Signed off by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-F6Rwf1ZqSNScsl7Sds5z
Content-Disposition: attachment; filename=luan-pcix.patch
Content-Type: text/x-patch; name=luan-pcix.patch
Content-Transfer-Encoding: 7bit

diff --git a/arch/ppc/platforms/4xx/luan.c b/arch/ppc/platforms/4xx/luan.c
--- a/arch/ppc/platforms/4xx/luan.c
+++ b/arch/ppc/platforms/4xx/luan.c
@@ -95,9 +95,7 @@ luan_map_irq(struct pci_dev *dev, unsign
 {
 	struct pci_controller *hose = pci_bus_to_hose(dev->bus->number);
 
-	/* PCIX0 in adapter mode, no host interrupt routing */
-
-	/* PCIX1 */
+	/* PCIX0 */
 	if (hose->index == 0) {
 		static char pci_irq_table[][4] =
 		/*
@@ -105,6 +103,21 @@ luan_map_irq(struct pci_dev *dev, unsign
 		 *	  A   B   C   D
 		 */
 		{
+			{ 32, 32, 32, 32 },	/* IDSEL 1 - PCIX0 Slot 0 */
+			{ 32, 32, 32, 32 },	/* IDSEL 2 - PCIX0 Slot 1 */
+			{ 32, 32, 32, 32 },	/* IDSEL 3 - PCIX0 Slot 2 */
+			{ 32, 32, 32, 32 },	/* IDSEL 4 - PCIX0 Slot 3 */
+		};
+		const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	/* PCIX1 */
+	} else if (hose->index == 1) {
+		static char pci_irq_table[][4] =
+		/*
+		 *	PCI IDSEL/INTPIN->INTLINE
+		 *	  A   B   C   D
+		 */
+		{
 			{ 49, 49, 49, 49 },	/* IDSEL 1 - PCIX1 Slot 0 */
 			{ 49, 49, 49, 49 },	/* IDSEL 2 - PCIX1 Slot 1 */
 			{ 49, 49, 49, 49 },	/* IDSEL 3 - PCIX1 Slot 2 */
@@ -113,7 +126,7 @@ luan_map_irq(struct pci_dev *dev, unsign
 		const long min_idsel = 1, max_idsel = 4, irqs_per_slot = 4;
 		return PCI_IRQ_TABLE_LOOKUP;
 	/* PCIX2 */
-	} else if (hose->index == 1) {
+	} else if (hose->index == 2) {
 		static char pci_irq_table[][4] =
 		/*
 		 *	PCI IDSEL/INTPIN->INTLINE
@@ -237,42 +250,70 @@ luan_setup_hose(struct pci_controller *h
 static void __init
 luan_setup_hoses(void)
 {
-	struct pci_controller *hose1, *hose2;
+	struct pci_controller *hose0, *hose1, *hose2;
+	int last_busno = -1;
 
 	/* Configure windows on the PCI-X host bridge */
 	luan_setup_pcix();
+	
+	/* Setup PCIX0 */
+	if (SDR_READ(0x01c0) & 0x20000000) {
+		hose0 = pcibios_alloc_controller();
+		if (!hose0)
+			return;
+		hose0->first_busno = 0;
+		hose0->last_busno = 0xff;
+		hose0->index = 0;
+
+		luan_setup_hose(hose0,
+				LUAN_PCIX0_LOWER_MEM,
+				LUAN_PCIX0_UPPER_MEM,
+				PCIX0_CFGA,
+				PCIX0_CFGD,
+				PCIX0_IO_BASE);
 
-	/* Allocate hoses for PCIX1 and PCIX2 */
-	hose1 = pcibios_alloc_controller();
-	hose2 = pcibios_alloc_controller();
-	if (!hose1 || !hose2)
-		return;
+		last_busno = hose0->last_busno =
+			     pciauto_bus_scan(hose0, hose0->first_busno);
+	}
 
 	/* Setup PCIX1 */
-	hose1->first_busno = 0;
-	hose1->last_busno = 0xff;
-
-	luan_setup_hose(hose1,
-			LUAN_PCIX1_LOWER_MEM,
-			LUAN_PCIX1_UPPER_MEM,
-			PCIX1_CFGA,
-			PCIX1_CFGD,
-			PCIX1_IO_BASE);
+	if (SDR_READ(0x01c3) & 0x20000000) {
+		hose1 = pcibios_alloc_controller();
+		if (!hose1)
+			return;
+		hose1->first_busno = last_busno + 1;
+		hose1->last_busno = 0xff;
+		hose1->index = 1;
+
+		luan_setup_hose(hose1,
+				LUAN_PCIX1_LOWER_MEM,
+				LUAN_PCIX1_UPPER_MEM,
+				PCIX1_CFGA,
+				PCIX1_CFGD,
+				PCIX1_IO_BASE);
 
-	hose1->last_busno = pciauto_bus_scan(hose1, hose1->first_busno);
+		last_busno = hose1->last_busno = 
+			     pciauto_bus_scan(hose1, hose1->first_busno);
+	}
 
 	/* Setup PCIX2 */
-	hose2->first_busno = hose1->last_busno + 1;
-	hose2->last_busno = 0xff;
+	if (SDR_READ(0x01c6) & 0x20000000) {
+		hose2 = pcibios_alloc_controller();
+		if (!hose2)
+			return;
+		hose2->first_busno = last_busno + 1;
+		hose2->last_busno = 0xff;
+		hose2->index = 2;
+
+		luan_setup_hose(hose2,
+				LUAN_PCIX2_LOWER_MEM,
+				LUAN_PCIX2_UPPER_MEM,
+				PCIX2_CFGA,
+				PCIX2_CFGD,
+				PCIX2_IO_BASE);
 
-	luan_setup_hose(hose2,
-			LUAN_PCIX2_LOWER_MEM,
-			LUAN_PCIX2_UPPER_MEM,
-			PCIX2_CFGA,
-			PCIX2_CFGD,
-			PCIX2_IO_BASE);
-
-	hose2->last_busno = pciauto_bus_scan(hose2, hose2->first_busno);
+		hose2->last_busno = pciauto_bus_scan(hose2, hose2->first_busno);
+	}
 
 	ppc_md.pci_swizzle = common_swizzle;
 	ppc_md.pci_map_irq = luan_map_irq;
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -560,8 +560,8 @@
 #define PCIX2_CFGD		0x2ec00004UL
 
 #define PCIX0_IO_BASE		0x0000000908000000ULL
-#define PCIX1_IO_BASE		0x0000000908000000ULL
-#define PCIX2_IO_BASE		0x0000000908000000ULL
+#define PCIX1_IO_BASE		0x0000000918000000ULL
+#define PCIX2_IO_BASE		0x0000000928000000ULL
 #define PCIX_IO_SIZE		0x00010000
 
 #ifdef CONFIG_440SP

--=-F6Rwf1ZqSNScsl7Sds5z--
