Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F5D61A072E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:49:21 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 6 Aug 2014 12:49:20 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E076D2CE8090
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 12:48:55 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s762nQr916711728
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:49:26 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s762ms3t004267
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 12:48:55 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/4] vfio: spapr: Fix build error
Date: Wed,  6 Aug 2014 12:48:31 +1000
Message-Id: <1407293313-24894-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1407293313-24894-1-git-send-email-aik@ozlabs.ru>
References: <1407293313-24894-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, kvm@vger.kernel.org
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
[removed include "pci.h" in vfio.c]
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v2:
* removed #include <linux/pci.h> from vfio.c and tested

---
 drivers/vfio/Makefile         | 4 ++--
 drivers/vfio/vfio_spapr_eeh.c | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

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
