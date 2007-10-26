Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <296ceb5ddb01c4e93735c6baa32d38a9ae4c39d9.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 15/16] Use of_get_next_child() in eeh_reset_device()
Date: Fri, 26 Oct 2007 16:54:49 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We should use of_get_next_child() in eeh_reset_device() to safely
traverse the node's children.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

---

Linas, I don't grok the logic in here, can you check it's OK. The old code
would potentially not walk through all siblings if pe_dn->node was not
equal to pe_dn->node->parent->child, but now it will regardless.


 arch/powerpc/platforms/pseries/eeh_driver.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 15e015e..abf1850 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -249,7 +249,7 @@ static void eeh_report_failure(struct pci_dev *dev, void *userdata)
 
 static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
 {
-	struct device_node *dn;
+	struct device_node *dn, *parent;
 	int cnt, rc;
 
 	/* pcibios will clear the counter; save the value */
@@ -270,15 +270,16 @@ static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
 	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
 		dn = dn->parent->child;
 
-	while (dn) {
+	parent = of_node_get(dn->parent);
+	for (dn = NULL; (dn = of_get_next_child(parent, dn));) {
 		struct pci_dn *ppe = PCI_DN(dn);
 		/* On Power4, always true because eeh_pe_config_addr=0 */
 		if (pe_dn->eeh_pe_config_addr == ppe->eeh_pe_config_addr) {
 			rtas_configure_bridge(ppe);
 			eeh_restore_bars(ppe);
  		}
-		dn = dn->sibling;
 	}
+	of_node_put(parent);
 
 	/* Give the system 5 seconds to finish running the user-space
 	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes, 
-- 
1.5.2.rc1.1884.g59b20
