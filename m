Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B2E61A007B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 19:49:15 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 6 Aug 2014 19:49:14 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5FC2F3578023
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 19:49:10 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s769njFM15270014
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 19:49:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s769n9wl025233
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 19:49:10 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 3/4] drivers/vfio: Allow EEH to be built as module
Date: Wed,  6 Aug 2014 19:49:04 +1000
Message-Id: <1407318545-17554-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1407318545-17554-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1407318545-17554-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This adds necessary declarations to the SPAPR VFIO EEH module,
otherwise multiple dynamic linker errors reported:

vfio_spapr_eeh: Unknown symbol eeh_pe_set_option (err 0)
vfio_spapr_eeh: Unknown symbol eeh_pe_configure (err 0)
vfio_spapr_eeh: Unknown symbol eeh_pe_reset (err 0)
vfio_spapr_eeh: Unknown symbol eeh_pe_get_state (err 0)
vfio_spapr_eeh: Unknown symbol eeh_iommu_group_to_pe (err 0)
vfio_spapr_eeh: Unknown symbol eeh_dev_open (err 0)
vfio_spapr_eeh: Unknown symbol eeh_pe_set_option (err 0)
vfio_spapr_eeh: Unknown symbol eeh_pe_configure (err 0)
vfio_spapr_eeh: Unknown symbol eeh_pe_reset (err 0)
vfio_spapr_eeh: Unknown symbol eeh_pe_get_state (err 0)
vfio_spapr_eeh: Unknown symbol eeh_iommu_group_to_pe (err 0)
vfio_spapr_eeh: Unknown symbol eeh_dev_open (err 0)

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/vfio/vfio_spapr_eeh.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
index 949f98e..4779cac 100644
--- a/drivers/vfio/vfio_spapr_eeh.c
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -9,10 +9,15 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <asm/eeh.h>
 
+#define DRIVER_VERSION	"0.1"
+#define DRIVER_AUTHOR	"Gavin Shan, IBM Corporation"
+#define DRIVER_DESC	"VFIO IOMMU SPAPR EEH"
+
 /* We might build address mapping here for "fast" path later */
 int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
 {
@@ -88,3 +93,8 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 	return ret;
 }
 EXPORT_SYMBOL(vfio_spapr_iommu_eeh_ioctl);
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
-- 
1.8.3.2
