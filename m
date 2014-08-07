Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 359C41A087F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 12:47:31 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 7 Aug 2014 08:17:28 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B1750394001A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 08:17:25 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s772ll8H58196150
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 08:17:47 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s772lOAV016186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 08:17:25 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 4/5] drivers/vfio: Allow EEH to be built as module
Date: Thu,  7 Aug 2014 12:47:19 +1000
Message-Id: <1407379640-13065-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1407379640-13065-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1407379640-13065-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
