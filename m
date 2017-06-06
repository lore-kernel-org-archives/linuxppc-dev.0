Return-Path: <mopsfelder@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whr8k25DszDqLy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 22:09:42 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id w1so22807701qtg.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 05:09:42 -0700 (PDT)
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Subject: [PATCH] include/linux/vfio.h: Guard powerpc-specific functions with
 CONFIG_VFIO_SPAPR_EEH
Date: Tue,  6 Jun 2017 09:09:14 -0300
Message-Id: <20170606120914.15851-1-mopsfelder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_EEH=y and CONFIG_VFIO_SPAPR_EEH=n, build fails with the
following:

    drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_release':
    vfio_pci.c:(.text+0xa98): undefined reference to `.vfio_spapr_pci_eeh_release'
    drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_open':
    vfio_pci.c:(.text+0x1420): undefined reference to `.vfio_spapr_pci_eeh_open'

In this case, vfio_pci.c should use the empty definitions of
vfio_spapr_pci_eeh_open and vfio_spapr_pci_eeh_release functions.

This patch fixes it by guarding these function definitions with
CONFIG_VFIO_SPAPR_EEH, the symbol that controls whether vfio_spapr_eeh.c is
built, which is where the non-empty versions of these functions are.

This issue was found during a randconfig build. Logs are here:

    http://kisskb.ellerman.id.au/kisskb/buildresult/12982362/

Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
---
 include/linux/vfio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index edf9b2c..0a05d57 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -150,7 +150,7 @@ extern int vfio_set_irqs_validate_and_prepare(struct vfio_irq_set *hdr,
 					      size_t *data_size);
 
 struct pci_dev;
-#ifdef CONFIG_EEH
+#ifdef CONFIG_VFIO_SPAPR_EEH
 extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
 extern void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
 extern long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
@@ -171,7 +171,7 @@ static inline long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 {
 	return -ENOTTY;
 }
-#endif /* CONFIG_EEH */
+#endif /* CONFIG_VFIO_SPAPR_EEH */
 
 /*
  * IRQfd - generic
-- 
2.9.4
