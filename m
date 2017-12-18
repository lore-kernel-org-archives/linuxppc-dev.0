Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0lBR45w4zDsF7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 02:21:51 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIFJJTD140216
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:49 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2exegund8k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:48 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 15:21:46 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH 05/13] powerpc/powernv: Capture actag information for the
 device
Date: Mon, 18 Dec 2017 16:21:18 +0100
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
Message-Id: <0575f03a450f732f6de4f3ab82714b8181d3e3b7.1513608243.git.fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the opencapi protocol, host memory contexts are referenced by a
'actag'. During setup, a driver must tell the device how many actags
it can used, and what values are acceptable.

On POWER9, the NPU can handle 64 actags per link, so they must be
shared between all the PCI functions of the link. To get a global
picture of how many actags are used by each AFU of every function, we
capture some data at the end of PCI enumeration, so that actags can be
shared fairly if needed.

This is not powernv specific per say, but rather a consequence of the
opencapi configuration specification being quite general. The number
of available actags on POWER9 makes it more likely to be hit. This is
somewhat mitigated by the fact that existing AFUs are coded by
requesting a reasonable count of actags and existing devices carry
only one AFU.


Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pnv-ocxl.h   |   4 +
 arch/powerpc/platforms/powernv/ocxl.c | 302 ++++++++++++++++++++++++++++++++++
 include/misc/ocxl-config.h            |  52 ++++++
 3 files changed, 358 insertions(+)
 create mode 100644 include/misc/ocxl-config.h

diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index b9ab3f0a9634..5a7ae7f28209 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -16,6 +16,10 @@
 #define PNV_OCXL_TL_BITS_PER_RATE       4
 #define PNV_OCXL_TL_RATE_BUF_SIZE       ((PNV_OCXL_TL_MAX_TEMPLATE+1) * PNV_OCXL_TL_BITS_PER_RATE / 8)
 
