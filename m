Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id DC22867A5F
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:09:12 +1000 (EST)
Date: Fri, 19 May 2006 16:48:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 04/14] powerpc: remove iSeries_Global_Device_List
Message-Id: <20060519164847.47d64807.sfr@canb.auug.org.au>
In-Reply-To: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
References: <20060519164249.2dc43bc4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We can now scan the list of device nodes instead.  This also allows us
to remove the Device_list member of struct pci_dn.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/iommu.c |   15 +++++++++------
 arch/powerpc/platforms/iseries/pci.c   |   14 ++++++--------
 include/asm-powerpc/pci-bridge.h       |    1 -
 3 files changed, 15 insertions(+), 15 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

80052bf80f481996ffec6dddc8fab45bb36db0a3
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index 3ac2206..75a5a1e 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -32,13 +32,11 @@ #include <asm/iommu.h>
 #include <asm/tce.h>
 #include <asm/machdep.h>
 #include <asm/abs_addr.h>
+#include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #include <asm/iseries/hv_call_xm.h>
 #include <asm/iseries/iommu.h>
 
-extern struct list_head iSeries_Global_Device_List;
-
-
 static void tce_build_iSeries(struct iommu_table *tbl, long index, long npages,
 		unsigned long uaddr, enum dma_data_direction direction)
 {
@@ -140,10 +138,15 @@ #ifdef CONFIG_PCI
  */
 static struct iommu_table *iommu_table_find(struct iommu_table * tbl)
 {
-	struct pci_dn *pdn;
+	struct device_node *node;
+
+	for (node = NULL; (node = of_find_all_nodes(node)); ) {
+		struct pci_dn *pdn = PCI_DN(node);
+		struct iommu_table *it;
 
-	list_for_each_entry(pdn, &iSeries_Global_Device_List, Device_List) {
-		struct iommu_table *it = pdn->iommu_table;
+		if (pdn == NULL)
+			continue;
+		it = pdn->iommu_table;
 		if ((it != NULL) &&
 		    (it->it_type == TCE_PCI) &&
 		    (it->it_offset == tbl->it_offset) &&
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 9d571e7..5bc08d4 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -50,8 +50,6 @@ #include "call_pci.h"
  */
 static struct device_node *find_Device_Node(int bus, int devfn);
 
-LIST_HEAD(iSeries_Global_Device_List);
-
 static int Pci_Retry_Max = 3;	/* Only retry 3 times  */
 static int Pci_Error_Flag = 1;	/* Set Retry Error on. */
 
@@ -245,8 +243,6 @@ void iSeries_pcibios_init(void)
 			pdn->bussubno = *busp;
 			pdn->Irq = irq;
 			pdn->LogicalSlot = *lsn;
-			list_add_tail(&pdn->Device_List,
-					&iSeries_Global_Device_List);
 		}
 	}
 }
@@ -338,11 +334,13 @@ EXPORT_SYMBOL(iSeries_memcpy_fromio);
  */
 static struct device_node *find_Device_Node(int bus, int devfn)
 {
-	struct pci_dn *pdn;
+	struct device_node *node;
+
+	for (node = NULL; (node = of_find_all_nodes(node)); ) {
+		struct pci_dn *pdn = PCI_DN(node);
 
-	list_for_each_entry(pdn, &iSeries_Global_Device_List, Device_List) {
-		if ((bus == pdn->busno) && (devfn == pdn->devfn))
-			return pdn->node;
+		if (pdn && (bus == pdn->busno) && (devfn == pdn->devfn))
+			return node;
 	}
 	return NULL;
 }
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 38de92d..59794b4 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -79,7 +79,6 @@ #endif
 	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 	struct	device_node *node;	/* back-pointer to the device_node */
 #ifdef CONFIG_PPC_ISERIES
-	struct	list_head Device_List;
 	int	Irq;			/* Assigned IRQ */
 	int	Flags;			/* Possible flags(disable/bist)*/
 	u8	LogicalSlot;		/* Hv Slot Index for Tces */
-- 
1.3.1.ge923
