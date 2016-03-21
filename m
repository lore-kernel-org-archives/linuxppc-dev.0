Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTQw93Vb3zDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 06:32:57 +1100 (AEDT)
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 21 Mar 2016 19:32:53 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 302D11B08090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 19:33:22 +0000 (GMT)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2LJWoVH8388864
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 19:32:50 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2LJWn5q010711
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 13:32:50 -0600
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 next] cxl: Allow initialization on timebase sync failures
Date: Mon, 21 Mar 2016 14:32:48 -0500
Message-Id: <1458588768-21253-1-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1458304941-19393-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Failure to synchronize the PSL timebase currently prevents the
initialization of the cxl card, thus rendering the card useless. This
is too extreme for a feature which is rarely used, if at all. No
hardware AFUs or software is currently using PSL timebase.

This patch still tries to synchronize the PSL timebase when the card
is initialized, but ignores the error if it can't. Instead, it reports
a status via /sys.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
Applies on current (4.6) tree.

Changelog:
version for 4.6 adds definition of psl_timebase_synced attribute for LPARs
v2: Update commit msg and a comment in code (Mikey's review)

 Documentation/ABI/testing/sysfs-class-cxl |  8 ++++++++
 drivers/misc/cxl/cxl.h                    |  1 +
 drivers/misc/cxl/guest.c                  |  6 ++++++
 drivers/misc/cxl/pci.c                    | 21 ++++++++++++---------
 drivers/misc/cxl/sysfs.c                  | 10 ++++++++++
 5 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 7fd737e..4ba0a2a 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -233,3 +233,11 @@ Description:	read/write
 		0 = don't trust, the image may be different (default)
 		1 = trust that the image will not change.
 Users:		https://github.com/ibm-capi/libcxl
+
+What:           /sys/class/cxl/<card>/psl_timebase_synced
+Date:           March 2016
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+                Returns 1 if the psl timebase register is synchronized
+                with the core timebase register, 0 otherwise.
+Users:          https://github.com/ibm-capi/libcxl
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 38e21cf..dfdbfb0 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -579,6 +579,7 @@ struct cxl {
 	bool perst_loads_image;
 	bool perst_select_user;
 	bool perst_same_image;
+	bool psl_timebase_synced;
 };
 
 int cxl_pci_alloc_one_irq(struct cxl *adapter);
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 8213372..a83acf9 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -1101,6 +1101,12 @@ struct cxl *cxl_guest_init_adapter(struct device_node *np, struct platform_devic
 	adapter->dev.release = release_adapter;
 	dev_set_drvdata(&pdev->dev, adapter);
 
+	/*
+	 * Hypervisor controls PSL timebase initialization (p1 register).
+	 * On FW840, PSL is initialized.
+	 */
+	adapter->psl_timebase_synced = true;
+
 	if ((rc = cxl_of_read_adapter_handle(adapter, np)))
 		goto err1;
 
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 2844e97..cfae1a8 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -355,22 +355,24 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
 #define TBSYNC_CNT(n) (((u64)n & 0x7) << (63-6))
 #define _2048_250MHZ_CYCLES 1
 
-static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
+static void cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 {
 	u64 psl_tb;
 	int delta;
 	unsigned int retry = 0;
 	struct device_node *np;
 
+	adapter->psl_timebase_synced = false;
+
 	if (!(np = pnv_pci_get_phb_node(dev)))
-		return -ENODEV;
+		return;
 
 	/* Do not fail when CAPP timebase sync is not supported by OPAL */
 	of_node_get(np);
 	if (! of_get_property(np, "ibm,capp-timebase-sync", NULL)) {
 		of_node_put(np);
-		pr_err("PSL: Timebase sync: OPAL support missing\n");
-		return 0;
+		dev_info(&dev->dev, "PSL timebase inactive: OPAL support missing\n");
+		return;
 	}
 	of_node_put(np);
 
@@ -389,8 +391,8 @@ static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 	do {
 		msleep(1);
 		if (retry++ > 5) {
-			pr_err("PSL: Timebase sync: giving up!\n");
-			return -EIO;
+			dev_info(&dev->dev, "PSL timebase can't synchronize\n");
+			return;
 		}
 		psl_tb = cxl_p1_read(adapter, CXL_PSL_Timebase);
 		delta = mftb() - psl_tb;
@@ -398,7 +400,8 @@ static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 			delta = -delta;
 	} while (tb_to_ns(delta) > 16000);
 
-	return 0;
+	adapter->psl_timebase_synced = true;
+	return;
 }
 
 static int init_implementation_afu_regs(struct cxl_afu *afu)
@@ -1144,8 +1147,8 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
 	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON)))
 		goto err;
 
-	if ((rc = cxl_setup_psl_timebase(adapter, dev)))
-		goto err;
+	/* Ignore error, adapter init is not dependant on timebase sync */
+	cxl_setup_psl_timebase(adapter, dev);
 
 	if ((rc = cxl_native_register_psl_err_irq(adapter)))
 		goto err;
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 25913c0..b043c20 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -57,6 +57,15 @@ static ssize_t image_loaded_show(struct device *device,
 	return scnprintf(buf, PAGE_SIZE, "factory\n");
 }
 
+static ssize_t psl_timebase_synced_show(struct device *device,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct cxl *adapter = to_cxl_adapter(device);
+
+	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->psl_timebase_synced);
+}
+
 static ssize_t reset_adapter_store(struct device *device,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
@@ -142,6 +151,7 @@ static struct device_attribute adapter_attrs[] = {
 	__ATTR_RO(psl_revision),
 	__ATTR_RO(base_image),
 	__ATTR_RO(image_loaded),
+	__ATTR_RO(psl_timebase_synced),
 	__ATTR_RW(load_image_on_perst),
 	__ATTR_RW(perst_reloads_same_image),
 	__ATTR(reset, S_IWUSR, NULL, reset_adapter_store),
-- 
1.9.1
