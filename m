Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQmNd6YClzDqy7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 22:32:01 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0NBTR8V014092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:31:59 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fp2jwmcn5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 06:31:59 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 23 Jan 2018 11:31:57 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: [PATCH v2 04/13] powerpc/powernv: Add platform-specific services for
 opencapi
Date: Tue, 23 Jan 2018 12:31:39 +0100
In-Reply-To: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
References: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
Message-Id: <20180123113148.6024-5-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement a few platform-specific calls which can be used by drivers:

- provide the Transaction Layer capabilities of the host, so that the
  driver can find some common ground and configure the device and host
  appropriately.

- provide the hw interrupt to be used for translation faults raised by
  the NPU

- map/unmap some NPU mmio registers to get the fault context when the
  NPU raises an address translation fault

The rest are wrappers around the previously-introduced opal calls.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pnv-ocxl.h     |  29 +++++
 arch/powerpc/platforms/powernv/Makefile |   1 +
 arch/powerpc/platforms/powernv/ocxl.c   | 180 ++++++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100644 arch/powerpc/include/asm/pnv-ocxl.h
 create mode 100644 arch/powerpc/platforms/powernv/ocxl.c

diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
new file mode 100644
index 000000000000..36868d49aeed
--- /dev/null
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2017 IBM Corp.
+#ifndef _ASM_PNV_OCXL_H
+#define _ASM_PNV_OCXL_H
+
+#include <linux/pci.h>
+
+#define PNV_OCXL_TL_MAX_TEMPLATE        63
+#define PNV_OCXL_TL_BITS_PER_RATE       4
+#define PNV_OCXL_TL_RATE_BUF_SIZE       ((PNV_OCXL_TL_MAX_TEMPLATE+1) * PNV_OCXL_TL_BITS_PER_RATE / 8)
+
+extern int pnv_ocxl_get_tl_cap(struct pci_dev *dev, long *cap,
+			char *rate_buf, int rate_buf_size);
+extern int pnv_ocxl_set_tl_conf(struct pci_dev *dev, long cap,
+			uint64_t rate_buf_phys, int rate_buf_size);
+
+extern int pnv_ocxl_get_xsl_irq(struct pci_dev *dev, int *hwirq);
+extern void pnv_ocxl_unmap_xsl_regs(void __iomem *dsisr, void __iomem *dar,
+				void __iomem *tfc, void __iomem *pe_handle);
+extern int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
+				void __iomem **dar, void __iomem **tfc,
+				void __iomem **pe_handle);
+
+extern int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask,
+			void **platform_data);
+extern void pnv_ocxl_spa_release(void *platform_data);
+extern int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle);
+
+#endif /* _ASM_PNV_OCXL_H */
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index 3732118a0482..6c9d5199a7e2 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_PERF_EVENTS) += opal-imc.o
 obj-$(CONFIG_PPC_MEMTRACE)	+= memtrace.o
 obj-$(CONFIG_PPC_VAS)	+= vas.o vas-window.o vas-debug.o
 obj-$(CONFIG_PPC_FTW)	+= nx-ftw.o
