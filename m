Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t99r51h2BzDvQ2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 16:48:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: alex.williamson@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 aik@ozlabs.ru, gwshan@linux.vnet.ibm.com
Subject: [PATCH] vfio: Fix build break when SPAPR_TCE_IOMMU=n
Date: Fri,  4 Nov 2016 16:48:41 +1100
Message-Id: <1478238521-32203-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the kconfig logic for VFIO_IOMMU_SPAPR_TCE and VFIO_SPAPR_EEH
is broken when SPAPR_TCE_IOMMU=n. Leading to:

    warning: (VFIO) selects VFIO_IOMMU_SPAPR_TCE which has unmet direct dependencies (VFIO && SPAPR_TCE_IOMMU)
    warning: (VFIO) selects VFIO_IOMMU_SPAPR_TCE which has unmet direct dependencies (VFIO && SPAPR_TCE_IOMMU)
    drivers/vfio/vfio_iommu_spapr_tce.c:113:8: error: implicit declaration of function 'mm_iommu_find'

This stems from the fact that VFIO selects VFIO_IOMMU_SPAPR_TCE, and
although it has an if clause, the condition is not correct.

We could fix it by doing select VFIO_IOMMU_SPAPR_TCE if SPAPR_TCE_IOMMU,
but the cleaner fix is to drop the selects and tie VFIO_IOMMU_SPAPR_TCE
to the value of VFIO, and express the dependencies in only once place.

Do the same for VFIO_SPAPR_EEH.

The end result is that the values of VFIO_IOMMU_SPAPR_TCE and
VFIO_SPAPR_EEH follow the value of VFIO, except when SPAPR_TCE_IOMMU=n
and/or EEH=n. Which is exactly what we want to happen.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/vfio/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index da6e2ce77495..6b51a4ebed8a 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -6,12 +6,12 @@ config VFIO_IOMMU_TYPE1
 config VFIO_IOMMU_SPAPR_TCE
 	tristate
 	depends on VFIO && SPAPR_TCE_IOMMU
-	default n
+	default VFIO
 
 config VFIO_SPAPR_EEH
 	tristate
 	depends on EEH && VFIO_IOMMU_SPAPR_TCE
-	default n
+	default VFIO
 
 config VFIO_VIRQFD
 	tristate
@@ -22,8 +22,6 @@ menuconfig VFIO
 	tristate "VFIO Non-Privileged userspace driver framework"
 	depends on IOMMU_API
 	select VFIO_IOMMU_TYPE1 if (X86 || S390 || ARM_SMMU || ARM_SMMU_V3)
-	select VFIO_IOMMU_SPAPR_TCE if (PPC_POWERNV || PPC_PSERIES)
-	select VFIO_SPAPR_EEH if (PPC_POWERNV || PPC_PSERIES)
 	select ANON_INODES
 	help
 	  VFIO provides a framework for secure userspace device drivers.
-- 
2.7.4
