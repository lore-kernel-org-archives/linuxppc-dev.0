Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 08 Dec 2008 15:53:25 +1100
Subject: [PATCH] powerpc: Fix build of 4xx simple platforms without CONFIG_PCI
Message-Id: <20081208045411.0CE03DDE0E@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The global ppc_pci_flags is not defined when CONFIG_PCI is not
set, causing a link error

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/40x/ppc40x_simple.c |    2 ++
 arch/powerpc/platforms/44x/ppc44x_simple.c |    2 ++
 2 files changed, 4 insertions(+)

--- linux-work.orig/arch/powerpc/platforms/40x/ppc40x_simple.c	2008-12-08 15:51:49.000000000 +1100
+++ linux-work/arch/powerpc/platforms/40x/ppc40x_simple.c	2008-12-08 15:51:52.000000000 +1100
@@ -61,7 +61,9 @@ static int __init ppc40x_probe(void)
 
 	for (i = 0; i < ARRAY_SIZE(board); i++) {
 		if (of_flat_dt_is_compatible(root, board[i])) {
+#ifdef CONFIG_PCI
 			ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+#endif
 			return 1;
 		}
 	}
Index: linux-work/arch/powerpc/platforms/44x/ppc44x_simple.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/44x/ppc44x_simple.c	2008-12-08 15:51:31.000000000 +1100
+++ linux-work/arch/powerpc/platforms/44x/ppc44x_simple.c	2008-12-08 15:51:39.000000000 +1100
@@ -70,7 +70,9 @@ static int __init ppc44x_probe(void)
 
 	for (i = 0; i < ARRAY_SIZE(board); i++) {
 		if (of_flat_dt_is_compatible(root, board[i])) {
+#ifdef CONFIG_PCI
 			ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
+#endif
 			return 1;
 		}
 	}
