Return-Path: <mohicks@gmail.com>
Received: from mail-ig0-x22f.google.com (mail-ig0-x22f.google.com
 [IPv6:2607:f8b0:4001:c05::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 834501A0F8B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 03:21:54 +1100 (AEDT)
Received: by mail-ig0-f175.google.com with SMTP id hn18so4203569igb.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 08:21:52 -0800 (PST)
Sender: Martin Hicks <mohicks@gmail.com>
From: Martin Hicks <mort@bork.org>
To: Kim Phillips <kim.phillips@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/5] crypto: talitos: Fix off-by-one and use all hardware slots
Date: Fri, 20 Feb 2015 11:21:14 -0500
Message-Id: <1424449276-5288-4-git-send-email-mort@bork.org>
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
