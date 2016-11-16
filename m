Return-Path: <claudiu.manoil@nxp.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0075.outbound.protection.outlook.com [104.47.41.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJn4N2dFWzDvmh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 01:40:52 +1100 (AEDT)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Scott Wood <oss@buserror.net>, <roy.pledge@nxp.com>
Subject: [PATCH 09/17] soc/qman: test: Don't use dummy platform device for dma
 mapping
Date: Wed, 16 Nov 2016 16:40:22 +0200
Message-ID: <1479307230-16650-10-git-send-email-claudiu.manoil@nxp.com>
In-Reply-To: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
References: <1479307230-16650-1-git-send-email-claudiu.manoil@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace dummy platform device hack with a reference to a portal's
platform device, in order to dma map the test frame for this
small unit test.  The 2 qman symbols need to be exported because
this self test is a kernel module.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/qman.c            |  1 +
 drivers/soc/fsl/qbman/qman_portal.c     |  1 +
 drivers/soc/fsl/qbman/qman_test_stash.c | 31 ++++++++++++++++++++-----------
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index a0020d2..283c2d3 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -2711,6 +2711,7 @@ const struct qm_portal_config *qman_get_qm_portal_config(
 {
 	return portal->config;
 }
+EXPORT_SYMBOL(qman_get_qm_portal_config);
 
 struct gen_pool *qm_fqalloc; /* FQID allocator */
 struct gen_pool *qm_qpalloc; /* pool-channel allocator */
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index e6da2ea..c9a9bcb 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -31,6 +31,7 @@
 #include "qman_priv.h"
 
 struct qman_portal *qman_dma_portal;
+EXPORT_SYMBOL(qman_dma_portal);
 
 /* Enable portal interupts (as opposed to polling mode) */
 #define CONFIG_FSL_DPA_PIRQ_SLOW  1
diff --git a/drivers/soc/fsl/qbman/qman_test_stash.c b/drivers/soc/fsl/qbman/qman_test_stash.c
index 43cf66b..f8d25fa 100644
--- a/drivers/soc/fsl/qbman/qman_test_stash.c
+++ b/drivers/soc/fsl/qbman/qman_test_stash.c
@@ -191,6 +191,9 @@ struct hp_cpu {
 static u32 *frame_ptr;
 static dma_addr_t frame_dma;
 
+/* needed for dma_map*() */
+static const struct qm_portal_config *pcfg;
+
 /* the main function waits on this */
 static DECLARE_WAIT_QUEUE_HEAD(queue);
 
@@ -210,16 +213,14 @@ static int allocate_frame_data(void)
 {
 	u32 lfsr = HP_FIRST_WORD;
 	int loop;
-	struct platform_device *pdev = platform_device_alloc("foobar", -1);
 
-	if (!pdev) {
-		pr_crit("platform_device_alloc() failed");
-		return -EIO;
-	}
-	if (platform_device_add(pdev)) {
-		pr_crit("platform_device_add() failed");
+	if (!qman_dma_portal) {
+		pr_crit("portal not available\n");
 		return -EIO;
 	}
+
+	pcfg = qman_get_qm_portal_config(qman_dma_portal);
+
 	__frame_ptr = kmalloc(4 * HP_NUM_WORDS, GFP_KERNEL);
 	if (!__frame_ptr)
 		return -ENOMEM;
@@ -229,15 +230,22 @@ static int allocate_frame_data(void)
 		frame_ptr[loop] = lfsr;
 		lfsr = do_lfsr(lfsr);
 	}
-	frame_dma = dma_map_single(&pdev->dev, frame_ptr, 4 * HP_NUM_WORDS,
+
+	frame_dma = dma_map_single(pcfg->dev, frame_ptr, 4 * HP_NUM_WORDS,
 				   DMA_BIDIRECTIONAL);
-	platform_device_del(pdev);
-	platform_device_put(pdev);
+	if (dma_mapping_error(pcfg->dev, frame_dma)) {
+		pr_crit("dma mapping failure\n");
+		kfree(__frame_ptr);
+		return -EIO;
+	}
+
 	return 0;
 }
 
 static void deallocate_frame_data(void)
 {
+	dma_unmap_single(pcfg->dev, frame_dma, 4 * HP_NUM_WORDS,
+			 DMA_BIDIRECTIONAL);
 	kfree(__frame_ptr);
 }
 
@@ -249,7 +257,8 @@ static inline int process_frame_data(struct hp_handler *handler,
 	int loop;
 
 	if (qm_fd_addr_get64(fd) != handler->addr) {
-		pr_crit("bad frame address");
+		pr_crit("bad frame address, [%llX != %llX]\n",
+			qm_fd_addr_get64(fd), handler->addr);
 		return -EIO;
 	}
 	for (loop = 0; loop < HP_NUM_WORDS; loop++, p++) {
-- 
1.7.11.7
