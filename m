Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <caa14cc9fec7d3c363b79a8f5f9d892a56f27bdd.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 14/16] Use of_get_next_child() in __eeh_clear_slot()
Date: Fri, 26 Oct 2007 16:54:48 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We should use of_get_next_child() in __eeh_clear_slot() to safely
traverse the node's children.

To achieve this we need to change __eeh_clear_slot() to take the parent
node, not the child. This is also safer, as passing anything other than
node->child to the existing routine will not traverse all peers, only
those deeper in the sibling list.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/eeh.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index d06ab36..1537597 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -412,16 +412,17 @@ void eeh_mark_slot (struct device_node *dn, int mode_flag)
 	__eeh_mark_slot(dn, mode_flag);
 }
 
-static void __eeh_clear_slot (struct device_node *dn, int mode_flag)
+static void __eeh_clear_slot(struct device_node *parent, int mode_flag)
 {
-	while (dn) {
+	struct device_node *dn;
+
+	for (dn = NULL; (dn = of_get_next_child(parent, dn));) {
 		if (PCI_DN(dn)) {
 			PCI_DN(dn)->eeh_mode &= ~mode_flag;
 			PCI_DN(dn)->eeh_check_count = 0;
 			if (dn->child)
-				__eeh_clear_slot (dn->child, mode_flag);
+				__eeh_clear_slot(dn, mode_flag);
 		}
-		dn = dn->sibling;
 	}
 }
 
@@ -438,7 +439,7 @@ void eeh_clear_slot (struct device_node *dn, int mode_flag)
 
 	PCI_DN(dn)->eeh_mode &= ~mode_flag;
 	PCI_DN(dn)->eeh_check_count = 0;
-	__eeh_clear_slot (dn->child, mode_flag);
+	__eeh_clear_slot(dn, mode_flag);
 	spin_unlock_irqrestore(&confirm_error_lock, flags);
 }
 
-- 
1.5.2.rc1.1884.g59b20
