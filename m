Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 137C51A08E3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 12:47:36 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 7 Aug 2014 12:47:30 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 435672CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 12:47:28 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s772UDqU42074336
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 12:30:14 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s772lRkf021818
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Aug 2014 12:47:27 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 3/5] drivers/vfio: Fix EEH build error
Date: Thu,  7 Aug 2014 12:47:18 +1000
Message-Id: <1407379640-13065-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1407379640-13065-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1407379640-13065-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The VFIO related components could be built as dynamic modules.
Unfortunately, CONFIG_EEH can't be configured to "m". The patch
fixes the build errors when configuring VFIO related components
as dynamic modules as follows:

  CC [M]  drivers/vfio/vfio_iommu_spapr_tce.o
In file included from drivers/vfio/vfio.c:33:0:
include/linux/vfio.h:101:43: warning: =E2=80=98struct pci_dev=E2=80=99 de=
clared \
inside parameter list [enabled by default]
   :
  WRAP    arch/powerpc/boot/zImage.pseries
  WRAP    arch/powerpc/boot/zImage.maple
  WRAP    arch/powerpc/boot/zImage.pmac
  WRAP    arch/powerpc/boot/zImage.epapr
  MODPOST 1818 modules
ERROR: ".vfio_spapr_iommu_eeh_ioctl" [drivers/vfio/vfio_iommu_spapr_tce.k=
o]\
undefined!
ERROR: ".vfio_spapr_pci_eeh_open" [drivers/vfio/pci/vfio-pci.ko] undefine=
d!
ERROR: ".vfio_spapr_pci_eeh_release" [drivers/vfio/pci/vfio-pci.ko] undef=
ined!

Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
v3: Introduce CONFIG_VFIO_SPAPR_EEH and add "struct pci_dev" in vfio.h
v2: remove #include <linux/pci.h> from vfio.c
---
 drivers/vfio/Kconfig          | 6 ++++++
 drivers/vfio/Makefile         | 2 +-
 drivers/vfio/vfio_spapr_eeh.c | 3 +++
 include/linux/vfio.h          | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index af7b204..d8c5763 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -8,11 +8,17 @@ config VFIO_IOMMU_SPAPR_TCE
 	depends on VFIO && SPAPR_TCE_IOMMU
 	default n
=20
+config VFIO_SPAPR_EEH
+	tristate
+	depends on EEH && VFIO_IOMMU_SPAPR_TCE
+	default n
+
 menuconfig VFIO
 	tristate "VFIO Non-Privileged userspace driver framework"
 	depends on IOMMU_API
 	select VFIO_IOMMU_TYPE1 if X86
 	select VFIO_IOMMU_SPAPR_TCE if (PPC_POWERNV || PPC_PSERIES)
+	select VFIO_SPAPR_EEH if (PPC_POWERNV || PPC_PSERIES)
 	select ANON_INODES
 	help
 	  VFIO provides a framework for secure userspace device drivers.
diff --git a/drivers/vfio/Makefile b/drivers/vfio/Makefile
index 50e30bc..0b035b1 100644
--- a/drivers/vfio/Makefile
+++ b/drivers/vfio/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_VFIO) +=3D vfio.o
 obj-$(CONFIG_VFIO_IOMMU_TYPE1) +=3D vfio_iommu_type1.o
 obj-$(CONFIG_VFIO_IOMMU_SPAPR_TCE) +=3D vfio_iommu_spapr_tce.o
-obj-$(CONFIG_EEH) +=3D vfio_spapr_eeh.o
+obj-$(CONFIG_VFIO_SPAPR_EEH) +=3D vfio_spapr_eeh.o
 obj-$(CONFIG_VFIO_PCI) +=3D pci/
diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.=
c
index f834b4c..949f98e 100644
--- a/drivers/vfio/vfio_spapr_eeh.c
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -18,11 +18,13 @@ int vfio_spapr_pci_eeh_open(struct pci_dev *pdev)
 {
 	return eeh_dev_open(pdev);
 }
+EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_open);
=20
 void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
 {
 	eeh_dev_release(pdev);
 }
+EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_release);
=20
 long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 				unsigned int cmd, unsigned long arg)
@@ -85,3 +87,4 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *gro=
up,
=20
 	return ret;
 }
+EXPORT_SYMBOL(vfio_spapr_iommu_eeh_ioctl);
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 25a0fbd..224128a 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -98,6 +98,7 @@ extern int vfio_external_user_iommu_id(struct vfio_grou=
p *group);
 extern long vfio_external_check_extension(struct vfio_group *group,
 					  unsigned long arg);
=20
+struct pci_dev;
 #ifdef CONFIG_EEH
 extern int vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
 extern void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
--=20
1.8.3.2
