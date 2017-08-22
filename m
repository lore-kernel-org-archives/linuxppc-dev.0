Return-Path: <clabbe.montjoie@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xc3CV3h7PzDql9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 18:10:46 +1000 (AEST)
Received: by mail-wr0-x241.google.com with SMTP id p14so16007753wrg.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 01:10:46 -0700 (PDT)
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, tglx@linutronix.de,
 mingo@redhat.com, hpa@zytor.com, x86@kernel.org, horia.geanta@nxp.com,
 dan.douglass@nxp.com, thomas.lendacky@amd.com, gary.hook@amd.com,
 harsh@chelsio.com, matthias.bgg@gmail.com, leosilva@linux.vnet.ibm.com,
 pfsmorigo@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: [PATCH 08/11] crypto: chelsio - Use GCM IV size constant
Date: Tue, 22 Aug 2017 10:08:15 +0200
Message-Id: <20170822080818.12486-9-clabbe.montjoie@gmail.com>
In-Reply-To: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
References: <20170822080818.12486-1-clabbe.montjoie@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch replace GCM IV size value by their constant name.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index 0e8160701833..936bdd895efa 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -53,6 +53,7 @@
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
 #include <crypto/hash.h>
+#include <crypto/gcm.h>
 #include <crypto/sha.h>
 #include <crypto/authenc.h>
 #include <crypto/ctr.h>
@@ -2534,9 +2535,9 @@ static struct sk_buff *create_gcm_wr(struct aead_request *req,
 	if (get_aead_subtype(tfm) ==
 	    CRYPTO_ALG_SUB_TYPE_AEAD_RFC4106) {
 		memcpy(reqctx->iv, aeadctx->salt, 4);
-		memcpy(reqctx->iv + 4, req->iv, 8);
+		memcpy(reqctx->iv + 4, req->iv, GCM_RFC4106_IV_SIZE);
 	} else {
-		memcpy(reqctx->iv, req->iv, 12);
+		memcpy(reqctx->iv, req->iv, GCM_AES_IV_SIZE);
 	}
 	*((unsigned int *)(reqctx->iv + 12)) = htonl(0x01);
 
@@ -3385,7 +3386,7 @@ static struct chcr_alg_template driver_algs[] = {
 						sizeof(struct chcr_aead_ctx) +
 						sizeof(struct chcr_gcm_ctx),
 			},
-			.ivsize = 12,
+			.ivsize = GCM_AES_IV_SIZE,
 			.maxauthsize = GHASH_DIGEST_SIZE,
 			.setkey = chcr_gcm_setkey,
 			.setauthsize = chcr_gcm_setauthsize,
@@ -3405,7 +3406,7 @@ static struct chcr_alg_template driver_algs[] = {
 						sizeof(struct chcr_gcm_ctx),
 
 			},
-			.ivsize = 8,
+			.ivsize = GCM_RFC4106_IV_SIZE,
 			.maxauthsize	= GHASH_DIGEST_SIZE,
 			.setkey = chcr_gcm_setkey,
 			.setauthsize	= chcr_4106_4309_setauthsize,
-- 
2.13.0
