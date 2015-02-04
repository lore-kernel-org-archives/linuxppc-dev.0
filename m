Return-Path: <imunsie@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30B201A09D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 19:10:24 +1100 (AEDT)
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0B9A0140180
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2015 19:10:23 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 4 Feb 2015 18:10:22 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AC28D2CE8050
 for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2015 19:10:19 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t148AB2239977212
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2015 19:10:19 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1489i8j004916
 for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2015 19:09:46 +1100
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: mpe <mpe@ellerman.id.au>
Subject: [PATCH 1/2] cxl: Export optional AFU configuration record in sysfs
Date: Wed,  4 Feb 2015 19:09:01 +1100
Message-Id: <1423037342-26753-1-git-send-email-imunsie@au.ibm.com>
Cc: mikey <mikey@neuling.org>, Vaibhav Jain <vajain21@in.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Ryan Grimm <grimm@linux.vnet.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

An AFU may optionally contain one or more PCIe like configuration
records, which can be used to identify the AFU.

This patch adds support for exposing the raw config space and the
vendor, device and class code under sysfs. These will appear in a
subdirectory of the AFU device corresponding with the configuration
record number, e.g.

cat /sys/class/cxl/afu0.0/cr0/vendor
0x1014

cat /sys/class/cxl/afu0.0/cr0/device
0x4350

cat /sys/class/cxl/afu0.0/cr0/class
0x120000

hexdump -C /sys/class/cxl/afu0.0/cr0/config
00000000  14 10 50 43 00 00 00 00  06 00 00 12 00 00 00 00  |..PC............|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000100

These files behave in much the same way as the equivalent files for PCI
devices, with one exception being that the config file is currently
read-only and restricted to the root user. It is not necessarily
required to be this strict, but we currently do not have a compelling
use-case to make it writable and/or world-readable, so I erred on the
side of being restrictive.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 Documentation/ABI/testing/sysfs-class-cxl |  37 ++++++
 drivers/misc/cxl/cxl.h                    |  13 +++
 drivers/misc/cxl/pci.c                    |  23 ++++
 drivers/misc/cxl/sysfs.c                  | 179 ++++++++++++++++++++++++++++--
 4 files changed, 242 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index db31176..23aad38 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -76,6 +76,43 @@ Description:    read only
 
 
 
+AFU configuration records (eg. /sys/class/cxl/afu0.0/cr0):
+
+An AFU may optionally export one or more PCIe like configuration records, known
+as AFU configuration records, which will show up here (if present).
+
+What:           /sys/class/cxl/<afu>/cr<config num>/vendor
+Date:           February 2015
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+		Hexadecimal value of the vendor ID found in this AFU
+		configuration record.
+
+What:           /sys/class/cxl/<afu>/cr<config num>/device
+Date:           February 2015
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+		Hexadecimal value of the device ID found in this AFU
+		configuration record.
+
+What:           /sys/class/cxl/<afu>/cr<config num>/vendor
+Date:           February 2015
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+		Hexadecimal value of the class code found in this AFU
+		configuration record.
+
+What:           /sys/class/cxl/<afu>/cr<config num>/config
+Date:           February 2015
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+		This binary file provides raw access to the AFU configuration
+		record. The format is expected to match the either the standard
+		or extended configuration space defined by the PCIe
+		specification.
+
+
+
 Master contexts (eg. /sys/class/cxl/afu0.0m)
 
 What:           /sys/class/cxl/<afu>m/mmio_size
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 6a6a487..a1cee47 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -382,6 +382,10 @@ struct cxl_afu {
 	int slice;
 	int modes_supported;
 	int current_mode;
+	int crs_num;
+	u64 crs_len;
+	u64 crs_offset;
+	struct list_head crs;
 	enum prefault_modes prefault_mode;
 	bool psa;
 	bool pp_psa;
@@ -551,6 +555,15 @@ static inline void __iomem *_cxl_p2n_addr(struct cxl_afu *afu, cxl_p2n_reg_t reg
 #define cxl_p2n_read(afu, reg) \
 	in_be64(_cxl_p2n_addr(afu, reg))
 
+
+#define cxl_afu_cr_read64(afu, cr, off) \
+	in_le64((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off))
+#define cxl_afu_cr_read32(afu, cr, off) \
+	in_le32((afu)->afu_desc_mmio + (afu)->crs_offset + ((cr) * (afu)->crs_len) + (off))
+u16 cxl_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off);
+u8 cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off);
+
+
 struct cxl_calls {
 	void (*cxl_slbia)(struct mm_struct *mm);
 	struct module *owner;
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 5137ee5..128481e 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -114,6 +114,24 @@
 #define   AFUD_EB_LEN(val)		EXTRACT_PPC_BITS(val, 8, 63)
 #define AFUD_READ_EB_OFF(afu)		AFUD_READ(afu, 0x48)
 
+u16 cxl_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off)
+{
+	u64 aligned_off = off & ~0x3L;
+	u32 val;
+
+	val = cxl_afu_cr_read32(afu, cr, aligned_off);
+	return (val >> ((off & 0x2) * 8)) & 0xffff;
+}
+
+u8 cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off)
+{
+	u64 aligned_off = off & ~0x3L;
+	u32 val;
+
+	val = cxl_afu_cr_read32(afu, cr, aligned_off);
+	return (val >> ((off & 0x3) * 8)) & 0xff;
+}
+
 static DEFINE_PCI_DEVICE_TABLE(cxl_pci_tbl) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x0477), },
 	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x044b), },
