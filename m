Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8202F1A04D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 15:24:50 +1000 (AEST)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 20626140773
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2015 15:24:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Fri, 2 Oct 2015 15:24:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 626B42CE8055
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Oct 2015 15:24:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t925Obie57802788
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Oct 2015 15:24:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t925OCZ4028112
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Oct 2015 15:24:13 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <michaele@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Workaround malformed pcie packets on some cards
Date: Fri,  2 Oct 2015 15:23:33 +1000
Message-Id: <1443763413-8318-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Philippe Bergheaud <felix@linux.vnet.ibm.com>

This works around a pcie host bridge defect on some cards, that can cause
malformed Transaction Layer Packet (TLP) errors to be erroneously reported.

The upper nibble of the vendor section PSL revision is used to distinguish
between different cards. The affected ones have it set to 0.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---

Resending this on Philippe's behalf - it seems like the original never made it
to linuxppc-dev for some reason.

 drivers/misc/cxl/pci.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index a5e9771..85761d7 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1035,6 +1035,32 @@ static int cxl_read_vsec(struct cxl *adapter, struct pci_dev *dev)
 	return 0;
 }
 
+/*
+ * Workaround a PCIe Host Bridge defect on some cards, that can cause
+ * malformed Transaction Layer Packet (TLP) errors to be erroneously
+ * reported. Mask this error in the Uncorrectable Error Mask Register.
+ *
+ * The upper nibble of the PSL revision is used to distinguish between
+ * different cards. The affected ones have it set to 0.
+ */
+static void cxl_fixup_malformed_tlp(struct cxl *adapter, struct pci_dev *dev)
+{
+	int aer;
+	u32 data;
+
+	if (adapter->psl_rev & 0xf000)
+		return;
+	if (!(aer = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR)))
+		return;
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &data);
+	if (data & PCI_ERR_UNC_MALF_TLP)
+		if (data & PCI_ERR_UNC_INTN)
+			return;
+	data |= PCI_ERR_UNC_MALF_TLP;
+	data |= PCI_ERR_UNC_INTN;
+	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, data);
+}
+
 static int cxl_vsec_looks_ok(struct cxl *adapter, struct pci_dev *dev)
 {
 	if (adapter->vsec_status & CXL_STATUS_SECOND_PORT)
@@ -1134,6 +1160,8 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
 	if ((rc = cxl_vsec_looks_ok(adapter, dev)))
 	        return rc;
 
+	cxl_fixup_malformed_tlp(adapter, dev);
+
 	if ((rc = setup_cxl_bars(dev)))
 		return rc;
 
-- 
2.1.4
