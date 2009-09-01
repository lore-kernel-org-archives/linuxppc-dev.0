Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D7D4DB7B92
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 17:34:49 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 182B8DDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Sep 2009 17:34:48 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n817Yb9l029665
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Sep 2009 02:34:38 -0500
Subject: [PATCH v2] powerpc: Fix some late PowerMac G5 with PCIe ATI graphics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 01 Sep 2009 17:34:36 +1000
Message-Id: <1251790476.14675.314.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A misconfiguration by the firmware of the U4 PCIe bridge on PowerMac G5
with the U4 bridge (latest generations, may also affect the iMac G5
"iSight") is causing us to re-assign the PCI BARs of the video card,
which can get it out of sync with the firmware, thus breaking offb.

This works around it by fixing up the bridge configuration properly
at boot time. It also fixes a bug where the firmware provides us with
an incorrect set of accessible regions in the device-tree. 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 04cdd32..e81403b 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -1286,3 +1286,64 @@ static void fixup_k2_sata(struct pci_dev* dev)
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SERVERWORKS, 0x0240, fixup_k2_sata);
 
+/*
+ * On U4 (aka CPC945) the PCIe root complex "P2P" bridge resource ranges aren't
+ * configured by the firmware. The bridge itself seems to ignore them but it
+ * causes problems with Linux which then re-assigns devices below the bridge,
+ * thus changing addresses of those devices from what was in the device-tree,
+ * which sucks when those are video cards using offb
+ *
+ * We could just mark it transparent but I prefer fixing up the resources to
+ * properly show what's going on here, as I have some doubts about having them
+ * badly configured potentially being an issue for DMA.
+ *
+ * We leave PIO alone, it seems to be fine
+ *
+ * Oh and there's another funny bug. The OF properties advertize the region
+ * 0xf1000000..0xf1ffffff as being forwarded as memory space. But that's
+ * actually not true, this region is the memory mapped config space. So we
+ * also need to filter it out or we'll map things in the wrong place.
+ */
+static void fixup_u4_pcie(struct pci_dev* dev)
+{
+	struct pci_controller *host = pci_bus_to_host(dev->bus);
+	struct resource *region = NULL;
+	u32 reg;
+	int i;
+
+	/* Only do that on PowerMac */
+	if (!machine_is(powermac))
+		return;
+
+	/* Find the largest MMIO region */
+	for (i = 0; i < 3; i++) {
+		struct resource *r = &host->mem_resources[i];
+		if (!(r->flags & IORESOURCE_MEM))
+			continue;
+		/* Skip the 0xf0xxxxxx..f2xxxxxx regions, we know they
+		 * are reserved by HW for other things
+		 */
+		if (r->start >= 0xf0000000 && r->start < 0xf3000000)
+			continue;
+		if (!region || (r->end - r->start) >
+		    (region->end - region->start))
+			region = r;
+	}
+	/* Nothing found, bail */
+	if (region == 0)
+		return;
+
+	/* Print things out */
+	printk(KERN_INFO "PCI: Fixup U4 PCIe bridge range: %pR\n", region);
+
+	/* Fixup bridge config space. We know it's a Mac, resource aren't
+	 * offset so let's just blast them as-is. We also know that they
+	 * fit in 32 bits
+	 */
+	reg = ((region->start >> 16) & 0xfff0) | (region->end & 0xfff00000);
+	pci_write_config_dword(dev, PCI_MEMORY_BASE, reg);
+	pci_write_config_dword(dev, PCI_PREF_BASE_UPPER32, 0);
+	pci_write_config_dword(dev, PCI_PREF_LIMIT_UPPER32, 0);
+	pci_write_config_dword(dev, PCI_PREF_MEMORY_BASE, 0);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_U4_PCIE, fixup_u4_pcie);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0f71812..148d742 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -876,6 +876,7 @@
 #define PCI_DEVICE_ID_APPLE_SH_SUNGEM   0x0051
 #define PCI_DEVICE_ID_APPLE_U3L_AGP	0x0058
 #define PCI_DEVICE_ID_APPLE_U3H_AGP	0x0059
+#define PCI_DEVICE_ID_APPLE_U4_PCIE	0x005b
 #define PCI_DEVICE_ID_APPLE_IPID2_AGP	0x0066
 #define PCI_DEVICE_ID_APPLE_IPID2_ATA	0x0069
 #define PCI_DEVICE_ID_APPLE_IPID2_FW	0x006a
-- 
1.6.1.2.14.gf26b5