@@ -557,6 +575,7 @@ static int cxl_read_afu_descriptor(struct cxl_afu *afu)
 	val = AFUD_READ_INFO(afu);
 	afu->pp_irqs = AFUD_NUM_INTS_PER_PROC(val);
 	afu->max_procs_virtualised = AFUD_NUM_PROCS(val);
+	afu->crs_num = AFUD_NUM_CRS(val);
 
 	if (AFUD_AFU_DIRECTED(val))
 		afu->modes_supported |= CXL_MODE_DIRECTED;
@@ -571,6 +590,10 @@ static int cxl_read_afu_descriptor(struct cxl_afu *afu)
 	if ((afu->pp_psa = AFUD_PPPSA_PP(val)))
 		afu->pp_offset = AFUD_READ_PPPSA_OFF(afu);
 
+	val = AFUD_READ_CR(afu);
+	afu->crs_len = AFUD_CR_LEN(val) * 256;
+	afu->crs_offset = AFUD_READ_CR_OFF(afu);
+
 	return 0;
 }
 
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index adf1f6d..d0c38c7 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/sysfs.h>
+#include <linux/pci_regs.h>
 
 #include "cxl.h"
 
@@ -367,8 +368,6 @@ static struct device_attribute afu_attrs[] = {
 	__ATTR(reset, S_IWUSR, NULL, reset_store_afu),
 };
 
-
-
 int cxl_sysfs_adapter_add(struct cxl *adapter)
 {
 	int i, rc;
@@ -391,31 +390,191 @@ void cxl_sysfs_adapter_remove(struct cxl *adapter)
 		device_remove_file(&adapter->dev, &adapter_attrs[i]);
 }
 
