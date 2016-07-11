Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rp3N570DszDqyN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:51:33 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6BBnIGO037799
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 07:51:31 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 243enqpesj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 07:51:31 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 11 Jul 2016 21:51:27 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 68A522CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:51:26 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6BBpQaN18350116
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:51:26 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6BBpPaQ030956
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 21:51:26 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH 02/15] cxl: Add cxl_slot_is_supported API
Date: Mon, 11 Jul 2016 21:50:09 +1000
In-Reply-To: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
References: <1468237822-26276-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468237822-26276-3-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This extends the check that the adapter is in a CAPI capable slot so
that it may be called by external users in the kernel API. This will be
used by the upcoming Mellanox CX4 support, which needs to know ahead of
time if the card can be switched to cxl mode so that it can leave it in
PCI mode if it is not.

This API takes a parameter to check if CAPP DMA mode is supported, which
it currently only allows on P8NVL systems, since that mode currently has
issues accessing memory < 4GB on P8, and we cannot realistically avoid
that.

This API does not currently check if a CAPP unit is available (i.e. not
already assigned to another PHB) on P8. Doing so would be racy since it
is assigned on a first come first serve basis, and so long as CAPP DMA
mode is not supported on P8 we don't need this, since the only
anticipated user of this API requires CAPP DMA mode.

Cc: Philippe Bergheaud <felix@linux.vnet.ibm.com>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

---

V1->V2:
	- Fixed typos in comments spotted by Andrew
---
 drivers/misc/cxl/pci.c | 37 +++++++++++++++++++++++++++++++++++++
 include/misc/cxl.h     | 15 +++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 3a5f980..6ac6b05 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1426,6 +1426,43 @@ static int cxl_slot_is_switched(struct pci_dev *dev)
 	return (depth > CXL_MAX_PCIEX_PARENT);
 }
 
+bool cxl_slot_is_supported(struct pci_dev *dev, int flags)
+{
+	if (!cpu_has_feature(CPU_FTR_HVMODE))
+		return false;
+
+	if ((flags & CXL_SLOT_FLAG_DMA) && (!pvr_version_is(PVR_POWER8NVL))) {
+		/*
+		 * CAPP DMA mode is technically supported on regular P8, but
+		 * will EEH if the card attempts to access memory < 4GB, which
+		 * we cannot realistically avoid. We might be able to work
+		 * around the issue, but until then return unsupported:
+		 */
+		return false;
+	}
+
+	if (cxl_slot_is_switched(dev))
+		return false;
+
+	/*
+	 * XXX: This gets a little tricky on regular P8 (not POWER8NVL) since
+	 * the CAPP can be connected to PHB 0, 1 or 2 on a first come first
+	 * served basis, which is racy to check from here. If we need to
+	 * support this in future we might need to consider having this
+	 * function effectively reserve it ahead of time.
+	 *
+	 * Currently, the only user of this API is the Mellanox CX4, which is
+	 * only supported on P8NVL due to the above mentioned limitation of
+	 * CAPP DMA mode and therefore does not need to worry about this. If the
+	 * issue with CAPP DMA mode is later worked around on P8 we might need
+	 * to revisit this.
+	 */
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(cxl_slot_is_supported);
+
+
 static int cxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct cxl *adapter;
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index b6d040f..dd9eebb 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -24,6 +24,21 @@
  * generic PCI API. This API is agnostic to the actual AFU.
  */
 
+#define CXL_SLOT_FLAG_DMA 0x1
+
+/*
+ * Checks if the given card is in a cxl capable slot. Pass CXL_SLOT_FLAG_DMA if
+ * the card requires CAPP DMA mode to also check if the system supports it.
+ * This is intended to be used by bi-modal devices to determine if they can use
+ * cxl mode or if they should continue running in PCI mode.
+ *
+ * Note that this only checks if the slot is cxl capable - it does not
+ * currently check if the CAPP is currently available for chips where it can be
+ * assigned to different PHBs on a first come first serve basis (i.e. P8)
+ */
+bool cxl_slot_is_supported(struct pci_dev *dev, int flags);
+
+
 /* Get the AFU associated with a pci_dev */
 struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev);
 
-- 
2.8.1
