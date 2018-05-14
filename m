Return-Path: <felix@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40kv394m2kzF3SC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 18:28:05 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4E8P2sY048474
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 04:28:02 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hy5sjb3mu-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 04:28:02 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.ibm.com>;
 Mon, 14 May 2018 09:28:00 +0100
From: Philippe Bergheaud <felix@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.ibm.com, clombard@linux.ibm.com, benh@au1.ibm.com,
 Philippe Bergheaud <felix@linux.ibm.com>
Subject: [PATCH v4 2/2] cxl: Report the tunneled operations status
Date: Mon, 14 May 2018 10:27:36 +0200
In-Reply-To: <20180514082736.3699-1-felix@linux.ibm.com>
References: <20180514082736.3699-1-felix@linux.ibm.com>
Message-Id: <20180514082736.3699-2-felix@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Failure to synchronize the tunneled operations does not prevent
the initialization of the cxl card. This patch reports the tunneled
operations status via /sys.

Signed-off-by: Philippe Bergheaud <felix@linux.ibm.com>
---
v3: Added this patch to report the tunneled operations status.

v4: Updated Documentation/ABI/testing/sysfs-class-cxl.
---
 Documentation/ABI/testing/sysfs-class-cxl |  8 ++++++++
 drivers/misc/cxl/cxl.h                    |  1 +
 drivers/misc/cxl/pci.c                    |  7 ++++++-
 drivers/misc/cxl/sysfs.c                  | 10 ++++++++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 640f65e79ef1..8e69345c37cc 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -244,3 +244,11 @@ Description:    read only
                 Returns 1 if the psl timebase register is synchronized
                 with the core timebase register, 0 otherwise.
 Users:          https://github.com/ibm-capi/libcxl
+
+What:           /sys/class/cxl/<card>/tunneled_ops_supported
+Date:           May 2018
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+                Returns 1 if tunneled operations are supported in capi mode,
+                0 otherwise.
+Users:          https://github.com/ibm-capi/libcxl
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index a4c9c8297a6d..918d4fb742d1 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -717,6 +717,7 @@ struct cxl {
 	bool perst_select_user;
 	bool perst_same_image;
 	bool psl_timebase_synced;
+	bool tunneled_ops_supported;
 
 	/*
 	 * number of contexts mapped on to this card. Possible values are:
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 355c789406f7..008f50a0c465 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -1742,9 +1742,14 @@ static int cxl_configure_adapter(struct cxl *adapter, struct pci_dev *dev)
 	/* Required for devices using CAPP DMA mode, harmless for others */
 	pci_set_master(dev);
 
-	if (cxl_is_power9())
+	adapter->tunneled_ops_supported = false;
+
+	if (cxl_is_power9()) {
 		if (pnv_pci_set_tunnel_bar(dev, 0x00020000E0000000ull, 1))
 			dev_info(&dev->dev, "Tunneled operations unsupported\n");
+		else
+			adapter->tunneled_ops_supported = true;
+	}
 
 	if ((rc = pnv_phb_to_cxl_mode(dev, adapter->native->sl_ops->capi_mode)))
 		goto err;
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 95285b7f636f..4b5a4c5d3c01 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -78,6 +78,15 @@ static ssize_t psl_timebase_synced_show(struct device *device,
 	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->psl_timebase_synced);
 }
 
+static ssize_t tunneled_ops_supported_show(struct device *device,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct cxl *adapter = to_cxl_adapter(device);
+
+	return scnprintf(buf, PAGE_SIZE, "%i\n", adapter->tunneled_ops_supported);
+}
+
 static ssize_t reset_adapter_store(struct device *device,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
@@ -183,6 +192,7 @@ static struct device_attribute adapter_attrs[] = {
 	__ATTR_RO(base_image),
 	__ATTR_RO(image_loaded),
 	__ATTR_RO(psl_timebase_synced),
+	__ATTR_RO(tunneled_ops_supported),
 	__ATTR_RW(load_image_on_perst),
 	__ATTR_RW(perst_reloads_same_image),
 	__ATTR(reset, S_IWUSR, NULL, reset_adapter_store),
-- 
2.16.3