+obj-$(CONFIG_OCXL_BASE)	+= ocxl.o
diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
new file mode 100644
index 000000000000..d61186805a07
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright 2017 IBM Corp.
+#include <asm/pnv-ocxl.h>
+#include <asm/opal.h>
+#include "pci.h"
+
+#define PNV_OCXL_TL_P9_RECV_CAP		0x000000000000000Full
+/* PASIDs are 20-bit, but on P9, NPU can only handle 15 bits */
+#define PNV_OCXL_PASID_BITS		15
+#define PNV_OCXL_PASID_MAX		((1 << PNV_OCXL_PASID_BITS) - 1)
+
+
+static void set_templ_rate(unsigned int templ, unsigned int rate, char *buf)
+{
+	int shift, idx;
+
+	WARN_ON(templ > PNV_OCXL_TL_MAX_TEMPLATE);
+	idx = (PNV_OCXL_TL_MAX_TEMPLATE - templ) / 2;
+	shift = 4 * (1 - ((PNV_OCXL_TL_MAX_TEMPLATE - templ) % 2));
+	buf[idx] |= rate << shift;
+}
+
+int pnv_ocxl_get_tl_cap(struct pci_dev *dev, long *cap,
+			char *rate_buf, int rate_buf_size)
+{
+	if (rate_buf_size != PNV_OCXL_TL_RATE_BUF_SIZE)
+		return -EINVAL;
+	/*
+	 * The TL capabilities are a characteristic of the NPU, so
+	 * we go with hard-coded values.
+	 *
+	 * The receiving rate of each template is encoded on 4 bits.
+	 *
+	 * On P9:
+	 * - templates 0 -> 3 are supported
+	 * - templates 0, 1 and 3 have a 0 receiving rate
+	 * - template 2 has receiving rate of 1 (extra cycle)
+	 */
+	memset(rate_buf, 0, rate_buf_size);
+	set_templ_rate(2, 1, rate_buf);
+	*cap = PNV_OCXL_TL_P9_RECV_CAP;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_get_tl_cap);
+
+int pnv_ocxl_set_tl_conf(struct pci_dev *dev, long cap,
+			uint64_t rate_buf_phys, int rate_buf_size)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	int rc;
+
+	if (rate_buf_size != PNV_OCXL_TL_RATE_BUF_SIZE)
+		return -EINVAL;
+
+	rc = opal_npu_tl_set(phb->opal_id, dev->devfn, cap,
+			rate_buf_phys, rate_buf_size);
+	if (rc) {
+		dev_err(&dev->dev, "Can't configure host TL: %d\n", rc);
+		return -EINVAL;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_set_tl_conf);
+
+int pnv_ocxl_get_xsl_irq(struct pci_dev *dev, int *hwirq)
+{
+	int rc;
+
+	rc = of_property_read_u32(dev->dev.of_node, "ibm,opal-xsl-irq", hwirq);
+	if (rc) {
+		dev_err(&dev->dev,
+			"Can't get translation interrupt for device\n");
+		return rc;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_get_xsl_irq);
+
+void pnv_ocxl_unmap_xsl_regs(void __iomem *dsisr, void __iomem *dar,
+			void __iomem *tfc, void __iomem *pe_handle)
+{
+	iounmap(dsisr);
+	iounmap(dar);
+	iounmap(tfc);
+	iounmap(pe_handle);
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_unmap_xsl_regs);
+
+int pnv_ocxl_map_xsl_regs(struct pci_dev *dev, void __iomem **dsisr,
+			void __iomem **dar, void __iomem **tfc,
+			void __iomem **pe_handle)
+{
+	u64 reg;
+	int i, j, rc = 0;
+	void __iomem *regs[4];
+
+	/*
+	 * opal stores the mmio addresses of the DSISR, DAR, TFC and
+	 * PE_HANDLE registers in a device tree property, in that
+	 * order
+	 */
+	for (i = 0; i < 4; i++) {
+		rc = of_property_read_u64_index(dev->dev.of_node,
+						"ibm,opal-xsl-mmio", i, &reg);
+		if (rc)
+			break;
+		regs[i] = ioremap(reg, 8);
+		if (!regs[i]) {
+			rc = -EINVAL;
+			break;
+		}
+	}
+	if (rc) {
+		dev_err(&dev->dev, "Can't map translation mmio registers\n");
+		for (j = i - 1; j >= 0; j--)
+			iounmap(regs[j]);
+	} else {
+		*dsisr = regs[0];
+		*dar = regs[1];
+		*tfc = regs[2];
+		*pe_handle = regs[3];
+	}
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_map_xsl_regs);
+
+struct spa_data {
+	u64 phb_opal_id;
+	u32 bdfn;
+};
+
+int pnv_ocxl_spa_setup(struct pci_dev *dev, void *spa_mem, int PE_mask,
+		void **platform_data)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct spa_data *data;
+	u32 bdfn;
+	int rc;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	bdfn = (dev->bus->number << 8) | dev->devfn;
+	rc = opal_npu_spa_setup(phb->opal_id, bdfn, virt_to_phys(spa_mem),
+				PE_mask);
+	if (rc) {
+		dev_err(&dev->dev, "Can't setup Shared Process Area: %d\n", rc);
+		kfree(data);
+		return rc;
+	}
+	data->phb_opal_id = phb->opal_id;
+	data->bdfn = bdfn;
+	*platform_data = (void *) data;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_spa_setup);
+
+void pnv_ocxl_spa_release(void *platform_data)
+{
+	struct spa_data *data = (struct spa_data *) platform_data;
+	int rc;
+
+	rc = opal_npu_spa_setup(data->phb_opal_id, data->bdfn, 0, 0);
+	WARN_ON(rc);
+	kfree(data);
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
+
+int pnv_ocxl_spa_remove_pe(void *platform_data, int pe_handle)
+{
+	struct spa_data *data = (struct spa_data *) platform_data;
+	int rc;
+
+	rc = opal_npu_spa_clear_cache(data->phb_opal_id, data->bdfn, pe_handle);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_spa_remove_pe);
-- 
2.14.1
