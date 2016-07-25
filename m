Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryTYv0lhQzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 14:59:14 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6P4sOvi032223
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 00:59:11 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24c4ewe6wq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 00:59:11 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 25 Jul 2016 14:59:03 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AAA493578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 14:59:00 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6P4x0Zv26214640
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 14:59:00 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6P4x00L028138
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 14:59:00 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 vaibhav@linux.vnet.ibm.com, felix@linux.vnet.ibm.com,
 huyn@mellanox.com, clombard@linux.vnet.ibm.com
Subject: [PATCH] cxl: add device ID for Mellanox ConnectX-4
Date: Mon, 25 Jul 2016 14:58:12 +1000
Message-Id: <1469422692-30782-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the cxl driver attempts to bind to any class 1200 (processing
accelerator) device, and only works out whether it's actually a CAPI card
later on. This doesn't really break anything (if it's not a CAPI card,
we'll abort very quickly), but ideally we'd like to remove this and be
explicit about the cards we support.

For CAPI-capable FPGA devices, we currently use a regular PCI_DEVICE entry
in the ID table to match the vendor and device ID. However, in the case of
some bi-modal devices, such as the Mellanox ConnectX-4, this may not be
sufficient. The CX-4 uses the same vendor and device ID whether in regular
PCIe mode or in CAPI mode, and one of its functions in PCIe mode has a CAPI
VSEC, so cxl would incorrectly try to initialise it as if it's already in
CAPI mode.

For this case, add a PCI_DEVICE_ACCEL macro which also checks the class
number, and add a device ID for the Mellanox CX-4 in CAPI mode. Don't
remove the generic class entry just yet - we'll remove it eventually after
we're certain that no end users are depending on it.

Suggested-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/pci.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index d152e2d..cc66ee2 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -118,13 +118,29 @@
 #define   AFUD_EB_LEN(val)		EXTRACT_PPC_BITS(val, 8, 63)
 #define AFUD_READ_EB_OFF(afu)		AFUD_READ(afu, 0x48)
 
+/*
+ * Matches a given PCI vendor ID and device ID, but only for class 12
+ * (processing accelerators). Useful for bi-modal cards, such as the
+ * Mellanox ConnectX-4, which keep the same vendor/device ID
+ * post-mode-switch.
+ */
+#define PCI_DEVICE_ACCEL(vend, dev) \
+	.vendor = (vend), .device = (dev), \
+	.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID, \
+	.class = 0x120000, .class_mask = 0xff0000
+
 static const struct pci_device_id cxl_pci_tbl[] = {
+	/* FPGA devices */
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0477), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x04cf), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0601), },
-	{ PCI_DEVICE_CLASS(0x120000, ~0), },
 
+	/* Mellanox ConnectX-4 */
+	{ PCI_DEVICE_ACCEL(PCI_VENDOR_ID_MELLANOX, 0x1013), },
+
+	/* Generic match for class 120000 devices, will be removed eventually */
+	{ PCI_DEVICE_CLASS(0x120000, ~0), },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, cxl_pci_tbl);
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
