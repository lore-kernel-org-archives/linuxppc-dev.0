Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-x230.google.com (mail-pb0-x230.google.com
 [IPv6:2607:f8b0:400e:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2452B2C013F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 17:22:52 +1000 (EST)
Received: by mail-pb0-f48.google.com with SMTP id ma3so1840184pbc.35
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 00:22:50 -0700 (PDT)
From: aik@ozlabs.ru
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] powerpc/vfio: Enable on pSeries platform
Date: Mon,  6 May 2013 17:22:01 +1000
Message-Id: <51875a49.25ac440a.50d9.ffffe93e@mx.google.com>
In-Reply-To: <1367824921-27151-1-git-send-email-y>
References: <1367824921-27151-1-git-send-email-y>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The enables VFIO on the pSeries platform, enabling user space
programs to access PCI devices directly.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/platforms/pseries/iommu.c |    4 ++++
 drivers/iommu/Kconfig                  |    2 +-
 drivers/vfio/Kconfig                   |    2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index e2685ba..e178acc 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -613,6 +613,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 
 	iommu_table_setparms(pci->phb, dn, tbl);
 	pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
+	iommu_register_group(tbl, pci_domain_nr(bus), 0);
 
 	/* Divide the rest (1.75GB) among the children */
 	pci->phb->dma_window_size = 0x80000000ul;
@@ -657,6 +658,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 				   ppci->phb->node);
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
 		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
+		iommu_register_group(tbl, pci_domain_nr(bus), 0);
 		pr_debug("  created table: %p\n", ppci->iommu_table);
 	}
 }
@@ -683,6 +685,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 				   phb->node);
 		iommu_table_setparms(phb, dn, tbl);
 		PCI_DN(dn)->iommu_table = iommu_init_table(tbl, phb->node);
+		iommu_register_group(tbl, pci_domain_nr(phb->bus), 0);
 		set_iommu_table_base(&dev->dev, PCI_DN(dn)->iommu_table);
 		return;
 	}
@@ -1145,6 +1148,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 				   pci->phb->node);
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
 		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
+		iommu_register_group(tbl, pci_domain_nr(pci->phb->bus), 0);
 		pr_debug("  created table: %p\n", pci->iommu_table);
 	} else {
 		pr_debug("  found DMA window, table: %p\n", pci->iommu_table);
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 175e0f4..2d75ea0 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -189,7 +189,7 @@ config EXYNOS_IOMMU_DEBUG
 
 config SPAPR_TCE_IOMMU
 	bool "sPAPR TCE IOMMU Support"
-	depends on PPC_POWERNV
+	depends on PPC_POWERNV || PPC_PSERIES
 	select IOMMU_API
 	help
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index b464687..26b3d9d 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -12,7 +12,7 @@ menuconfig VFIO
 	tristate "VFIO Non-Privileged userspace driver framework"
 	depends on IOMMU_API
 	select VFIO_IOMMU_TYPE1 if X86
-	select VFIO_IOMMU_SPAPR_TCE if PPC_POWERNV
+	select VFIO_IOMMU_SPAPR_TCE if (PPC_POWERNV || PPC_PSERIES)
 	help
 	  VFIO provides a framework for secure userspace device drivers.
 	  See Documentation/vfio.txt for more details.
-- 
1.7.10.4
