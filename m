Return-Path: <mohicks@gmail.com>
Received: from mail-ie0-x229.google.com (mail-ie0-x229.google.com
 [IPv6:2607:f8b0:4001:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E787F1A0214
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 00:21:53 +1100 (AEDT)
Received: by iecrd18 with SMTP id rd18so57741302iec.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2015 05:21:51 -0800 (PST)
Sender: Martin Hicks <mohicks@gmail.com>
From: Martin Hicks <mort@bork.org>
To: Kim Phillips <kim.phillips@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 3/5] crypto: talitos: Fix off-by-one and use all hardware
 slots
Date: Tue,  3 Mar 2015 08:21:35 -0500
Message-Id: <1425388897-5434-4-git-send-email-mort@bork.org>
In-Reply-To: <1425388897-5434-1-git-send-email-mort@bork.org>
References: <1425388897-5434-1-git-send-email-mort@bork.org>
Cc: Martin Hicks <mort@bork.org>, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org,
 =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The submission count was off by one.

Signed-off-by: Martin Hicks <mort@bork.org>
---
 drivers/crypto/talitos.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 89cf4d5..7709805 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2722,8 +2722,7 @@ static int talitos_probe(struct platform_device *ofdev)
 			goto err_out;
 		}
 
-		atomic_set(&priv->chan[i].submit_count,
-			   -(priv->chfifo_len - 1));
+		atomic_set(&priv->chan[i].submit_count, -priv->chfifo_len);
 	}
 
 	dma_set_mask(dev, DMA_BIT_MASK(36));
-- 
1.7.10.4
