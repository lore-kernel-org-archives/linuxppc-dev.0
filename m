Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a6ca58c7274076dac07168740766d74a66df2e64.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 10/16] Use of_get_next_child() in EEH gather_pci_data()
Date: Fri, 26 Oct 2007 16:54:42 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We should use of_get_next_child() in the EEH gather_pci_data()
routine to safely traverse the node's children.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/eeh.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 22322b3..7309caa 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -238,12 +238,10 @@ static size_t gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 
 	/* Gather status on devices under the bridge */
 	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
-		dn = pdn->node->child;
-		while (dn) {
+		for (dn = NULL; (dn = of_get_next_child(pdn->node, dn));) {
 			pdn = PCI_DN(dn);
 			if (pdn)
 				n += gather_pci_data(pdn, buf+n, len-n);
-			dn = dn->sibling;
 		}
 	}
 
-- 
1.5.2.rc1.1884.g59b20
