Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id BEE1EB7D67
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 05:55:43 +1000 (EST)
Date: Tue, 8 Jun 2010 23:55:40 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/85xx: Fix SWIOTLB initalization for MPC85xxMDS
	boards
Message-ID: <20100608195540.GA11446@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The code inside '#ifdef CONFIG_QUICC_ENGINE' makes the
mpc85xx_mds_setup_arch() return early if no QE nodes present,
and so SWIOTLB is never initialized.

This patch fixes the issue by moving SWIOTLB code above
QE.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 8fe87fc..35ab2b4 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -202,6 +202,14 @@ static void __init mpc85xx_mds_setup_arch(void)
 	mpc85xx_smp_init();
 #endif
 
+#ifdef CONFIG_SWIOTLB
+	if (lmb_end_of_DRAM() > max) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
+	}
+#endif
+
 #ifdef CONFIG_QUICC_ENGINE
 	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
 	if (!np) {
@@ -323,14 +331,6 @@ static void __init mpc85xx_mds_setup_arch(void)
 
 	}
 #endif	/* CONFIG_QUICC_ENGINE */
-
-#ifdef CONFIG_SWIOTLB
-	if (lmb_end_of_DRAM() > max) {
-		ppc_swiotlb_enable = 1;
-		set_pci_dma_ops(&swiotlb_dma_ops);
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-	}
-#endif
 }
 
 
-- 
1.7.0.5
