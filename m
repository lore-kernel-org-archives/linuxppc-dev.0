Return-Path: <Bharat.Bhushan@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 16D3D1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 17:03:00 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0131.outbound.protection.outlook.com [157.56.111.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F1D1E1400DE
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2015 17:02:58 +1100 (AEDT)
From: Bharat Bhushan <Bharat.Bhushan@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 4/4 RFC] fsl/msi: Add interface to reserve/free msi bank
Date: Tue, 3 Mar 2015 10:47:46 +0530
Message-ID: <1425359866-31049-4-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1425359866-31049-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1425359866-31049-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <Bharat.Bhushan@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch allows a context (different from kernel context)
to reserve a MSI bank for itself. And then the devices in the
context will share the MSI bank.

VFIO meta driver is one of typical user of these APIs. It will
reserve a MSI bank for MSI interrupt support of direct assignment
PCI devices to a Guest. Patches for same will follow this patch.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>
---
 arch/powerpc/include/asm/device.h  |   2 +
 arch/powerpc/include/asm/fsl_msi.h |  26 ++++++
 arch/powerpc/sysdev/fsl_msi.c      | 169 +++++++++++++++++++++++++++++++------
 arch/powerpc/sysdev/fsl_msi.h      |   1 +
 4 files changed, 173 insertions(+), 25 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fsl_msi.h

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 38faede..1c2bfd7 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -40,6 +40,8 @@ struct dev_archdata {
 #ifdef CONFIG_FAIL_IOMMU
 	int fail_iommu;
 #endif
+
+	void *context;
 };
 
 struct pdev_archdata {
diff --git a/arch/powerpc/include/asm/fsl_msi.h b/arch/powerpc/include/asm/fsl_msi.h
new file mode 100644
index 0000000..e9041c2
--- /dev/null
+++ b/arch/powerpc/include/asm/fsl_msi.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2014 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: Bharat Bhushan <bharat.bhushan@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#ifndef _POWERPC_FSL_MSI_H
+#define _POWERPC_FSL_MSI_H
+
+extern int fsl_msi_set_msi_bank_region(struct iommu_domain *domain,
+				       void *context, int win,
+				       dma_addr_t iova, int prot);
+extern int fsl_msi_clear_msi_bank_region(struct iommu_domain *domain,
+					 struct iommu_group *iommu_group,
+					 int win, dma_addr_t iova);
+extern struct fsl_msi *fsl_msi_reserve_msi_bank(void *context);
+extern int fsl_msi_unreserve_msi_bank(void *context);
+extern int fsl_msi_set_msi_bank_in_dev(struct device *dev, void *data);
+
+#endif /* _POWERPC_FSL_MSI_H */
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 027aeeb..75cd196 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -25,6 +25,7 @@
 #include <asm/ppc-pci.h>
 #include <asm/mpic.h>
 #include <asm/fsl_hcalls.h>
+#include <linux/iommu.h>
 
 #include "fsl_msi.h"
 #include "fsl_pci.h"
@@ -172,22 +173,6 @@ static struct fsl_msi *fsl_msi_allocate_msi_bank(void *context)
 	return NULL;
 }
 
-/* FIXME: Assumption that host kernel will allocate only one MSI bank */
- __attribute__ ((unused)) static int fsl_msi_free_msi_bank(void *context)
-{
-	struct fsl_msi *msi_data;
-
-	list_for_each_entry(msi_data, &msi_head, list) {
-		if ((msi_data->reserved == MSI_RESERVED) &&
-		     (msi_data->context == context)) {
-			msi_data->reserved = MSI_FREE;
-			msi_data->context = NULL;
-			return 0;
-		}
-	}
-	return -ENODEV;
-}
-
 /*  This API returns the allocated MSI bank of "context"
  *  to which "pdev" device belongs.
  *  All kernel owned devices have NULL context. All devices
@@ -200,6 +185,12 @@ static struct fsl_msi *fsl_msi_get_reserved_msi_bank(struct pci_dev *pdev)
 {
 	struct fsl_msi *msi_data = NULL;
 	void *context = NULL;
+	struct device *dev = &pdev->dev;
+
+	/* Device assigned to userspace if there is valid context */
+	if (dev->archdata.context) {
+		context = dev->archdata.context;
+	}
 
 	list_for_each_entry(msi_data, &msi_head, list) {
 		if ((msi_data->reserved == MSI_RESERVED) &&
@@ -208,13 +199,133 @@ static struct fsl_msi *fsl_msi_get_reserved_msi_bank(struct pci_dev *pdev)
 	}
 
 	/* If no MSI bank allocated for kernel owned device, allocate one */
-	msi_data = fsl_msi_allocate_msi_bank(NULL);
-	if (msi_data)
-		return msi_data;
+	if (!context) {
+		msi_data = fsl_msi_allocate_msi_bank(NULL);
+		if (msi_data)
+			return msi_data;
+	}
 
 	return NULL;
 }
 
