Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0lBb5v2YzDsFf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 02:21:59 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIFLmeZ002323
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:58 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2exd8d947r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:57 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 15:21:53 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH 08/13] ocxl: Add a kernel API for other opencapi drivers
Date: Mon, 18 Dec 2017 16:21:21 +0100
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
Message-Id: <da32753e297a7a76379533a483affc187f72bb7a.1513608243.git.fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the functions done by the generic driver should also be needed
by other opencapi drivers: attaching a context to an adapter,
translation fault handling, AFU interrupt allocation...

So to avoid code duplication, the driver provides a kernel API that
other drivers can use, similar to calling a in-kernel library.

It is still a bit theoretical, for lack of real hardware, and will
likely need adjustements down the road. But we used the cxlflash
driver as a guinea pig.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/ocxl/config.c        |  13 ++-
 drivers/misc/ocxl/link.c          |   7 ++
 drivers/misc/ocxl/ocxl_internal.h |  71 +-----------
 include/misc/ocxl.h               | 221 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 241 insertions(+), 71 deletions(-)
 create mode 100644 include/misc/ocxl.h

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index bb2fde5967e2..2326e8da4029 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -9,8 +9,8 @@
 
 #include <linux/pci.h>
 #include <asm/pnv-ocxl.h>
+#include <misc/ocxl.h>
 #include <misc/ocxl-config.h>
-#include "ocxl_internal.h"
 
 #define EXTRACT_BIT(val, bit) (!!(val & BIT(bit)))
 #define EXTRACT_BITS(val, s, e) ((val & GENMASK(e, s)) >> s)
@@ -250,6 +250,7 @@ int ocxl_config_read_function(struct pci_dev *dev, struct ocxl_fn_config *fn)
 	rc = validate_function(dev, fn);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ocxl_config_read_function);
 
 static int read_afu_info(struct pci_dev *dev, struct ocxl_fn_config *fn,
 			int offset, u32 *data)
@@ -308,6 +309,7 @@ int ocxl_config_check_afu_index(struct pci_dev *dev,
 	}
 	return 1;
 }
+EXPORT_SYMBOL_GPL(ocxl_config_check_afu_index);
 
 static int read_afu_name(struct pci_dev *dev, struct ocxl_fn_config *fn,
 			struct ocxl_afu_config *afu)
@@ -505,6 +507,7 @@ int ocxl_config_read_afu(struct pci_dev *dev, struct ocxl_fn_config *fn,
 	rc = validate_afu(dev, afu);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ocxl_config_read_afu);
 
 int ocxl_config_get_actag_info(struct pci_dev *dev, u16 *base, u16 *enabled,
 			u16 *supported)
@@ -523,6 +526,7 @@ int ocxl_config_get_actag_info(struct pci_dev *dev, u16 *base, u16 *enabled,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ocxl_config_get_actag_info);
 
 void ocxl_config_set_afu_actag(struct pci_dev *dev, int pos, int actag_base,
 			int actag_count)
@@ -535,11 +539,13 @@ void ocxl_config_set_afu_actag(struct pci_dev *dev, int pos, int actag_base,
 	val = actag_base & OCXL_DVSEC_ACTAG_MASK;
 	pci_write_config_dword(dev, pos + OCXL_DVSEC_AFU_CTRL_ACTAG_BASE, val);
 }
+EXPORT_SYMBOL_GPL(ocxl_config_set_afu_actag);
 
 int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count)
 {
 	return pnv_ocxl_get_pasid_count(dev, count);
 }
+EXPORT_SYMBOL_GPL(ocxl_config_get_pasid_info);
 
 void ocxl_config_set_afu_pasid(struct pci_dev *dev, int pos, int pasid_base,
 			u32 pasid_count_log)
@@ -557,6 +563,7 @@ void ocxl_config_set_afu_pasid(struct pci_dev *dev, int pos, int pasid_base,
 	pci_write_config_dword(dev, pos + OCXL_DVSEC_AFU_CTRL_PASID_BASE,
 			val32);
 }
+EXPORT_SYMBOL_GPL(ocxl_config_set_afu_pasid);
 
 void ocxl_config_set_afu_state(struct pci_dev *dev, int pos, int enable)
 {
@@ -569,6 +576,7 @@ void ocxl_config_set_afu_state(struct pci_dev *dev, int pos, int enable)
 		val &= 0xFE;
 	pci_write_config_byte(dev, pos + OCXL_DVSEC_AFU_CTRL_ENABLE, val);
 }
