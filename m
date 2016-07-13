Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqWs0041kzDqFn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:11 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DL91t5096612
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:10 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24567dd3hc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:09 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 14 Jul 2016 07:18:06 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 297112BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:04 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DLI4eB25952442
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:04 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DLI3qH000937
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:03 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 09/15] cxl: Add kernel APIs to get & set the max irqs per
 context
Date: Thu, 14 Jul 2016 07:17:08 +1000
In-Reply-To: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
References: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468444634-1866-10-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

These APIs will be used by the Mellanox CX4 support. While they function
standalone to configure existing behaviour, their primary purpose is to
allow the Mellanox driver to inform the cxl driver of a hardware
limitation, which will be used in a future patch.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 drivers/misc/cxl/api.c | 27 +++++++++++++++++++++++++++
 include/misc/cxl.h     | 10 ++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 6a030bf..1e2c0d9 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -447,3 +447,30 @@ ssize_t cxl_read_adapter_vpd(struct pci_dev *dev, void *buf, size_t count)
 	return cxl_ops->read_adapter_vpd(afu->adapter, buf, count);
 }
 EXPORT_SYMBOL_GPL(cxl_read_adapter_vpd);
+
+int cxl_set_max_irqs_per_process(struct pci_dev *dev, int irqs)
+{
+	struct cxl_afu *afu = cxl_pci_to_afu(dev);
+	if (IS_ERR(afu))
+		return -ENODEV;
+
+	if (irqs > afu->adapter->user_irqs)
+		return -EINVAL;
+
+	/* Limit user_irqs to prevent the user increasing this via sysfs */
+	afu->adapter->user_irqs = irqs;
+	afu->irqs_max = irqs;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_set_max_irqs_per_process);
+
+int cxl_get_max_irqs_per_process(struct pci_dev *dev)
+{
+	struct cxl_afu *afu = cxl_pci_to_afu(dev);
+	if (IS_ERR(afu))
+		return -ENODEV;
+
+	return afu->irqs_max;
+}
+EXPORT_SYMBOL_GPL(cxl_get_max_irqs_per_process);
diff --git a/include/misc/cxl.h b/include/misc/cxl.h
index dd9eebb..fc07ed4 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl.h
@@ -166,6 +166,16 @@ void cxl_psa_unmap(void __iomem *addr);
 /*  Get the process element for this context */
 int cxl_process_element(struct cxl_context *ctx);
 
+/*
+ * Limit the number of interrupts that a single context can allocate via
+ * cxl_start_work. If using the api with a real phb, this may be used to
+ * request that additional default contexts be created when allocating
+ * interrupts via pci_enable_msix_range. These will be set to the same running
+ * state as the default context, and if that is running it will reuse the
+ * parameters previously passed to cxl_start_context for the default context.
+ */
+int cxl_set_max_irqs_per_process(struct pci_dev *dev, int irqs);
+int cxl_get_max_irqs_per_process(struct pci_dev *dev);
 
 /*
  * These calls allow drivers to create their own file descriptors and make them
-- 
2.8.1
