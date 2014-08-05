Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98F031A01F5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 22:30:03 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 5 Aug 2014 22:30:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 556D93578023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 22:29:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s75CUTHx11403428
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 22:30:31 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s75CTurS019983
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 22:29:57 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] vfio_spapr_eeh: Enable compile as a module
Date: Tue,  5 Aug 2014 22:29:44 +1000
Message-Id: <1407241785-30111-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1407241785-30111-1-git-send-email-aik@ozlabs.ru>
References: <1407241785-30111-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds necessary declarations to the module, otherwise multiple
dynamic linker errors happen:

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
---
 drivers/vfio/vfio_spapr_eeh.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
index 1a93e83..a942dd0 100644
--- a/drivers/vfio/vfio_spapr_eeh.c
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -9,10 +9,15 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/module.h>
 #include <linux/uaccess.h>
 #include <linux/vfio.h>
 #include <asm/eeh.h>
 
+#define DRIVER_VERSION  "0.1"
+#define DRIVER_AUTHOR   "Gavin Shan, IBM Corporation"
+#define DRIVER_DESC     "VFIO IOMMU SPAPR EEH"
+
 /* We might build address mapping here for "fast" path later */
 #ifdef CONFIG_EEH
 
@@ -91,3 +96,8 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 }
 EXPORT_SYMBOL_GPL(vfio_spapr_iommu_eeh_ioctl);
 #endif /* CONFIG_EEH */
+
+MODULE_VERSION(DRIVER_VERSION);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
-- 
2.0.0
