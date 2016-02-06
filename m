Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 792691A02ED
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Feb 2016 00:29:24 +1100 (AEDT)
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Sat, 6 Feb 2016 13:29:21 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id C1ECF17D8042
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2016 13:29:31 +0000 (GMT)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com
 [9.149.37.229])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u16DTIUo63045702
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 6 Feb 2016 13:29:18 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u16DTIU5004267
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 6 Feb 2016 06:29:18 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 14/18] cxl: Support to flash a new image on the adapter
 from a guest
Date: Sat,  6 Feb 2016 14:29:01 +0100
Message-Id: <1454765345-7417-15-git-send-email-fbarrat@linux.vnet.ibm.com>
In-Reply-To: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Christophe Lombard <clombard@linux.vnet.ibm.com>

The new flash.c file contains the logic to flash a new image on the
adapter, through a hcall. It is an iterative process, with chunks of
data of 1M at a time. There are also 2 phases: write and verify. The
flash operation itself is driven from a user-land tool.

Once flashing is successful, an rtas call is made to update the device
tree with the new properties values for the adapter and the AFU(s)

Add a new char device for the adapter, so that the flash tool can
access the card, even if there is no valid AFU on it.

Co-authored-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 Documentation/powerpc/cxl.txt |  60 +++++
 drivers/misc/cxl/Makefile     |   2 +-
 drivers/misc/cxl/base.c       |   7 +
 drivers/misc/cxl/cxl.h        |  15 ++
 drivers/misc/cxl/file.c       |  11 +-
 drivers/misc/cxl/flash.c      | 515 ++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/cxl/guest.c      |  19 ++
 7 files changed, 624 insertions(+), 5 deletions(-)
 create mode 100644 drivers/misc/cxl/flash.c

diff --git a/Documentation/powerpc/cxl.txt b/Documentation/powerpc/cxl.txt
index 205c1b8..70408a3 100644
--- a/Documentation/powerpc/cxl.txt
+++ b/Documentation/powerpc/cxl.txt
@@ -116,6 +116,8 @@ Work Element Descriptor (WED)
 User API
 ========
 
+1. AFU character devices
+
     For AFUs operating in AFU directed mode, two character device
     files will be created. /dev/cxl/afu0.0m will correspond to a
     master context and /dev/cxl/afu0.0s will correspond to a slave
@@ -362,6 +364,64 @@ read
         reserved fields:
             For future extensions and padding
 
+
+2. Card character device (powerVM guest only)
+
+    In a powerVM guest, an extra character device is created for the
+    card. The device is only used to write (flash) a new image on the
+    FPGA accelerator. Once the image is written and verified, the
+    device tree is updated and the card is reset to reload the updated
+    image.
+
+open
+----
+
+    Opens the device and allocates a file descriptor to be used with
+    the rest of the API. The device can only be opened once.
+
+ioctl
+-----
+
+CXL_IOCTL_TRANSFER_IMAGE:
+    Starts and controls flashing a new FPGA image. Partial
+    reconfiguration is not supported (yet), so the image must contain
+    a copy of the PSL and AFU(s). Since an image can be quite large,
+    the caller may have to iterate, splitting the image in smaller
+    chunks.
+
+    Takes a pointer to a struct cxl_adapter_image:
+	struct cxl_adapter_image {
+		__u32 version;
+		__u8 *data;
+		__u64 len_data;
+		__u64 len_image;
+		__u32 need_header;
+		__u32 op;
+	};
+
+    version:
+        Describes the version of the structure.
+
+    data:
+        Pointer to a buffer with part of the image to write to the
+        card.
+
+    len_data:
+        Size of the buffer pointed to by data.
+
+    len_image:
+	Full size of the image.
+
+    need_header:
+        Specifies if a header must be inserted in front of the image
+        before calling the hypervisor.
+
+    op:
+        Operation requested. After it is written, an image must be
+        verified.
+
+
+
 Sysfs Class
 ===========
 
diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index a3d4bef..9ab874f 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -4,7 +4,7 @@ ccflags-$(CONFIG_PPC_WERROR)	+= -Werror
 cxl-y				+= main.o file.o irq.o fault.o native.o
 cxl-y				+= context.o sysfs.o debugfs.o pci.o trace.o
 cxl-y				+= vphb.o api.o
-cxl-y				+= guest.o of.o hcalls.o
+cxl-y				+= flash.o guest.o of.o hcalls.o
 obj-$(CONFIG_CXL)		+= cxl.o
 obj-$(CONFIG_CXL_BASE)		+= base.o
 
diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
index a9f0dd3..957f4dd 100644
--- a/drivers/misc/cxl/base.c
+++ b/drivers/misc/cxl/base.c
@@ -84,3 +84,10 @@ void unregister_cxl_calls(struct cxl_calls *calls)
 	synchronize_rcu();
 }
 EXPORT_SYMBOL_GPL(unregister_cxl_calls);
+
+int cxl_update_properties(struct device_node *dn,
+			  struct property *new_prop)
+{
+	return of_update_property(dn, new_prop);
+}
+EXPORT_SYMBOL_GPL(cxl_update_properties);
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index ee0bbbd..527cbd5 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -324,6 +324,19 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_MODE_TIME_SLICED 0x4
 #define CXL_SUPPORTED_MODES (CXL_MODE_DEDICATED | CXL_MODE_DIRECTED)
 
