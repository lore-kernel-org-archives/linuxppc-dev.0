Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <0e6e00addf4fe520c9287b926d4b82680f53cf8d.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 16/16] Use of_get_next_child() in EEH print_device_node_tree()
Date: Fri, 26 Oct 2007 16:54:50 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We should use of_get_next_child() in print_device_node_tree() to safely
traverse the node's children.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/eeh_driver.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index abf1850..0a23bc4 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -44,6 +44,7 @@ static inline const char * pcid_name (struct pci_dev *pdev)
 #ifdef DEBUG
 static void print_device_node_tree (struct pci_dn *pdn, int dent)
 {
+	struct device_node *pc;
 	int i;
 	if (!pdn) return;
 	for (i=0;i<dent; i++)
@@ -52,11 +53,8 @@ static void print_device_node_tree (struct pci_dn *pdn, int dent)
 		pdn->node->name, pdn->eeh_mode, pdn->eeh_config_addr,
 		pdn->eeh_pe_config_addr, pdn->node->full_name);
 	dent += 3;
-	struct device_node *pc = pdn->node->child;
-	while (pc) {
+	for (pc = NULL; (pc = of_get_next_child(pdn->node, pc));)
 		print_device_node_tree(PCI_DN(pc), dent);
-		pc = pc->sibling;
-	}
 }
 #endif
 
-- 
1.5.2.rc1.1884.g59b20
