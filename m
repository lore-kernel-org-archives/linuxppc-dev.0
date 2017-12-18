Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0lBW5nggzDsNH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 02:21:54 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIFKlJX015535
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:52 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2exfja258t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 10:21:51 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 15:21:49 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH 06/13] ocxl: Driver code for 'generic' opencapi devices
Date: Mon, 18 Dec 2017 16:21:19 +0100
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
In-Reply-To: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
References: <cover.1513608243.git.fbarrat@linux.vnet.ibm.com>
Message-Id: <599cc92264dfdceb7d62ff65cc9aa9e2c2f1fd35.1513608243.git.fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add an ocxl driver to handle generic opencapi devices. Of course, it's
not meant to be the only opencapi driver, any device is free to
implement its own. But if a host application only needs basic services
like attaching to an opencapi adapter, have translation faults handled
or allocate AFU interrupts, it should suffice.

The AFU config space must follow the opencapi specification and use
the expected vendor/device ID to be seen by the generic driver.

The driver exposes the device AFUs as a char device in /dev/ocxl/

Note that the driver currently doesn't handle memory attached to the
opencapi device.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/config.c        | 718 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/ocxl/context.c       | 237 +++++++++++++
 drivers/misc/ocxl/file.c          | 405 +++++++++++++++++++++
 drivers/misc/ocxl/link.c          | 610 ++++++++++++++++++++++++++++++++
 drivers/misc/ocxl/main.c          |  40 +++
 drivers/misc/ocxl/ocxl_internal.h | 200 +++++++++++
 drivers/misc/ocxl/pasid.c         | 114 ++++++
 drivers/misc/ocxl/pci.c           | 592 +++++++++++++++++++++++++++++++
 drivers/misc/ocxl/sysfs.c         | 150 ++++++++
 include/uapi/misc/ocxl.h          |  47 +++
 10 files changed, 3113 insertions(+)
 create mode 100644 drivers/misc/ocxl/config.c
 create mode 100644 drivers/misc/ocxl/context.c
 create mode 100644 drivers/misc/ocxl/file.c
 create mode 100644 drivers/misc/ocxl/link.c
 create mode 100644 drivers/misc/ocxl/main.c
 create mode 100644 drivers/misc/ocxl/ocxl_internal.h
 create mode 100644 drivers/misc/ocxl/pasid.c
 create mode 100644 drivers/misc/ocxl/pci.c
 create mode 100644 drivers/misc/ocxl/sysfs.c
 create mode 100644 include/uapi/misc/ocxl.h

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
new file mode 100644
index 000000000000..bb2fde5967e2
--- /dev/null
+++ b/drivers/misc/ocxl/config.c
@@ -0,0 +1,718 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/pci.h>
+#include <asm/pnv-ocxl.h>
+#include <misc/ocxl-config.h>
+#include "ocxl_internal.h"
+
+#define EXTRACT_BIT(val, bit) (!!(val & BIT(bit)))
+#define EXTRACT_BITS(val, s, e) ((val & GENMASK(e, s)) >> s)
+
+#define OCXL_DVSEC_AFU_IDX_MASK              GENMASK(5, 0)
+#define OCXL_DVSEC_ACTAG_MASK                GENMASK(11, 0)
+#define OCXL_DVSEC_PASID_MASK                GENMASK(19, 0)
+#define OCXL_DVSEC_PASID_LOG_MASK            GENMASK(4, 0)
+
+#define OCXL_DVSEC_TEMPL_VERSION         0x0
+#define OCXL_DVSEC_TEMPL_NAME            0x4
+#define OCXL_DVSEC_TEMPL_AFU_VERSION     0x1C
+#define OCXL_DVSEC_TEMPL_MMIO_GLOBAL     0x20
+#define OCXL_DVSEC_TEMPL_MMIO_GLOBAL_SZ  0x28
+#define OCXL_DVSEC_TEMPL_MMIO_PP         0x30
+#define OCXL_DVSEC_TEMPL_MMIO_PP_SZ      0x38
+#define OCXL_DVSEC_TEMPL_MEM_SZ          0x3C
+#define OCXL_DVSEC_TEMPL_WWID            0x40
+
+#define OCXL_MAX_AFU_PER_FUNCTION 64
+#define OCXL_TEMPL_LEN            0x58
+#define OCXL_TEMPL_NAME_LEN       24
+#define OCXL_CFG_TIMEOUT     3
+
+static int find_dvsec(struct pci_dev *dev, int dvsec_id)
+{
+	int vsec = 0;
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
+	u16 vendor, id;
+	u8 idx;
+
+	while ((vsec = pci_find_next_ext_capability(dev, vsec,
+						    OCXL_EXT_CAP_ID_DVSEC))) {
+		pci_read_config_word(dev, vsec + OCXL_DVSEC_VENDOR_OFFSET,
+				&vendor);
+		pci_read_config_word(dev, vsec + OCXL_DVSEC_ID_OFFSET, &id);
+
+		if (vendor == PCI_VENDOR_ID_IBM &&
+			id == OCXL_DVSEC_AFU_CTRL_ID) {
+			pci_read_config_byte(dev,
+					vsec + OCXL_DVSEC_AFU_CTRL_AFU_IDX,
+					&idx);
+			if (idx == afu_idx)
+				return vsec;
+		}
+	}
+	return 0;
+}
+
+static int read_pasid(struct pci_dev *dev, struct ocxl_fn_config *fn)
+{
+	u16 val;
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PASID);
+	if (!pos) {
+		/*
+		 * PASID capability is not mandatory, but there
+		 * shouldn't be any AFU
+		 */
+		dev_dbg(&dev->dev, "Function doesn't require any PASID\n");
+		fn->max_pasid_log = -1;
+		goto out;
+	}
+	pci_read_config_word(dev, pos + PCI_PASID_CAP, &val);
+	fn->max_pasid_log = EXTRACT_BITS(val, 8, 12);
+
+out:
+	dev_dbg(&dev->dev, "PASID capability:\n");
+	dev_dbg(&dev->dev, "  Max PASID log = %d\n", fn->max_pasid_log);
+	return 0;
+}
+
+static int read_dvsec_tl(struct pci_dev *dev, struct ocxl_fn_config *fn)
+{
+	int pos;
+
+	pos = find_dvsec(dev, OCXL_DVSEC_TL_ID);
+	if (!pos && PCI_FUNC(dev->devfn) == 0) {
+		dev_err(&dev->dev, "Can't find TL DVSEC\n");
+		return -ENODEV;
+	}
+	if (pos && PCI_FUNC(dev->devfn) != 0) {
+		dev_err(&dev->dev, "TL DVSEC is only allowed on function 0\n");
+		return -ENODEV;
+	}
+	fn->dvsec_tl_pos = pos;
+	return 0;
+}
+
+static int read_dvsec_function(struct pci_dev *dev, struct ocxl_fn_config *fn)
+{
+	int pos, afu_present;
+	u32 val;
+
+	pos = find_dvsec(dev, OCXL_DVSEC_FUNC_ID);
+	if (!pos) {
+		dev_err(&dev->dev, "Can't find function DVSEC\n");
+		return -ENODEV;
+	}
+	fn->dvsec_function_pos = pos;
+
+	pci_read_config_dword(dev, pos + OCXL_DVSEC_FUNC_OFF_INDEX, &val);
+	afu_present = EXTRACT_BIT(val, 31);
+	if (!afu_present) {
+		fn->max_afu_index = -1;
+		dev_dbg(&dev->dev, "Function doesn't define any AFU\n");
+		goto out;
+	}
+	fn->max_afu_index = EXTRACT_BITS(val, 24, 29);
+
+out:
+	dev_dbg(&dev->dev, "Function DVSEC:\n");
+	dev_dbg(&dev->dev, "  Max AFU index = %d\n", fn->max_afu_index);
+	return 0;
+}
+
+static int read_dvsec_afu_info(struct pci_dev *dev, struct ocxl_fn_config *fn)
+{
+	int pos;
+
+	if (fn->max_afu_index < 0) {
+		fn->dvsec_afu_info_pos = -1;
+		return 0;
+	}
+
+	pos = find_dvsec(dev, OCXL_DVSEC_AFU_INFO_ID);
+	if (!pos) {
+		dev_err(&dev->dev, "Can't find AFU information DVSEC\n");
+		return -ENODEV;
+	}
+	fn->dvsec_afu_info_pos = pos;
+	return 0;
+}
+
+static int read_dvsec_vendor(struct pci_dev *dev)
+{
+	int pos;
+	u32 cfg, tlx, dlx;
+
+	/*
+	 * vendor specific DVSEC is optional
+	 *
+	 * It's currently only used on function 0 to specify the
+	 * version of some logic blocks. Some older images may not
+	 * even have it so we ignore any errors
+	 */
+	if (PCI_FUNC(dev->devfn) != 0)
+		return 0;
+
+	pos = find_dvsec(dev, OCXL_DVSEC_VENDOR_ID);
+	if (!pos)
+		return 0;
+
+	pci_read_config_dword(dev, pos + OCXL_DVSEC_VENDOR_CFG_VERS, &cfg);
+	pci_read_config_dword(dev, pos + OCXL_DVSEC_VENDOR_TLX_VERS, &tlx);
+	pci_read_config_dword(dev, pos + OCXL_DVSEC_VENDOR_DLX_VERS, &dlx);
+
+	dev_dbg(&dev->dev, "Vendor specific DVSEC:\n");
+	dev_dbg(&dev->dev, "  CFG version = 0x%x\n", cfg);
+	dev_dbg(&dev->dev, "  TLX version = 0x%x\n", tlx);
+	dev_dbg(&dev->dev, "  DLX version = 0x%x\n", dlx);
+	return 0;
+}
+
+static int validate_function(struct pci_dev *dev, struct ocxl_fn_config *fn)
+{
+	if (fn->max_pasid_log == -1 && fn->max_afu_index >= 0) {
+		dev_err(&dev->dev,
+			"AFUs are defined but no PASIDs are requested\n");
+		return -EINVAL;
+	}
+
+	if (fn->max_afu_index > OCXL_MAX_AFU_PER_FUNCTION) {
+		dev_err(&dev->dev,
+			"Max AFU index out of architectural limit (%d vs %d)\n",
+			fn->max_afu_index, OCXL_MAX_AFU_PER_FUNCTION);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int ocxl_config_read_function(struct pci_dev *dev, struct ocxl_fn_config *fn)
+{
+	int rc;
+
+	rc = read_pasid(dev, fn);
+	if (rc) {
+		dev_err(&dev->dev, "Invalid PASID configuration: %d\n", rc);
+		return -ENODEV;
+	}
+
+	rc = read_dvsec_tl(dev, fn);
+	if (rc) {
+		dev_err(&dev->dev,
+			"Invalid Transaction Layer DVSEC configuration: %d\n",
+			rc);
+		return -ENODEV;
+	}
+
+	rc = read_dvsec_function(dev, fn);
+	if (rc) {
+		dev_err(&dev->dev,
+			"Invalid Function DVSEC configuration: %d\n", rc);
+		return -ENODEV;
+	}
+
+	rc = read_dvsec_afu_info(dev, fn);
+	if (rc) {
+		dev_err(&dev->dev, "Invalid AFU configuration: %d\n", rc);
+		return -ENODEV;
+	}
+
+	rc = read_dvsec_vendor(dev);
+	if (rc) {
+		dev_err(&dev->dev,
+			"Invalid vendor specific DVSEC configuration: %d\n",
+			rc);
+		return -ENODEV;
+	}
+
+	rc = validate_function(dev, fn);
+	return rc;
+}
+
+static int read_afu_info(struct pci_dev *dev, struct ocxl_fn_config *fn,
+			int offset, u32 *data)
+{
+	u32 val;
+	unsigned long timeout = jiffies + (HZ * OCXL_CFG_TIMEOUT);
+	int pos = fn->dvsec_afu_info_pos;
+
+	/* Protect 'data valid' bit */
+	if (EXTRACT_BIT(offset, 31)) {
+		dev_err(&dev->dev, "Invalid offset in AFU info DVSEC\n");
+		return -EINVAL;
+	}
+
+	pci_write_config_dword(dev, pos + OCXL_DVSEC_AFU_INFO_OFF, offset);
+	pci_read_config_dword(dev, pos + OCXL_DVSEC_AFU_INFO_OFF, &val);
+	while (!EXTRACT_BIT(val, 31)) {
+		if (time_after_eq(jiffies, timeout)) {
+			dev_err(&dev->dev,
+				"Timeout while reading AFU info DVSEC (offset=%d)\n",
+				offset);
+			return -EBUSY;
+		}
+		cpu_relax();
+		pci_read_config_dword(dev, pos + OCXL_DVSEC_AFU_INFO_OFF, &val);
+	}
+	pci_read_config_dword(dev, pos + OCXL_DVSEC_AFU_INFO_DATA, data);
+	return 0;
+}
+
+int ocxl_config_check_afu_index(struct pci_dev *dev,
+				struct ocxl_fn_config *fn, int afu_idx)
+{
+	u32 val;
+	int rc, templ_major, templ_minor, len;
+
+	pci_write_config_word(dev, fn->dvsec_afu_info_pos, afu_idx);
+	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_VERSION, &val);
+	if (rc)
+		return rc;
+
+	/* AFU index map can have holes */
+	if (!val)
+		return 0;
+
+	templ_major = EXTRACT_BITS(val, 8, 15);
+	templ_minor = EXTRACT_BITS(val, 0, 7);
+	dev_dbg(&dev->dev, "AFU descriptor template version %d.%d\n",
+		templ_major, templ_minor);
+
+	len = EXTRACT_BITS(val, 16, 31);
+	if (len != OCXL_TEMPL_LEN) {
+		dev_warn(&dev->dev,
+			"Unexpected template length in AFU information (%#x)\n",
+			len);
+	}
+	return 1;
+}
+
+static int read_afu_name(struct pci_dev *dev, struct ocxl_fn_config *fn,
+			struct ocxl_afu_config *afu)
+{
+	int i, rc;
+	u32 val, *ptr;
+
+	BUILD_BUG_ON(OCXL_AFU_NAME_SZ < OCXL_TEMPL_NAME_LEN);
+	for (i = 0; i < OCXL_TEMPL_NAME_LEN; i += 4) {
+		rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_NAME + i, &val);
+		if (rc)
+			return rc;
+		ptr = (u32 *) &afu->name[i];
+		*ptr = val;
+	}
+	afu->name[OCXL_AFU_NAME_SZ - 1] = '\0'; /* play safe */
+	return 0;
+}
+
+static int read_afu_mmio(struct pci_dev *dev, struct ocxl_fn_config *fn,
+			struct ocxl_afu_config *afu)
+{
+	int rc;
+	u32 val;
+
+	/*
+	 * Global MMIO
+	 */
+	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_MMIO_GLOBAL, &val);
+	if (rc)
+		return rc;
+	afu->global_mmio_bar = EXTRACT_BITS(val, 0, 2);
+	afu->global_mmio_offset = EXTRACT_BITS(val, 16, 31) << 16;
+
+	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_MMIO_GLOBAL + 4, &val);
+	if (rc)
+		return rc;
+	afu->global_mmio_offset += (u64) val << 32;
+
+	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_MMIO_GLOBAL_SZ, &val);
+	if (rc)
+		return rc;
+	afu->global_mmio_size = val;
+
+	/*
+	 * Per-process MMIO
+	 */
+	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_MMIO_PP, &val);
+	if (rc)
+		return rc;
+	afu->pp_mmio_bar = EXTRACT_BITS(val, 0, 2);
+	afu->pp_mmio_offset = EXTRACT_BITS(val, 16, 31) << 16;
+
+	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_MMIO_PP + 4, &val);
+	if (rc)
+		return rc;
+	afu->pp_mmio_offset += (u64) val << 32;
+
+	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_MMIO_PP_SZ, &val);
+	if (rc)
+		return rc;
+	afu->pp_mmio_stride = val;
+
+	return 0;
+}
+
+static int read_afu_control(struct pci_dev *dev, struct ocxl_afu_config *afu)
+{
+	int pos;
+	u8 val8;
+	u16 val16;
+
+	pos = find_dvsec_afu_ctrl(dev, afu->idx);
+	if (!pos) {
+		dev_err(&dev->dev, "Can't find AFU control DVSEC for AFU %d\n",
+			afu->idx);
+		return -ENODEV;
+	}
+	afu->dvsec_afu_control_pos = pos;
+
+	pci_read_config_byte(dev, pos + OCXL_DVSEC_AFU_CTRL_PASID_SUP, &val8);
+	afu->pasid_supported_log = EXTRACT_BITS(val8, 0, 4);
+
+	pci_read_config_word(dev, pos + OCXL_DVSEC_AFU_CTRL_ACTAG_SUP, &val16);
+	afu->actag_supported = EXTRACT_BITS(val16, 0, 11);
+	return 0;
+}
+
+static bool char_allowed(int c)
+{
+	/*
+	 * Permitted Characters : Alphanumeric, hyphen, underscore, comma
+	 */
+	if ((c >= 0x30 && c <= 0x39) /* digits */ ||
+		(c >= 0x41 && c <= 0x5A) /* upper case */ ||
+		(c >= 0x61 && c <= 0x7A) /* lower case */ ||
+		c == 0 /* NULL */ ||
+		c == 0x2D /* - */ ||
+		c == 0x5F /* _ */ ||
+		c == 0x2C /* , */)
+		return true;
+	return false;
+}
+
+static int validate_afu(struct pci_dev *dev, struct ocxl_afu_config *afu)
+{
+	int i;
+
+	if (!afu->name[0]) {
+		dev_err(&dev->dev, "Empty AFU name\n");
+		return -EINVAL;
+	}
+	for (i = 0; i < OCXL_TEMPL_NAME_LEN; i++) {
+		if (!char_allowed(afu->name[i])) {
+			dev_err(&dev->dev,
+				"Invalid character in AFU name\n");
+			return -EINVAL;
+		}
+	}
+
+	if (afu->global_mmio_bar != 0 &&
+		afu->global_mmio_bar != 2 &&
+		afu->global_mmio_bar != 4) {
+		dev_err(&dev->dev, "Invalid global MMIO bar number\n");
+		return -EINVAL;
+	}
+	if (afu->pp_mmio_bar != 0 &&
+		afu->pp_mmio_bar != 2 &&
+		afu->pp_mmio_bar != 4) {
+		dev_err(&dev->dev, "Invalid per-process MMIO bar number\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int ocxl_config_read_afu(struct pci_dev *dev, struct ocxl_fn_config *fn,
+			struct ocxl_afu_config *afu, u8 afu_idx)
+{
+	int rc;
+	u32 val32;
+
+	/*
+	 * First, we need to write the AFU idx for the AFU we want to
+	 * access.
+	 */
+	WARN_ON((afu_idx & OCXL_DVSEC_AFU_IDX_MASK) != afu_idx);
+	afu->idx = afu_idx;
+	pci_write_config_byte(dev,
+			fn->dvsec_afu_info_pos + OCXL_DVSEC_AFU_INFO_AFU_IDX,
+			afu->idx);
+
+	rc = read_afu_name(dev, fn, afu);
+	if (rc)
+		return rc;
+
+	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_AFU_VERSION, &val32);
+	if (rc)
+		return rc;
+	afu->version_major = EXTRACT_BITS(val32, 24, 31);
+	afu->version_minor = EXTRACT_BITS(val32, 16, 23);
+	afu->afuc_type = EXTRACT_BITS(val32, 14, 15);
+	afu->afum_type = EXTRACT_BITS(val32, 12, 13);
+	afu->profile = EXTRACT_BITS(val32, 0, 7);
+
+	rc = read_afu_mmio(dev, fn, afu);
+	if (rc)
+		return rc;
+
+	rc = read_afu_info(dev, fn, OCXL_DVSEC_TEMPL_MEM_SZ, &val32);
+	if (rc)
+		return rc;
+	afu->log_mem_size = EXTRACT_BITS(val32, 0, 7);
+
+	rc = read_afu_control(dev, afu);
+	if (rc)
+		return rc;
+
+	dev_dbg(&dev->dev, "AFU configuration:\n");
+	dev_dbg(&dev->dev, "  name = %s\n", afu->name);
+	dev_dbg(&dev->dev, "  version = %d.%d\n", afu->version_major,
+		afu->version_minor);
+	dev_dbg(&dev->dev, "  global mmio bar = %hhu\n", afu->global_mmio_bar);
+	dev_dbg(&dev->dev, "  global mmio offset = %#llx\n",
+		afu->global_mmio_offset);
+	dev_dbg(&dev->dev, "  global mmio size = %#x\n", afu->global_mmio_size);
+	dev_dbg(&dev->dev, "  pp mmio bar = %hhu\n", afu->pp_mmio_bar);
+	dev_dbg(&dev->dev, "  pp mmio offset = %#llx\n", afu->pp_mmio_offset);
+	dev_dbg(&dev->dev, "  pp mmio stride = %#x\n", afu->pp_mmio_stride);
+	dev_dbg(&dev->dev, "  mem size (log) = %hhu\n", afu->log_mem_size);
+	dev_dbg(&dev->dev, "  pasid supported (log) = %u\n",
+		afu->pasid_supported_log);
+	dev_dbg(&dev->dev, "  actag supported = %u\n",
+		afu->actag_supported);
+
+	rc = validate_afu(dev, afu);
+	return rc;
+}
+
+int ocxl_config_get_actag_info(struct pci_dev *dev, u16 *base, u16 *enabled,
+			u16 *supported)
+{
+	int rc;
+
+	/*
+	 * This is really a simple wrapper for the kernel API, to
+	 * avoid an external driver using ocxl as a library to call
+	 * platform-dependent code
+	 */
+	rc = pnv_ocxl_get_actag(dev, base, enabled, supported);
+	if (rc) {
+		dev_err(&dev->dev, "Can't get actag for device: %d\n", rc);
+		return rc;
+	}
+	return 0;
+}
+
+void ocxl_config_set_afu_actag(struct pci_dev *dev, int pos, int actag_base,
+			int actag_count)
+{
+	u16 val;
+
+	val = actag_count & OCXL_DVSEC_ACTAG_MASK;
+	pci_write_config_byte(dev, pos + OCXL_DVSEC_AFU_CTRL_ACTAG_EN, val);
+
+	val = actag_base & OCXL_DVSEC_ACTAG_MASK;
+	pci_write_config_dword(dev, pos + OCXL_DVSEC_AFU_CTRL_ACTAG_BASE, val);
+}
+
+int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count)
+{
+	return pnv_ocxl_get_pasid_count(dev, count);
+}
+
+void ocxl_config_set_afu_pasid(struct pci_dev *dev, int pos, int pasid_base,
+			u32 pasid_count_log)
+{
+	u8 val8;
+	u32 val32;
+
+	val8 = pasid_count_log & OCXL_DVSEC_PASID_LOG_MASK;
+	pci_write_config_byte(dev, pos + OCXL_DVSEC_AFU_CTRL_PASID_EN, val8);
+
+	pci_read_config_dword(dev, pos + OCXL_DVSEC_AFU_CTRL_PASID_BASE,
+			&val32);
+	val32 &= ~OCXL_DVSEC_PASID_MASK;
+	val32 |= pasid_base & OCXL_DVSEC_PASID_MASK;
+	pci_write_config_dword(dev, pos + OCXL_DVSEC_AFU_CTRL_PASID_BASE,
+			val32);
+}
+
+void ocxl_config_set_afu_state(struct pci_dev *dev, int pos, int enable)
+{
+	u8 val;
+
+	pci_read_config_byte(dev, pos + OCXL_DVSEC_AFU_CTRL_ENABLE, &val);
+	if (enable)
+		val |= 1;
+	else
+		val &= 0xFE;
+	pci_write_config_byte(dev, pos + OCXL_DVSEC_AFU_CTRL_ENABLE, val);
+}
+
+int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec)
+{
+	u32 val, *ptr32;
+	u8 timers;
+	int i, rc;
+	long recv_cap;
+	char *recv_rate;
+
+	/*
+	 * Skip on function != 0, as the TL can only be defined on 0
+	 */
+	if (PCI_FUNC(dev->devfn) != 0)
+		return 0;
+
+	recv_rate = kzalloc(PNV_OCXL_TL_RATE_BUF_SIZE, GFP_KERNEL);
+	if (!recv_rate)
+		return -ENOMEM;
+	/*
+	 * The spec defines 64 templates for messages in the
+	 * Transaction Layer (TL).
+	 *
+	 * The host and device each support a subset, so we need to
+	 * configure the transmitters on each side to send only
+	 * templates the receiver understands, at a rate the receiver
+	 * can process.  Per the spec, template 0 must be supported by
+	 * everybody. That's the template which has been used by the
+	 * host and device so far.
+	 *
+	 * The sending rate limit must be set before the template is
+	 * enabled.
+	 */
+
+	/*
+	 * Device -> host
+	 */
+	rc = pnv_ocxl_get_tl_cap(dev, &recv_cap, recv_rate,
+				PNV_OCXL_TL_RATE_BUF_SIZE);
+	if (rc)
+		goto out;
+
+	for (i = 0; i < PNV_OCXL_TL_RATE_BUF_SIZE; i += 4) {
+		ptr32 = (u32 *) &recv_rate[i];
+		pci_write_config_dword(dev,
+				tl_dvsec + OCXL_DVSEC_TL_SEND_RATE + i,
+				be32_to_cpu(*ptr32));
+	}
+	val = recv_cap >> 32;
+	pci_write_config_dword(dev, tl_dvsec + OCXL_DVSEC_TL_SEND_CAP, val);
+	val = recv_cap & GENMASK(31, 0);
+	pci_write_config_dword(dev, tl_dvsec + OCXL_DVSEC_TL_SEND_CAP + 4, val);
+
+	/*
+	 * Host -> device
+	 */
+	for (i = 0; i < PNV_OCXL_TL_RATE_BUF_SIZE; i += 4) {
+		pci_read_config_dword(dev,
+				tl_dvsec + OCXL_DVSEC_TL_RECV_RATE + i,
+				&val);
+		ptr32 = (u32 *) &recv_rate[i];
+		*ptr32 = cpu_to_be32(val);
+	}
+	pci_read_config_dword(dev, tl_dvsec + OCXL_DVSEC_TL_RECV_CAP, &val);
+	recv_cap = (long) val << 32;
+	pci_read_config_dword(dev, tl_dvsec + OCXL_DVSEC_TL_RECV_CAP + 4, &val);
+	recv_cap |= val;
+
+	rc = pnv_ocxl_set_tl_conf(dev, recv_cap, __pa(recv_rate),
+				PNV_OCXL_TL_RATE_BUF_SIZE);
+	if (rc)
+		goto out;
+
+	/*
+	 * Opencapi commands needing to be retried are classified per
+	 * the TL in 2 groups: short and long commands.
+	 *
+	 * The short back off timer it not used for now. It will be
+	 * for opencapi 4.0.
+	 *
+	 * The long back off timer is typically used when an AFU hits
+	 * a page fault but the NPU is already processing one. So the
+	 * AFU needs to wait before it can resubmit. Having a value
+	 * too low doesn't break anything, but can generate extra
+	 * traffic on the link.
+	 * We set it to 1.6 us for now. It's shorter than, but in the
+	 * same order of magnitude as the time spent to process a page
+	 * fault.
+	 */
+	timers = 0x2 << 4; /* long timer = 1.6 us */
+	pci_write_config_byte(dev, tl_dvsec + OCXL_DVSEC_TL_BACKOFF_TIMERS,
+			timers);
+
+	rc = 0;
+out:
+	kfree(recv_rate);
+	return rc;
+}
+
+int ocxl_config_terminate_pasid(struct pci_dev *dev, int afu_control, int pasid)
+{
+	u32 val;
+	unsigned long timeout;
+
+	pci_read_config_dword(dev, afu_control + OCXL_DVSEC_AFU_CTRL_TERM_PASID,
+			&val);
+	if (EXTRACT_BIT(val, 20)) {
+		dev_err(&dev->dev,
+			"Can't terminate PASID %#x, previous termination didn't complete\n",
+			pasid);
+		return -EBUSY;
+	}
+
+	val &= ~OCXL_DVSEC_PASID_MASK;
+	val |= pasid & OCXL_DVSEC_PASID_MASK;
+	val |= BIT(20);
+	pci_write_config_dword(dev,
+			afu_control + OCXL_DVSEC_AFU_CTRL_TERM_PASID,
+			val);
+
+	timeout = jiffies + (HZ * OCXL_CFG_TIMEOUT);
+	pci_read_config_dword(dev, afu_control + OCXL_DVSEC_AFU_CTRL_TERM_PASID,
+			&val);
+	while (EXTRACT_BIT(val, 20)) {
+		if (time_after_eq(jiffies, timeout)) {
+			dev_err(&dev->dev,
+				"Timeout while waiting for AFU to terminate PASID %#x\n",
+				pasid);
+			return -EBUSY;
+		}
+		cpu_relax();
+		pci_read_config_dword(dev,
+				afu_control + OCXL_DVSEC_AFU_CTRL_TERM_PASID,
+				&val);
+	}
+	return 0;
+}
+
+void ocxl_config_set_actag(struct pci_dev *dev, int func_dvsec, u32 tag_first,
+			u32 tag_count)
+{
+	u32 val;
+
+	val = (tag_first & OCXL_DVSEC_ACTAG_MASK) << 16;
+	val |= tag_count & OCXL_DVSEC_ACTAG_MASK;
+	pci_write_config_dword(dev, func_dvsec + OCXL_DVSEC_FUNC_OFF_ACTAG,
+			val);
+}
diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
new file mode 100644
index 000000000000..0bc0dd97d784
--- /dev/null
+++ b/drivers/misc/ocxl/context.c
@@ -0,0 +1,237 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sched/mm.h>
+#include "ocxl_internal.h"
+
+struct ocxl_context *ocxl_context_alloc(void)
+{
+	return kzalloc(sizeof(struct ocxl_context), GFP_KERNEL);
+}
+
+int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
+		struct address_space *mapping)
+{
+	int pasid;
+
+	ctx->afu = afu;
+	mutex_lock(&afu->contexts_lock);
+	pasid = idr_alloc(&afu->contexts_idr, ctx, afu->pasid_base,
+			afu->pasid_base + afu->pasid_max, GFP_KERNEL);
+	if (pasid < 0) {
+		mutex_unlock(&afu->contexts_lock);
+		return pasid;
+	}
+	afu->pasid_count++;
+	mutex_unlock(&afu->contexts_lock);
+
+	ctx->pasid = pasid;
+	ctx->status = OPENED;
+	mutex_init(&ctx->status_mutex);
+	ctx->mapping = mapping;
+	mutex_init(&ctx->mapping_lock);
+	init_waitqueue_head(&ctx->events_wq);
+	mutex_init(&ctx->xsl_error_lock);
+	/*
+	 * Keep a reference on the AFU to make sure it's valid for the
+	 * duration of the life of the context
+	 */
+	ocxl_afu_get(afu);
+	return 0;
+}
+
+/*
+ * Callback for when a translation fault triggers an error
+ * data:	a pointer to the context which triggered the fault
+ * addr:	the address that triggered the error
+ * dsisr:	the value of the PPC64 dsisr register
+ */
+static void xsl_fault_error(void *data, u64 addr, u64 dsisr)
+{
+	struct ocxl_context *ctx = (struct ocxl_context *) data;
+
+	mutex_lock(&ctx->xsl_error_lock);
+	ctx->xsl_error.addr = addr;
+	ctx->xsl_error.dsisr = dsisr;
+	ctx->xsl_error.count++;
+	mutex_unlock(&ctx->xsl_error_lock);
+
+	wake_up_all(&ctx->events_wq);
+}
+
+int ocxl_context_attach(struct ocxl_context *ctx, u64 amr)
+{
+	int rc;
+
+	mutex_lock(&ctx->status_mutex);
+	if (ctx->status != OPENED) {
+		rc = -EIO;
+		goto out;
+	}
+
+	rc = ocxl_link_add_pe(ctx->afu->fn->link, ctx->pasid,
+			current->mm->context.id, 0, amr, current->mm,
+			xsl_fault_error, ctx);
+	if (rc)
+		goto out;
+
+	ctx->status = ATTACHED;
+out:
+	mutex_unlock(&ctx->status_mutex);
+	return rc;
+}
+
+static int map_pp_mmio(struct vm_area_struct *vma, unsigned long address,
+		u64 offset, struct ocxl_context *ctx)
+{
+	u64 pp_mmio_addr;
+	int pasid_off;
+
+	if (offset >= ctx->afu->config.pp_mmio_stride)
+		return VM_FAULT_SIGBUS;
+
+	mutex_lock(&ctx->status_mutex);
+	if (ctx->status != ATTACHED) {
+		mutex_unlock(&ctx->status_mutex);
+		pr_debug("%s: Context not attached, failing mmio mmap\n",
+			__func__);
+		return VM_FAULT_SIGBUS;
+	}
+
+	pasid_off = ctx->pasid - ctx->afu->pasid_base;
+	pp_mmio_addr = ctx->afu->pp_mmio_start +
+		pasid_off * ctx->afu->config.pp_mmio_stride +
+		offset;
+
+	vm_insert_pfn(vma, address, pp_mmio_addr >> PAGE_SHIFT);
+	mutex_unlock(&ctx->status_mutex);
+	return VM_FAULT_NOPAGE;
+}
+
+static int ocxl_mmap_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct ocxl_context *ctx = vma->vm_file->private_data;
+	u64 offset;
+	int rc;
+
+	offset = vmf->pgoff << PAGE_SHIFT;
+	pr_debug("%s: pasid %d address 0x%lx offset 0x%llx\n", __func__,
+		ctx->pasid, vmf->address, offset);
+
+	rc = map_pp_mmio(vma, vmf->address, offset, ctx);
+	return rc;
+}
+
+static const struct vm_operations_struct ocxl_vmops = {
+	.fault = ocxl_mmap_fault,
+};
+
+static int check_mmap_mmio(struct ocxl_context *ctx,
+			struct vm_area_struct *vma)
+{
+	if ((vma_pages(vma) + vma->vm_pgoff) >
+		(ctx->afu->config.pp_mmio_stride >> PAGE_SHIFT))
+		return -EINVAL;
+	return 0;
+}
+
+int ocxl_context_mmap(struct ocxl_context *ctx, struct vm_area_struct *vma)
+{
+	int rc;
+
+	rc = check_mmap_mmio(ctx, vma);
+	if (rc)
+		return rc;
+
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_ops = &ocxl_vmops;
+	return 0;
+}
+
+int ocxl_context_detach(struct ocxl_context *ctx)
+{
+	struct pci_dev *dev;
+	int afu_control_pos;
+	enum ocxl_context_status status;
+	int rc;
+
+	mutex_lock(&ctx->status_mutex);
+	status = ctx->status;
+	ctx->status = CLOSED;
+	mutex_unlock(&ctx->status_mutex);
+	if (status != ATTACHED)
+		return 0;
+
+	dev = to_pci_dev(ctx->afu->fn->dev.parent);
+	afu_control_pos = ctx->afu->config.dvsec_afu_control_pos;
+
+	mutex_lock(&ctx->afu->afu_control_lock);
+	rc = ocxl_config_terminate_pasid(dev, afu_control_pos, ctx->pasid);
+	mutex_unlock(&ctx->afu->afu_control_lock);
+	if (rc) {
+		/*
+		 * If we timeout waiting for the AFU to terminate the
+		 * pasid, then it's dangerous to clean up the Process
+		 * Element entry in the SPA, as it may be referenced
+		 * in the future by the AFU. In which case, we would
+		 * checkstop because of an invalid PE access (FIR
+		 * register 2, bit 42). So leave the PE
+		 * defined. Caller shouldn't free the context so that
+		 * PASID remains allocated.
+		 *
+		 * A link reset will be required to cleanup the AFU
+		 * and the SPA.
+		 */
+		if (rc == -EBUSY)
+			return rc;
+	}
+	rc = ocxl_link_remove_pe(ctx->afu->fn->link, ctx->pasid);
+	if (rc) {
+		dev_warn(&ctx->afu->dev,
+			"Couldn't remove PE entry cleanly: %d\n", rc);
+	}
+	return 0;
+}
+
+void ocxl_context_detach_all(struct ocxl_afu *afu)
+{
+	struct ocxl_context *ctx;
+	int tmp;
+
+	mutex_lock(&afu->contexts_lock);
+	idr_for_each_entry(&afu->contexts_idr, ctx, tmp) {
+		ocxl_context_detach(ctx);
+		/*
+		 * We are force detaching - remove any active mmio
+		 * mappings so userspace cannot interfere with the
+		 * card if it comes back.  Easiest way to exercise
+		 * this is to unbind and rebind the driver via sysfs
+		 * while it is in use.
+		 */
+		mutex_lock(&ctx->mapping_lock);
+		if (ctx->mapping)
+			unmap_mapping_range(ctx->mapping, 0, 0, 1);
+		mutex_unlock(&ctx->mapping_lock);
+	}
+	mutex_unlock(&afu->contexts_lock);
+}
+
+void ocxl_context_free(struct ocxl_context *ctx)
+{
+	mutex_lock(&ctx->afu->contexts_lock);
+	ctx->afu->pasid_count--;
+	idr_remove(&ctx->afu->contexts_idr, ctx->pasid);
+	mutex_unlock(&ctx->afu->contexts_lock);
+
+	/* reference to the AFU taken in ocxl_context_init */
+	ocxl_afu_put(ctx->afu);
+	kfree(ctx);
+}
diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
new file mode 100644
index 000000000000..a51386eff4f5
--- /dev/null
+++ b/drivers/misc/ocxl/file.c
@@ -0,0 +1,405 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/fs.h>
+#include <linux/poll.h>
+#include <linux/sched/signal.h>
+#include <linux/uaccess.h>
+#include <uapi/misc/ocxl.h>
+#include "ocxl_internal.h"
+
+
+#define OCXL_NUM_MINORS 256 /* Total to reserve */
+
+static dev_t ocxl_dev;
+static struct class *ocxl_class;
+static struct mutex minors_idr_lock;
+static struct idr minors_idr;
+
+static struct ocxl_afu *find_and_get_afu(dev_t devno)
+{
+	struct ocxl_afu *afu;
+	int afu_minor;
+
+	afu_minor = MINOR(devno);
+	/*
+	 * We don't declare an RCU critical section here, as our AFU
+	 * is protected by a reference counter on the device. By the time the
+	 * minor number of a device is removed from the idr, the ref count of
+	 * the device is already at 0, so no user API will access that AFU and
+	 * this function can't return it.
+	 */
+	afu = idr_find(&minors_idr, afu_minor);
+	if (afu)
+		ocxl_afu_get(afu);
+	return afu;
+}
+
+static int allocate_afu_minor(struct ocxl_afu *afu)
+{
+	int minor;
+
+	mutex_lock(&minors_idr_lock);
+	minor = idr_alloc(&minors_idr, afu, 0, OCXL_NUM_MINORS, GFP_KERNEL);
+	mutex_unlock(&minors_idr_lock);
+	return minor;
+}
+
+static void free_afu_minor(struct ocxl_afu *afu)
+{
+	mutex_lock(&minors_idr_lock);
+	idr_remove(&minors_idr, MINOR(afu->dev.devt));
+	mutex_unlock(&minors_idr_lock);
+}
+
+static int afu_open(struct inode *inode, struct file *file)
+{
+	struct ocxl_afu *afu;
+	struct ocxl_context *ctx;
+	int rc;
+
+	pr_debug("%s for device %x\n", __func__, inode->i_rdev);
+
+	afu = find_and_get_afu(inode->i_rdev);
+	if (!afu)
+		return -ENODEV;
+
+	ctx = ocxl_context_alloc();
+	if (!ctx) {
+		rc = -ENOMEM;
+		goto put_afu;
+	}
+
+	rc = ocxl_context_init(ctx, afu, inode->i_mapping);
+	if (rc)
+		goto put_afu;
+	file->private_data = ctx;
+	ocxl_afu_put(afu);
+	return 0;
+
+put_afu:
+	ocxl_afu_put(afu);
+	return rc;
+}
+
+static long afu_ioctl_attach(struct ocxl_context *ctx,
+			struct ocxl_ioctl_attach __user *uarg)
+{
+	struct ocxl_ioctl_attach arg;
+	u64 amr = 0;
+	int rc;
+
+	pr_debug("%s for context %d\n", __func__, ctx->pasid);
+
+	if (copy_from_user(&arg, uarg, sizeof(arg)))
+		return -EFAULT;
+
+	/* Make sure reserved fields are not set for forward compatibility */
+	if (arg.reserved1 || arg.reserved2 || arg.reserved3)
+		return -EINVAL;
+
+	amr = arg.amr & mfspr(SPRN_UAMOR);
+	rc = ocxl_context_attach(ctx, amr);
+	return rc;
+}
+
+#define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH" :			\
+			"UNKNOWN")
+
+static long afu_ioctl(struct file *file, unsigned int cmd,
+		unsigned long args)
+{
+	struct ocxl_context *ctx = file->private_data;
+	long rc;
+
+	pr_debug("%s for context %d, command %s\n", __func__, ctx->pasid,
+		CMD_STR(cmd));
+
+	if (ctx->status == CLOSED)
+		return -EIO;
+
+	switch (cmd) {
+	case OCXL_IOCTL_ATTACH:
+		rc = afu_ioctl_attach(ctx,
+				(struct ocxl_ioctl_attach __user *) args);
+		break;
+
+	default:
+		rc = -EINVAL;
+	}
+	return rc;
+}
+
+static long afu_compat_ioctl(struct file *file, unsigned int cmd,
+			unsigned long args)
+{
+	return afu_ioctl(file, cmd, args);
+}
+
+static int afu_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct ocxl_context *ctx = file->private_data;
+
+	pr_debug("%s for context %d\n", __func__, ctx->pasid);
+	return ocxl_context_mmap(ctx, vma);
+}
+
+static bool has_xsl_error(struct ocxl_context *ctx)
+{
+	bool ret;
+
+	mutex_lock(&ctx->xsl_error_lock);
+	ret = !!ctx->xsl_error.addr;
+	mutex_unlock(&ctx->xsl_error_lock);
+
+	return ret;
+}
+
+/*
+ * Are there any events pending on the AFU
+ * ctx: The AFU context
+ * Returns: true if there are events pending
+ */
+static bool afu_events_pending(struct ocxl_context *ctx)
+{
+	if (has_xsl_error(ctx))
+		return true;
+	return false;
+}
+
+static unsigned int afu_poll(struct file *file, struct poll_table_struct *wait)
+{
+	struct ocxl_context *ctx = file->private_data;
+	unsigned int mask = 0;
+	bool closed;
+
+	pr_debug("%s for context %d\n", __func__, ctx->pasid);
+
+	poll_wait(file, &ctx->events_wq, wait);
+
+	mutex_lock(&ctx->status_mutex);
+	closed = (ctx->status == CLOSED);
+	mutex_unlock(&ctx->status_mutex);
+
+	if (afu_events_pending(ctx))
+		mask = POLLIN | POLLRDNORM;
+	else if (closed)
+		mask = POLLERR;
+
+	return mask;
+}
+
+/*
+ * Populate the supplied buffer with a single XSL error
+ * ctx:	The AFU context to report the error from
+ * header: the event header to populate
+ * buf: The buffer to write the body into (should be at least
+ *      AFU_EVENT_BODY_XSL_ERROR_SIZE)
+ * Return: the amount of buffer that was populated
+ */
+static ssize_t append_xsl_error(struct ocxl_context *ctx,
+				struct ocxl_kernel_event_header *header,
+				char __user *buf)
+{
+	struct ocxl_kernel_event_xsl_fault_error body;
+
+	memset(&body, 0, sizeof(body));
+
+	mutex_lock(&ctx->xsl_error_lock);
+	if (!ctx->xsl_error.addr) {
+		mutex_unlock(&ctx->xsl_error_lock);
+		return 0;
+	}
+
+	body.addr = ctx->xsl_error.addr;
+	body.dsisr = ctx->xsl_error.dsisr;
+	body.count = ctx->xsl_error.count;
+
+	ctx->xsl_error.addr = 0;
+	ctx->xsl_error.dsisr = 0;
+	ctx->xsl_error.count = 0;
+
+	mutex_unlock(&ctx->xsl_error_lock);
+
+	header->type = OCXL_AFU_EVENT_XSL_FAULT_ERROR;
+
+	if (copy_to_user(buf, &body, sizeof(body)))
+		return -EFAULT;
+
+	return sizeof(body);
+}
+
+#define AFU_EVENT_BODY_MAX_SIZE sizeof(struct ocxl_kernel_event_xsl_fault_error)
+
+/*
+ * Reports events on the AFU
+ * Format:
+ *	Header (struct ocxl_kernel_event_header)
+ *	Body (struct ocxl_kernel_event_*)
+ *	Header...
+ */
+static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
+			loff_t *off)
+{
+	struct ocxl_context *ctx = file->private_data;
+	struct ocxl_kernel_event_header header;
+	ssize_t rc;
+	size_t used = 0;
+	DEFINE_WAIT(event_wait);
+
+	memset(&header, 0, sizeof(header));
+
+	/* Require offset to be 0 */
+	if (*off != 0)
+		return -EINVAL;
+
+	if (count < (sizeof(struct ocxl_kernel_event_header) +
+			AFU_EVENT_BODY_MAX_SIZE))
+		return -EINVAL;
+
+	for (;;) {
+		prepare_to_wait(&ctx->events_wq, &event_wait,
+				TASK_INTERRUPTIBLE);
+
+		if (afu_events_pending(ctx))
+			break;
+
+		if (ctx->status == CLOSED)
+			break;
+
+		if (file->f_flags & O_NONBLOCK) {
+			finish_wait(&ctx->events_wq, &event_wait);
+			return -EAGAIN;
+		}
+
+		if (signal_pending(current)) {
+			finish_wait(&ctx->events_wq, &event_wait);
+			return -ERESTARTSYS;
+		}
+
+		schedule();
+	}
+
+	finish_wait(&ctx->events_wq, &event_wait);
+
+	if (has_xsl_error(ctx)) {
+		used = append_xsl_error(ctx, &header, buf + sizeof(header));
+		if (used < 0)
+			return used;
+	}
+
+	if (!afu_events_pending(ctx))
+		header.flags |= OCXL_KERNEL_EVENT_FLAG_LAST;
+
+	if (copy_to_user(buf, &header, sizeof(header)))
+		return -EFAULT;
+
+	used += sizeof(header);
+
+	rc = (ssize_t) used;
+	return rc;
+}
+
+static int afu_release(struct inode *inode, struct file *file)
+{
+	struct ocxl_context *ctx = file->private_data;
+	int rc;
+
+	pr_debug("%s for device %x\n", __func__, inode->i_rdev);
+	rc = ocxl_context_detach(ctx);
+	mutex_lock(&ctx->mapping_lock);
+	ctx->mapping = NULL;
+	mutex_unlock(&ctx->mapping_lock);
+	wake_up_all(&ctx->events_wq);
+	if (rc != -EBUSY)
+		ocxl_context_free(ctx);
+	return 0;
+}
+
+static const struct file_operations ocxl_afu_fops = {
+	.owner		= THIS_MODULE,
+	.open           = afu_open,
+	.unlocked_ioctl = afu_ioctl,
+	.compat_ioctl   = afu_compat_ioctl,
+	.mmap           = afu_mmap,
+	.poll           = afu_poll,
+	.read           = afu_read,
+	.release        = afu_release,
+};
+
+int ocxl_create_cdev(struct ocxl_afu *afu)
+{
+	int rc;
+
+	cdev_init(&afu->cdev, &ocxl_afu_fops);
+	rc = cdev_add(&afu->cdev, afu->dev.devt, 1);
+	if (rc) {
+		dev_err(&afu->dev, "Unable to add afu char device: %d\n", rc);
+		return rc;
+	}
+	return 0;
+}
+
+void ocxl_destroy_cdev(struct ocxl_afu *afu)
+{
+	cdev_del(&afu->cdev);
+}
+
+int ocxl_register_afu(struct ocxl_afu *afu)
+{
+	int minor;
+
+	minor = allocate_afu_minor(afu);
+	if (minor < 0)
+		return minor;
+	afu->dev.devt = MKDEV(MAJOR(ocxl_dev), minor);
+	afu->dev.class = ocxl_class;
+	return device_register(&afu->dev);
+}
+
+void ocxl_unregister_afu(struct ocxl_afu *afu)
+{
+	free_afu_minor(afu);
+}
+
+static char *ocxl_devnode(struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "ocxl/%s", dev_name(dev));
+}
+
+int ocxl_file_init(void)
+{
+	int rc;
+
+	mutex_init(&minors_idr_lock);
+	idr_init(&minors_idr);
+
+	rc = alloc_chrdev_region(&ocxl_dev, 0, OCXL_NUM_MINORS, "ocxl");
+	if (rc) {
+		pr_err("Unable to allocate ocxl major number: %d\n", rc);
+		return rc;
+	}
+
+	ocxl_class = class_create(THIS_MODULE, "ocxl");
+	if (IS_ERR(ocxl_class)) {
+		pr_err("Unable to create ocxl class\n");
+		unregister_chrdev_region(ocxl_dev, OCXL_NUM_MINORS);
+		return PTR_ERR(ocxl_class);
+	}
+
+	ocxl_class->devnode = ocxl_devnode;
+	return 0;
+}
+
+void ocxl_file_exit(void)
+{
+	class_destroy(ocxl_class);
+	unregister_chrdev_region(ocxl_dev, OCXL_NUM_MINORS);
+	idr_destroy(&minors_idr);
+}
diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
new file mode 100644
index 000000000000..6b184cd7d2a6
--- /dev/null
+++ b/drivers/misc/ocxl/link.c
@@ -0,0 +1,610 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sched/mm.h>
+#include <linux/mutex.h>
+#include <linux/mmu_context.h>
+#include <asm/copro.h>
+#include <asm/pnv-ocxl.h>
+#include "ocxl_internal.h"
+
+
+#define SPA_PASID_BITS		15
+#define SPA_PASID_MAX		((1 << SPA_PASID_BITS) - 1)
+#define SPA_PE_MASK		SPA_PASID_MAX
+#define SPA_SPA_SIZE_LOG	22 /* Each SPA is 4 Mb */
+
+#define SPA_CFG_SF		(1ull << (63-0))
+#define SPA_CFG_TA		(1ull << (63-1))
+#define SPA_CFG_HV		(1ull << (63-3))
+#define SPA_CFG_UV		(1ull << (63-4))
+#define SPA_CFG_XLAT_hpt	(0ull << (63-6)) /* Hashed page table (HPT) mode */
+#define SPA_CFG_XLAT_roh	(2ull << (63-6)) /* Radix on HPT mode */
+#define SPA_CFG_XLAT_ror	(3ull << (63-6)) /* Radix on Radix mode */
+#define SPA_CFG_PR		(1ull << (63-49))
+#define SPA_CFG_TC		(1ull << (63-54))
+#define SPA_CFG_DR		(1ull << (63-59))
+
+#define SPA_XSL_TF		(1ull << (63-3))  /* Translation fault */
+#define SPA_XSL_S		(1ull << (63-38)) /* Store operation */
+
+#define SPA_PE_VALID		0x80000000
+
+
+struct pe_data {
+	struct mm_struct *mm;
+	/* callback to trigger when a translation fault occurs */
+	void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr);
+	/* opaque pointer to be passed to the above callback */
+	void *xsl_err_data;
+	struct rcu_head rcu;
+};
+
+struct spa {
+	struct ocxl_process_element *spa_mem;
+	int spa_order;
+	struct mutex spa_lock;
+	struct radix_tree_root pe_tree; /* Maps PE handles to pe_data */
+	char *irq_name;
+	int virq;
+	void __iomem *reg_dsisr;
+	void __iomem *reg_dar;
+	void __iomem *reg_tfc;
+	void __iomem *reg_pe_handle;
+	/*
+	 * The following field are used by the memory fault
+	 * interrupt handler. We can only have one interrupt at a
+	 * time. The NPU won't raise another interrupt until the
+	 * previous one has been ack'd by writing to the TFC register
+	 */
+	struct xsl_fault {
+		struct work_struct fault_work;
+		u64 pe;
+		u64 dsisr;
+		u64 dar;
+		struct pe_data pe_data;
+	} xsl_fault;
+};
+
+/*
+ * A opencapi link can be used be by several PCI functions. We have
+ * one link per device slot.
+ *
+ * A linked list of opencapi links should suffice, as there's a
+ * limited number of opencapi slots on a system and lookup is only
+ * done when the device is probed
+ */
+struct link {
+	struct list_head list;
+	struct kref ref;
+	int domain;
+	int bus;
+	int dev;
+	atomic_t irq_available;
+	struct spa *spa;
+	void *platform_data;
+};
+static struct list_head links_list = LIST_HEAD_INIT(links_list);
+static DEFINE_MUTEX(links_list_lock);
+
+enum xsl_response {
+	CONTINUE,
+	ADDRESS_ERROR,
+	RESTART,
+};
+
+
+static void read_irq(struct spa *spa, u64 *dsisr, u64 *dar, u64 *pe)
+{
+	u64 reg;
+
+	*dsisr = in_be64(spa->reg_dsisr);
+	*dar = in_be64(spa->reg_dar);
+	reg = in_be64(spa->reg_pe_handle);
+	*pe = reg & SPA_PE_MASK;
+}
+
+static void ack_irq(struct spa *spa, enum xsl_response r)
+{
+	u64 reg = 0;
+
+	/* continue is not supported */
+	if (r == RESTART)
+		reg = PPC_BIT(31);
+	else if (r == ADDRESS_ERROR)
+		reg = PPC_BIT(30);
+	else
+		WARN(1, "Invalid irq response %d\n", r);
+
+	if (reg)
+		out_be64(spa->reg_tfc, reg);
+}
+
+static void xsl_fault_handler_bh(struct work_struct *fault_work)
+{
+	unsigned int flt = 0;
+	unsigned long access, flags, inv_flags = 0;
+	enum xsl_response r;
+	struct xsl_fault *fault = container_of(fault_work, struct xsl_fault,
+					fault_work);
+	struct spa *spa = container_of(fault, struct spa, xsl_fault);
+
+	int rc;
+
+	/*
+	 * We need to release a reference on the mm whenever exiting this
+	 * function (taken in the memory fault interrupt handler)
+	 */
+	rc = copro_handle_mm_fault(fault->pe_data.mm, fault->dar, fault->dsisr,
+				&flt);
+	if (rc) {
+		pr_debug("copro_handle_mm_fault failed: %d\n", rc);
+		if (fault->pe_data.xsl_err_cb) {
+			fault->pe_data.xsl_err_cb(
+				fault->pe_data.xsl_err_data,
+				fault->dar, fault->dsisr);
+		}
+		r = ADDRESS_ERROR;
+		goto ack;
+	}
+
+	if (!radix_enabled()) {
+		/*
+		 * update_mmu_cache() will not have loaded the hash
+		 * since current->trap is not a 0x400 or 0x300, so
+		 * just call hash_page_mm() here.
+		 */
+		access = _PAGE_PRESENT | _PAGE_READ;
+		if (fault->dsisr & SPA_XSL_S)
+			access |= _PAGE_WRITE;
+
+		if (REGION_ID(fault->dar) != USER_REGION_ID)
+			access |= _PAGE_PRIVILEGED;
+
+		local_irq_save(flags);
+		hash_page_mm(fault->pe_data.mm, fault->dar, access, 0x300,
+			inv_flags);
+		local_irq_restore(flags);
+	}
+	r = RESTART;
+ack:
+	mmdrop(fault->pe_data.mm);
+	ack_irq(spa, r);
+}
+
+static irqreturn_t xsl_fault_handler(int irq, void *data)
+{
+	struct link *link = (struct link *) data;
+	struct spa *spa = link->spa;
+	u64 dsisr, dar, pe_handle;
+	struct pe_data *pe_data;
+	struct ocxl_process_element *pe;
+	int lpid, pid, tid;
+
+	read_irq(spa, &dsisr, &dar, &pe_handle);
+
+	WARN_ON(pe_handle > SPA_PE_MASK);
+	pe = spa->spa_mem + pe_handle;
+	lpid = be32_to_cpu(pe->lpid);
+	pid = be32_to_cpu(pe->pid);
+	tid = be32_to_cpu(pe->tid);
+	/* We could be reading all null values here if the PE is being
+	 * removed while an interrupt kicks in. It's not supposed to
+	 * happen if the driver notified the AFU to terminate the
+	 * PASID, and the AFU waited for pending operations before
+	 * acknowledging. But even if it happens, we won't find a
+	 * memory context below and fail silently, so it should be ok.
+	 */
+	if (!(dsisr & SPA_XSL_TF)) {
+		WARN(1, "Invalid xsl interrupt fault register %#llx\n", dsisr);
+		ack_irq(spa, ADDRESS_ERROR);
+		return IRQ_HANDLED;
+	}
+
+	rcu_read_lock();
+	pe_data = radix_tree_lookup(&spa->pe_tree, pe_handle);
+	if (!pe_data) {
+		/*
+		 * Could only happen if the driver didn't notify the
+		 * AFU about PASID termination before removing the PE,
+		 * or the AFU didn't wait for all memory access to
+		 * have completed.
+		 *
+		 * Either way, we fail early, but we shouldn't log an
+		 * error message, as it is a valid (if unexpected)
+		 * scenario
+		 */
+		rcu_read_unlock();
+		pr_debug("Unknown mm context for xsl interrupt\n");
+		ack_irq(spa, ADDRESS_ERROR);
+		return IRQ_HANDLED;
+	}
+	WARN_ON(pe_data->mm->context.id != pid);
+
+	spa->xsl_fault.pe = pe_handle;
+	spa->xsl_fault.dar = dar;
+	spa->xsl_fault.dsisr = dsisr;
+	spa->xsl_fault.pe_data = *pe_data;
+	mmgrab(pe_data->mm); /* mm count is released by bottom half */
+
+	rcu_read_unlock();
+	schedule_work(&spa->xsl_fault.fault_work);
+	return IRQ_HANDLED;
+}
+
+static void unmap_irq_registers(struct spa *spa)
+{
+	pnv_ocxl_unmap_xsl_regs(spa->reg_dsisr, spa->reg_dar, spa->reg_tfc,
+				spa->reg_pe_handle);
+}
+
+static int map_irq_registers(struct pci_dev *dev, struct spa *spa)
+{
+	return pnv_ocxl_map_xsl_regs(dev, &spa->reg_dsisr, &spa->reg_dar,
+				&spa->reg_tfc, &spa->reg_pe_handle);
+}
+
+static int setup_xsl_irq(struct pci_dev *dev, struct link *link)
+{
+	struct spa *spa = link->spa;
+	int rc;
+	int hwirq;
+
+	rc = pnv_ocxl_get_xsl_irq(dev, &hwirq);
+	if (rc)
+		return rc;
+
+	rc = map_irq_registers(dev, spa);
+	if (rc)
+		return rc;
+
+	spa->irq_name = kasprintf(GFP_KERNEL, "ocxl-xsl-%x-%x-%x",
+				link->domain, link->bus, link->dev);
+	if (!spa->irq_name) {
+		unmap_irq_registers(spa);
+		dev_err(&dev->dev, "Can't allocate name for xsl interrupt\n");
+		return -ENOMEM;
+	}
+	/*
+	 * At some point, we'll need to look into allowing a higher
+	 * number of interrupts. Could we have an IRQ domain per link?
+	 */
+	spa->virq = irq_create_mapping(NULL, hwirq);
+	if (!spa->virq) {
+		kfree(spa->irq_name);
+		unmap_irq_registers(spa);
+		dev_err(&dev->dev,
+			"irq_create_mapping failed for translation interrupt\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(&dev->dev, "hwirq %d mapped to virq %d\n", hwirq, spa->virq);
+
+	rc = request_irq(spa->virq, xsl_fault_handler, 0, spa->irq_name,
+			link);
+	if (rc) {
+		irq_dispose_mapping(spa->virq);
+		kfree(spa->irq_name);
+		unmap_irq_registers(spa);
+		dev_err(&dev->dev,
+			"request_irq failed for translation interrupt: %d\n",
+			rc);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static void release_xsl_irq(struct link *link)
+{
+	struct spa *spa = link->spa;
+
+	if (spa->virq) {
+		free_irq(spa->virq, link);
+		irq_dispose_mapping(spa->virq);
+	}
+	kfree(spa->irq_name);
+	unmap_irq_registers(spa);
+}
+
+static int alloc_spa(struct pci_dev *dev, struct link *link)
+{
+	struct spa *spa;
+
+	spa = kzalloc(sizeof(struct spa), GFP_KERNEL);
+	if (!spa)
+		return -ENOMEM;
+
+	mutex_init(&spa->spa_lock);
+	INIT_RADIX_TREE(&spa->pe_tree, GFP_KERNEL);
+	INIT_WORK(&spa->xsl_fault.fault_work, xsl_fault_handler_bh);
+
+	spa->spa_order = SPA_SPA_SIZE_LOG - PAGE_SHIFT;
+	spa->spa_mem = (struct ocxl_process_element *)
+		__get_free_pages(GFP_KERNEL | __GFP_ZERO, spa->spa_order);
+	if (!spa->spa_mem) {
+		dev_err(&dev->dev, "Can't allocate Shared Process Area\n");
+		kfree(spa);
+		return -ENOMEM;
+	}
+	pr_debug("Allocated SPA for %x:%x:%x at %p\n", link->domain, link->bus,
+		link->dev, spa->spa_mem);
+
+	link->spa = spa;
+	return 0;
+}
+
+static void free_spa(struct link *link)
+{
+	struct spa *spa = link->spa;
+
+	pr_debug("Freeing SPA for %x:%x:%x\n", link->domain, link->bus,
+		link->dev);
+
+	if (spa && spa->spa_mem) {
+		free_pages((unsigned long) spa->spa_mem, spa->spa_order);
+		kfree(spa);
+		link->spa = NULL;
+	}
+}
+
+static int alloc_link(struct pci_dev *dev, int PE_mask, struct link **out_link)
+{
+	struct link *link;
+	int rc;
+
+	link = kzalloc(sizeof(struct link), GFP_KERNEL);
+	if (!link)
+		return -ENOMEM;
+
+	kref_init(&link->ref);
+	link->domain = pci_domain_nr(dev->bus);
+	link->bus = dev->bus->number;
+	link->dev = PCI_SLOT(dev->devfn);
+	atomic_set(&link->irq_available, MAX_IRQ_PER_LINK);
+
+	rc = alloc_spa(dev, link);
+	if (rc)
+		goto err_free;
+
+	rc = setup_xsl_irq(dev, link);
+	if (rc)
+		goto err_spa;
+
+	/* platform specific hook */
+	rc = pnv_ocxl_spa_setup(dev, link->spa->spa_mem, PE_mask,
+				&link->platform_data);
+	if (rc)
+		goto err_xsl_irq;
+
+	*out_link = link;
+	return 0;
+
+err_xsl_irq:
+	release_xsl_irq(link);
+err_spa:
+	free_spa(link);
+err_free:
+	kfree(link);
+	return rc;
+}
+
+static void free_link(struct link *link)
+{
+	release_xsl_irq(link);
+	free_spa(link);
+	kfree(link);
+}
+
+int ocxl_link_setup(struct pci_dev *dev, int PE_mask, void **link_handle)
+{
+	int rc = 0;
+	struct link *link;
+
+	mutex_lock(&links_list_lock);
+	list_for_each_entry(link, &links_list, list) {
+		/* The functions of a device all share the same link */
+		if (link->domain == pci_domain_nr(dev->bus) &&
+			link->bus == dev->bus->number &&
+			link->dev == PCI_SLOT(dev->devfn)) {
+			kref_get(&link->ref);
+			*link_handle = link;
+			goto unlock;
+		}
+	}
+	rc = alloc_link(dev, PE_mask, &link);
+	if (rc)
+		goto unlock;
+
+	list_add(&link->list, &links_list);
+	*link_handle = link;
+unlock:
+	mutex_unlock(&links_list_lock);
+	return rc;
+}
+
+static void release_xsl(struct kref *ref)
+{
+	struct link *link = container_of(ref, struct link, ref);
+
+	list_del(&link->list);
+	/* call platform code before releasing data */
+	pnv_ocxl_spa_release(link->platform_data);
+	free_link(link);
+}
+
+void ocxl_link_release(struct pci_dev *dev, void *link_handle)
+{
+	struct link *link = (struct link *) link_handle;
+
+	mutex_lock(&links_list_lock);
+	kref_put(&link->ref, release_xsl);
+	mutex_unlock(&links_list_lock);
+}
+
+static u64 calculate_cfg_state(bool kernel)
+{
+	u64 state;
+
+	state = SPA_CFG_DR;
+	if (mfspr(SPRN_LPCR) & LPCR_TC)
+		state |= SPA_CFG_TC;
+	if (radix_enabled())
+		state |= SPA_CFG_XLAT_ror;
+	else
+		state |= SPA_CFG_XLAT_hpt;
+	state |= SPA_CFG_HV;
+	if (kernel) {
+		if (mfmsr() & MSR_SF)
+			state |= SPA_CFG_SF;
+	} else {
+		state |= SPA_CFG_PR;
+		if (!test_tsk_thread_flag(current, TIF_32BIT))
+			state |= SPA_CFG_SF;
+	}
+	return state;
+}
+
+int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
+		u64 amr, struct mm_struct *mm,
+		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
+		void *xsl_err_data)
+{
+	struct link *link = (struct link *) link_handle;
+	struct spa *spa = link->spa;
+	struct ocxl_process_element *pe;
+	int pe_handle, rc = 0;
+	struct pe_data *pe_data;
+
+	BUILD_BUG_ON(sizeof(struct ocxl_process_element) != 128);
+	if (pasid > SPA_PASID_MAX)
+		return -EINVAL;
+
+	mutex_lock(&spa->spa_lock);
+	pe_handle = pasid & SPA_PE_MASK;
+	pe = spa->spa_mem + pe_handle;
+
+	if (pe->software_state) {
+		rc = -EBUSY;
+		goto unlock;
+	}
+
+	pe_data = kmalloc(sizeof(*pe_data), GFP_KERNEL);
+	if (!pe_data) {
+		rc = -ENOMEM;
+		goto unlock;
+	}
+
+	pe_data->mm = mm;
+	pe_data->xsl_err_cb = xsl_err_cb;
+	pe_data->xsl_err_data = xsl_err_data;
+
+	memset(pe, 0, sizeof(struct ocxl_process_element));
+	pe->config_state = cpu_to_be64(calculate_cfg_state(pidr == 0));
+	pe->lpid = cpu_to_be32(mfspr(SPRN_LPID));
+	pe->pid = cpu_to_be32(pidr);
+	pe->tid = cpu_to_be32(tidr);
+	pe->amr = cpu_to_be64(amr);
+	pe->software_state = cpu_to_be32(SPA_PE_VALID);
+
+	mm_context_add_copro(mm);
+	/*
+	 * Barrier is to make sure PE is visible in the SPA before it
+	 * is used by the device. It also helps with the global TLBI
+	 * invalidation
+	 */
+	mb();
+	radix_tree_insert(&spa->pe_tree, pe_handle, pe_data);
+
+	/*
+	 * The mm must stay valid for as long as the device uses it. We
+	 * lower the count when the context is removed from the SPA.
+	 *
+	 * We grab mm_count (and not mm_users), as we don't want to
+	 * end up in a circular dependency if a process mmaps its
+	 * mmio, therefore incrementing the file ref count when
+	 * calling mmap(), and forgets to unmap before exiting. In
+	 * that scenario, when the kernel handles the death of the
+	 * process, the file is not cleaned because unmap was not
+	 * called, and the mm wouldn't be freed because we would still
+	 * have a reference on mm_users. Incrementing mm_count solves
+	 * the problem.
+	 */
+	mmgrab(mm);
+unlock:
+	mutex_unlock(&spa->spa_lock);
+	return rc;
+}
+
+int ocxl_link_remove_pe(void *link_handle, int pasid)
+{
+	struct link *link = (struct link *) link_handle;
+	struct spa *spa = link->spa;
+	struct ocxl_process_element *pe;
+	struct pe_data *pe_data;
+	int pe_handle, rc;
+
+	if (pasid > SPA_PASID_MAX)
+		return -EINVAL;
+
+	/*
+	 * About synchronization with our memory fault handler:
+	 *
+	 * Before removing the PE, the driver is supposed to have
+	 * notified the AFU, which should have cleaned up and make
+	 * sure the PASID is no longer in use, including pending
+	 * interrupts. However, there's no way to be sure...
+	 *
+	 * We clear the PE and remove the context from our radix
+	 * tree. From that point on, any new interrupt for that
+	 * context will fail silently, which is ok. As mentioned
+	 * above, that's not expected, but it could happen if the
+	 * driver or AFU didn't do the right thing.
+	 *
+	 * There could still be a bottom half running, but we don't
+	 * need to wait/flush, as it is managing a reference count on
+	 * the mm it reads from the radix tree.
+	 */
+	pe_handle = pasid & SPA_PE_MASK;
+	pe = spa->spa_mem + pe_handle;
+
+	mutex_lock(&spa->spa_lock);
+
+	if (!(pe->software_state & cpu_to_be32(SPA_PE_VALID))) {
+		rc = -EINVAL;
+		goto unlock;
+	}
+
+	memset(pe, 0, sizeof(struct ocxl_process_element));
+	/*
+	 * The barrier makes sure the PE is removed from the SPA
+	 * before we clear the NPU context cache below, so that the
+	 * old PE cannot be reloaded erroneously.
+	 */
+	mb();
+
+	/*
+	 * hook to platform code
+	 * On powerpc, the entry needs to be cleared from the context
+	 * cache of the NPU.
+	 */
+	rc = pnv_ocxl_spa_remove_pe(link->platform_data, pe_handle);
+	WARN_ON(rc);
+
+	pe_data = radix_tree_delete(&spa->pe_tree, pe_handle);
+	if (!pe_data) {
+		WARN(1, "Couldn't find pe data when removing PE\n");
+	} else {
+		mm_context_remove_copro(pe_data->mm);
+		mmdrop(pe_data->mm);
+		kfree_rcu(pe_data, rcu);
+	}
+unlock:
+	mutex_unlock(&spa->spa_lock);
+	return rc;
+}
diff --git a/drivers/misc/ocxl/main.c b/drivers/misc/ocxl/main.c
new file mode 100644
index 000000000000..be34b8fae97a
--- /dev/null
+++ b/drivers/misc/ocxl/main.c
@@ -0,0 +1,40 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "ocxl_internal.h"
+
+static int __init init_ocxl(void)
+{
+	int rc = 0;
+
+	rc = ocxl_file_init();
+	if (rc)
+		return rc;
+
+	rc = pci_register_driver(&ocxl_pci_driver);
+	if (rc) {
+		ocxl_file_exit();
+		return rc;
+	}
+	return 0;
+}
+
+static void exit_ocxl(void)
+{
+	pci_unregister_driver(&ocxl_pci_driver);
+	ocxl_file_exit();
+}
+
+module_init(init_ocxl);
+module_exit(exit_ocxl);
+
+MODULE_DESCRIPTION("Open Coherent Accelerator");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/ocxl/ocxl_internal.h b/drivers/misc/ocxl/ocxl_internal.h
new file mode 100644
index 000000000000..e07f7d523275
--- /dev/null
+++ b/drivers/misc/ocxl/ocxl_internal.h
@@ -0,0 +1,200 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _OCXL_INTERNAL_H_
+#define _OCXL_INTERNAL_H_
+
+#include <linux/pci.h>
+#include <linux/cdev.h>
+#include <linux/list.h>
+
+#define OCXL_AFU_NAME_SZ      (24+1)  /* add 1 for NULL termination */
+#define MAX_IRQ_PER_LINK	2000
+#define MAX_IRQ_PER_CONTEXT	MAX_IRQ_PER_LINK
+
+#define to_ocxl_function(d) container_of(d, struct ocxl_fn, dev)
+#define to_ocxl_afu(d) container_of(d, struct ocxl_afu, dev)
+
+extern struct pci_driver ocxl_pci_driver;
+
+/*
+ * The following 2 structures are a fairly generic way of representing
+ * the configuration data for a function and AFU, as read from the
+ * configuration space.
+ */
+struct ocxl_afu_config {
+	u8 idx;
+	int dvsec_afu_control_pos;
+	char name[OCXL_AFU_NAME_SZ];
+	u8 version_major;
+	u8 version_minor;
+	u8 afuc_type;
+	u8 afum_type;
+	u8 profile;
+	u8 global_mmio_bar;
+	u64 global_mmio_offset;
+	u32 global_mmio_size;
+	u8 pp_mmio_bar;
+	u64 pp_mmio_offset;
+	u32 pp_mmio_stride;
+	u8 log_mem_size;
+	u8 pasid_supported_log;
+	u16 actag_supported;
+};
+
+struct ocxl_fn_config {
+	int dvsec_tl_pos;
+	int dvsec_function_pos;
+	int dvsec_afu_info_pos;
+	s8 max_pasid_log;
+	s8 max_afu_index;
+};
+
+struct ocxl_fn {
+	struct device dev;
+	int bar_used[3];
+	struct ocxl_fn_config config;
+	struct list_head afu_list;
+	int pasid_base;
+	int actag_base;
+	int actag_enabled;
+	int actag_supported;
+	struct list_head pasid_list;
+	struct list_head actag_list;
+	void *link;
+};
+
+struct ocxl_afu {
+	struct ocxl_fn *fn;
+	struct list_head list;
+	struct device dev;
+	struct cdev cdev;
+	struct ocxl_afu_config config;
+	int pasid_base;
+	int pasid_count; /* opened contexts */
+	int pasid_max; /* maximum number of contexts */
+	int actag_base;
+	int actag_enabled;
+	struct mutex contexts_lock;
+	struct idr contexts_idr;
+	struct mutex afu_control_lock;
+	u64 global_mmio_start;
+	u64 irq_base_offset;
+	void __iomem *global_mmio_ptr;
+	u64 pp_mmio_start;
+	struct bin_attribute attr_global_mmio;
+};
+
+enum ocxl_context_status {
+	CLOSED,
+	OPENED,
+	ATTACHED,
+};
+
+// Contains metadata about a translation fault
+struct ocxl_xsl_error {
+	u64 addr; // The address that triggered the fault
+	u64 dsisr; // the value of the dsisr register
+	u64 count; // The number of times this fault has been triggered
+};
+
+struct ocxl_context {
+	struct ocxl_afu *afu;
+	int pasid;
+	struct mutex status_mutex;
+	enum ocxl_context_status status;
+	struct address_space *mapping;
+	struct mutex mapping_lock;
+	wait_queue_head_t events_wq;
+	struct mutex xsl_error_lock;
+	struct ocxl_xsl_error xsl_error;
+	struct mutex irq_lock;
+	struct idr irq_idr;
+};
+
+struct ocxl_process_element {
+	u64 config_state;
+	u32 reserved1[11];
+	u32 lpid;
+	u32 tid;
+	u32 pid;
+	u32 reserved2[10];
+	u64 amr;
+	u32 reserved3[3];
+	u32 software_state;
+};
+
+
+extern struct ocxl_afu *ocxl_afu_get(struct ocxl_afu *afu);
+extern void ocxl_afu_put(struct ocxl_afu *afu);
+
+extern int ocxl_create_cdev(struct ocxl_afu *afu);
+extern void ocxl_destroy_cdev(struct ocxl_afu *afu);
+extern int ocxl_register_afu(struct ocxl_afu *afu);
+extern void ocxl_unregister_afu(struct ocxl_afu *afu);
+
+extern int ocxl_file_init(void);
+extern void ocxl_file_exit(void);
+
+extern int ocxl_config_read_function(struct pci_dev *dev,
+				struct ocxl_fn_config *fn);
+
+extern int ocxl_config_check_afu_index(struct pci_dev *dev,
+				struct ocxl_fn_config *fn, int afu_idx);
+extern int ocxl_config_read_afu(struct pci_dev *dev,
+				struct ocxl_fn_config *fn,
+				struct ocxl_afu_config *afu,
+				u8 afu_idx);
+extern int ocxl_config_get_pasid_info(struct pci_dev *dev, int *count);
+extern void ocxl_config_set_afu_pasid(struct pci_dev *dev,
+				int afu_control,
+				int pasid_base, u32 pasid_count_log);
+extern int ocxl_config_get_actag_info(struct pci_dev *dev,
+				u16 *base, u16 *enabled, u16 *supported);
+extern void ocxl_config_set_actag(struct pci_dev *dev, int func_dvsec,
+				u32 tag_first, u32 tag_count);
+extern void ocxl_config_set_afu_actag(struct pci_dev *dev, int afu_control,
+				int actag_base, int actag_count);
+extern void ocxl_config_set_afu_state(struct pci_dev *dev, int afu_control,
+				int enable);
+extern int ocxl_config_set_TL(struct pci_dev *dev, int tl_dvsec);
+extern int ocxl_config_terminate_pasid(struct pci_dev *dev, int afu_control,
+				int pasid);
+
+extern int ocxl_link_setup(struct pci_dev *dev, int PE_mask,
+			void **link_handle);
+extern void ocxl_link_release(struct pci_dev *dev, void *link_handle);
+extern int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
+		u64 amr, struct mm_struct *mm,
+		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
+		void *xsl_err_data);
+extern int ocxl_link_remove_pe(void *link_handle, int pasid);
+extern int ocxl_link_irq_alloc(void *link_handle, int *hw_irq,
+			u64 *addr);
+extern void ocxl_link_free_irq(void *link_handle, int hw_irq);
+
+extern int ocxl_pasid_afu_alloc(struct ocxl_fn *fn, u32 size);
+extern void ocxl_pasid_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
+extern int ocxl_actag_afu_alloc(struct ocxl_fn *fn, u32 size);
+extern void ocxl_actag_afu_free(struct ocxl_fn *fn, u32 start, u32 size);
+
+extern struct ocxl_context *ocxl_context_alloc(void);
+extern int ocxl_context_init(struct ocxl_context *ctx, struct ocxl_afu *afu,
+			struct address_space *mapping);
+extern int ocxl_context_attach(struct ocxl_context *ctx, u64 amr);
+extern int ocxl_context_mmap(struct ocxl_context *ctx,
+			struct vm_area_struct *vma);
+extern int ocxl_context_detach(struct ocxl_context *ctx);
+extern void ocxl_context_detach_all(struct ocxl_afu *afu);
+extern void ocxl_context_free(struct ocxl_context *ctx);
+
+extern int ocxl_sysfs_add_afu(struct ocxl_afu *afu);
+extern void ocxl_sysfs_remove_afu(struct ocxl_afu *afu);
+
+#endif /* _OCXL_INTERNAL_H_ */
diff --git a/drivers/misc/ocxl/pasid.c b/drivers/misc/ocxl/pasid.c
new file mode 100644
index 000000000000..ea999a3a99b4
--- /dev/null
+++ b/drivers/misc/ocxl/pasid.c
@@ -0,0 +1,114 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include "ocxl_internal.h"
+
+
+struct id_range {
+	struct list_head list;
+	u32 start;
+	u32 end;
+};
+
+#ifdef DEBUG
+static void dump_list(struct list_head *head, char *type_str)
+{
+	struct id_range *cur;
+
+	pr_debug("%s ranges allocated:\n", type_str);
+	list_for_each_entry(cur, head, list) {
+		pr_debug("Range %d->%d\n", cur->start, cur->end);
+	}
+}
+#endif
+
+static int range_alloc(struct list_head *head, u32 size, int max_id,
+		char *type_str)
+{
+	struct list_head *pos;
+	struct id_range *cur, *new;
+	int rc, last_end;
+
+	new = kmalloc(sizeof(struct id_range), GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	pos = head;
+	last_end = -1;
+	list_for_each_entry(cur, head, list) {
+		if ((cur->start - last_end) > size)
+			break;
+		last_end = cur->end;
+		pos = &cur->list;
+	}
+
+	new->start = last_end + 1;
+	new->end = new->start + size - 1;
+
+	if (new->end > max_id) {
+		kfree(new);
+		rc = -ENOSPC;
+	} else {
+		list_add(&new->list, pos);
+		rc = new->start;
+	}
+
+#ifdef DEBUG
+	dump_list(head, type_str);
+#endif
+	return rc;
+}
+
+static void range_free(struct list_head *head, u32 start, u32 size,
+		char *type_str)
+{
+	bool found = false;
+	struct id_range *cur, *tmp;
+
+	list_for_each_entry_safe(cur, tmp, head, list) {
+		if (cur->start == start && cur->end == (start + size - 1)) {
+			found = true;
+			list_del(&cur->list);
+			kfree(cur);
+			break;
+		}
+	}
+	WARN_ON(!found);
+#ifdef DEBUG
+	dump_list(head, type_str);
+#endif
+}
+
+int ocxl_pasid_afu_alloc(struct ocxl_fn *fn, u32 size)
+{
+	int max_pasid;
+
+	if (fn->config.max_pasid_log < 0)
+		return -ENOSPC;
+	max_pasid = 1 << fn->config.max_pasid_log;
+	return range_alloc(&fn->pasid_list, size, max_pasid, "afu pasid");
+}
+
+void ocxl_pasid_afu_free(struct ocxl_fn *fn, u32 start, u32 size)
+{
+	return range_free(&fn->pasid_list, start, size, "afu pasid");
+}
+
+int ocxl_actag_afu_alloc(struct ocxl_fn *fn, u32 size)
+{
+	int max_actag;
+
+	max_actag = fn->actag_enabled;
+	return range_alloc(&fn->actag_list, size, max_actag, "afu actag");
+}
+
+void ocxl_actag_afu_free(struct ocxl_fn *fn, u32 start, u32 size)
+{
+	return range_free(&fn->actag_list, start, size, "afu actag");
+}
diff --git a/drivers/misc/ocxl/pci.c b/drivers/misc/ocxl/pci.c
new file mode 100644
index 000000000000..39e7bdd48215
--- /dev/null
+++ b/drivers/misc/ocxl/pci.c
@@ -0,0 +1,592 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/idr.h>
+#include <asm/pnv-ocxl.h>
+#include "ocxl_internal.h"
+
+/*
+ * Any opencapi device which wants to use this 'generic' driver should
+ * use the 0x062B device ID. Vendors should define the subsystem
+ * vendor/device ID to help differentiate devices.
+ */
+static const struct pci_device_id ocxl_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_IBM, 0x062B), },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, ocxl_pci_tbl);
+
+
+static struct ocxl_fn *ocxl_fn_get(struct ocxl_fn *fn)
+{
+	return (get_device(&fn->dev) == NULL) ? NULL : fn;
+}
+
+static void ocxl_fn_put(struct ocxl_fn *fn)
+{
+	put_device(&fn->dev);
+}
+
+struct ocxl_afu *ocxl_afu_get(struct ocxl_afu *afu)
+{
+	return (get_device(&afu->dev) == NULL) ? NULL : afu;
+}
+
+void ocxl_afu_put(struct ocxl_afu *afu)
+{
+	put_device(&afu->dev);
+}
+
+static struct ocxl_afu *alloc_afu(struct ocxl_fn *fn)
+{
+	struct ocxl_afu *afu;
+
+	afu = kzalloc(sizeof(struct ocxl_afu), GFP_KERNEL);
+	if (!afu)
+		return NULL;
+
+	mutex_init(&afu->contexts_lock);
+	mutex_init(&afu->afu_control_lock);
+	idr_init(&afu->contexts_idr);
+	afu->fn = fn;
+	ocxl_fn_get(fn);
+	return afu;
+}
+
+static void free_afu(struct ocxl_afu *afu)
+{
+	idr_destroy(&afu->contexts_idr);
+	ocxl_fn_put(afu->fn);
+	kfree(afu);
+}
+
+static void free_afu_dev(struct device *dev)
+{
+	struct ocxl_afu *afu = to_ocxl_afu(dev);
+
+	ocxl_unregister_afu(afu);
+	free_afu(afu);
+}
+
+static int set_afu_device(struct ocxl_afu *afu, const char *location)
+{
+	struct ocxl_fn *fn = afu->fn;
+	int rc;
+
+	afu->dev.parent = &fn->dev;
+	afu->dev.release = free_afu_dev;
+	rc = dev_set_name(&afu->dev, "%s.%s.%hhu", afu->config.name, location,
+		afu->config.idx);
+	return rc;
+}
+
+static int assign_afu_actag(struct ocxl_afu *afu, struct pci_dev *dev)
+{
+	struct ocxl_fn *fn = afu->fn;
+	int actag_count, actag_offset;
+
+	/*
+	 * if there were not enough actags for the function, each afu
+	 * reduces its count as well
+	 */
+	actag_count = afu->config.actag_supported *
+		fn->actag_enabled / fn->actag_supported;
+	actag_offset = ocxl_actag_afu_alloc(fn, actag_count);
+	if (actag_offset < 0) {
+		dev_err(&afu->dev, "Can't allocate %d actags for AFU: %d\n",
+			actag_count, actag_offset);
+		return actag_offset;
+	}
+	afu->actag_base = fn->actag_base + actag_offset;
+	afu->actag_enabled = actag_count;
+
+	ocxl_config_set_afu_actag(dev, afu->config.dvsec_afu_control_pos,
+				afu->actag_base, afu->actag_enabled);
+	dev_dbg(&afu->dev, "actag base=%d enabled=%d\n",
+		afu->actag_base, afu->actag_enabled);
+	return 0;
+}
+
+static void reclaim_afu_actag(struct ocxl_afu *afu)
+{
+	struct ocxl_fn *fn = afu->fn;
+	int start_offset, size;
+
+	start_offset = afu->actag_base - fn->actag_base;
+	size = afu->actag_enabled;
+	ocxl_actag_afu_free(afu->fn, start_offset, size);
+}
+
+static int assign_afu_pasid(struct ocxl_afu *afu, struct pci_dev *dev)
+{
+	struct ocxl_fn *fn = afu->fn;
+	int pasid_count, pasid_offset;
+
+	/*
+	 * We only support the case where the function configuration
+	 * requested enough PASIDs to cover all AFUs.
+	 */
+	pasid_count = 1 << afu->config.pasid_supported_log;
+	pasid_offset = ocxl_pasid_afu_alloc(fn, pasid_count);
+	if (pasid_offset < 0) {
+		dev_err(&afu->dev, "Can't allocate %d PASIDs for AFU: %d\n",
+			pasid_count, pasid_offset);
+		return pasid_offset;
+	}
+	afu->pasid_base = fn->pasid_base + pasid_offset;
+	afu->pasid_count = 0;
+	afu->pasid_max = pasid_count;
+
+	ocxl_config_set_afu_pasid(dev, afu->config.dvsec_afu_control_pos,
+				afu->pasid_base,
+				afu->config.pasid_supported_log);
+	dev_dbg(&afu->dev, "PASID base=%d, enabled=%d\n",
+		afu->pasid_base, pasid_count);
+	return 0;
+}
+
+static void reclaim_afu_pasid(struct ocxl_afu *afu)
+{
+	struct ocxl_fn *fn = afu->fn;
+	int start_offset, size;
+
+	start_offset = afu->pasid_base - fn->pasid_base;
+	size = 1 << afu->config.pasid_supported_log;
+	ocxl_pasid_afu_free(afu->fn, start_offset, size);
+}
+
+static int reserve_fn_bar(struct ocxl_fn *fn, int bar)
+{
+	struct pci_dev *dev = to_pci_dev(fn->dev.parent);
+	int rc, idx;
+
+	if (bar != 0 && bar != 2 && bar != 4)
+		return -EINVAL;
+
+	idx = bar >> 1;
+	if (fn->bar_used[idx]++ == 0) {
+		rc = pci_request_region(dev, bar, "ocxl");
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+static void release_fn_bar(struct ocxl_fn *fn, int bar)
+{
+	struct pci_dev *dev = to_pci_dev(fn->dev.parent);
+	int idx;
+
+	if (bar != 0 && bar != 2 && bar != 4)
+		return;
+
+	idx = bar >> 1;
+	if (--fn->bar_used[idx] == 0)
+		pci_release_region(dev, bar);
+	WARN_ON(fn->bar_used[idx] < 0);
+}
+
+static int map_mmio_areas(struct ocxl_afu *afu, struct pci_dev *dev)
+{
+	int rc;
+
+	rc = reserve_fn_bar(afu->fn, afu->config.global_mmio_bar);
+	if (rc)
+		return rc;
+
+	rc = reserve_fn_bar(afu->fn, afu->config.pp_mmio_bar);
+	if (rc) {
+		release_fn_bar(afu->fn, afu->config.global_mmio_bar);
+		return rc;
+	}
+
+	afu->global_mmio_start =
+		pci_resource_start(dev, afu->config.global_mmio_bar) +
+		afu->config.global_mmio_offset;
+	afu->pp_mmio_start =
+		pci_resource_start(dev, afu->config.pp_mmio_bar) +
+		afu->config.pp_mmio_offset;
+
+	afu->global_mmio_ptr = ioremap(afu->global_mmio_start,
+				afu->config.global_mmio_size);
+	if (!afu->global_mmio_ptr) {
+		release_fn_bar(afu->fn, afu->config.pp_mmio_bar);
+		release_fn_bar(afu->fn, afu->config.global_mmio_bar);
+		dev_err(&dev->dev, "Error mapping global mmio area\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * Leave an empty page between the per-process mmio area and
+	 * the AFU interrupt mappings
+	 */
+	afu->irq_base_offset = afu->config.pp_mmio_stride + PAGE_SIZE;
+	return 0;
+}
+
+static void unmap_mmio_areas(struct ocxl_afu *afu)
+{
+	if (afu->global_mmio_ptr) {
+		iounmap(afu->global_mmio_ptr);
+		afu->global_mmio_ptr = NULL;
+	}
+	afu->global_mmio_start = 0;
+	afu->pp_mmio_start = 0;
+	release_fn_bar(afu->fn, afu->config.pp_mmio_bar);
+	release_fn_bar(afu->fn, afu->config.global_mmio_bar);
+}
+
+static int configure_afu(struct ocxl_afu *afu, u8 afu_idx, struct pci_dev *dev)
+{
+	int rc;
+
+	rc = ocxl_config_read_afu(dev, &afu->fn->config, &afu->config, afu_idx);
+	if (rc)
+		return rc;
+
+	rc = set_afu_device(afu, dev_name(&dev->dev));
+	if (rc)
+		return rc;
+
+	rc = assign_afu_actag(afu, dev);
+	if (rc)
+		return rc;
+
+	rc = assign_afu_pasid(afu, dev);
+	if (rc) {
+		reclaim_afu_actag(afu);
+		return rc;
+	}
+
+	rc = map_mmio_areas(afu, dev);
+	if (rc) {
+		reclaim_afu_pasid(afu);
+		reclaim_afu_actag(afu);
+		return rc;
+	}
+	return 0;
+}
+
+static void deconfigure_afu(struct ocxl_afu *afu)
+{
+	unmap_mmio_areas(afu);
+	reclaim_afu_pasid(afu);
+	reclaim_afu_actag(afu);
+}
+
+static int activate_afu(struct pci_dev *dev, struct ocxl_afu *afu)
+{
+	int rc;
+
+	ocxl_config_set_afu_state(dev, afu->config.dvsec_afu_control_pos, 1);
+	/*
+	 * Char device creation is the last step, as processes can
+	 * call our driver immediately, so all our inits must be finished.
+	 */
+	rc = ocxl_create_cdev(afu);
+	if (rc)
+		return rc;
+	return 0;
+}
+
+static void deactivate_afu(struct ocxl_afu *afu)
+{
+	struct pci_dev *dev = to_pci_dev(afu->fn->dev.parent);
+
+	ocxl_destroy_cdev(afu);
+	ocxl_config_set_afu_state(dev, afu->config.dvsec_afu_control_pos, 0);
+}
+
+static int init_afu(struct pci_dev *dev, struct ocxl_fn *fn, u8 afu_idx)
+{
+	int rc;
+	struct ocxl_afu *afu;
+
+	afu = alloc_afu(fn);
+	if (!afu)
+		return -ENOMEM;
+
+	rc = configure_afu(afu, afu_idx, dev);
+	if (rc) {
+		free_afu(afu);
+		return rc;
+	}
+
+	rc = ocxl_register_afu(afu);
+	if (rc)
+		goto err;
+
+	rc = ocxl_sysfs_add_afu(afu);
+	if (rc)
+		goto err;
+
+	rc = activate_afu(dev, afu);
+	if (rc)
+		goto err_sys;
+
+	list_add_tail(&afu->list, &fn->afu_list);
+	return 0;
+
+err_sys:
+	ocxl_sysfs_remove_afu(afu);
+err:
+	deconfigure_afu(afu);
+	device_unregister(&afu->dev);
+	return rc;
+}
+
+static void remove_afu(struct ocxl_afu *afu)
+{
+	list_del(&afu->list);
+	ocxl_context_detach_all(afu);
+	deactivate_afu(afu);
+	ocxl_sysfs_remove_afu(afu);
+	deconfigure_afu(afu);
+	device_unregister(&afu->dev);
+}
+
+static struct ocxl_fn *alloc_function(struct pci_dev *dev)
+{
+	struct ocxl_fn *fn;
+
+	fn = kzalloc(sizeof(struct ocxl_fn), GFP_KERNEL);
+	if (!fn)
+		return NULL;
+
+	INIT_LIST_HEAD(&fn->afu_list);
+	INIT_LIST_HEAD(&fn->pasid_list);
+	INIT_LIST_HEAD(&fn->actag_list);
+	return fn;
+}
+
+static void free_function(struct ocxl_fn *fn)
+{
+	WARN_ON(!list_empty(&fn->afu_list));
+	WARN_ON(!list_empty(&fn->pasid_list));
+	kfree(fn);
+}
+
+static void free_function_dev(struct device *dev)
+{
+	struct ocxl_fn *fn = to_ocxl_function(dev);
+
+	free_function(fn);
+}
+
+static int set_function_device(struct ocxl_fn *fn, struct pci_dev *dev)
+{
+	int rc;
+
+	fn->dev.parent = &dev->dev;
+	fn->dev.release = free_function_dev;
+	rc = dev_set_name(&fn->dev, "ocxlfn.%s", dev_name(&dev->dev));
+	if (rc)
+		return rc;
+	pci_set_drvdata(dev, fn);
+	return 0;
+}
+
+static int assign_function_actag(struct ocxl_fn *fn)
+{
+	struct pci_dev *dev = to_pci_dev(fn->dev.parent);
+	u16 base, enabled, supported;
+	int rc;
+
+	rc = ocxl_config_get_actag_info(dev, &base, &enabled, &supported);
+	if (rc)
+		return rc;
+
+	fn->actag_base = base;
+	fn->actag_enabled = enabled;
+	fn->actag_supported = supported;
+
+	ocxl_config_set_actag(dev, fn->config.dvsec_function_pos,
+			fn->actag_base,	fn->actag_enabled);
+	dev_dbg(&fn->dev, "actag range starting at %d, enabled %d\n",
+		fn->actag_base, fn->actag_enabled);
+	return 0;
+}
+
+static int set_function_pasid(struct ocxl_fn *fn)
+{
+	struct pci_dev *dev = to_pci_dev(fn->dev.parent);
+	int rc, desired_count, max_count;
+
+	/* A function may not require any PASID */
+	if (fn->config.max_pasid_log < 0)
+		return 0;
+
+	rc = ocxl_config_get_pasid_info(dev, &max_count);
+	if (rc)
+		return rc;
+
+	desired_count = 1 << fn->config.max_pasid_log;
+
+	if (desired_count > max_count) {
+		dev_err(&fn->dev,
+			"Function requires more PASIDs than is available (%d vs. %d)\n",
+			desired_count, max_count);
+		return -ENOSPC;
+	}
+
+	fn->pasid_base = 0;
+	return 0;
+}
+
+static int configure_function(struct ocxl_fn *fn, struct pci_dev *dev)
+{
+	int rc;
+
+	rc = pci_enable_device(dev);
+	if (rc) {
+		dev_err(&dev->dev, "pci_enable_device failed: %d\n", rc);
+		return rc;
+	}
+
+	/*
+	 * Once it has been confirmed to work on our hardware, we
+	 * should reset the function, to force the adapter to restart
+	 * from scratch.
+	 * A function reset would also reset all its AFUs.
+	 *
+	 * Some hints for implementation:
+	 *
+	 * - there's not status bit to know when the reset is done. We
+	 *   should try reading the config space to know when it's
+	 *   done.
+	 * - probably something like:
+	 *	Reset
+	 *	wait 100ms
+	 *	issue config read
+	 *	allow device up to 1 sec to return success on config
+	 *	read before declaring it broken
+	 *
+	 * Some shared logic on the card (CFG, TLX) won't be reset, so
+	 * there's no guarantee that it will be enough.
+	 */
+	rc = ocxl_config_read_function(dev, &fn->config);
+	if (rc)
+		return rc;
+
+	rc = set_function_device(fn, dev);
+	if (rc)
+		return rc;
+
+	rc = assign_function_actag(fn);
+	if (rc)
+		return rc;
+
+	rc = set_function_pasid(fn);
+	if (rc)
+		return rc;
+
+	rc = ocxl_link_setup(dev, 0, &fn->link);
+	if (rc)
+		return rc;
+
+	rc = ocxl_config_set_TL(dev, fn->config.dvsec_tl_pos);
+	if (rc) {
+		ocxl_link_release(dev, fn->link);
+		return rc;
+	}
+	return 0;
+}
+
+static void deconfigure_function(struct ocxl_fn *fn)
+{
+	struct pci_dev *dev = to_pci_dev(fn->dev.parent);
+
+	ocxl_link_release(dev, fn->link);
+	pci_disable_device(dev);
+}
+
+static struct ocxl_fn *init_function(struct pci_dev *dev)
+{
+	struct ocxl_fn *fn;
+	int rc;
+
+	fn = alloc_function(dev);
+	if (!fn)
+		return ERR_PTR(-ENOMEM);
+
+	rc = configure_function(fn, dev);
+	if (rc) {
+		free_function(fn);
+		return ERR_PTR(rc);
+	}
+
+	rc = device_register(&fn->dev);
+	if (rc) {
+		deconfigure_function(fn);
+		device_unregister(&fn->dev);
+		return ERR_PTR(rc);
+	}
+	return fn;
+}
+
+static void remove_function(struct ocxl_fn *fn)
+{
+	deconfigure_function(fn);
+	device_unregister(&fn->dev);
+}
+
+static int ocxl_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	int rc, afu_count = 0;
+	u8 afu;
+	struct ocxl_fn *fn;
+
+	if (!radix_enabled()) {
+		dev_err(&dev->dev, "Unsupported memory model (hash)\n");
+		return -ENODEV;
+	}
+
+	fn = init_function(dev);
+	if (IS_ERR(fn)) {
+		dev_err(&dev->dev, "function init failed: %li\n",
+			PTR_ERR(fn));
+		return PTR_ERR(fn);
+	}
+
+	for (afu = 0; afu <= fn->config.max_afu_index; afu++) {
+		rc = ocxl_config_check_afu_index(dev, &fn->config, afu);
+		if (rc > 0) {
+			rc = init_afu(dev, fn, afu);
+			if (rc) {
+				dev_err(&dev->dev,
+					"Can't initialize AFU index %d\n", afu);
+				continue;
+			}
+			afu_count++;
+		}
+	}
+	dev_info(&dev->dev, "%d AFU(s) configured\n", afu_count);
+	return 0;
+}
+
+static void ocxl_remove(struct pci_dev *dev)
+{
+	struct ocxl_afu *afu, *tmp;
+	struct ocxl_fn *fn = pci_get_drvdata(dev);
+
+	list_for_each_entry_safe(afu, tmp, &fn->afu_list, list) {
+		remove_afu(afu);
+	}
+	remove_function(fn);
+}
+
+struct pci_driver ocxl_pci_driver = {
+	.name = "ocxl",
+	.id_table = ocxl_pci_tbl,
+	.probe = ocxl_probe,
+	.remove = ocxl_remove,
+	.shutdown = ocxl_remove,
+};
diff --git a/drivers/misc/ocxl/sysfs.c b/drivers/misc/ocxl/sysfs.c
new file mode 100644
index 000000000000..b7b1d1735c07
--- /dev/null
+++ b/drivers/misc/ocxl/sysfs.c
@@ -0,0 +1,150 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/sysfs.h>
+#include "ocxl_internal.h"
+
+static ssize_t global_mmio_size_show(struct device *device,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct ocxl_afu *afu = to_ocxl_afu(device);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			afu->config.global_mmio_size);
+}
+
+static ssize_t pp_mmio_size_show(struct device *device,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct ocxl_afu *afu = to_ocxl_afu(device);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			afu->config.pp_mmio_stride);
+}
+
+static ssize_t afu_version_show(struct device *device,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct ocxl_afu *afu = to_ocxl_afu(device);
+
+	return scnprintf(buf, PAGE_SIZE, "%hhu:%hhu\n",
+			afu->config.version_major,
+			afu->config.version_minor);
+}
+
+static ssize_t contexts_show(struct device *device,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct ocxl_afu *afu = to_ocxl_afu(device);
+
+	return scnprintf(buf, PAGE_SIZE, "%d/%d\n",
+			afu->pasid_count, afu->pasid_max);
+}
+
+static struct device_attribute afu_attrs[] = {
+	__ATTR_RO(global_mmio_size),
+	__ATTR_RO(pp_mmio_size),
+	__ATTR_RO(afu_version),
+	__ATTR_RO(contexts),
+};
+
+static ssize_t global_mmio_read(struct file *filp, struct kobject *kobj,
+				struct bin_attribute *bin_attr, char *buf,
+				loff_t off, size_t count)
+{
+	struct ocxl_afu *afu = to_ocxl_afu(kobj_to_dev(kobj));
+
+	if (count == 0 || off < 0 ||
+		off >= afu->config.global_mmio_size)
+		return 0;
+
+	memcpy(buf, afu->global_mmio_ptr + off, count);
+	return count;
+}
+
+static int global_mmio_fault(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct ocxl_afu *afu = vma->vm_private_data;
+	unsigned long offset;
+
+	if (vmf->pgoff >= (afu->config.global_mmio_size >> PAGE_SHIFT))
+		return VM_FAULT_SIGBUS;
+
+	offset = vmf->pgoff;
+	offset += (afu->global_mmio_start >> PAGE_SHIFT);
+	vm_insert_pfn(vma, vmf->address, offset);
+	return VM_FAULT_NOPAGE;
+}
+
+static const struct vm_operations_struct global_mmio_vmops = {
+	.fault = global_mmio_fault,
+};
+
+static int global_mmio_mmap(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *bin_attr,
+			struct vm_area_struct *vma)
+{
+	struct ocxl_afu *afu = to_ocxl_afu(kobj_to_dev(kobj));
+
+	if ((vma_pages(vma) + vma->vm_pgoff) >
+		(afu->config.global_mmio_size >> PAGE_SHIFT))
+		return -EINVAL;
+
+	vma->vm_flags |= VM_IO | VM_PFNMAP;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_ops = &global_mmio_vmops;
+	vma->vm_private_data = afu;
+	return 0;
+}
+
+int ocxl_sysfs_add_afu(struct ocxl_afu *afu)
+{
+	int i, rc;
+
+	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++) {
+		rc = device_create_file(&afu->dev, &afu_attrs[i]);
+		if (rc)
+			goto err;
+	}
+
+	sysfs_attr_init(&afu->attr_global_mmio.attr);
+	afu->attr_global_mmio.attr.name = "global_mmio_area";
+	afu->attr_global_mmio.attr.mode = 0600;
+	afu->attr_global_mmio.size = afu->config.global_mmio_size;
+	afu->attr_global_mmio.read = global_mmio_read;
+	afu->attr_global_mmio.mmap = global_mmio_mmap;
+	rc = device_create_bin_file(&afu->dev, &afu->attr_global_mmio);
+	if (rc) {
+		dev_err(&afu->dev,
+			"Unable to create global mmio attr for afu: %d\n",
+			rc);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	for (i--; i >= 0; i--)
+		device_remove_file(&afu->dev, &afu_attrs[i]);
+	return rc;
+}
+
+void ocxl_sysfs_remove_afu(struct ocxl_afu *afu)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(afu_attrs); i++)
+		device_remove_file(&afu->dev, &afu_attrs[i]);
+	device_remove_bin_file(&afu->dev, &afu->attr_global_mmio);
+}
diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
new file mode 100644
index 000000000000..71fa387f2efd
--- /dev/null
+++ b/include/uapi/misc/ocxl.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright 2017 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _UAPI_MISC_OCXL_H
+#define _UAPI_MISC_OCXL_H
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+enum ocxl_event_type {
+	OCXL_AFU_EVENT_XSL_FAULT_ERROR = 0,
+};
+
+#define OCXL_KERNEL_EVENT_FLAG_LAST 0x0001  /* This is the last event pending */
+
+struct ocxl_kernel_event_header {
+	__u16 type;
+	__u16 flags;
+	__u32 reserved;
+};
+
+struct ocxl_kernel_event_xsl_fault_error {
+	__u64 addr;
+	__u64 dsisr;
+	__u64 count;
+	__u64 reserved;
+};
+
+struct ocxl_ioctl_attach {
+	__u64 amr;
+	__u64 reserved1;
+	__u64 reserved2;
+	__u64 reserved3;
+};
+
+/* ioctl numbers */
+#define OCXL_MAGIC 0xCA
+/* AFU devices */
+#define OCXL_IOCTL_ATTACH	_IOW(OCXL_MAGIC, 0x10, struct ocxl_ioctl_attach)
+
+#endif /* _UAPI_MISC_OCXL_H */
-- 
2.14.1