+#define CXL_DEV_MINORS 13   /* 1 control + 4 AFUs * 3 (dedicated/master/shared) */
+#define CXL_CARD_MINOR(adapter) (adapter->adapter_num * CXL_DEV_MINORS)
+#define CXL_DEVT_ADAPTER(dev) (MINOR(dev) / CXL_DEV_MINORS)
+
+struct cxl_adapter_image {
+	__u32 version;
+	__u8 *data;
+	__u64 len_data;
+	__u64 len_image;
+	__u32 need_header;
+	__u32 op;
+};
+
 enum cxl_context_status {
 	CLOSED,
 	OPENED,
@@ -686,12 +699,14 @@ struct cxl_calls {
 };
 int register_cxl_calls(struct cxl_calls *calls);
 void unregister_cxl_calls(struct cxl_calls *calls);
+int cxl_update_properties(struct device_node *dn, struct property *new_prop);
 
 void cxl_remove_adapter_nr(struct cxl *adapter);
 
 int cxl_alloc_spa(struct cxl_afu *afu);
 void cxl_release_spa(struct cxl_afu *afu);
 
+dev_t cxl_get_dev(void);
 int cxl_file_init(void);
 void cxl_file_exit(void);
 int cxl_register_adapter(struct cxl *adapter);
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index df4d49a..e160462 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -26,9 +26,7 @@
 #include "trace.h"
 
 #define CXL_NUM_MINORS 256 /* Total to reserve */
-#define CXL_DEV_MINORS 13   /* 1 control + 4 AFUs * 3 (dedicated/master/shared) */
 
-#define CXL_CARD_MINOR(adapter) (adapter->adapter_num * CXL_DEV_MINORS)
 #define CXL_AFU_MINOR_D(afu) (CXL_CARD_MINOR(afu->adapter) + 1 + (3 * afu->slice))
 #define CXL_AFU_MINOR_M(afu) (CXL_AFU_MINOR_D(afu) + 1)
 #define CXL_AFU_MINOR_S(afu) (CXL_AFU_MINOR_D(afu) + 2)
@@ -36,7 +34,6 @@
 #define CXL_AFU_MKDEV_M(afu) MKDEV(MAJOR(cxl_dev), CXL_AFU_MINOR_M(afu))
 #define CXL_AFU_MKDEV_S(afu) MKDEV(MAJOR(cxl_dev), CXL_AFU_MINOR_S(afu))
 
-#define CXL_DEVT_ADAPTER(dev) (MINOR(dev) / CXL_DEV_MINORS)
 #define CXL_DEVT_AFU(dev) ((MINOR(dev) % CXL_DEV_MINORS - 1) / 3)
 
 #define CXL_DEVT_IS_CARD(dev) (MINOR(dev) % CXL_DEV_MINORS == 0)
@@ -446,7 +443,8 @@ static const struct file_operations afu_master_fops = {
 
 static char *cxl_devnode(struct device *dev, umode_t *mode)
 {
-	if (CXL_DEVT_IS_CARD(dev->devt)) {
+	if (cpu_has_feature(CPU_FTR_HVMODE) &&
+	    CXL_DEVT_IS_CARD(dev->devt)) {
 		/*
 		 * These minor numbers will eventually be used to program the
 		 * PSL and AFUs once we have dynamic reprogramming support
@@ -547,6 +545,11 @@ int cxl_register_adapter(struct cxl *adapter)
 	return device_register(&adapter->dev);
 }
 
+dev_t cxl_get_dev(void)
+{
+	return cxl_dev;
+}
+
 int __init cxl_file_init(void)
 {
 	int rc;
diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
new file mode 100644
index 0000000..dc239af
--- /dev/null
+++ b/drivers/misc/cxl/flash.c
@@ -0,0 +1,515 @@
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/semaphore.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <asm/rtas.h>
+
+#include "cxl.h"
+#include "hcalls.h"
+
+#define CXL_IOCTL_TRANSFER_IMAGE _IOR(CXL_MAGIC, 0x10, struct cxl_adapter_image)
+#define ADAPTER_IMAGE_HEADER_SIZE 128
+#define MAX_CHUNK_SIZE (SG_BUFFER_SIZE * SG_MAX_ENTRIES)
+#define DOWNLOAD_IMAGE 1
+#define VALIDATE_IMAGE 2
+#define INITIAL_VERSION 1
+
+struct ai_header {
+	u16 version;
+	u8  reserverd0[6];
+	u16 vendor;
+	u16 device;
+	u16 subsystem_vendor;
+	u16 subsystem;
+	u64 image_offset;
+	u64 image_length;
+	u8  reserverd1[96];
+};
+
+
+static struct semaphore sem;
+unsigned long *buffer[SG_MAX_ENTRIES];
+struct sg_list *le;
+static u64 token;
+static unsigned int transfer;
+
+struct update_props_workarea {
+	__be32 phandle;
+	__be32 state;
+	__be64 reserved;
+	__be32 nprops;
+} __packed;
+
+struct update_nodes_workarea {
+	__be32 state;
+	__be64 unit_address;
+	__be32 reserved;
+} __packed;
+
+#define DEVICE_SCOPE 3
+#define NODE_ACTION_MASK	0xff000000
+#define NODE_COUNT_MASK		0x00ffffff
+#define OPCODE_DELETE	0x01000000
+#define OPCODE_UPDATE	0x02000000
+#define OPCODE_ADD	0x03000000
+
+static int rcall(int token, char *buf, s32 scope)
+{
+	int rc;
+
+	spin_lock(&rtas_data_buf_lock);
+
+	memcpy(rtas_data_buf, buf, RTAS_DATA_BUF_SIZE);
+	rc = rtas_call(token, 2, 1, NULL, rtas_data_buf, scope);
+	memcpy(buf, rtas_data_buf, RTAS_DATA_BUF_SIZE);
+
+	spin_unlock(&rtas_data_buf_lock);
+	return rc;
+}
+
+static int update_property(struct device_node *dn, const char *name,
+			   u32 vd, char *value)
+{
+	struct property *new_prop;
+	u32 *val;
+	int rc;
+
+	new_prop = kzalloc(sizeof(*new_prop), GFP_KERNEL);
+	if (!new_prop)
+		return -ENOMEM;
+
+	new_prop->name = kstrdup(name, GFP_KERNEL);
+	if (!new_prop->name) {
+		kfree(new_prop);
+		return -ENOMEM;
+	}
+
+	new_prop->length = vd;
+	new_prop->value = kzalloc(new_prop->length, GFP_KERNEL);
+	if (!new_prop->value) {
+		kfree(new_prop->name);
+		kfree(new_prop);
+		return -ENOMEM;
+	}
+	memcpy(new_prop->value, value, vd);
+
+	val = (u32 *)new_prop->value;
+	rc = cxl_update_properties(dn, new_prop);
+	pr_devel("%s: update property (%s, length: %i, value: %#x)\n",
+		  dn->name, name, vd, be32_to_cpu(*val));
+
+	if (rc) {
+		kfree(new_prop->name);
+		kfree(new_prop->value);
+		kfree(new_prop);
+	}
+	return rc;
+}
+
+static int update_node(__be32 phandle, s32 scope)
+{
+	struct update_props_workarea *upwa;
+	struct device_node *dn;
+	int i, rc, ret;
+	char *prop_data;
+	char *buf;
+	int token;
+	u32 nprops;
+	u32 vd;
+
+	token = rtas_token("ibm,update-properties");
+	if (token == RTAS_UNKNOWN_SERVICE)
+		return -EINVAL;
+
+	buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	memset(buf, 0, RTAS_DATA_BUF_SIZE);
+
+	dn = of_find_node_by_phandle(be32_to_cpu(phandle));
+	if (!dn) {
+		kfree(buf);
+		return -ENOENT;
+	}
+
+	upwa = (struct update_props_workarea *)&buf[0];
+	upwa->phandle = phandle;
+	do {
+		rc = rcall(token, buf, scope);
+		if (rc < 0)
+			break;
+
+		prop_data = buf + sizeof(*upwa);
+		nprops = be32_to_cpu(upwa->nprops);
+
+		if (*prop_data == 0) {
+			prop_data++;
+			vd = be32_to_cpu(*(__be32 *)prop_data);
+			prop_data += vd + sizeof(vd);
+			nprops--;
+		}
+
+		for (i = 0; i < nprops; i++) {
+			char *prop_name;
+
+			prop_name = prop_data;
+			prop_data += strlen(prop_name) + 1;
+			vd = be32_to_cpu(*(__be32 *)prop_data);
+			prop_data += sizeof(vd);
+
+			if ((vd != 0x00000000) && (vd != 0x80000000)) {
+				ret = update_property(dn, prop_name, vd, prop_data);
+				if (ret)
+					pr_err("cxl: Could not update property %s - %i\n",
+					       prop_name, ret);
+
+				prop_data += vd;
+			}
+		}
+	} while (rc == 1);
+
+	of_node_put(dn);
+	kfree(buf);
+	return rc;
+}
+
+static int update_devicetree(struct cxl *adapter, s32 scope)
+{
+	struct update_nodes_workarea *unwa;
+	u32 action, node_count;
+	int token, rc, i;
+	__be32 *data, drc_index, phandle;
+	char *buf;
+
+	token = rtas_token("ibm,update-nodes");
+	if (token == RTAS_UNKNOWN_SERVICE)
+		return -EINVAL;
+
+	buf = kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+	memset(buf, 0, RTAS_DATA_BUF_SIZE);
+
+	unwa = (struct update_nodes_workarea *)&buf[0];
+	unwa->unit_address = cpu_to_be64(adapter->guest->handle);
+	do {
+		rc = rcall(token, buf, scope);
+		if (rc && rc != 1)
+			break;
+
+		data = (__be32 *)buf + 4;
+		while (be32_to_cpu(*data) & NODE_ACTION_MASK) {
+			action = be32_to_cpu(*data) & NODE_ACTION_MASK;
+			node_count = be32_to_cpu(*data) & NODE_COUNT_MASK;
+			pr_devel("device reconfiguration - action: %#x, nodes: %#x\n",
+				 action, node_count);
+			data++;
+
+			for (i = 0; i < node_count; i++) {
+				phandle = *data++;
+
+				switch (action) {
+				case OPCODE_DELETE:
+					/* nothing to do */
+					break;
+				case OPCODE_UPDATE:
+					update_node(phandle, scope);
+					break;
+				case OPCODE_ADD:
+					/* nothing to do, just move the pointer */
+					drc_index = *data++;
+					break;
+				}
+			}
+		}
+	} while (rc == 1);
+
+	kfree(buf);
+	return 0;
+}
+
+static int handle_image(struct cxl *adapter,
+			long (*fct)(u64, u64, u64, u64 *),
+			struct cxl_adapter_image *ai)
+{
+	size_t mod, s_copy, len_chunk = 0;
+	struct ai_header *header = NULL;
+	unsigned int entries = 0, i;
+	void *dest, *from;
+	int rc = 0;
+
+	/* base adapter image header */
+	if (ai->need_header) {
+		header = kzalloc(sizeof(struct ai_header), GFP_KERNEL);
+		if (!header)
+			return -ENOMEM;
+		header->version = cpu_to_be16(1);
+		header->vendor = cpu_to_be16(adapter->guest->vendor);
+		header->device = cpu_to_be16(adapter->guest->device);
+		header->subsystem_vendor = cpu_to_be16(adapter->guest->subsystem_vendor);
+		header->subsystem = cpu_to_be16(adapter->guest->subsystem);
+		header->image_offset = cpu_to_be64(ADAPTER_IMAGE_HEADER_SIZE);
+		header->image_length = cpu_to_be64(ai->len_image);
+	}
+
+	/* number of entries in the list */
+	len_chunk = ai->len_data;
+	if (ai->need_header)
+		len_chunk += ADAPTER_IMAGE_HEADER_SIZE;
+
+	entries = len_chunk / SG_BUFFER_SIZE;
+	mod = len_chunk % SG_BUFFER_SIZE;
+	if (mod)
+		entries++;
+
+	if (entries > SG_MAX_ENTRIES) {
+		rc = -EINVAL;
+		goto err;
+	}
+
+	/*          < -- MAX_CHUNK_SIZE = 4096 * 256 = 1048576 bytes -->
+	 * chunk 0  ----------------------------------------------------
+	 *          | header   |  data                                 |
+	 *          ----------------------------------------------------
+	 * chunk 1  ----------------------------------------------------
+	 *          | data                                             |
+	 *          ----------------------------------------------------
+	 * ....
+	 * chunk n  ----------------------------------------------------
+	 *          | data                                             |
+	 *          ----------------------------------------------------
+	 */
+	from = ai->data;
+	for (i = 0; i < entries; i++) {
+		dest = buffer[i];
+		s_copy = SG_BUFFER_SIZE;
+
+		if ((ai->need_header) && (i == 0)) {
+			/* add adapter image header */
+			memcpy(buffer[i], header, sizeof(struct ai_header));
+			s_copy = SG_BUFFER_SIZE - ADAPTER_IMAGE_HEADER_SIZE;
+			dest += ADAPTER_IMAGE_HEADER_SIZE; /* image offset */
+		}
+		if ((i == (entries - 1)) && mod)
+			s_copy = mod;
+
+		/* copy data */
+		if (copy_from_user(dest, from, s_copy))
+			goto err;
+
+		/* fill in the list */
+		le[i].phys_addr = cpu_to_be64(virt_to_phys(buffer[i]));
+		le[i].len = cpu_to_be64(SG_BUFFER_SIZE);
+		if ((i == (entries - 1)) && mod)
+			le[i].len = cpu_to_be64(mod);
+		from += s_copy;
+	}
+	pr_devel("%s (op: %i, need header: %i, entries: %i, token: %#llx)\n",
+		 __func__, ai->op, ai->need_header, entries, token);
+
+	/*
+	 * download/validate the adapter image to the coherent
+	 * platform facility
+	 */
+	rc = fct(adapter->guest->handle, virt_to_phys(le), entries, &token);
+	if (rc == 0) /* success of download/validation operation */
+		token = 0;
+
+err:
+	kfree(header);
+
+	return rc;
+}
+
+static int transfer_image(struct cxl *adapter,
+			 struct cxl_adapter_image *ai)
+{
+	int rc = 0;
+
+	switch (ai->op) {
+	case DOWNLOAD_IMAGE:
+		rc = handle_image(adapter, &cxl_h_download_adapter_image, ai);
+		if (rc < 0) {
+			pr_devel("resetting adapter\n");
+			cxl_h_reset_adapter(adapter->guest->handle);
+		}
+		return rc;
+
+	case VALIDATE_IMAGE:
+		rc = handle_image(adapter, &cxl_h_validate_adapter_image, ai);
+		if (rc < 0) {
+			pr_devel("resetting adapter\n");
+			cxl_h_reset_adapter(adapter->guest->handle);
+			return rc;
+		}
+		if (rc == 0) {
+			pr_devel("resetting adapter\n");
+			cxl_h_reset_adapter(adapter->guest->handle);
+
+			/* The entire image has now been
+			 * downloaded and the validation has
+			 * been successfully performed.
+			 * After that, the partition should call
+			 * ibm,update-nodes and
+			 * ibm,update-properties to receive the
+			 * current configuration
+			 */
+			rc = update_devicetree(adapter, DEVICE_SCOPE);
+			transfer = 1;
+		}
+		return rc;
+	}
+
+	return -EINVAL;
+}
+
+static long ioctl_transfer_image(struct cxl *adapter,
+				 struct cxl_adapter_image __user *uai)
+{
+	struct cxl_adapter_image ai;
+
+	pr_devel("%s\n", __func__);
+
+	if (copy_from_user(&ai, uai, sizeof(struct cxl_adapter_image)))
+		return -EFAULT;
+
+	if (ai.version > INITIAL_VERSION) {
+		pr_err("cxl: Version not supported: %d\n", ai.version);
+		return -EINVAL;
+	}
+	return transfer_image(adapter, &ai);
+}
+
+static int device_open(struct inode *inode, struct file *file)
+{
+	int adapter_num = CXL_DEVT_ADAPTER(inode->i_rdev);
+	struct cxl *adapter;
+	int rc = 0, i;
+
+	pr_devel("in %s\n", __func__);
+
+	BUG_ON(sizeof(struct ai_header) != ADAPTER_IMAGE_HEADER_SIZE);
+
+	/* Allows one process to open the device by using a semaphore */
+	if (down_interruptible(&sem) != 0)
+		return -EPERM;
+
+	if (!(adapter = get_cxl_adapter(adapter_num)))
+		return -ENODEV;
+
+	file->private_data = adapter;
+	token = 0;
+	transfer = 0;
+
+	for (i = 0; i < SG_MAX_ENTRIES; i++)
+		buffer[i] = NULL;
+
+	/* aligned buffer containing list entries which describes up to
+	 * 1 megabyte of data (256 entries of 4096 bytes each)
+	 *  Logical real address of buffer 0  -  Buffer 0 length in bytes
+	 *  Logical real address of buffer 1  -  Buffer 1 length in bytes
+	 *  Logical real address of buffer 2  -  Buffer 2 length in bytes
+	 *  ....
+	 *  ....
+	 *  Logical real address of buffer N  -  Buffer N length in bytes
+	 */
+	le = (struct sg_list *)get_zeroed_page(GFP_KERNEL);
+	if (!le) {
+		rc = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < SG_MAX_ENTRIES; i++) {
+		buffer[i] = (unsigned long *)get_zeroed_page(GFP_KERNEL);
+		if (!buffer[i]) {
+			rc = -ENOMEM;
+			goto err1;
+		}
+	}
+
+	return 0;
+
+err1:
+	for (i = 0; i < SG_MAX_ENTRIES; i++) {
+		if (buffer[i])
+			free_page((unsigned long) buffer[i]);
+	}
+
+	if (le)
+		free_page((unsigned long) le);
+err:
+	put_device(&adapter->dev);
+
+	return rc;
+}
+
+static long device_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct cxl *adapter = file->private_data;
+
+	pr_devel("in %s\n", __func__);
+
+	if (cmd == CXL_IOCTL_TRANSFER_IMAGE)
+		return ioctl_transfer_image(adapter,
+					    (struct cxl_adapter_image __user *)arg);
+	else
+		return -EINVAL;
+}
+
+static int device_close(struct inode *inode, struct file *file)
+{
+	struct cxl *adapter = file->private_data;
+	int i;
+
+	pr_devel("in %s\n", __func__);
+
+	for (i = 0; i < SG_MAX_ENTRIES; i++) {
+		if (buffer[i])
+			free_page((unsigned long) buffer[i]);
+	}
+
+	if (le)
+		free_page((unsigned long) le);
+
+	up(&sem);
+	put_device(&adapter->dev);
+	token = 0;
+
+	/* reload the module */
+	if (transfer)
+		cxl_guest_reload_module(adapter);
+
+	transfer = 0;
+	return 0;
+}
+
+static const struct file_operations fops = {
+	.owner		= THIS_MODULE,
+	.open		= device_open,
+	.unlocked_ioctl	= device_ioctl,
+	.release	= device_close,
+};
+
+void cxl_guest_remove_chardev(struct cxl *adapter)
+{
+	cdev_del(&adapter->guest->cdev);
+}
+
+int cxl_guest_add_chardev(struct cxl *adapter)
+{
+	dev_t devt;
+	int rc;
+
+	devt = MKDEV(MAJOR(cxl_get_dev()), CXL_CARD_MINOR(adapter));
+	cdev_init(&adapter->guest->cdev, &fops);
+	if ((rc = cdev_add(&adapter->guest->cdev, devt, 1))) {
+		dev_err(&adapter->dev, "Unable to add chardev on adapter (card%i): %i\n",
+					adapter->adapter_num, rc);
+		goto err;
+	}
+	adapter->dev.devt = devt;
+	sema_init(&sem, 1);
+err:
+	return rc;
+}
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index d02ff03..96f25dc 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -876,6 +876,7 @@ void cxl_guest_remove_adapter(struct cxl *adapter)
 
 	cxl_sysfs_adapter_remove(adapter);
 
