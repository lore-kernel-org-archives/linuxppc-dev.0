Return-Path: <mohicks@gmail.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BACEA1A0F0B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 03:21:49 +1100 (AEDT)
Received: by iebtr6 with SMTP id tr6so8924625ieb.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 08:21:47 -0800 (PST)
Sender: Martin Hicks <mohicks@gmail.com>
From: Martin Hicks <mort@bork.org>
To: Kim Phillips <kim.phillips@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/5] crypto: talitos: Simplify per-channel initialization
Date: Fri, 20 Feb 2015 11:21:12 -0500
Message-Id: <1424449276-5288-2-git-send-email-mort@bork.org>
In-Reply-To: <1424449276-5288-1-git-send-email-mort@bork.org>
References: <1424449276-5288-1-git-send-email-mort@bork.org>
Cc: Martin Hicks <mort@bork.org>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There were multiple loops in a row, for each separate step of the
initialization of the channels.  Simplify to a single loop.

Signed-off-by: Martin Hicks <mort@bork.org>
---
 drivers/crypto/talitos.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 067ec21..c49d977 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2706,20 +2706,16 @@ static int talitos_probe(struct platform_device *ofdev)
 		goto err_out;
 	}
 
+	priv->fifo_len = roundup_pow_of_two(priv->chfifo_len);
+
 	for (i = 0; i < priv->num_channels; i++) {
 		priv->chan[i].reg = priv->reg + TALITOS_CH_STRIDE * (i + 1);
 		if (!priv->irq[1] || !(i & 1))
 			priv->chan[i].reg += TALITOS_CH_BASE_OFFSET;
-	}
 
-	for (i = 0; i < priv->num_channels; i++) {
 		spin_lock_init(&priv->chan[i].head_lock);
 		spin_lock_init(&priv->chan[i].tail_lock);
-	}
 
-	priv->fifo_len = roundup_pow_of_two(priv->chfifo_len);
-
-	for (i = 0; i < priv->num_channels; i++) {
 		priv->chan[i].fifo = kzalloc(sizeof(struct talitos_request) *
 					     priv->fifo_len, GFP_KERNEL);
 		if (!priv->chan[i].fifo) {
@@ -2727,11 +2723,10 @@ static int talitos_probe(struct platform_device *ofdev)
 			err = -ENOMEM;
 			goto err_out;
 		}
-	}
 
-	for (i = 0; i < priv->num_channels; i++)
 		atomic_set(&priv->chan[i].submit_count,
 			   -(priv->chfifo_len - 1));
+	}
 
 	dma_set_mask(dev, DMA_BIT_MASK(36));
 
-- 
1.7.10.4
