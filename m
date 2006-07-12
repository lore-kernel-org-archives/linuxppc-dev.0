Return-Path: <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
From: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH 03/16] [powerpc,iseries] Constify & voidify get_property()
Message-ID: <1152678686.20160.03@pokey>
Date: Wed, 12 Jul 2006 15:39:42 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_property() returns a void *, there's no need to cast its
return value. Also, treat the return value as const, so we can
constify get_property later.

iseries platform changes.

Built for iseries_defconfig

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
---

 resend: rebase after benh's IRQ changes

 iommu.c |    2 +-
 pci.c   |    9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/iseries/iommu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/iommu.c
+++ linux-2.6/arch/powerpc/platforms/iseries/iommu.c
@@ -162,7 +162,7 @@ void iommu_devnode_init_iSeries(struct d
 {
 	struct iommu_table *tbl;
 	struct pci_dn *pdn = PCI_DN(dn);
-	u32 *lsn = (u32 *)get_property(dn, "linux,logical-slot-number", NULL);
+	const u32 *lsn = get_property(dn, "linux,logical-slot-number", NULL);
 
 	BUG_ON(lsn == NULL);
 
Index: linux-2.6/arch/powerpc/platforms/iseries/pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/pci.c
+++ linux-2.6/arch/powerpc/platforms/iseries/pci.c
@@ -176,12 +176,12 @@ void iSeries_pcibios_init(void)
 	}
 	while ((node = of_get_next_child(root, node)) != NULL) {
 		HvBusNumber bus;
-		u32 *busp;
+		const u32 *busp;
 
 		if ((node->type == NULL) || (strcmp(node->type, "pci") != 0))
 			continue;
 
-		busp = (u32 *)get_property(node, "bus-range", NULL);
+		busp = get_property(node, "bus-range", NULL);
 		if (busp == NULL)
 			continue;
 		bus = *busp;
@@ -221,10 +221,9 @@ void __init iSeries_pci_final_fixup(void
 
 		if (node != NULL) {
 			struct pci_dn *pdn = PCI_DN(node);
-			u32 *agent;
+			const u32 *agent;
 
-			agent = (u32 *)get_property(node, "linux,agent-id",
-					NULL);
+			agent = get_property(node, "linux,agent-id", NULL);
 			if ((pdn != NULL) && (agent != NULL)) {
 				u8 irq = iSeries_allocate_IRQ(pdn->busno, 0,
 						pdn->bussubno);
