Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 47AE367B83
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 17:09:42 +1000 (EST)
Date: Fri, 19 May 2006 16:51:57 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 06/14] powerpc: remove LogicalSlot from pci_dn
Message-Id: <20060519165157.2d636a98.sfr@canb.auug.org.au>
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

As we now store enough information in the device_node.

Also the Flags field was not used either, do remove that.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/powerpc/platforms/iseries/iommu.c |    5 ++++-
 arch/powerpc/platforms/iseries/pci.c   |    8 --------
 include/asm-powerpc/pci-bridge.h       |    4 ----
 3 files changed, 4 insertions(+), 13 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

bf52061e7db75eb167e5f7749d706614de5bcc81
diff --git a/arch/powerpc/platforms/iseries/iommu.c b/arch/powerpc/platforms/iseries/iommu.c
index 75a5a1e..a992f6a 100644
--- a/arch/powerpc/platforms/iseries/iommu.c
+++ b/arch/powerpc/platforms/iseries/iommu.c
@@ -162,10 +162,13 @@ void iommu_devnode_init_iSeries(struct d
 {
 	struct iommu_table *tbl;
 	struct pci_dn *pdn = PCI_DN(dn);
+	u32 *lsn = (u32 *)get_property(dn, "linux,logical-slot-number", NULL);
+
+	BUG_ON(lsn == NULL);
 
 	tbl = kmalloc(sizeof(struct iommu_table), GFP_KERNEL);
 
-	iommu_table_getparms_iSeries(pdn->busno, pdn->LogicalSlot, 0, tbl);
+	iommu_table_getparms_iSeries(pdn->busno, *lsn, 0, tbl);
 
 	/* Look for existing tce table */
 	pdn->iommu_table = iommu_table_find(tbl);
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index edaafbb..86a8698 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -191,7 +191,6 @@ void iSeries_pcibios_init(void)
 		for (dn = NULL; (dn = of_get_next_child(node, dn)) != NULL;) {
 			struct pci_dn *pdn;
 			u32 *reg;
-			u32 *lsn;
 
 			reg = (u32 *)get_property(dn, "reg", NULL);
 			if (reg == NULL) {
@@ -203,12 +202,6 @@ void iSeries_pcibios_init(void)
 				printk(KERN_DEBUG "no subbus property!\n");
 				continue;
 			}
-			lsn = (u32 *)get_property(dn,
-					"linux,logical-slot-number", NULL);
-			if (lsn == NULL) {
-				printk(KERN_DEBUG "no logical-slot-number\n");
-				continue;
-			}
 
 			pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
 			if (pdn == NULL)
@@ -218,7 +211,6 @@ void iSeries_pcibios_init(void)
 			pdn->busno = bus;
 			pdn->devfn = (reg[0] >> 8) & 0xff;
 			pdn->bussubno = *busp;
-			pdn->LogicalSlot = *lsn;
 		}
 	}
 }
diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
index 09079e4..84a3075 100644
--- a/include/asm-powerpc/pci-bridge.h
+++ b/include/asm-powerpc/pci-bridge.h
@@ -78,10 +78,6 @@ #endif
 	struct	iommu_table *iommu_table;	/* for phb's or bridges */
 	struct	pci_dev *pcidev;	/* back-pointer to the pci device */
 	struct	device_node *node;	/* back-pointer to the device_node */
-#ifdef CONFIG_PPC_ISERIES
-	int	Flags;			/* Possible flags(disable/bist)*/
-	u8	LogicalSlot;		/* Hv Slot Index for Tces */
-#endif
 	u32	config_space[16];	/* saved PCI config space */
 };
 
-- 
1.3.1.ge923