+	cxl_guest_remove_chardev(adapter);
 	device_unregister(&adapter->dev);
 }
 
@@ -913,6 +914,9 @@ struct cxl *cxl_guest_init_adapter(struct device_node *np, struct platform_devic
 	if ((rc = properties_look_ok(adapter)))
 		goto err1;
 
+	if ((rc = cxl_guest_add_chardev(adapter)))
+		goto err1;
+
 	/*
 	 * After we call this function we must not free the adapter directly,
 	 * even if it returns an error!
@@ -928,12 +932,27 @@ struct cxl *cxl_guest_init_adapter(struct device_node *np, struct platform_devic
 err_put1:
 	device_unregister(&adapter->dev);
 	free = false;
+	cxl_guest_remove_chardev(adapter);
 err1:
 	if (free)
 		free_adapter(adapter);
 	return ERR_PTR(rc);
 }
 
+void cxl_guest_reload_module(struct cxl *adapter)
+{
+	struct platform_device *pdev;
+	int afu;
+
+	for (afu = 0; afu < adapter->slices; afu++)
+		cxl_guest_remove_afu(adapter->afu[afu]);
+
+	pdev = adapter->guest->pdev;
+	cxl_guest_remove_adapter(adapter);
+
+	cxl_of_probe(pdev);
+}
+
 const struct cxl_backend_ops cxl_guest_ops = {
 	.module = THIS_MODULE,
 	.adapter_reset = guest_reset,
-- 
1.9.1
