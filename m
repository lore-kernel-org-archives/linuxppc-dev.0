Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9F74E1A0CD7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 04:15:04 +1100 (AEDT)
Received: from e06smtp08.uk.ibm.com (e06smtp08.uk.ibm.com [195.75.94.104])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F136140307
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Jan 2016 04:15:02 +1100 (AEDT)
Received: from localhost
 by e06smtp08.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 19 Jan 2016 17:14:59 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 047962190023
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2016 17:14:44 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0JHEt8k10879248
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2016 17:14:55 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0JHEtVR014459
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2016 10:14:55 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com, linuxppc-dev@ozlabs.org
Subject: [PATCH] cxl: Add cxl_read_adapter_vpd() to the kernel API
Date: Tue, 19 Jan 2016 18:14:54 +0100
Message-Id: <1453223694-5190-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce a new API to read the VPD of the adapter. In bare-metal, a
kernel driver can find out the adapter pci_dev behind the AFU device
and call pci_read_vpd() directly, but it won't work in a (powerVM)
guest.
Current implementation is a stub to allow existing drivers (cxlflash)
to start using it.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c | 8 ++++++++
 include/misc/cxl.h     | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index ea3eeb7..c73aa3a 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -363,3 +363,11 @@ void cxl_perst_reloads_same_image(struct cxl_afu *afu,
 	afu->adapter->perst_same_image = perst_reloads_same_image;
 }
 EXPORT_SYMBOL_GPL(cxl_perst_reloads_same_image);
+
+ssize_t cxl_read_adapter_vpd(struct pci_dev *afu_dev, void *buf, size_t count)
+{
+	struct device *parent = cxl_get_phys_dev(afu_dev);
+
+	return pci_read_vpd(to_pci_dev(parent), 0, count, buf);
+}
+EXPORT_SYMBOL_GPL(cxl_read_adapter_vpd);
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index f2ffe5b..3f9e84f 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -210,4 +210,9 @@ ssize_t cxl_fd_read(struct file *file, char __user *buf, size_t count,
 void cxl_perst_reloads_same_image(struct cxl_afu *afu,
 				  bool perst_reloads_same_image);
 
+/*
+ * Read the VPD of the adapter where the AFU pci dev resides
+ */
+ssize_t cxl_read_adapter_vpd(struct pci_dev *afu_dev, void *buf, size_t count);
+
 #endif /* _MISC_CXL_H */
-- 
1.9.1
