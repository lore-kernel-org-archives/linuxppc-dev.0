Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <5da35481beab4acacf7c6de4985a659e0f39ea16.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 13/16] Use of_get_next_child() in __eeh_mark_slot()
Date: Fri, 26 Oct 2007 16:54:47 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We should use of_get_next_child() in __eeh_mark_slot() to safely
traverse the node's children.

To achieve this we need to change __eeh_mark_slot() to take the parent
node, not the child. This is also safer, as passing anything other than
node->child to the existing routine will not traverse all peers, only
those deeper in the sibling list.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/eeh.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index d1d6d55..d06ab36 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -373,9 +373,11 @@ struct device_node * find_device_pe(struct device_node *dn)
  *  an interrupt context, which is bad.
  */
 
-static void __eeh_mark_slot (struct device_node *dn, int mode_flag)
+static void __eeh_mark_slot(struct device_node *parent, int mode_flag)
 {
-	while (dn) {
+	struct device_node *dn;
+
+	for (dn = NULL; (dn = of_get_next_child(parent, dn));) {
 		if (PCI_DN(dn)) {
 			/* Mark the pci device driver too */
 			struct pci_dev *dev = PCI_DN(dn)->pcidev;
@@ -386,9 +388,8 @@ static void __eeh_mark_slot (struct device_node *dn, int mode_flag)
 				dev->error_state = pci_channel_io_frozen;
 
 			if (dn->child)
-				__eeh_mark_slot (dn->child, mode_flag);
+				__eeh_mark_slot(dn, mode_flag);
 		}
-		dn = dn->sibling;
 	}
 }
 
@@ -408,7 +409,7 @@ void eeh_mark_slot (struct device_node *dn, int mode_flag)
 	if (dev)
 		dev->error_state = pci_channel_io_frozen;
 
-	__eeh_mark_slot (dn->child, mode_flag);
+	__eeh_mark_slot(dn, mode_flag);
 }
 
 static void __eeh_clear_slot (struct device_node *dn, int mode_flag)
-- 
1.5.2.rc1.1884.g59b20
