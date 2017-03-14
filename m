Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj1Qy4tq9zDqZm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 15:07:22 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2E3xJ6E090872
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 00:07:10 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2963vr3nh6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 00:07:09 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Tue, 14 Mar 2017 09:37:06 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2E473In34668588
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 09:37:03 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2E4712e016223
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 09:37:02 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: [PATCH 2/3] cxl: Introduce afu_desc sysfs attribute
Date: Tue, 14 Mar 2017 09:36:05 +0530
In-Reply-To: <20170314040606.16894-1-vaibhav@linux.vnet.ibm.com>
References: <20170314040606.16894-1-vaibhav@linux.vnet.ibm.com>
Message-Id: <20170314040606.16894-3-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch introduces a new afu sysfs attribute named afu_desc. This
binary attribute provides access to raw contents of the afu descriptor
to user-space. Direct access to afu descriptor is useful for libcxl
that can use it to determine if the CXL card has been fenced or
provide application access to afu attributes beyond one defined in
CAIA.

We introduce three new backend-ops:

* afu_desc_size(): Return the size in bytes of the afu descriptor.

* afu_desc_read(): Copy into a provided buffer contents of afu
  descriptor starting at specific offset.

* afu_desc_mmap(): Memory map the afu descriptor to the given
  vm_area_struct.

If afu_desc_size() > 0 the afu_desc attribute gets created for the AFU.
The bin_attribute callbacks route the calls to corresponding cxl backend
implementation.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-class-cxl |  9 +++++++
 drivers/misc/cxl/cxl.h                    |  9 +++++++
 drivers/misc/cxl/sysfs.c                  | 45 +++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index 640f65e..9ac84c4 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -6,6 +6,15 @@ Example: The real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
 
 Slave contexts (eg. /sys/class/cxl/afu0.0s):
 
+What:           /sys/class/cxl/<afu>/afu_desc
+Date:           March 2016
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+                AFU Descriptor contents. The contents of this file are
+		binary contents of the AFU descriptor. LIBCXL library can
+		use this file to read afu descriptor and in some special cases
+		determine if the cxl card has been fenced.
+
 What:           /sys/class/cxl/<afu>/afu_err_buf
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index ef683b7..1c43d06 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -426,6 +426,9 @@ struct cxl_afu {
 	u64 eb_len, eb_offset;
 	struct bin_attribute attr_eb;
 
+	/* Afu descriptor */
+	struct bin_attribute attr_afud;
+
 	/* pointer to the vphb */
 	struct pci_controller *phb;
 
@@ -995,6 +998,12 @@ struct cxl_backend_ops {
 	int (*afu_cr_write16)(struct cxl_afu *afu, int cr_idx, u64 offset, u16 val);
 	int (*afu_cr_write32)(struct cxl_afu *afu, int cr_idx, u64 offset, u32 val);
 	ssize_t (*read_adapter_vpd)(struct cxl *adapter, void *buf, size_t count);
+	/* Access to AFU descriptor */
+	ssize_t (*afu_desc_size)(struct cxl_afu *afu);
+	ssize_t (*afu_desc_read)(struct cxl_afu *afu, char *buf, loff_t off,
+				 size_t count);
+	int (*afu_desc_mmap)(struct cxl_afu *afu, struct file *filp,
+			     struct vm_area_struct *vma);
 };
 extern const struct cxl_backend_ops cxl_native_ops;
 extern const struct cxl_backend_ops cxl_guest_ops;
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index a8b6d6a..fff3468 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -426,6 +426,26 @@ static ssize_t afu_eb_read(struct file *filp, struct kobject *kobj,
 	return cxl_ops->afu_read_err_buffer(afu, buf, off, count);
 }
 
+static ssize_t afu_desc_read(struct file *filp, struct kobject *kobj,
+			     struct bin_attribute *bin_attr, char *buf,
+			     loff_t off, size_t count)
+{
+	struct cxl_afu *afu = to_cxl_afu(kobj_to_dev(kobj));
+
+	return cxl_ops->afu_desc_read ?
+		cxl_ops->afu_desc_read(afu, buf, off, count) : -EIO;
+}
+
+static int afu_desc_mmap(struct file *filp, struct kobject *kobj,
+			 struct bin_attribute *attr, struct vm_area_struct *vma)
+{
+	struct cxl_afu *afu = to_cxl_afu(kobj_to_dev(kobj));
+
+	return cxl_ops->afu_desc_mmap ?
+		cxl_ops->afu_desc_mmap(afu, filp, vma) : -EINVAL;
+}
+
+
 static struct device_attribute afu_attrs[] = {
 	__ATTR_RO(mmio_size),
 	__ATTR_RO(irqs_min),
@@ -625,6 +645,9 @@ void cxl_sysfs_afu_remove(struct cxl_afu *afu)
 	struct afu_config_record *cr, *tmp;
 	int i;
 
+	if (afu->attr_afud.size > 0)
+		device_remove_bin_file(&afu->dev, &afu->attr_afud);
+
 	/* remove the err buffer bin attribute */
 	if (afu->eb_len)
 		device_remove_bin_file(&afu->dev, &afu->attr_eb);
@@ -686,6 +709,28 @@ int cxl_sysfs_afu_add(struct cxl_afu *afu)
 		list_add(&cr->list, &afu->crs);
 	}
 
+	/* Create the sysfs binattr for afu-descriptor */
+	afu->attr_afud.size = cxl_ops->afu_desc_size ?
+		cxl_ops->afu_desc_size(afu) : 0;
+
+	if (afu->attr_afud.size > 0) {
+		sysfs_attr_init(&afu->attr_afud.attr);
+		afu->attr_afud.attr.name = "afu_desc";
+		afu->attr_afud.attr.mode = 0444;
+		afu->attr_afud.read = afu_desc_read;
+		afu->attr_afud.mmap = afu_desc_mmap;
+
+		rc = device_create_bin_file(&afu->dev, &afu->attr_afud);
+		if (rc) {
+			/* indicate that we did'nt create the sysfs attr */
+			afu->attr_afud.size = 0;
+			dev_err(&afu->dev,
+				"Unable to create afu_desc attr for the afu. Err(%d)\n",
+				rc);
+			goto err1;
+		}
+	}
+
 	return 0;
 
 err1:
-- 
2.9.3
