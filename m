Return-Path: <nacc@us.ibm.com>
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 05/11] ppc: do not search for dma-window property on dlpar
	remove
Date: Fri,  8 Oct 2010 10:33:06 -0700
Message-Id: <1286559192-10898-6-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
References: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	miltonm@bga.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The iommu_table pointer in the pci auxiliary struct of device_node has
not been used by the iommu ops since the dma refactor of
12d04eef927bf61328af2c7cbe756c96f98ac3bf, however this code still uses
it to find tables for dlpar. By only setting the PCI_DN iommu_table
pointer on nodes with dma window properties, we will be able to quickly
find the node for later checks, and can remove the table without looking
for the the dma window property on dlpar remove.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9184db3..8ab32da 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -455,9 +455,6 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
 		pr_debug("  created table: %p\n", ppci->iommu_table);
 	}
-
-	if (pdn != dn)
-		PCI_DN(dn)->iommu_table = ppci->iommu_table;
 }
 
 
@@ -571,8 +568,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 
 	switch (action) {
 	case PSERIES_RECONFIG_REMOVE:
-		if (pci && pci->iommu_table &&
-		    of_get_property(np, "ibm,dma-window", NULL))
+		if (pci && pci->iommu_table)
 			iommu_free_table(pci->iommu_table, np->full_name);
 		break;
 	default:
-- 
1.7.1
