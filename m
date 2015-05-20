Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E82F11A060E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 20:57:03 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 20 May 2015 16:27:00 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 687141258053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 16:29:14 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4KAul8142926332
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 16:26:48 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4KAG1d2016080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 15:46:02 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] cxl: Export AFU error buffer via sysfs
Date: Wed, 20 May 2015 16:26:42 +0530
Message-Id: <1432119402-10774-1-git-send-email-vaibhav@linux.vnet.ibm.com>
In-Reply-To: <1428910011-4242-1-git-send-email-vaibhav@linux.vnet.ibm.com>
References: <1428910011-4242-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Cc: Michael Neuling <michael.neuling@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>, Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export the "AFU Error Buffer" via sysfs attribute (afu_err_buf). AFU
error buffer is used by the AFU to report application specific
errors. The contents of this buffer are AFU specific and are intended to
be interpreted by the application interacting with the afu.

Testing:
	- Build against pseries le/be configs.
	- Run testing with a special version of memcpy afu on a 'be'
	kernel.

Change-log:
v1 -> v2
	- Simplified cxl_afu_read_err_buffer to handle unaligned reads
	by performing a short read.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-class-cxl | 11 ++++++
 drivers/misc/cxl/cxl.h                    |  7 ++++
 drivers/misc/cxl/pci.c                    | 60 +++++++++++++++++++++++++++++++
 drivers/misc/cxl/sysfs.c                  | 33 +++++++++++++++++
 4 files changed, 111 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
index d46bba8..45e9ce3 100644
--- a/Documentation/ABI/testing/sysfs-class-cxl
+++ b/Documentation/ABI/testing/sysfs-class-cxl
@@ -6,6 +6,17 @@ Example: The real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
 
 Slave contexts (eg. /sys/class/cxl/afu0.0s):
 
+What:           /sys/class/cxl/<afu>/afu_err_buf
+Date:           September 2014
+Contact:        linuxppc-dev@lists.ozlabs.org
+Description:    read only
+                AFU Error Buffer contents. The contents of this file are
+		application specific and depends on the AFU being used.
+		Applications interacting with the AFU can use this attribute
+		to know about the current error condition and take appropriate
+		action like logging the event etc.
+
+
 What:           /sys/class/cxl/<afu>/irqs_max
 Date:           September 2014
 Contact:        linuxppc-dev@lists.ozlabs.org
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index a1cee47..789f077 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -362,6 +362,10 @@ struct cxl_afu {
 	struct mutex spa_mutex;
 	spinlock_t afu_cntl_lock;
 
+	/* AFU error buffer fields and bin attribute for sysfs */
+	u64 eb_len, eb_offset;
+	struct bin_attribute attr_eb;
+
 	/*
 	 * Only the first part of the SPA is used for the process element
 	 * linked list. The only other part that software needs to worry about
@@ -563,6 +567,9 @@ static inline void __iomem *_cxl_p2n_addr(struct cxl_afu *afu, cxl_p2n_reg_t reg
 u16 cxl_afu_cr_read16(struct cxl_afu *afu, int cr, u64 off);
 u8 cxl_afu_cr_read8(struct cxl_afu *afu, int cr, u64 off);
 
+ssize_t cxl_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
+				loff_t off, size_t count);
+
 
 struct cxl_calls {
 	void (*cxl_slbia)(struct mm_struct *mm);
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 1ef0164..162a8fc 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -593,6 +593,22 @@ static int cxl_read_afu_descriptor(struct cxl_afu *afu)
 	afu->crs_len = AFUD_CR_LEN(val) * 256;
 	afu->crs_offset = AFUD_READ_CR_OFF(afu);
 
+
+	/* eb_len is in multiple of 4K */
+	afu->eb_len = AFUD_EB_LEN(AFUD_READ_EB(afu)) * 4096;
+	afu->eb_offset = AFUD_READ_EB_OFF(afu);
+
+	/* eb_off is 4K aligned so lower 12 bits are always zero */
+	if (EXTRACT_PPC_BITS(afu->eb_offset, 0, 11) != 0) {
+		dev_warn(&afu->dev,
+			 "Invalid AFU error buffer offset %Lx\n",
+			 afu->eb_offset);
+		dev_info(&afu->dev,
+			 "Ignoring AFU error buffer in the descriptor\n");
+		/* indicate that no afu buffer exists */
+		afu->eb_len = 0;
+	}
+
 	return 0;
 }
 