+EXPORT_SYMBOL_GPL(ocxl_config_set_afu_state);
 
 int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec)
 {
@@ -666,6 +674,7 @@ int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec)
 	kfree(recv_rate);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ocxl_config_set_TL);
 
 int ocxl_config_terminate_pasid(struct pci_dev *dev, int afu_control, int pasid)
 {
@@ -705,6 +714,7 @@ int ocxl_config_terminate_pasid(struct pci_dev *dev, int afu_control, int pasid)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ocxl_config_terminate_pasid);
 
 void ocxl_config_set_actag(struct pci_dev *dev, int func_dvsec, u32 tag_first,
 			u32 tag_count)
@@ -716,3 +726,4 @@ void ocxl_config_set_actag(struct pci_dev *dev, int func_dvsec, u32 tag_first,
 	pci_write_config_dword(dev, func_dvsec + OCXL_DVSEC_FUNC_OFF_ACTAG,
 			val);
 }
+EXPORT_SYMBOL_GPL(ocxl_config_set_actag);
diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index 5f12564eea99..fda2c9def4ff 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -12,6 +12,7 @@
 #include <linux/mmu_context.h>
 #include <asm/copro.h>
 #include <asm/pnv-ocxl.h>
+#include <misc/ocxl.h>
 #include "ocxl_internal.h"
 
 
@@ -427,6 +428,7 @@ int ocxl_link_setup(struct pci_dev *dev, int PE_mask, void **link_handle)
 	mutex_unlock(&links_list_lock);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ocxl_link_setup);
 
 static void release_xsl(struct kref *ref)
 {
@@ -446,6 +448,7 @@ void ocxl_link_release(struct pci_dev *dev, void *link_handle)
 	kref_put(&link->ref, release_xsl);
 	mutex_unlock(&links_list_lock);
 }
+EXPORT_SYMBOL_GPL(ocxl_link_release);
 
 static u64 calculate_cfg_state(bool kernel)
 {
@@ -540,6 +543,7 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 	mutex_unlock(&spa->spa_lock);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ocxl_link_add_pe);
 
 int ocxl_link_remove_pe(void *link_handle, int pasid)
 {
@@ -608,6 +612,7 @@ int ocxl_link_remove_pe(void *link_handle, int pasid)
 	mutex_unlock(&spa->spa_lock);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ocxl_link_remove_pe);
 
 int ocxl_link_irq_alloc(void *link_handle, int *hw_irq, u64 *trigger_addr)
 {
@@ -628,6 +633,7 @@ int ocxl_link_irq_alloc(void *link_handle, int *hw_irq, u64 *trigger_addr)
 	*trigger_addr = addr;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(ocxl_link_irq_alloc);
 
 void ocxl_link_free_irq(void *link_handle, int hw_irq)
 {
@@ -636,3 +642,4 @@ void ocxl_link_free_irq(void *link_handle, int hw_irq)
 	pnv_ocxl_free_xive_irq(hw_irq);
 	atomic_inc(&link->irq_available);
 }
+EXPORT_SYMBOL_GPL(ocxl_link_free_irq);
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
index 829369c5f004..18ec28c0a5cb 100644
--- a/drivers/misc/ocxl/ocxl_internal.h
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -13,8 +13,8 @@
 #include <linux/pci.h>
 #include <linux/cdev.h>
 #include <linux/list.h>
+#include <misc/ocxl.h>
 
-#define OCXL_AFU_NAME_SZ      (24+1)  /* add 1 for NULL termination */
 #define MAX_IRQ_PER_LINK	2000
 #define MAX_IRQ_PER_CONTEXT	MAX_IRQ_PER_LINK
 
@@ -23,38 +23,6 @@
 
 extern struct pci_driver ocxl_pci_driver;
 
-/*
- * The following 2 structures are a fairly generic way of representing
- * the configuration data for a function and AFU, as read from the
- * configuration space.
- */
-struct ocxl_afu_config {
-	u8 idx;
-	int dvsec_afu_control_pos;
-	char name[OCXL_AFU_NAME_SZ];
-	u8 version_major;
-	u8 version_minor;
-	u8 afuc_type;
-	u8 afum_type;
-	u8 profile;
-	u8 global_mmio_bar;
-	u64 global_mmio_offset;
-	u32 global_mmio_size;
-	u8 pp_mmio_bar;
-	u64 pp_mmio_offset;
-	u32 pp_mmio_stride;
-	u8 log_mem_size;
-	u8 pasid_supported_log;
-	u16 actag_supported;
-};
-
-struct ocxl_fn_config {
-	int dvsec_tl_pos;
-	int dvsec_function_pos;
-	int dvsec_afu_info_pos;
-	s8 max_pasid_log;
-	s8 max_afu_index;
-};
 
 struct ocxl_fn {
 	struct device dev;
@@ -142,43 +110,6 @@ extern void ocxl_unregister_afu(struct ocxl_afu *afu);
 extern int ocxl_file_init(void);
 extern void ocxl_file_exit(void);
 
-extern int ocxl_config_read_function(struct pci_dev *dev,
-				struct ocxl_fn_config *fn);
-
-extern int ocxl_config_check_afu_index(struct pci_dev *dev,
-				struct ocxl_fn_config *fn, int afu_idx);
-extern int ocxl_config_read_afu(struct pci_dev *dev,
-				struct ocxl_fn_config *fn,
-				struct ocxl_afu_config *afu,
-				u8 afu_idx);
-extern int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
-extern void ocxl_config_set_afu_pasid(struct pci_dev *dev,
-				int afu_control,
-				int pasid_base, u32 pasid_count_log);
-extern int ocxl_config_get_actag_info(struct pci_dev *dev,
-				u16 *base, u16 *enabled, u16 *supported);
-extern void ocxl_config_set_actag(struct pci_dev *dev, int func_dvsec,
-				u32 tag_first, u32 tag_count);
-extern void ocxl_config_set_afu_actag(struct pci_dev *dev, int afu_control,
-				int actag_base, int actag_count);
-extern void ocxl_config_set_afu_state(struct pci_dev *dev, int afu_control,
-				int enable);
-extern int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec);
-extern int ocxl_config_terminate_pasid(struct pci_dev *dev, int afu_control,
-				int pasid);
-
-extern int ocxl_link_setup(struct pci_dev *dev, int PE_mask,
-			void **link_handle);
-extern void ocxl_link_release(struct pci_dev *dev, void *link_handle);
-extern int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
-		u64 amr, struct mm_struct *mm,
-		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
-		void *xsl_err_data);
-extern int ocxl_link_remove_pe(void *link_handle, int pasid);
-extern int ocxl_link_irq_alloc(void *link_handle, int *hw_irq,
-			u64 *addr);
-extern void ocxl_link_free_irq(void *link_handle, int hw_irq);
-
 extern int ocxl_pasid_afu_alloc(struct ocxl_fn *fn, u32 size);
 extern void ocxl_pasid_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
 extern int ocxl_actag_afu_alloc(struct ocxl_fn *fn, u32 size);
diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
new file mode 100644
index 000000000000..2b66a2083a23
--- /dev/null
+++ b/include/misc/ocxl.h
@@ -0,0 +1,221 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _MISC_OCXL_H_
+#define _MISC_OCXL_H_
+
+#include <linux/pci.h>
+
+/*
+ * Opencapi drivers all need some common facilities, like parsing the
+ * device configuration space, adding a Process Element to the Shared
+ * Process Area, etc...
+ *
+ * The ocxl module provides a kernel API, to allow other drivers to
+ * reuse common code. A bit like a in-kernel library.
+ */
+
+#define OCXL_AFU_NAME_SZ      (24+1)  /* add 1 for NULL termination */
+
+/*
+ * The following 2 structures are a fairly generic way of representing
+ * the configuration data for a function and AFU, as read from the
+ * configuration space.
+ */
+struct ocxl_afu_config {
+	u8 idx;
+	int dvsec_afu_control_pos; /* offset of AFU control DVSEC */
+	char name[OCXL_AFU_NAME_SZ];
+	u8 version_major;
+	u8 version_minor;
+	u8 afuc_type;
+	u8 afum_type;
+	u8 profile;
+	u8 global_mmio_bar;     /* global MMIO area */
+	u64 global_mmio_offset;
+	u32 global_mmio_size;
+	u8 pp_mmio_bar;         /* per-process MMIO area */
+	u64 pp_mmio_offset;
+	u32 pp_mmio_stride;
+	u8 log_mem_size;
+	u8 pasid_supported_log;
+	u16 actag_supported;
+};
+
+struct ocxl_fn_config {
+	int dvsec_tl_pos;       /* offset of the Transaction Layer DVSEC */
+	int dvsec_function_pos; /* offset of the Function DVSEC */
+	int dvsec_afu_info_pos; /* offset of the AFU information DVSEC */
+	s8 max_pasid_log;
+	s8 max_afu_index;
+};
+
+/*
+ * Read the configuration space of a function and fill in a
+ * ocxl_fn_config structure with all the function details
+ */
+extern int ocxl_config_read_function(struct pci_dev *dev,
+				struct ocxl_fn_config *fn);
+
+/*
+ * Check if an AFU index is valid for the given function.
+ *
+ * AFU indexes can be sparse, so a driver should check all indexes up
+ * to the maximum found in the function description
+ */
+extern int ocxl_config_check_afu_index(struct pci_dev *dev,
+				struct ocxl_fn_config *fn, int afu_idx);
+
+/*
+ * Read the configuration space of a function for the AFU specified by
+ * the index 'afu_idx'. Fills in a ocxl_afu_config structure
+ */
+extern int ocxl_config_read_afu(struct pci_dev *dev,
+				struct ocxl_fn_config *fn,
+				struct ocxl_afu_config *afu,
+				u8 afu_idx);
+
+/*
+ * Get the max PASID value that can be used by the function
+ */
+extern int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
+
+/*
+ * Tell an AFU, by writing in the configuration space, the PASIDs that
+ * it can use. Range starts at 'pasid_base' and its size is a multiple
+ * of 2
+ *
+ * 'afu_control_offset' is the offset of the AFU control DVSEC which
+ * can be found in the function configuration
+ */
+extern void ocxl_config_set_afu_pasid(struct pci_dev *dev,
+				int afu_control_offset,
+				int pasid_base, u32 pasid_count_log);
+
+/*
+ * Get the actag configuration for the function:
+ * 'base' is the first actag value that can be used.
+ * 'enabled' it the number of actags available, starting from base.
+ * 'supported' is the total number of actags desired by all the AFUs
+ *             of the function.
+ */
+extern int ocxl_config_get_actag_info(struct pci_dev *dev,
+				u16 *base, u16 *enabled, u16 *supported);
+
+/*
+ * Tell a function, by writing in the configuration space, the actags
+ * it can use.
+ *
+ * 'func_offset' is the offset of the Function DVSEC that can found in
+ * the function configuration
+ */
+extern void ocxl_config_set_actag(struct pci_dev *dev, int func_offset,
+				u32 actag_base, u32 actag_count);
+
+/*
+ * Tell an AFU, by writing in the configuration space, the actags it
+ * can use.
+ *
+ * 'afu_control_offset' is the offset of the AFU control DVSEC for the
+ * desired AFU. It can be found in the AFU configuration
+ */
+extern void ocxl_config_set_afu_actag(struct pci_dev *dev,
+				int afu_control_offset,
+				int actag_base, int actag_count);
+
+/*
+ * Enable/disable an AFU, by writing in the configuration space.
+ *
+ * 'afu_control_offset' is the offset of the AFU control DVSEC for the
+ * desired AFU. It can be found in the AFU configuration
+ */
+extern void ocxl_config_set_afu_state(struct pci_dev *dev,
+				int afu_control_offset, int enable);
+
+/*
+ * Set the Transaction Layer configuration in the configuration space.
+ * Only needed for function 0.
+ *
+ * It queries the host TL capabilities, find some common ground
+ * between the host and device, and set the Transaction Layer on both
+ * accordingly.
+ */
+extern int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec);
+
+/*
+ * Request an AFU to terminate a PASID.
+ * Will return once the AFU has acked the request, or an error in case
+ * of timeout.
+ *
+ * The hardware can only terminate one PASID at a time, so caller must
+ * guarantee some kind of serialization.
+ *
+ * 'afu_control_offset' is the offset of the AFU control DVSEC for the
+ * desired AFU. It can be found in the AFU configuration
+ */
+extern int ocxl_config_terminate_pasid(struct pci_dev *dev,
+				int afu_control_offset, int pasid);
+
+/*
+ * Set up the opencapi link for the function.
+ *
+ * When called for the first time for a link, it sets up the Shared
+ * Process Area for the link and the interrupt handler to process
+ * translation faults.
+ *
+ * Returns a 'link handle' that should be used for further calls for
+ * the link
+ */
+extern int ocxl_link_setup(struct pci_dev *dev, int PE_mask,
+			void **link_handle);
+
+/*
+ * Remove the association between the function and its link.
+ */
+extern void ocxl_link_release(struct pci_dev *dev, void *link_handle);
+
+/*
+ * Add a Process Element to the Shared Process Area for a link.
+ * The process is defined by its PASID, pid, tid and its mm_struct.
+ *
+ * 'xsl_err_cb' is an optional callback if the driver wants to be
+ * notified when the translation fault interrupt handler detects an
+ * address error.
+ * 'xsl_err_data' is an argument passed to the above callback, if
+ * defined
+ */
+extern int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
+		u64 amr, struct mm_struct *mm,
+		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
+		void *xsl_err_data);
+
+/*
+ * Remove a Process Element from the Shared Process Area for a link
+ */
+extern int ocxl_link_remove_pe(void *link_handle, int pasid);
+
+/*
+ * Allocate an AFU interrupt associated to the link.
+ *
+ * 'hw_irq' is the hardware interrupt number
+ * 'obj_handle' is the 64-bit object handle to be passed to the AFU to
+ * trigger the interrupt.
+ * On P9, 'obj_handle' is an address, which, if written, triggers the
+ * interrupt. It is an MMIO address which needs to be remapped (one
+ * page).
+ */
+extern int ocxl_link_irq_alloc(void *link_handle, int *hw_irq,
+			u64 *obj_handle);
+
+/*
+ * Free a previously allocated AFU interrupt
+ */
+extern void ocxl_link_free_irq(void *link_handle, int hw_irq);
+
+#endif /* _MISC_OCXL_H_ */
-- 
2.14.1
