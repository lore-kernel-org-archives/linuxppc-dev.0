Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRPxx0Y1mzDqHw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 23:42:28 +1100 (AEDT)
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 18 Mar 2016 12:42:25 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 51F101B0806E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 12:42:52 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2ICgMM465077270
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 12:42:22 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2ICgM6f027596
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 08:42:22 -0400
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] cxl: Allow initialization on timebase sync failures
Date: Fri, 18 Mar 2016 13:42:21 +0100
Message-Id: <1458304941-19393-1-git-send-email-fbarrat@linux.vnet.ibm.com>
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
Acked-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
Applies on 4.5 tree. Version to be picked-up potentially by distros.
Needs a refresh for linux-next due to the powerVM patchset. Coming up.

Changelog:
v2: Update commit msg and a comment in code (Mikey's review)
    Remove ball of negativity within me.



 Documentation/ABI/testing/sysfs-class-cxl |  8 ++++++++
 drivers/misc/cxl/cxl.h                    |  1 +
 drivers/misc/cxl/pci.c                    | 21 ++++++++++++---------
 drivers/misc/cxl/sysfs.c                  | 10 ++++++++++
 4 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index b07e86d..ba33cdf 100644
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
\ No newline at end of file
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index a521bc7..baa5052 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -517,6 +517,7 @@ struct cxl {
 	bool perst_loads_image;
 	bool perst_select_user;
 	bool perst_same_image;
+	bool psl_timebase_synced;
 };
 
 int cxl_alloc_one_irq(struct cxl *adapter);
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 0c6c17a1..d53a4a8 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -374,22 +374,24 @@ static int init_implementation_adapter_regs(struct cxl *adapter, struct pci_dev
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
 
@@ -408,8 +410,8 @@ static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
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
@@ -417,7 +419,8 @@ static int cxl_setup_psl_timebase(struct cxl *adapter, struct pci_dev *dev)
 			delta = -delta;
 	} while (tb_to_ns(delta) > 16000);
 
-	return 0;
+	adapter->psl_timebase_synced = true;
+	return;
 }
 
 static int init_implementation_afu_regs(struct cxl_afu *afu)
@@ -1189,8 +1192,8 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
 	if ((rc = pnv_phb_to_cxl_mode(dev, OPAL_PHB_CAPI_MODE_SNOOP_ON)))
 		goto err;
 
-	if ((rc = cxl_setup_psl_timebase(adapter, dev)))
-		goto err;
+	/* Ignore error, adapter init is not dependant on timebase sync */
+	cxl_setup_psl_timebase(adapter, dev);
 
 	if ((rc = cxl_register_psl_err_irq(adapter)))
 		goto err;
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 02006f71..b4bb9b2 100644
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
