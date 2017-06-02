Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfJz05s8yzDqLy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 19:37:32 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v529Xogn043284
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Jun 2017 05:37:25 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2au1bntyf0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 05:37:24 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Fri, 2 Jun 2017 19:37:19 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v529b8jL2752784
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Jun 2017 19:37:16 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v529aiob022021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Jun 2017 19:36:44 +1000
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>, stable@vger.kernel.org
Subject: [RESEND-PATCH] cxl: Avoid double free_irq() for psl,slice interrupts
Date: Fri,  2 Jun 2017 15:05:55 +0530
Message-Id: <20170602093555.9205-1-vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During an eeh call to cxl_remove can result in double free_irq of
psl,slice interrupts. This can happen if perst_reloads_same_image == 1
and call to cxl_configure_adapter() fails during slot_reset
callback. In such a case we see a kernel oops with following back-trace:

Oops: Kernel access of bad area, sig: 11 [#1]
Call Trace:
  free_irq+0x88/0xd0 (unreliable)
  cxl_unmap_irq+0x20/0x40 [cxl]
  cxl_native_release_psl_irq+0x78/0xd8 [cxl]
  pci_deconfigure_afu+0xac/0x110 [cxl]
  cxl_remove+0x104/0x210 [cxl]
  pci_device_remove+0x6c/0x110
  device_release_driver_internal+0x204/0x2e0
  pci_stop_bus_device+0xa0/0xd0
  pci_stop_and_remove_bus_device+0x28/0x40
  pci_hp_remove_devices+0xb0/0x150
  pci_hp_remove_devices+0x68/0x150
  eeh_handle_normal_event+0x140/0x580
  eeh_handle_event+0x174/0x360
  eeh_event_handler+0x1e8/0x1f0

This patch fixes the issue of double free_irq by checking that
variables that hold the virqs (err_hwirq, serr_hwirq, psl_virq) are
not '0' before un-mapping and resetting these variables to '0' when
they are un-mapped.

Cc: stable@vger.kernel.org
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---
Re-send:
- Added stable to recipients
---
 drivers/misc/cxl/native.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 871a2f0..3ed2254 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -1302,13 +1302,16 @@ int cxl_native_register_psl_err_irq(struct cxl *adapter)
 
 void cxl_native_release_psl_err_irq(struct cxl *adapter)
 {
-	if (adapter->native->err_virq != irq_find_mapping(NULL, adapter->native->err_hwirq))
+	if (adapter->native->err_virq == 0 ||
+	    adapter->native->err_virq !=
+	    irq_find_mapping(NULL, adapter->native->err_hwirq))
 		return;
 
 	cxl_p1_write(adapter, CXL_PSL_ErrIVTE, 0x0000000000000000);
 	cxl_unmap_irq(adapter->native->err_virq, adapter);
 	cxl_ops->release_one_irq(adapter, adapter->native->err_hwirq);
 	kfree(adapter->irq_name);
+	adapter->native->err_virq = 0;
 }
 
 int cxl_native_register_serr_irq(struct cxl_afu *afu)
@@ -1346,13 +1349,15 @@ int cxl_native_register_serr_irq(struct cxl_afu *afu)
 
 void cxl_native_release_serr_irq(struct cxl_afu *afu)
 {
-	if (afu->serr_virq != irq_find_mapping(NULL, afu->serr_hwirq))
+	if (afu->serr_virq == 0 ||
+	    afu->serr_virq != irq_find_mapping(NULL, afu->serr_hwirq))
 		return;
 
 	cxl_p1n_write(afu, CXL_PSL_SERR_An, 0x0000000000000000);
 	cxl_unmap_irq(afu->serr_virq, afu);
 	cxl_ops->release_one_irq(afu->adapter, afu->serr_hwirq);
 	kfree(afu->err_irq_name);
+	afu->serr_virq = 0;
 }
 
 int cxl_native_register_psl_irq(struct cxl_afu *afu)
@@ -1375,12 +1380,15 @@ int cxl_native_register_psl_irq(struct cxl_afu *afu)
 
 void cxl_native_release_psl_irq(struct cxl_afu *afu)
 {
-	if (afu->native->psl_virq != irq_find_mapping(NULL, afu->native->psl_hwirq))
+	if (afu->native->psl_virq == 0 ||
+	    afu->native->psl_virq !=
+	    irq_find_mapping(NULL, afu->native->psl_virq))
 		return;
 
 	cxl_unmap_irq(afu->native->psl_virq, afu);
 	cxl_ops->release_one_irq(afu->adapter, afu->native->psl_hwirq);
 	kfree(afu->psl_irq_name);
+	afu->native->psl_virq = 0;
 }
 
 static void recover_psl_err(struct cxl_afu *afu, u64 errstat)
-- 
2.9.4
