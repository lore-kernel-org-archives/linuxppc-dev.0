Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09938B7154
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Sep 2010 02:42:26 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o7VGgN6w028554
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 11:42:23 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Fix compile issue with p1022_ds due to lmb
	rename to memblock
Date: Tue, 31 Aug 2010 11:42:23 -0500
Message-Id: <1283272943-2454-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch/powerpc/platforms/85xx/p1022_ds.c:22:23: error: linux/lmb.h: No such file or directory
arch/powerpc/platforms/85xx/p1022_ds.c: In function 'p1022_ds_setup_arch':
arch/powerpc/platforms/85xx/p1022_ds.c:100: error: implicit declaration of function 'memblock_end_of_DRAM'
arch/powerpc/platforms/85xx/p1022_ds.c: At top level:
arch/powerpc/platforms/85xx/p1022_ds.c:147: error: 'udbg_progress' undeclared here (not in a function)
make[2]: *** [arch/powerpc/platforms/85xx/p1022_ds.o] Error 1

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/p1022_ds.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index e1467c9..34e0090 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -19,7 +19,7 @@
 
 #include <linux/pci.h>
 #include <linux/of_platform.h>
-#include <linux/lmb.h>
+#include <linux/memblock.h>
 
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
@@ -97,7 +97,7 @@ static void __init p1022_ds_setup_arch(void)
 #endif
 
 #ifdef CONFIG_SWIOTLB
-	if (lmb_end_of_DRAM() > max) {
+	if (memblock_end_of_DRAM() > max) {
 		ppc_swiotlb_enable = 1;
 		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-- 
1.6.0.6
