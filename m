Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9709F1A01F2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 22:30:02 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 5 Aug 2014 22:30:00 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D74862BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Aug 2014 22:29:56 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s75CCj4Y62521372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 22:12:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s75CTuSc008677
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Aug 2014 22:29:56 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/4] vfio: spapr: Fix build error
Date: Tue,  5 Aug 2014 22:29:43 +1000
Message-Id: <1407241785-30111-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1407241785-30111-1-git-send-email-aik@ozlabs.ru>
References: <1407241785-30111-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gavin Shan <gwshan@linux.vnet.ibm.com>

The VFIO related components could be built as dynamic modules.
Unfortunately, CONFIG_EEH can't be configured to "m". The patch
fixes the build errors when configuring VFIO related components
as dynamic modules as follows:

  CC [M]  drivers/vfio/vfio_iommu_spapr_tce.o
In file included from drivers/vfio/vfio.c:33:0:
include/linux/vfio.h:101:43: warning: ‘struct pci_dev’ declared \
inside parameter list [enabled by default]
:
  WRAP    arch/powerpc/boot/zImage.pseries
  WRAP    arch/powerpc/boot/zImage.maple
  WRAP    arch/powerpc/boot/zImage.pmac
  WRAP    arch/powerpc/boot/zImage.epapr
  MODPOST 1818 modules
ERROR: ".vfio_spapr_iommu_eeh_ioctl" [drivers/vfio/vfio_iommu_spapr_tce.ko]\
undefined!
ERROR: ".vfio_spapr_pci_eeh_open" [drivers/vfio/pci/vfio-pci.ko] undefined!
ERROR: ".vfio_spapr_pci_eeh_release" [drivers/vfio/pci/vfio-pci.ko] undefined!

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/vfio/Makefile         | 4 ++--
 drivers/vfio/vfio.c           | 1 +
 drivers/vfio/vfio_spapr_eeh.c | 6 ++++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
index 50e30bc..4891cca 100644
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_VFIO) += vfio.o
 obj-$(CONFIG_VFIO_IOMMU_TYPE1) += vfio_iommu_type1.o
-obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o
-obj-$(CONFIG_EEH) += vfio_spapr_eeh.o
+obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) += vfio_iommu_spapr_tce.o \
+				      vfio_spapr_eeh.o
 obj-$(CONFIG_VFIO_PCI) += pci/
diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index f018d8d..b4118e0 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -25,6 +25,7 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pci.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
index f834b4c..1a93e83 100644
--- a/drivers/vfio/vfio_spapr_eeh.c
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -14,15 +14,19 @@
 #include <asm/eeh.h>
 
 /* We might build address mapping here for "fast" path later */
+#ifdef CONFIG_EEH
+
 int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
 {
 	return eeh_dev_open(pdev);
 }
+EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_open);
 
 void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
 {
 	eeh_dev_release(pdev);
 }
+EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_release);
 
 long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 				unsigned int cmd, unsigned long arg)
@@ -85,3 +89,5 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(vfio_spapr_iommu_eeh_ioctl);
+#endif /* CONFIG_EEH */
-- 
2.0.0
