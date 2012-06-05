Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 85524B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2012 23:48:06 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <galak@kernel.crashing.org>, <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Fix assmption of end_of_DRAM() returns end address
Date: Tue, 5 Jun 2012 19:25:04 +0530
Message-ID: <1338904504-2750-1-git-send-email-bharat.bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

memblock_end_of_DRAM() returns end_address + 1, not end address.
While some code assumes that it returns end address.

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
This patch is based on next branch of https://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git

 arch/powerpc/platforms/44x/currituck.c     |    2 +-
 arch/powerpc/platforms/85xx/corenet_ds.c   |    2 +-
 arch/powerpc/platforms/85xx/ge_imp3a.c     |    2 +-
 arch/powerpc/platforms/85xx/mpc8536_ds.c   |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c   |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c  |    2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c     |    2 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/44x/currituck.c b/arch/powerpc/platforms/44x/currituck.c
index 583e67f..9f6c33d 100644
--- a/arch/powerpc/platforms/44x/currituck.c
+++ b/arch/powerpc/platforms/44x/currituck.c
@@ -160,7 +160,7 @@ static void __init ppc47x_setup_arch(void)
 	/* No need to check the DMA config as we /know/ our windows are all of
  	 * RAM.  Lets hope that doesn't change */
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > 0xffffffff) {
+	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
 		ppc_swiotlb_enable = 1;
 		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index dd3617c..925b028 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -77,7 +77,7 @@ void __init corenet_ds_setup_arch(void)
 #endif
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if ((memblock_end_of_DRAM() - 1) > max) {
 		ppc_swiotlb_enable = 1;
 		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
diff --git a/arch/powerpc/platforms/85xx/ge_imp3a.c b/arch/powerpc/platforms/85xx/ge_imp3a.c
index 1801462..b6a728b 100644
--- a/arch/powerpc/platforms/85xx/ge_imp3a.c
+++ b/arch/powerpc/platforms/85xx/ge_imp3a.c
@@ -125,7 +125,7 @@ static void __init ge_imp3a_setup_arch(void)
 	mpc85xx_smp_init();
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if ((memblock_end_of_DRAM() - 1) > max) {
 		ppc_swiotlb_enable = 1;
 		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 585bd22..767c7cf 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -75,7 +75,7 @@ static void __init mpc8536_ds_setup_arch(void)
 #endif
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if ((memblock_end_of_DRAM() - 1) > max) {
 		ppc_swiotlb_enable = 1;
 		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 1fd91e9..d30f6c4 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -173,7 +173,7 @@ static void __init mpc85xx_ds_setup_arch(void)
 	mpc85xx_smp_init();
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if ((memblock_end_of_DRAM() - 1) > max) {
 		ppc_swiotlb_enable = 1;
 		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index d208ebc..8e4b094 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -359,7 +359,7 @@ static void __init mpc85xx_mds_setup_arch(void)
 	mpc85xx_mds_qe_init();
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if ((memblock_end_of_DRAM() - 1) > max) {
 		ppc_swiotlb_enable = 1;
 		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index f700c81..74e310b 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -450,7 +450,7 @@ static void __init p1022_ds_setup_arch(void)
 	mpc85xx_smp_init();
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if ((memblock_end_of_DRAM() - 1) > max) {
 		ppc_swiotlb_enable = 1;
 		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 3755e61..817245b 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -102,7 +102,7 @@ mpc86xx_hpcn_setup_arch(void)
 #endif
 
 #ifdef CONFIG_SWIOTLB
-	if (memblock_end_of_DRAM() > max) {
+	if ((memblock_end_of_DRAM() - 1) > max) {
 		ppc_swiotlb_enable = 1;
 		set_pci_dma_ops(&swiotlb_dma_ops);
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
-- 
1.7.0.4
