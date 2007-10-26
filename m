Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <cfdcdd2b4772cc1205e0efdabd69e0756d19f71f.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 12/16] Use of_get_next_child() in eeh_add_device_tree_early()
Date: Fri, 26 Oct 2007 16:54:44 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We should use of_get_next_child() in the eeh_add_device_tree_early()
routine to safely traverse the node's children.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/eeh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index abe3de1..d1d6d55 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -1120,7 +1120,7 @@ static void eeh_add_device_early(struct device_node *dn)
 void eeh_add_device_tree_early(struct device_node *dn)
 {
 	struct device_node *sib;
-	for (sib = dn->child; sib; sib = sib->sibling)
+	for (sib = NULL; (sib = of_get_next_child(dn, sib));)
 		eeh_add_device_tree_early(sib);
 	eeh_add_device_early(dn);
 }
-- 
1.5.2.rc1.1884.g59b20
