Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj1RH35fFzDqbs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 15:07:39 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2E3xIZk127014
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 00:07:22 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 295yydphnn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 00:07:22 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 14 Mar 2017 09:37:19 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2E4666V13893848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 09:36:06 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2E47FWh016374
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 09:37:16 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH 3/3] cxl: Provide user-space access to afu descriptor on bare
 metal
Date: Tue, 14 Mar 2017 09:36:06 +0530
In-Reply-To: <20170314040606.16894-1-vaibhav@linux.vnet.ibm.com>
References: <20170314040606.16894-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <20170314040606.16894-4-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements cxl backend to provide user-space access to
binary afu descriptor contents via sysfs. We add a new member to
struct cxl_afu_native named phy_desc that caches the physical base
address of afu descriptor, which is then used in implementation of new
native cxl backend ops namel:

* native_afu_desc_size()
* native_afu_desc_read()
* native_afu_desc_mmap()

The implementations of all these callbacks is mostly trivial except
native_afu_desc_mmap() which maps the PFNs pointing to afu descriptor
in i/o memory, to user-space vm_area_struct.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h    |  3 +++
 drivers/misc/cxl/native.c | 33 +++++++++++++++++++++++++++++++++
 drivers/misc/cxl/pci.c    |  3 +++
 3 files changed, 39 insertions(+)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 1c43d06..c6db1fa 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -386,6 +386,9 @@ struct cxl_afu_native {
 	int spa_order;
 	int spa_max_procs;
 	u64 pp_offset;
+
+	/* Afu descriptor physical address */
+	u64 phy_desc;
 };
 
 struct cxl_afu_guest {
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 20d3df6..44e3e84 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -1330,6 +1330,36 @@ static ssize_t native_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
 	return __aligned_memcpy(buf, ebuf, off, count, afu->eb_len);
 }
 
+static ssize_t native_afu_desc_size(struct cxl_afu *afu)
+{
+	return afu->adapter->native->afu_desc_size;
+}
+
+static ssize_t native_afu_desc_read(struct cxl_afu *afu, char *buf, loff_t off,
+				     size_t count)
+{
+	return __aligned_memcpy(buf, afu->native->afu_desc_mmio, off, count,
+				afu->adapter->native->afu_desc_size);
+}
+
+static int native_afu_desc_mmap(struct cxl_afu *afu, struct file *filp,
+		     struct vm_area_struct *vma)
+{
+	u64 len = vma->vm_end - vma->vm_start;
+
+	/* Check the size vma so that it doesn't go beyond afud size */
+	if (len > native_afu_desc_size(afu)) {
+		pr_err("Requested VMA too large. Requested=%lld, Available=%ld\n",
+		       len, native_afu_desc_size(afu));
+		return -EINVAL;
+	}
+
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return vm_iomap_memory(vma, afu->native->phy_desc, len);
+}
+
 const struct cxl_backend_ops cxl_native_ops = {
 	.module = THIS_MODULE,
 	.adapter_reset = cxl_pci_reset,
@@ -1361,4 +1391,7 @@ const struct cxl_backend_ops cxl_native_ops = {
 	.afu_cr_write16 = native_afu_cr_write16,
 	.afu_cr_write32 = native_afu_cr_write32,
 	.read_adapter_vpd = cxl_pci_read_adapter_vpd,
+	.afu_desc_read = native_afu_desc_read,
+	.afu_desc_mmap = native_afu_desc_mmap,
+	.afu_desc_size =  native_afu_desc_size
 };
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 541dc9a..a6166e0 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -869,6 +869,9 @@ static int pci_map_slice_regs(struct cxl_afu *afu, struct cxl *adapter, struct p
 	if (afu_desc) {
 		if (!(afu->native->afu_desc_mmio = ioremap(afu_desc, adapter->native->afu_desc_size)))
 			goto err2;
+
+		/* Cache the afu descriptor physical address */
+		afu->native->phy_desc = afu_desc;
 	}
 
 	return 0;
-- 
2.9.3
