Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rtkcx4xkYzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 12:33:53 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6J2XXhS045777
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 22:33:50 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2495r80r5e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 22:33:50 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Tue, 19 Jul 2016 12:33:47 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2A8632BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 12:33:45 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6J2Xj9q21692662
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 12:33:45 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6J2Xi86017769
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jul 2016 12:33:44 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH v2] powerpc/powernv: fix pci-cxl.c build when CONFIG_MODULES=n
Date: Tue, 19 Jul 2016 12:33:35 +1000
In-Reply-To: <1468828399-30151-1-git-send-email-andrew.donnellan@au1.ibm.com>
References: <1468828399-30151-1-git-send-email-andrew.donnellan@au1.ibm.com>
Message-Id: <1468895615-4855-1-git-send-email-imunsie@au.ibm.com>
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

Changes since v1:
	- Actually tested now our systems are back online
	- Passed error code back to caller
	- Fixed IS_MODULE(cxl) to IS_MODULE(CONFIG_CXL)
	- Face was introduced to palm, several times
---
 arch/powerpc/platforms/powernv/pci-cxl.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
index 3f34207..2d67be0 100644
--- a/arch/powerpc/platforms/powernv/pci-cxl.c
+++ b/arch/powerpc/platforms/powernv/pci-cxl.c
@@ -166,6 +166,24 @@ int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
 }
 EXPORT_SYMBOL(pnv_cxl_ioda_msi_setup);
 
+#if IS_MODULE(CONFIG_CXL)
+static inline int get_cxl_module(void)
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
+       return 0;
+}
+#else
+static inline int get_cxl_module(void) { return 0; }
+#endif
+
 /*
  * Sets flags and switches the controller ops to enable the cxl kernel api.
  * Originally the cxl kernel API operated on a virtual PHB, but certain cards
@@ -175,7 +193,7 @@ EXPORT_SYMBOL(pnv_cxl_ioda_msi_setup);
 int pnv_cxl_enable_phb_kernel_api(struct pci_controller *hose, bool enable)
 {
 	struct pnv_phb *phb = hose->private_data;
-	struct module *cxl_module;
+	int rc;
 
 	if (!enable) {
 		/*
@@ -194,13 +212,9 @@ int pnv_cxl_enable_phb_kernel_api(struct pci_controller *hose, bool enable)
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
+	rc = get_cxl_module();
+	if (rc)
+		return rc;
 
 	phb->flags |= PNV_PHB_FLAG_CXL;
 	hose->controller_ops = pnv_cxl_cx4_ioda_controller_ops;
-- 
2.8.1