+struct afu_config_record {
+	struct kobject kobj;
+	struct bin_attribute config_attr;
+	struct list_head list;
+	int cr;
+	u16 device;
+	u16 vendor;
+	u32 class;
+};
+
+#define to_cr(obj) container_of(obj, struct afu_config_record, kobj)
+
+static ssize_t vendor_show(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	struct afu_config_record *cr = to_cr(kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%.4x\n", cr->vendor);
+}
+
+static ssize_t device_show(struct kobject *kobj,
+			   struct kobj_attribute *attr, char *buf)
+{
+	struct afu_config_record *cr = to_cr(kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%.4x\n", cr->device);
+}
+
+static ssize_t class_show(struct kobject *kobj,
+			  struct kobj_attribute *attr, char *buf)
+{
+	struct afu_config_record *cr = to_cr(kobj);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%.6x\n", cr->class);
+}
+
+static ssize_t afu_read_config(struct file *filp, struct kobject *kobj,
+			       struct bin_attribute *bin_attr, char *buf,
+			       loff_t off, size_t count)
+{
+	struct afu_config_record *cr = to_cr(kobj);
+	struct cxl_afu *afu = to_cxl_afu(container_of(kobj->parent, struct device, kobj));
+
+	u64 i, j, val, size = afu->crs_len;
+
+	if (off > size)
+		return 0;
+	if (off + count > size)
+		count = size - off;
+
+	for (i = 0; i < count;) {
+		val = cxl_afu_cr_read64(afu, cr->cr, off & ~0x7);
+		for (j = off & 0x7; j < 8 && i < count; i++, j++, off++)
+			buf[i] = (val >> (j * 8)) & 0xff;
+	}
+
+	return count;
+}
+
+static struct kobj_attribute vendor_attribute =
+	__ATTR_RO(vendor);
+static struct kobj_attribute device_attribute =
+	__ATTR_RO(device);
+static struct kobj_attribute class_attribute =
+	__ATTR_RO(class);
+
+static struct attribute *afu_cr_attrs[] = {
+	&vendor_attribute.attr,
+	&device_attribute.attr,
+	&class_attribute.attr,
+	NULL,
+};
+
+static void release_afu_config_record(struct kobject *kobj)
+{
+	struct afu_config_record *cr = to_cr(kobj);
+
+	kfree(cr);
+}
+
+static struct kobj_type afu_config_record_type = {
+	.sysfs_ops = &kobj_sysfs_ops,
+	.release = release_afu_config_record,
+	.default_attrs = afu_cr_attrs,
+};
+
+static struct afu_config_record *cxl_sysfs_afu_new_cr(struct cxl_afu *afu, int cr_idx)
+{
+	struct afu_config_record *cr;
+	int rc;
+
+	cr = kzalloc(sizeof(struct afu_config_record), GFP_KERNEL);
+	if (!cr)
+		return ERR_PTR(-ENOMEM);
+
+	cr->cr = cr_idx;
+	cr->device = cxl_afu_cr_read16(afu, cr_idx, PCI_DEVICE_ID);
+	cr->vendor = cxl_afu_cr_read16(afu, cr_idx, PCI_VENDOR_ID);
+	cr->class = cxl_afu_cr_read32(afu, cr_idx, PCI_CLASS_REVISION) >> 8;
+
+	/*
+	 * Export raw AFU PCIe like config record. For now this is read only by
+	 * root - we can expand that later to be readable by non-root and maybe
+	 * even writable provided we have a good use-case. Once we suport
+	 * exposing AFUs through a virtual PHB they will get that for free from
+	 * Linux' PCI infrastructure, but until then it's not clear that we
+	 * need it for anything since the main use case is just identifying
+	 * AFUs, which can be done via the vendor, device and class attributes.
+	 */
+	sysfs_bin_attr_init(&cr->config_attr);
+	cr->config_attr.attr.name = "config";
+	cr->config_attr.attr.mode = S_IRUSR;
+	cr->config_attr.size = afu->crs_len;
+	cr->config_attr.read = afu_read_config;
+
+	rc = kobject_init_and_add(&cr->kobj, &afu_config_record_type,
+				  &afu->dev.kobj, "cr%i", cr->cr);
+	if (rc)
+		goto err;
+
+	rc = sysfs_create_bin_file(&cr->kobj, &cr->config_attr);
+	if (rc)
+		goto err1;
+
+	rc = kobject_uevent(&cr->kobj, KOBJ_ADD);
+	if (rc)
+		goto err2;
+
+	return cr;
+err2:
+	sysfs_remove_bin_file(&cr->kobj, &cr->config_attr);
+err1:
+	kobject_put(&cr->kobj);
+	return ERR_PTR(rc);
+err:
+	kfree(cr);
+	return ERR_PTR(rc);
+}
+
+void cxl_sysfs_afu_remove(struct cxl_afu *afu)
+{
+	struct afu_config_record *cr, *tmp;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++)
+		device_remove_file(&afu->dev, &afu_attrs[i]);
+
+	list_for_each_entry_safe(cr, tmp, &afu->crs, list) {
+		sysfs_remove_bin_file(&cr->kobj, &cr->config_attr);
+		kobject_put(&cr->kobj);
+	}
+}
+
 int cxl_sysfs_afu_add(struct cxl_afu *afu)
 {
+	struct afu_config_record *cr;
 	int i, rc;
 
+	INIT_LIST_HEAD(&afu->crs);
+
 	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++) {
 		if ((rc = device_create_file(&afu->dev, &afu_attrs[i])))
 			goto err;
 	}
 
+	for (i = 0; i < afu->crs_num; i++) {
+		cr = cxl_sysfs_afu_new_cr(afu, i);
+		if (IS_ERR(cr)) {
+			rc = PTR_ERR(cr);
+			goto err1;
+		}
+		list_add(&cr->list, &afu->crs);
+	}
+
 	return 0;
 
+err1:
+	cxl_sysfs_afu_remove(afu);
+	return rc;
 err:
 	for (i--; i >= 0; i--)
 		device_remove_file(&afu->dev, &afu_attrs[i]);
 	return rc;
 }
 
-void cxl_sysfs_afu_remove(struct cxl_afu *afu)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++)
-		device_remove_file(&afu->dev, &afu_attrs[i]);
-}
-
 int cxl_sysfs_afu_m_add(struct cxl_afu *afu)
 {
 	int i, rc;
-- 
2.1.4