+extern int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled,
+			u16 *supported);
+extern int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count);
+
 extern int pnv_ocxl_get_tl_cap(struct pci_dev *dev, long *cap,
 			char *rate_buf, int rate_buf_size);
 extern int pnv_ocxl_set_tl_conf(struct pci_dev *dev, long cap,
diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 3378b75cf5e5..6c79924b95c8 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -9,13 +9,315 @@
 
 #include <asm/pnv-ocxl.h>
 #include <asm/opal.h>
+#include <misc/ocxl-config.h>
 #include "pci.h"
 
 #define PNV_OCXL_TL_P9_RECV_CAP		0x000000000000000Full
+#define PNV_OCXL_ACTAG_MAX		64
 /* PASIDs are 20-bit, but on P9, NPU can only handle 15 bits */
 #define PNV_OCXL_PASID_BITS		15
 #define PNV_OCXL_PASID_MAX		((1 << PNV_OCXL_PASID_BITS) - 1)
 
+#define AFU_PRESENT (1 << 31)
+#define AFU_INDEX_MASK 0x3F000000
+#define AFU_INDEX_SHIFT 24
+#define ACTAG_MASK 0xFFF
+
+
+struct actag_range {
+	u16 start;
+	u16 count;
+};
+
+struct npu_link {
+	struct list_head list;
+	int domain;
+	int bus;
+	int dev;
+	u16 fn_desired_actags[8];
+	struct actag_range fn_actags[8];
+	bool assignment_done;
+};
+static struct list_head links_list = LIST_HEAD_INIT(links_list);
+static DEFINE_MUTEX(links_list_lock);
+
+
+/*
+ * opencapi actags handling:
+ *
+ * When sending commands, the opencapi device references the memory
+ * context it's targeting with an 'actag', which is really an alias
+ * for a (BDF, pasid) combination. When it receives a command, the NPU
+ * must do a lookup of the actag to identify the memory context. The
+ * hardware supports a finite number of actags per link (64 for
+ * POWER9).
+ *
+ * The device can carry multiple functions, and each function can have
+ * multiple AFUs. Each AFU advertises in its config space the number
+ * of desired actags. The host must configure in the config space of
+ * the AFU how many actags the AFU is really allowed to use (which can
+ * be less than what the AFU desires).
+ *
+ * When a PCI function is probed by the driver, it has no visibility
+ * about the other PCI functions and how many actags they'd like,
+ * which makes it impossible to distribute actags fairly among AFUs.
+ *
+ * Unfortunately, the only way to know how many actags a function
+ * desires is by looking at the data for each AFU in the config space
+ * and add them up. Similarly, the only way to know how many actags
+ * all the functions of the physical device desire is by adding the
+ * previously computed function counts. Then we can match that against
+ * what the hardware supports.
+ *
+ * To get a comprehensive view, we use a 'pci fixup': at the end of
+ * PCI enumeration, each function counts how many actags its AFUs
+ * desire and we save it in a 'npu_link' structure, shared between all
+ * the PCI functions of a same device. Therefore, when the first
+ * function is probed by the driver, we can get an idea of the total
+ * count of desired actags for the device, and assign the actags to
+ * the AFUs, by pro-rating if needed.
+ */
+
+static int find_dvsec_from_pos(struct pci_dev *dev, int dvsec_id, int pos)
+{
+	int vsec = pos;
+	u16 vendor, id;
+
+	while ((vsec = pci_find_next_ext_capability(dev, vsec,
+						    OCXL_EXT_CAP_ID_DVSEC))) {
+		pci_read_config_word(dev, vsec + OCXL_DVSEC_VENDOR_OFFSET,
+				&vendor);
+		pci_read_config_word(dev, vsec + OCXL_DVSEC_ID_OFFSET, &id);
+		if (vendor == PCI_VENDOR_ID_IBM && id == dvsec_id)
+			return vsec;
+	}
+	return 0;
+}
+
+static int find_dvsec_afu_ctrl(struct pci_dev *dev, u8 afu_idx)
+{
+	int vsec = 0;
+	u8 idx;
+
+	while ((vsec = find_dvsec_from_pos(dev, OCXL_DVSEC_AFU_CTRL_ID,
+					   vsec))) {
+		pci_read_config_byte(dev, vsec + OCXL_DVSEC_AFU_CTRL_AFU_IDX,
+				&idx);
+		if (idx == afu_idx)
+			return vsec;
+	}
+	return 0;
+}
+
+static int get_max_afu_index(struct pci_dev *dev, int *afu_idx)
+{
+	int pos;
+	u32 val;
+
+	pos = find_dvsec_from_pos(dev, OCXL_DVSEC_FUNC_ID, 0);
+	if (!pos)
+		return -ESRCH;
+
+	pci_read_config_dword(dev, pos + OCXL_DVSEC_FUNC_OFF_INDEX, &val);
+	if (val & AFU_PRESENT)
+		*afu_idx = (val & AFU_INDEX_MASK) >> AFU_INDEX_SHIFT;
+	else
+		*afu_idx = -1;
+	return 0;
+}
+
+static int get_actag_count(struct pci_dev *dev, int afu_idx, int *actag)
+{
+	int pos;
+	u16 actag_sup;
+
+	pos = find_dvsec_afu_ctrl(dev, afu_idx);
+	if (!pos)
+		return -ESRCH;
+
+	pci_read_config_word(dev, pos + OCXL_DVSEC_AFU_CTRL_ACTAG_SUP,
+			&actag_sup);
+	*actag = actag_sup & ACTAG_MASK;
+	return 0;
+}
+
+static struct npu_link *find_link(struct pci_dev *dev)
+{
+	struct npu_link *link;
+
+	list_for_each_entry(link, &links_list, list) {
+		/* The functions of a device all share the same link */
+		if (link->domain == pci_domain_nr(dev->bus) &&
+			link->bus == dev->bus->number &&
+			link->dev == PCI_SLOT(dev->devfn)) {
+			return link;
+		}
+	}
+
+	/* link doesn't exist yet. Allocate one */
+	link = kzalloc(sizeof(struct npu_link), GFP_KERNEL);
+	if (!link)
+		return NULL;
+	link->domain = pci_domain_nr(dev->bus);
+	link->bus = dev->bus->number;
+	link->dev = PCI_SLOT(dev->devfn);
+	list_add(&link->list, &links_list);
+	return link;
+}
+
+static void pnv_ocxl_fixup_actag(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct npu_link *link;
+	int rc, afu_idx = -1, i, actag;
+
+	if (phb->type != PNV_PHB_NPU_OCAPI)
+		return;
+
+	mutex_lock(&links_list_lock);
+
+	link = find_link(dev);
+	if (!link) {
+		dev_warn(&dev->dev, "couldn't update actag information\n");
+		mutex_unlock(&links_list_lock);
+		return;
+	}
+
+	/*
+	 * Check how many actags are desired for the AFUs under that
+	 * function and add it to the count for the link
+	 */
+	rc = get_max_afu_index(dev, &afu_idx);
+	if (rc) {
+		/* Most likely an invalid config space */
+		dev_dbg(&dev->dev, "couldn't find AFU information\n");
+		afu_idx = -1;
+	}
+
+	link->fn_desired_actags[PCI_FUNC(dev->devfn)] = 0;
+	for (i = 0; i <= afu_idx; i++) {
+		/*
+		 * AFU index 'holes' are allowed. So don't fail if we
+		 * can't read the actag info for an index
+		 */
+		rc = get_actag_count(dev, i, &actag);
+		if (rc)
+			continue;
+		link->fn_desired_actags[PCI_FUNC(dev->devfn)] += actag;
+	}
+	dev_dbg(&dev->dev, "total actags for function: %d\n",
+		link->fn_desired_actags[PCI_FUNC(dev->devfn)]);
+
+	mutex_unlock(&links_list_lock);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pnv_ocxl_fixup_actag);
+
+static u16 assign_fn_actags(u16 desired, u16 total)
+{
+	u16 count;
+
+	if (total <= PNV_OCXL_ACTAG_MAX)
+		count = desired;
+	else
+		count = PNV_OCXL_ACTAG_MAX * desired / total;
+
+	return count;
+}
+
+static void assign_actags(struct npu_link *link)
+{
+	u16 actag_count, range_start = 0, total_desired = 0;
+	int i;
+
+	for (i = 0; i < 8; i++)
+		total_desired += link->fn_desired_actags[i];
+
+	for (i = 0; i < 8; i++) {
+		if (link->fn_desired_actags[i]) {
+			actag_count = assign_fn_actags(
+				link->fn_desired_actags[i],
+				total_desired);
+			link->fn_actags[i].start = range_start;
+			link->fn_actags[i].count = actag_count;
+			range_start += actag_count;
+			WARN_ON(range_start >= PNV_OCXL_ACTAG_MAX);
+		}
+		pr_debug("link %x:%x:%x fct %d actags: start=%d count=%d (desired=%d)\n",
+			link->domain, link->bus, link->dev, i,
+			link->fn_actags[i].start, link->fn_actags[i].count,
+			link->fn_desired_actags[i]);
+	}
+	link->assignment_done = true;
+}
+
+int pnv_ocxl_get_actag(struct pci_dev *dev, u16 *base, u16 *enabled,
+		u16 *supported)
+{
+	struct npu_link *link;
+
+	mutex_lock(&links_list_lock);
+
+	link = find_link(dev);
+	if (!link) {
+		dev_err(&dev->dev, "actag information not found\n");
+		mutex_unlock(&links_list_lock);
+		return -ENODEV;
+	}
+	/*
+	 * On p9, we only have 64 actags per link, so they must be
+	 * shared by all the functions of the same adapter. We counted
+	 * the desired actag counts during PCI enumeration, so that we
+	 * can allocate a pro-rated number of actags to each function.
+	 */
+	if (!link->assignment_done)
+		assign_actags(link);
+
+	*base      = link->fn_actags[PCI_FUNC(dev->devfn)].start;
+	*enabled   = link->fn_actags[PCI_FUNC(dev->devfn)].count;
+	*supported = link->fn_desired_actags[PCI_FUNC(dev->devfn)];
+
+	mutex_unlock(&links_list_lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_get_actag);
+
+int pnv_ocxl_get_pasid_count(struct pci_dev *dev, int *count)
+{
+	struct npu_link *link;
+	int i, rc = -EINVAL;
+
+	/*
+	 * The number of PASIDs (process address space ID) which can
+	 * be used by a function depends on how many functions exist
+	 * on the device. The NPU needs to be configured to know how
+	 * many bits are available to PASIDs and how many are to be
+	 * used by the function BDF indentifier.
+	 *
+	 * We only support one AFU-carrying function for now.
+	 */
+	mutex_lock(&links_list_lock);
+
+	link = find_link(dev);
+	if (!link) {
+		dev_err(&dev->dev, "actag information not found\n");
+		mutex_unlock(&links_list_lock);
+		return -ENODEV;
+	}
+
+	for (i = 0; i < 8; i++)
+		if (link->fn_desired_actags[i] && (i == PCI_FUNC(dev->devfn))) {
+			*count = PNV_OCXL_PASID_MAX;
+			rc = 0;
+			break;
+		}
+
+	mutex_unlock(&links_list_lock);
+	dev_dbg(&dev->dev, "%d PASIDs available for function\n",
+		rc ? 0 : *count);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_get_pasid_count);
 
 static void set_templ_rate(unsigned int templ, unsigned int rate, char *buf)
 {
diff --git a/include/misc/ocxl-config.h b/include/misc/ocxl-config.h
new file mode 100644
index 000000000000..b6677899ed09
--- /dev/null
+++ b/include/misc/ocxl-config.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _OCXL_CONFIG_H_
+#define _OCXL_CONFIG_H_
+
+/*
+ * This file lists the various constants used to read the
+ * configuration space of an opencapi adapter.
+ *
+ * It follows the specification for opencapi 3.0
+ */
+
+#define OCXL_EXT_CAP_ID_DVSEC                 0x23
+
+#define OCXL_DVSEC_VENDOR_OFFSET              0x4
+#define OCXL_DVSEC_ID_OFFSET                  0x8
+#define OCXL_DVSEC_TL_ID                      0xF000
+#define   OCXL_DVSEC_TL_BACKOFF_TIMERS          0x10
+#define   OCXL_DVSEC_TL_RECV_CAP                0x18
+#define   OCXL_DVSEC_TL_SEND_CAP                0x20
+#define   OCXL_DVSEC_TL_RECV_RATE               0x30
+#define   OCXL_DVSEC_TL_SEND_RATE               0x50
+#define OCXL_DVSEC_FUNC_ID                    0xF001
+#define   OCXL_DVSEC_FUNC_OFF_INDEX             0x08
+#define   OCXL_DVSEC_FUNC_OFF_ACTAG             0x0C
+#define OCXL_DVSEC_AFU_INFO_ID                0xF003
+#define   OCXL_DVSEC_AFU_INFO_AFU_IDX           0x0A
+#define   OCXL_DVSEC_AFU_INFO_OFF               0x0C
+#define   OCXL_DVSEC_AFU_INFO_DATA              0x10
+#define OCXL_DVSEC_AFU_CTRL_ID                0xF004
+#define   OCXL_DVSEC_AFU_CTRL_AFU_IDX           0x0A
+#define   OCXL_DVSEC_AFU_CTRL_TERM_PASID        0x0C
+#define   OCXL_DVSEC_AFU_CTRL_ENABLE            0x0F
+#define   OCXL_DVSEC_AFU_CTRL_PASID_SUP         0x10
+#define   OCXL_DVSEC_AFU_CTRL_PASID_EN          0x11
+#define   OCXL_DVSEC_AFU_CTRL_PASID_BASE        0x14
+#define   OCXL_DVSEC_AFU_CTRL_ACTAG_SUP         0x18
+#define   OCXL_DVSEC_AFU_CTRL_ACTAG_EN          0x1A
+#define   OCXL_DVSEC_AFU_CTRL_ACTAG_BASE        0x1C
+#define OCXL_DVSEC_VENDOR_ID                  0xF0F0
+#define   OCXL_DVSEC_VENDOR_CFG_VERS            0x0C
+#define   OCXL_DVSEC_VENDOR_TLX_VERS            0x10
+#define   OCXL_DVSEC_VENDOR_DLX_VERS            0x20
+
+#endif /* _OCXL_CONFIG_H_ */
-- 
2.14.1
