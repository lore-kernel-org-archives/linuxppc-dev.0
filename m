Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0CC5EDDDEF
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 13:40:48 +1100 (EST)
Date: Thu, 6 Dec 2007 13:39:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 1/2] [POWERPC] iommu_free_table doesn't need the device_node
Message-Id: <20071206133919.9c609f17.sfr@canb.auug.org.au>
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

It only needs the iommu_table address.  It also makes use of the node
name to print error messages.  So just pass it the things it needs.
This reduces the places that know about the pci_dn by one.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/iommu.c            |    8 +++-----
 arch/powerpc/platforms/pseries/iommu.c |    2 +-
 include/asm-powerpc/iommu.h            |    3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 2d0c9ef..47c3fe5 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -526,16 +526,14 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 	return tbl;
 }
 
-void iommu_free_table(struct device_node *dn)
+void iommu_free_table(struct iommu_table *tbl, const char *node_name)
 {
-	struct pci_dn *pdn = dn->data;
-	struct iommu_table *tbl = pdn->iommu_table;
 	unsigned long bitmap_sz, i;
 	unsigned int order;
 
 	if (!tbl || !tbl->it_map) {
 		printk(KERN_ERR "%s: expected TCE map for %s\n", __FUNCTION__,
-				dn->full_name);
+				node_name);
 		return;
 	}
 
@@ -544,7 +542,7 @@ void iommu_free_table(struct device_node *dn)
 	for (i = 0; i < (tbl->it_size/64); i++) {
 		if (tbl->it_map[i] != 0) {
 			printk(KERN_WARNING "%s: Unexpected TCEs for %s\n",
-				__FUNCTION__, dn->full_name);
+				__FUNCTION__, node_name);
 			break;
 		}
 	}
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index be17d23..d4e9d85 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -556,7 +556,7 @@ static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long acti
 	case PSERIES_RECONFIG_REMOVE:
 		if (pci && pci->iommu_table &&
 		    of_get_property(np, "ibm,dma-window", NULL))
-			iommu_free_table(np);
+			iommu_free_table(pci->iommu_table, np->full_name);
 		break;
 	default:
 		err = NOTIFY_DONE;
diff --git a/include/asm-powerpc/iommu.h b/include/asm-powerpc/iommu.h
index 4a82fdc..7a3cef7 100644
--- a/include/asm-powerpc/iommu.h
+++ b/include/asm-powerpc/iommu.h
@@ -69,10 +69,9 @@ struct iommu_table {
 };
 
 struct scatterlist;
-struct device_node;
 
 /* Frees table for an individual device node */
-extern void iommu_free_table(struct device_node *dn);
+extern void iommu_free_table(struct iommu_table *tbl, const char *node_name);
 
 /* Initializes an iommu_table based in values set in the passed-in
  * structure
-- 
1.5.3.7
