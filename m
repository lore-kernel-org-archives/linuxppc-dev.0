Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <4e749fe7078e2c006cf40921cea904833c75263c.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 09/16] Use of_get_next_parent() in axon_msi.c
Date: Fri, 26 Oct 2007 16:54:41 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We can use of_get_next_parent() in two places in axon_msi.c to
simplify the looping logic.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/axon_msi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 095988f..76870fe 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -125,7 +125,7 @@ static struct axon_msic *find_msi_translator(struct pci_dev *dev)
 		return NULL;
 	}
 
-	for (; dn; tmp = of_get_parent(dn), of_node_put(dn), dn = tmp) {
+	for (; dn; dn = of_get_next_parent(dn)) {
 		ph = of_get_property(dn, "msi-translator", NULL);
 		if (ph)
 			break;
@@ -171,7 +171,7 @@ static int axon_msi_check_device(struct pci_dev *dev, int nvec, int type)
 
 static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 {
-	struct device_node *dn, *tmp;
+	struct device_node *dn;
 	struct msi_desc *entry;
 	int len;
 	const u32 *prop;
@@ -184,7 +184,7 @@ static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 
 	entry = list_first_entry(&dev->msi_list, struct msi_desc, list);
 
-	for (; dn; tmp = of_get_parent(dn), of_node_put(dn), dn = tmp) {
+	for (; dn; dn = of_get_next_parent(dn)) {
 		if (entry->msi_attrib.is_64) {
 			prop = of_get_property(dn, "msi-address-64", &len);
 			if (prop)
-- 
1.5.2.rc1.1884.g59b20
