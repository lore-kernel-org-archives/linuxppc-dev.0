Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 3370F1A1706
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2015 00:32:22 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 16/17] crypto: talitos - Add fsl,sec1.0 compatible
To: Kim Phillips <kim.phillips@freescale.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David S Miller <davem@davemloft.net>
Message-Id: <20150417143220.237551A242C@localhost.localdomain>
Date: Fri, 17 Apr 2015 16:32:20 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We add a specific compatible for SEC1, to handle the differences
between SEC1 and SEC2+

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index f1406d7b..c04074d 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -3086,9 +3086,16 @@ err_out:
 }
 
 static const struct of_device_id talitos_match[] = {
+#ifdef CONFIG_CRYPTO_DEV_TALITOS1
+	{
+		.compatible = "fsl,sec1.0",
+	},
+#endif
+#ifdef CONFIG_CRYPTO_DEV_TALITOS2
 	{
 		.compatible = "fsl,sec2.0",
 	},
+#endif
 	{},
 };
 MODULE_DEVICE_TABLE(of, talitos_match);
-- 
2.1.0
