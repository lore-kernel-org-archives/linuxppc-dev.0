Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7qbz2WVnzDqmX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 00:04:47 +1100 (AEDT)
Message-Id: <16521c1a371ace21d7829c21aaef03c547959905.1507284818.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1507284818.git.christophe.leroy@c-s.fr>
References: <cover.1507284818.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 06/18] crypto: talitos - fix ctr-aes-talitos
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri,  6 Oct 2017 15:04:43 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ctr-aes-talitos test fails as follows on SEC2

[    0.837427] alg: skcipher: Test 1 failed (invalid result) on encryption for ctr-aes-talitos
[    0.845763] 00000000: 16 36 d5 ee 34 f8 06 25 d7 7f 8e 56 ca 88 43 45
[    0.852345] 00000010: f9 3f f7 17 2a b2 12 23 30 43 09 15 82 dd e1 97
[    0.858940] 00000020: a7 f7 32 b5 eb 25 06 13 9a ec f5 29 25 f8 4d 66
[    0.865366] 00000030: b0 03 5b 8e aa 9a 42 b6 19 33 8a e2 9d 65 96 95

This patch fixes the descriptor type which is special for CTR AES

Fixes: 5e75ae1b3cef6 ("crypto: talitos - add new crypto modes")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index cf5c9701b898..a19b5d0300a9 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -2635,7 +2635,7 @@ static struct talitos_alg_template driver_algs[] = {
 				.ivsize = AES_BLOCK_SIZE,
 			}
 		},
-		.desc_hdr_template = DESC_HDR_TYPE_COMMON_NONSNOOP_NO_AFEU |
+		.desc_hdr_template = DESC_HDR_TYPE_AESU_CTR_NONSNOOP |
 				     DESC_HDR_SEL0_AESU |
 				     DESC_HDR_MODE0_AESU_CTR,
 	},
-- 
2.13.3
