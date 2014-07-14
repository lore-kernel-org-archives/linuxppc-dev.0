Return-Path: <xuelin.shi@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0237.outbound.protection.outlook.com [207.46.163.237])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00A521A014B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jul 2014 18:06:24 +1000 (EST)
From: <xuelin.shi@freescale.com>
To: <dan.j.williams@intel.com>, <vinod.koul@intel.com>
Subject: [PATCH] dmaengine: fsl raid parity continuation support
Date: Mon, 14 Jul 2014 15:20:01 +0800
Message-ID: <1405322401-20156-1-git-send-email-xuelin.shi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: dmaengine@vger.kernel.org, Xuelin Shi <xuelin.shi@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, Xuelin Shi <b29237@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Xuelin Shi <xuelin.shi@freescale.com>

support more than 16 disks parity computation.

Signed-off-by: Xuelin Shi <b29237@freescale.com>
---
 comment: passed the raid6 recovery test.

 drivers/dma/fsl_raid.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
index 1dc5981..935d05a 100644
--- a/drivers/dma/fsl_raid.c
+++ b/drivers/dma/fsl_raid.c
@@ -328,6 +328,8 @@ static struct dma_async_tx_descriptor *re_jr_prep_genq(
 	struct cmpnd_frame *cf;
 	u32 cdb;
 	unsigned int i, j;
+	unsigned int save_src_cnt = src_cnt;
+	int cont_q = 0;
 
 	if (len > MAX_DATA_LENGTH) {
 		pr_err("Length greater than %d not supported\n",
@@ -340,6 +342,11 @@ static struct dma_async_tx_descriptor *re_jr_prep_genq(
 	if (desc <= 0)
 		return NULL;
 
+	if (scf && (flags & DMA_PREP_CONTINUE)) {
+		cont_q = 1;
+		src_cnt += 1;
+	}
+
 	/* Filling xor CDB */
 	cdb = RE_XOR_OPCODE << RE_CDB_OPCODE_SHIFT;
 	cdb |= (src_cnt - 1) << RE_CDB_NRCS_SHIFT;
@@ -351,8 +358,10 @@ static struct dma_async_tx_descriptor *re_jr_prep_genq(
 
 	if (scf != NULL) {
 		/* compute q = src0*coef0^src1*coef1^..., * is GF(8) mult */
-		for (i = 0; i < src_cnt; i++)
+		for (i = 0; i < save_src_cnt; i++)
 			xor->gfm[i] = scf[i];
+		if (cont_q)
+			xor->gfm[i++] = 1;
 	} else {
 		/* compute P, that is XOR all srcs */
 		for (i = 0; i < src_cnt; i++)
@@ -367,9 +376,12 @@ static struct dma_async_tx_descriptor *re_jr_prep_genq(
 	fill_cfd_frame(cf, 1, len, dest, 0);
 
 	/* Fill CFD's rest of the frames with source buffers */
-	for (i = 2, j = 0; j < src_cnt; i++, j++)
+	for (i = 2, j = 0; j < save_src_cnt; i++, j++)
 		fill_cfd_frame(cf, i, len, src[j], 0);
 
+	if (cont_q)
+		fill_cfd_frame(cf, i++, len, dest, 0);
+
 	/* Setting the final bit in the last source buffer frame in CFD */
 	cf[i - 1].efrl32 |= 1 << CF_FINAL_SHIFT;
 
@@ -404,6 +416,7 @@ static struct dma_async_tx_descriptor *re_jr_prep_pq(
 	u32 cdb;
 	u8 *p;
 	int gfmq_len, i, j;
+	unsigned long save_src_cnt = src_cnt;
 
 	if (len > MAX_DATA_LENGTH) {
 		pr_err("Length greater than %d not supported\n",
@@ -445,6 +458,9 @@ static struct dma_async_tx_descriptor *re_jr_prep_pq(
 		return re_jr_prep_genq(chan, dest[1], src, src_cnt,
 				scf, len, flags);
 
+	if (flags & DMA_PREP_CONTINUE)
+		src_cnt += 3;
+
 	jr = container_of(chan, struct re_jr, chan);
 	desc = re_jr_alloc_desc(jr, flags);
 	if (desc <= 0)
@@ -482,9 +498,19 @@ static struct dma_async_tx_descriptor *re_jr_prep_pq(
 		fill_cfd_frame(cf, i, len, dest[j], 0);
 
 	/* Fill CFD's rest of the frames with source buffers */
-	for (i = 3, j = 0; j < src_cnt; i++, j++)
+	for (i = 3, j = 0; j < save_src_cnt; i++, j++)
 		fill_cfd_frame(cf, i, len, src[j], 0);
 
+	/* PQ computation continuation */
+	if (src_cnt - save_src_cnt == 3) {
+		p[save_src_cnt] = 0;
+		p[save_src_cnt + 1] = 0;
+		p[save_src_cnt + 2] = 1;
+		fill_cfd_frame(cf, i++, len, dest[0], 0);
+		fill_cfd_frame(cf, i++, len, dest[1], 0);
+		fill_cfd_frame(cf, i++, len, dest[1], 0);
+	}
+
 	/* Setting the final bit in the last source buffer frame in CFD */
 	cf[i - 1].efrl32 |= 1 << CF_FINAL_SHIFT;
 
-- 
1.9.1
