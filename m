Return-Path: <clabbe.montjoie@gmail.com>
Received: from mail-wr0-x241.google.com (mail-wr0-x241.google.com
 [IPv6:2a00:1450:400c:c0c::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xc3CR6mdYzDql8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 18:10:43 +1000 (AEST)
Received: by mail-wr0-x241.google.com with SMTP id a47so753538wra.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 01:10:43 -0700 (PDT)
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
Subject: [PATCH 06/11] crypto: bcm - Use GCM IV size constant
Date: Tue, 22 Aug 2017 10:08:13 +0200
Message-Id: <20170822080818.12486-7-clabbe.montjoie@gmail.com>
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
 drivers/crypto/bcm/cipher.c | 8 ++++----
 drivers/crypto/bcm/cipher.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/bcm/cipher.c b/drivers/crypto/bcm/cipher.c
index 8685c7e4debd..537a67483aa3 100644
--- a/drivers/crypto/bcm/cipher.c
+++ b/drivers/crypto/bcm/cipher.c
@@ -1367,11 +1367,11 @@ static int handle_aead_req(struct iproc_reqctx_s *rctx)
 		 * expects AAD to include just SPI and seqno. So
 		 * subtract off the IV len.
 		 */
-		aead_parms.assoc_size -= GCM_ESP_IV_SIZE;
+		aead_parms.assoc_size -= GCM_RFC4106_IV_SIZE;
 
 		if (rctx->is_encrypt) {
 			aead_parms.return_iv = true;
-			aead_parms.ret_iv_len = GCM_ESP_IV_SIZE;
+			aead_parms.ret_iv_len = GCM_RFC4106_IV_SIZE;
 			aead_parms.ret_iv_off = GCM_ESP_SALT_SIZE;
 		}
 	} else {
@@ -3255,7 +3255,7 @@ static struct iproc_alg_s driver_algs[] = {
 			.cra_flags = CRYPTO_ALG_NEED_FALLBACK
 		 },
 		 .setkey = aead_gcm_esp_setkey,
-		 .ivsize = GCM_ESP_IV_SIZE,
+		 .ivsize = GCM_RFC4106_IV_SIZE,
 		 .maxauthsize = AES_BLOCK_SIZE,
 	 },
 	 .cipher_info = {
@@ -3301,7 +3301,7 @@ static struct iproc_alg_s driver_algs[] = {
 			.cra_flags = CRYPTO_ALG_NEED_FALLBACK
 		 },
 		 .setkey = rfc4543_gcm_esp_setkey,
-		 .ivsize = GCM_ESP_IV_SIZE,
+		 .ivsize = GCM_RFC4106_IV_SIZE,
 		 .maxauthsize = AES_BLOCK_SIZE,
 	 },
 	 .cipher_info = {
diff --git a/drivers/crypto/bcm/cipher.h b/drivers/crypto/bcm/cipher.h
index 57a55eb2a255..763c425c41ca 100644
--- a/drivers/crypto/bcm/cipher.h
+++ b/drivers/crypto/bcm/cipher.h
@@ -23,6 +23,7 @@
 #include <crypto/aes.h>
 #include <crypto/internal/hash.h>
 #include <crypto/aead.h>
+#include <crypto/gcm.h>
 #include <crypto/sha.h>
 #include <crypto/sha3.h>
 
@@ -39,8 +40,6 @@
 #define ARC4_STATE_SIZE     4
 
 #define CCM_AES_IV_SIZE    16
-#define GCM_AES_IV_SIZE    12
-#define GCM_ESP_IV_SIZE     8
 #define CCM_ESP_IV_SIZE     8
 #define RFC4543_ICV_SIZE   16
 
-- 
2.13.0