+/* API to set "context" to which the device belongs */
+int fsl_msi_set_msi_bank_in_dev(struct device *dev, void *data)
+{
+	dev->archdata.context = data;
+	return 0;
+}
+
+/*  This API Allows a MSI bank to be reserved for a "context".
+ *  All devices in same "context" will share the allocated
+ *  MSI bank.
+ *  Typically this function will be called from meta
+ *  driver like VFIO with a valid "context".
+ */
+struct fsl_msi *fsl_msi_reserve_msi_bank(void *context)
+{
+	struct fsl_msi *msi_data;
+
+	if (!context)
+		return NULL;
+
+	/* Check if msi-bank already allocated for the context */
+	list_for_each_entry(msi_data, &msi_head, list) {
+		if (msi_data->reserved == MSI_FREE)
+			continue;
+
+		if (context == msi_data->context)
+			return msi_data;
+	}
+
+	msi_data = fsl_msi_allocate_msi_bank(context);
+	return msi_data;
+}
+
+/* Free reserved MSI bank for a given valid context */
+int fsl_msi_unreserve_msi_bank(void *context)
+{
+	struct fsl_msi *msi_data;
+
+	if (!context)
+		return -EINVAL;
+
+	list_for_each_entry(msi_data, &msi_head, list) {
+		if ((context == msi_data->context) &&
+		    (msi_data->reserved == MSI_RESERVED)) {
+			msi_data->reserved = MSI_FREE;
+			msi_data->context = NULL;
+			return 0;
+		}
+	}
+	return -ENODEV;
+}
+
+static int is_msi_bank_reserved(struct fsl_msi *msi)
+{
+	return msi->reserved != MSI_FREE;
+}
+
+/*
+ * This function configures PAMU window for MSI page with
+ * given iova. Also same iova will be used as "msi-address"
+ * when configuring msi-message in the devices using this
+ * msi bank.
+ */
+int fsl_msi_set_msi_bank_region(struct iommu_domain *domain,
+				void *context , int win,
+				dma_addr_t iova, int prot)
+{
+	struct fsl_msi *msi_data;
+	dma_addr_t addr;
+	u64 size;
+	int ret;
+
+	if (!context)
+		return -EINVAL;
+
+	list_for_each_entry(msi_data, &msi_head, list) {
+		if (msi_data->reserved == MSI_FREE)
+			continue;
+
+		if (context != msi_data->context)
+			continue;
+
+		size = PAGE_SIZE;
+		addr = msi_data->msiir & ~(size - 1);
+		ret = iommu_domain_window_enable(domain, win, addr, size, prot);
+		if (ret) {
+			pr_err("%s Error: unable to map msi region\n", __func__);
+			return ret;
+		}
+		msi_data->iova = iova | (msi_data->msiir & (size - 1));
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+/* This allows to undo what is done in fsl_msi_set_msi_bank_region() */
+int fsl_msi_clear_msi_bank_region(struct iommu_domain *domain, void *context,
+				  int win)
+{
+	struct fsl_msi *msi_data;
+
+	if (!context)
+		return -EINVAL;
+
+	list_for_each_entry(msi_data, &msi_head, list) {
+		if (msi_data->reserved == MSI_FREE)
+			continue;
+
+		if (context == msi_data->context) {
+			iommu_domain_window_disable(domain, win);
+			msi_data->iova = 0;
+			return 0;
+		}
+	}
+	return -ENODEV;
+}
+
 static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 				struct msi_msg *msg,
 				struct fsl_msi *fsl_msi_data)
@@ -225,12 +336,17 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 	int len;
 	const __be64 *reg;
 
-	/* If the msi-address-64 property exists, then use it */
-	reg = of_get_property(hose->dn, "msi-address-64", &len);
-	if (reg && (len == sizeof(u64)))
-		address = be64_to_cpup(reg);
-	else
-		address = msi_data->msiir;
+	if (pdev->dev.archdata.context) {
+		address = msi_data->iova;
+	} else {
+		/* If the msi-address-64 property exists, then use it */
+		reg = of_get_property(hose->dn, "msi-address-64", &len);
+		if (reg && (len == sizeof(u64)))
+			address = be64_to_cpup(reg);
+		else
+			address = fsl_pci_immrbar_base(hose) +
+					(msi_data->msiir & 0xfffff);
+	}
 
 	msg->address_lo = lower_32_bits(address);
 	msg->address_hi = upper_32_bits(address);
@@ -401,6 +517,9 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
 	struct fsl_msi *msi = platform_get_drvdata(ofdev);
 	int virq, i;
 
+	if (is_msi_bank_reserved(msi))
+		return -EBUSY;
+
 	if (msi->list.prev != NULL)
 		list_del(&msi->list);
 	for (i = 0; i < NR_MSI_REG_MAX; i++) {
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index c69702b..7dc6f35 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -50,6 +50,7 @@ struct fsl_msi {
 #define MSI_RESERVED		1
         int reserved;
         void *context;
+	dma_addr_t iova;
 };
 
 #endif /* _POWERPC_SYSDEV_FSL_MSI_H */
-- 
1.9.3
