Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y13yZ6wxNzDsND
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Sep 2017 22:57:26 +1000 (AEST)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] crypto: talitos - fix AEAD for sha224 on non sha224 capable
 chips
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Message-Id: <20170925125723.2A6476896D@po15668-vm-win7.idsi0.si.c-s.fr>
Date: Mon, 25 Sep 2017 14:57:23 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sha224 AEAD test fails with:

[    2.803125] talitos ff020000.crypto: DEUISR 0x00000000_00000000
[    2.808743] talitos ff020000.crypto: MDEUISR 0x80100000_00000000
[    2.814678] talitos ff020000.crypto: DESCBUF 0x20731f21_00000018
[    2.820616] talitos ff020000.crypto: DESCBUF 0x0628d64c_00000010
[    2.826554] talitos ff020000.crypto: DESCBUF 0x0631005c_00000018
[    2.832492] talitos ff020000.crypto: DESCBUF 0x0628d664_00000008
[    2.838430] talitos ff020000.crypto: DESCBUF 0x061b13a0_00000080
[    2.844369] talitos ff020000.crypto: DESCBUF 0x0631006c_00000080
[    2.850307] talitos ff020000.crypto: DESCBUF 0x0631006c_00000018
[    2.856245] talitos ff020000.crypto: DESCBUF 0x063100ec_00000000
[    2.884972] talitos ff020000.crypto: failed to reset channel 0
[    2.890503] talitos ff020000.crypto: done overflow, internal time out, or rngu error: ISR 0x20000000_00020000
[    2.900652] alg: aead: encryption failed on test 1 for authenc-hmac-sha224-cbc-3des-talitos: ret=22

This is due to SHA224 not being supported by the HW. Allthough for
hash we are able to init the hash contet by SW, it is not
possible for AEAD. Therefore SHA224 AEAD has to be deactivated.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/crypto/talitos.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 09a2cd3a31d2..9bfda9d59ace 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -3045,6 +3045,11 @@ static struct talitos_crypto_alg *talitos_alg_alloc(struct device *dev,
 		t_alg->algt.alg.aead.setkey = aead_setkey;
 		t_alg->algt.alg.aead.encrypt = aead_encrypt;
 		t_alg->algt.alg.aead.decrypt = aead_decrypt;
+		if (!(priv->features & TALITOS_FTR_SHA224_HWINIT) &&
+		    !strncmp(alg->cra_name, "authenc(hmac(sha224)", 20)) {
+			kfree(t_alg);
+			return ERR_PTR(-ENOTSUPP);
+		}
 		break;
 	case CRYPTO_ALG_TYPE_AHASH:
 		alg = &t_alg->algt.alg.hash.halg.base;
-- 
2.13.3
