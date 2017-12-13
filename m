Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxkQL0kGLzDrcH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 04:36:41 +1100 (AEDT)
Subject: [PATCH 3/3] soc/fsl/qe: Use common error handling code in
 ucc_fast_init()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <07738369-a787-98b4-41a5-71b7d630c356@users.sourceforge.net>
Message-ID: <9668351a-8189-037f-5912-5663ac8706b1@users.sourceforge.net>
Date: Wed, 13 Dec 2017 18:36:08 +0100
MIME-Version: 1.0
In-Reply-To: <07738369-a787-98b4-41a5-71b7d630c356@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 13 Dec 2017 18:18:56 +0100

Add jump targets so that a bit of exception handling can be better reused
at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/soc/fsl/qe/ucc_fast.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
index 2092bfdcf1bc..268dfc5dc89b 100644
--- a/drivers/soc/fsl/qe/ucc_fast.c
+++ b/drivers/soc/fsl/qe/ucc_fast.c
@@ -269,8 +269,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO\n",
 			__func__);
 		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
-		ucc_fast_free(uccf);
-		return -ENOMEM;
+		goto free_nomem;
 	}
 
 	/* Allocate memory for Rx Virtual Fifo */
@@ -282,8 +281,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO\n",
 			__func__);
 		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
-		ucc_fast_free(uccf);
-		return -ENOMEM;
+		goto free_nomem;
 	}
 
 	/* Set Virtual Fifo registers */
@@ -312,8 +310,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 					COMM_DIR_RX)) {
 			printk(KERN_ERR "%s: illegal value for RX clock\n",
 			       __func__);
-			ucc_fast_free(uccf);
-			return -EINVAL;
+			goto free_inval;
 		}
 		/* Tx clock routing */
 		if ((uf_info->tx_clock != QE_CLK_NONE) &&
@@ -321,8 +318,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 					COMM_DIR_TX)) {
 			printk(KERN_ERR "%s: illegal value for TX clock\n",
 			       __func__);
-			ucc_fast_free(uccf);
-			return -EINVAL;
+			goto free_inval;
 		}
 	} else {
 		/* tdm Rx clock routing */
@@ -330,8 +326,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 		    ucc_set_tdm_rxtx_clk(uf_info->tdm_num, uf_info->rx_clock,
 					 COMM_DIR_RX)) {
 			pr_err("%s: illegal value for RX clock", __func__);
-			ucc_fast_free(uccf);
-			return -EINVAL;
+			goto free_inval;
 		}
 
 		/* tdm Tx clock routing */
@@ -339,8 +334,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 		    ucc_set_tdm_rxtx_clk(uf_info->tdm_num, uf_info->tx_clock,
 					 COMM_DIR_TX)) {
 			pr_err("%s: illegal value for TX clock", __func__);
-			ucc_fast_free(uccf);
-			return -EINVAL;
+			goto free_inval;
 		}
 
 		/* tdm Rx sync clock routing */
@@ -348,8 +342,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 		    ucc_set_tdm_rxtx_sync(uf_info->tdm_num, uf_info->rx_sync,
 					  COMM_DIR_RX)) {
 			pr_err("%s: illegal value for RX clock", __func__);
-			ucc_fast_free(uccf);
-			return -EINVAL;
+			goto free_inval;
 		}
 
 		/* tdm Tx sync clock routing */
@@ -357,8 +350,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 		    ucc_set_tdm_rxtx_sync(uf_info->tdm_num, uf_info->tx_sync,
 					  COMM_DIR_TX)) {
 			pr_err("%s: illegal value for TX clock", __func__);
-			ucc_fast_free(uccf);
-			return -EINVAL;
+			goto free_inval;
 		}
 	}
 
@@ -374,6 +366,14 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 
 	*uccf_ret = uccf;
 	return 0;
+
+free_nomem:
+	ucc_fast_free(uccf);
+	return -ENOMEM;
+
+free_inval:
+	ucc_fast_free(uccf);
+	return -EINVAL;
 }
 EXPORT_SYMBOL(ucc_fast_init);
 
-- 
2.15.1
