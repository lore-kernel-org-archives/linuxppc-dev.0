Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtFp76ycHzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 17:55:11 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6I7roQo073928
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 03:55:09 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2482fvvceu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 03:55:09 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 18 Jul 2016 17:55:04 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7BE6C2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 17:55:01 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6I7t1Pn26411206
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 17:55:01 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6I7t0AU012210
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 17:55:01 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: imunsie@au1.ibm.com
Subject: [PATCH] powerpc/powernv: fix pci-cxl.c build when CONFIG_MODULES=n
Date: Mon, 18 Jul 2016 17:53:19 +1000
Message-Id: <1468828399-30151-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

pnv_cxl_enable_phb_kernel_api() grabs a reference to the cxl module to
prevent it from being unloaded after the PHB has been switched to CX4 mode.
This breaks the build when CONFIG_MODULES=n as module_mutex doesn't exist.

However, if we don't have modules, we don't need to protect against the
case of the cxl module being unloaded. As such, split the relevant
code out into a function surrounded with #if IS_MODULE(CXL) so we don't try
to compile it if cxl isn't being compiled as a module.

Fixes: 5918dbc9b4ec ("powerpc/powernv: Add support for the cxl kernel api
on the real phb")
Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

Compile tested only.
---
 arch/powerpc/platforms/powernv/pci-cxl.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
index 1559ca2..40b9d19 100644
--- a/arch/powerpc/platforms/powernv/pci-cxl.c
+++ b/arch/powerpc/platforms/powernv/pci-cxl.c
@@ -166,6 +166,23 @@ int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 }
 EXPORT_SYMBOL(pnv_cxl_ioda_msi_setup);
 
+#if IS_MODULE(cxl)
+static inline void get_cxl_module(void)
+{
+       struct module *cxl_module;
+
+       mutex_lock(&module_mutex);
+       cxl_module = find_module("cxl");
+       if (cxl_module)
+              __module_get(cxl_module);
+       mutex_unlock(&module_mutex);
+       if (!cxl_module)
+              return -ENODEV;
+}
+#else
+static inline void get_cxl_module(void) {}
+#endif
+
 /*
  * Sets flags and switches the controller ops to enable the cxl kernel api.
  * Original the cxl kernel API operated on a virtual PHB, but certain cards
@@ -175,7 +192,6 @@ EXPORT_SYMBOL(pnv_cxl_ioda_msi_setup);
 int pnv_cxl_enable_phb_kernel_api(struct pci_controller *hose, bool enable)
 {
 	struct pnv_phb *phb = hose->private_data;
-	struct module *cxl_module;
 
 	if (!enable) {
 		/*
@@ -194,13 +210,7 @@ int pnv_cxl_enable_phb_kernel_api(struct pci_controller *hose, bool enable)
 	 * long as we are in this mode (and since we can't safely disable this
 	 * mode once enabled...).
 	 */
-	mutex_lock(&module_mutex);
-	cxl_module = find_module("cxl");
-	if (cxl_module)
-		__module_get(cxl_module);
-	mutex_unlock(&module_mutex);
-	if (!cxl_module)
-		return -ENODEV;
+	get_cxl_module();
 
 	phb->flags |= PNV_PHB_FLAG_CXL;
 	hose->controller_ops = pnv_cxl_cx4_ioda_controller_ops;
-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