@@ -672,6 +688,50 @@ static int sanitise_afu_regs(struct cxl_afu *afu)
 	return 0;
 }
 
+/*
+ * afu_eb_read:
+ * Called from sysfs and reads the afu error info buffer. The h/w only supports
+ * 4/8 bytes aligned access. So most of the code tries to get around this by
+ * reading full 8 bytes aligned chunks, copying it to a temp buffer and dropping
+ * unneeded bytes at the beginning & the end of the requested region.
+ */
+ssize_t cxl_afu_read_err_buffer(struct cxl_afu *afu, char *buf,
+				loff_t off, size_t count)
+{
+	u8 tbuff[8];
+	const void __iomem *ebuf = afu->afu_desc_mmio + afu->eb_offset;
+
+	count = min((size_t)(afu->eb_len - off), count);
+
+	if (unlikely(count <= 0)) {
+		/* handle case where no ebuf exists or offset out of bound */
+		count = 0;
+
+	} else if ((count >= 8) && IS_ALIGNED(off, 8)) {
+		/* read all the intermediate aligned words */
+
+		count = round_down(off + count, 8) - off;
+		_memcpy_fromio(buf,
+			       ebuf + off, count);
+
+	} else if (!IS_ALIGNED(off, 8)) {
+		/* handle unaligned access at the beginning */
+		_memcpy_fromio(tbuff, ebuf + round_down(off, 8), 8);
+
+		count = min((size_t)(ALIGN(off, 8) - off), count);
+		memcpy(buf, tbuff + (off & 0x7), count);
+
+	} else {
+		/* offset is aligned but count < 8 */
+		_memcpy_fromio(tbuff, ebuf + round_down(off + count, 8), 8);
+
+		count = (off + count) - round_down(off + count, 8);
+		memcpy(buf, tbuff, count);
+	}
+
+	return count;
+}
+
 static int cxl_init_afu(struct cxl *adapter, int slice, struct pci_dev *dev)
 {
 	struct cxl_afu *afu;
diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index d0c38c7..4942d55 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -356,6 +356,16 @@ static ssize_t api_version_compatible_show(struct device *device,
 	return scnprintf(buf, PAGE_SIZE, "%i\n", CXL_API_VERSION_COMPATIBLE);
 }
 
+static ssize_t afu_eb_read(struct file *filp, struct kobject *kobj,
+			       struct bin_attribute *bin_attr, char *buf,
+			       loff_t off, size_t count)
+{
+	struct cxl_afu *afu = to_cxl_afu(container_of(kobj,
+						      struct device, kobj));
+
+	return cxl_afu_read_err_buffer(afu, buf, off, count);
+}
+
 static struct device_attribute afu_attrs[] = {
 	__ATTR_RO(mmio_size),
 	__ATTR_RO(irqs_min),
@@ -534,6 +544,10 @@ void cxl_sysfs_afu_remove(struct cxl_afu *afu)
 	struct afu_config_record *cr, *tmp;
 	int i;
 
+	/* remove the err buffer bin attribute */
+	if (afu->eb_len)
+		device_remove_bin_file(&afu->dev, &afu->attr_eb);
+
 	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++)
 		device_remove_file(&afu->dev, &afu_attrs[i]);
 
@@ -555,6 +569,22 @@ int cxl_sysfs_afu_add(struct cxl_afu *afu)
 			goto err;
 	}
 
+	/* conditionally create the add the binary file for error info buffer */
+	if (afu->eb_len) {
+		afu->attr_eb.attr.name = "afu_err_buff";
+		afu->attr_eb.attr.mode = S_IRUGO;
+		afu->attr_eb.size = afu->eb_len;
+		afu->attr_eb.read = afu_eb_read;
+
+		rc = device_create_bin_file(&afu->dev, &afu->attr_eb);
+		if (rc) {
+			dev_err(&afu->dev,
+				"Unable to create eb attr for the afu. Err(%d)\n",
+				rc);
+			goto err;
+		}
+	}
+
 	for (i = 0; i < afu->crs_num; i++) {
 		cr = cxl_sysfs_afu_new_cr(afu, i);
 		if (IS_ERR(cr)) {
@@ -570,6 +600,9 @@ err1:
 	cxl_sysfs_afu_remove(afu);
 	return rc;
 err:
+	/* reset the eb_len as we havent created the bin attr */
+	afu->eb_len = 0;
+
 	for (i--; i >= 0; i--)
 		device_remove_file(&afu->dev, &afu_attrs[i]);
 	return rc;
-- 
2.2.1
