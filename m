Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsdbK66jyzDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 20:44:59 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] crypto: talitos - fix sha224
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, Stephan Muller <smueller@chronox.de>
Message-Id: <20170913104451.75E8B684D7@po15668-vm-win7.idsi0.si.c-s.fr>
Date: Wed, 13 Sep 2017 12:44:51 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kernel crypto tests report the following error at startup

[    2.752626] alg: hash: Test 4 failed for sha224-talitos
[    2.757907] 00000000: 30 e2 86 e2 e7 8a dd 0d d7 eb 9f d5 83 fe f1 b0
00000010: 2d 5a 6c a5 f9 55 ea fd 0e 72 05 22

This patch fixes it

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index d47b3eb1f0..e2d323fa24 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1756,9 +1756,9 @@ static int common_nonsnoop_hash(struct talitos_edesc *edesc,
 		req_ctx->swinit = 0;
 	} else {
 		desc->ptr[1] = zero_entry;
-		/* Indicate next op is not the first. */
-		req_ctx->first = 0;
 	}
+	/* Indicate next op is not the first. */
+	req_ctx->first = 0;
 
 	/* HMAC key */
 	if (ctx->keylen)
-- 
2.13.3
