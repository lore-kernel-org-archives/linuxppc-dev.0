Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D67EBDDE0D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 10:08:02 +1000 (EST)
Date: Thu, 7 May 2009 10:07:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
	<paulus@samba.org>
Subject: [PATCH] powerpc/iseries; fix pci breakage
Message-Id: <20090507100752.4fa4db7f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Becky Bruce <becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 4fc665b88a79a45bae8bbf3a05563c27c7337c3d "powerpc: Merge 32 and
64-bit dma code" made changes to the PCI initialisation code that added
an assignment to archdata.dma_data but only for 32 bit code.  Commit
7eef440a545c7f812ed10b49d4a10a351df9cad6 "powerpc/pci: Cosmetic cleanups
of pci-common.c" removed the conditional compilation.  Unfortunately,
the iSeries code setup the archdata.dma_data before that assignment was
done - effectively overwriting the dma_data with NULL.

Fix this up by moving the iSeries setup of dma_data into a
pci_dma_dev_setup callback.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/iseries/iommu.h |    4 ----
 arch/powerpc/platforms/iseries/iommu.c   |    6 +++++-
 arch/powerpc/platforms/iseries/pci.c     |    1 -
 3 files changed, 5 insertions(+), 6 deletions(-)

Built and booted iseries_defconfig with and without CONFIG_PCI.

This is a regression in v2.6.29 from v2.6.28, so I guess we need to send this to the stable team (backported if necessary) after it is upstream.

diff --git a/arch/powerpc/include/asm/iseries/iommu.h b/arch/powerpc/include/asm/iseries/iommu.h
index c59ee7e..1b9692c 100644
--- a/arch/powerpc/include/asm/iseries/iommu.h
+++ b/arch/powerpc/include/asm/iseries/iommu.h
@@ -26,10 +26,6 @@ struct vio_dev;
 struct device_node;
 struct iommu_table;
 
-/* Creates table for an individual device node */
-extern void iommu_devnode_init_iSeries(struct pci_dev *pdev,
-				       struct device_node *dn);
-
 /* Get table parameters from HV */
 extern void iommu_table_getparms_iSeries(unsigned long busno,
 		unsigned char slotno, unsigned char virtbus,
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index ff43f1f..4021982 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -174,9 +174,10 @@ static struct iommu_table *iommu_table_find(struct iommu_table * tbl)
 }
 
 
-void iommu_devnode_init_iSeries(struct pci_dev *pdev, struct device_node *dn)
+static void pci_dma_dev_setup_iseries(struct pci_dev *pdev)
 {
 	struct iommu_table *tbl;
+	struct device_node *dn = pdev->sysdata;
 	struct pci_dn *pdn = PCI_DN(dn);
 	const u32 *lsn = of_get_property(dn, "linux,logical-slot-number", NULL);
 
@@ -194,6 +195,8 @@ void iommu_devnode_init_iSeries(struct pci_dev *pdev, struct device_node *dn)
 		kfree(tbl);
 	pdev->dev.archdata.dma_data = pdn->iommu_table;
 }
+#else
+#define pci_dma_dev_setup_iseries	NULL
 #endif
 
 static struct iommu_table veth_iommu_table;
@@ -251,5 +254,6 @@ void iommu_init_early_iSeries(void)
 	ppc_md.tce_build = tce_build_iSeries;
 	ppc_md.tce_free  = tce_free_iSeries;
 
+	ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_iseries;
 	set_pci_dma_ops(&dma_iommu_ops);
 }
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 02a634f..21cddc3 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -444,7 +444,6 @@ void __init iSeries_pcibios_fixup_resources(struct pci_dev *pdev)
 	pdev->sysdata = node;
 	allocate_device_bars(pdev);
 	iseries_device_information(pdev, bus, *sub_bus);
-	iommu_devnode_init_iSeries(pdev, node);
 }
 
 /*
-- 
1.6.2.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
