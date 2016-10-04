Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0062.outbound.protection.outlook.com [104.47.38.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sp9d36n61zDskP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 18:33:27 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <linuxdev.baldrick@gmail.com>
Subject: [net-next 11/13] fsl/fman: fix return value checking
Date: Tue, 4 Oct 2016 10:32:57 +0300
Message-ID: <1475566379-5078-12-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1475566379-5078-1-git-send-email-madalin.bucur@nxp.com>
References: <1475566379-5078-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
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

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 1fc1049..dafd9e1 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -618,7 +618,7 @@ struct fman {
 	unsigned long cam_offset;
 	size_t cam_size;
 	/* Fifo in MURAM */
-	int fifo_offset;
+	unsigned long fifo_offset;
 	size_t fifo_size;
 
 	u32 liodn_base[64];
@@ -2036,7 +2036,7 @@ static int fman_init(struct fman *fman)
 	/* allocate MURAM for FIFO according to total size */
 	fman->fifo_offset = fman_muram_alloc(fman->muram,
 					     fman->state->total_fifo_size);
-	if (IS_ERR_VALUE(fman->cam_offset)) {
+	if (IS_ERR_VALUE(fman->fifo_offset)) {
 		free_init_resources(fman);
 		dev_err(fman->dev, "%s: MURAM alloc for BMI FIFO failed\n",
 			__func__);
-- 
2.1.0
