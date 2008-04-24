Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <65e06a1e9229c240334b1603bc999f613eb52b74.1209002921.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Use of_get_next_parent() in platforms/cell/axon_msi.c
Date: Thu, 24 Apr 2008 12:08:54 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Replace two open-coded occurences of the of_get_next_parent() logic.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

The function touched by the first chunk still needs the tmp variable.


 arch/powerpc/platforms/cell/axon_msi.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index d95e71d..c39f5c2 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -123,7 +123,7 @@ static struct axon_msic *find_msi_translator(struct pci_dev *dev)
 		return NULL;
 	}
 
-	for (; dn; tmp = of_get_parent(dn), of_node_put(dn), dn = tmp) {
+	for (; dn; dn = of_get_next_parent(dn)) {
 		ph = of_get_property(dn, "msi-translator", NULL);
 		if (ph)
 			break;
@@ -169,7 +169,7 @@ static int axon_msi_check_device(struct pci_dev *dev, int nvec, int type)
 
 static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 {
-	struct device_node *dn, *tmp;
+	struct device_node *dn;
 	struct msi_desc *entry;
 	int len;
 	const u32 *prop;
@@ -182,7 +182,7 @@ static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
 
 	entry = list_first_entry(&dev->msi_list, struct msi_desc, list);
 
-	for (; dn; tmp = of_get_parent(dn), of_node_put(dn), dn = tmp) {
+	for (; dn; dn = of_get_next_parent(dn)) {
 		if (entry->msi_attrib.is_64) {
 			prop = of_get_property(dn, "msi-address-64", &len);
 			if (prop)
-- 
1.5.5
