Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ef7facd658919117aa7c693b4eeb12241ca859d8.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 11/16] Use of_get_next_child() in eeh_restore_bars()
Date: Fri, 26 Oct 2007 16:54:43 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We should use of_get_next_child() in the eeh_restore_bars()
routine to safely traverse the node's children.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/eeh.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 7309caa..abe3de1 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -841,11 +841,8 @@ void eeh_restore_bars(struct pci_dn *pdn)
 	if ((pdn->eeh_mode & EEH_MODE_SUPPORTED) && !IS_BRIDGE(pdn->class_code))
 		__restore_bars (pdn);
 
-	dn = pdn->node->child;
-	while (dn) {
+	for (dn = NULL; (dn = of_get_next_child(pdn->node, dn));)
 		eeh_restore_bars (PCI_DN(dn));
-		dn = dn->sibling;
-	}
 }
 
 /**
-- 
1.5.2.rc1.1884.g59b20
