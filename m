Return-Path: <clabbe.montjoie@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xc3CQ3StdzDr54
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 18:10:42 +1000 (AEST)
Received: by mail-wr0-x242.google.com with SMTP id f8so16134549wrf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 01:10:42 -0700 (PDT)
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
Subject: [PATCH 05/11] crypto: atmel - Use GCM IV size constant
Date: Tue, 22 Aug 2017 10:08:12 +0200
Message-Id: <20170822080818.12486-6-clabbe.montjoie@gmail.com>
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
 drivers/crypto/atmel-aes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 29e20c37f3a6..903fd43f23a5 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -36,6 +36,7 @@
 #include <crypto/scatterwalk.h>
 #include <crypto/algapi.h>
 #include <crypto/aes.h>
+#include <crypto/gcm.h>
 #include <crypto/xts.h>
 #include <crypto/internal/aead.h>
 #include <linux/platform_data/crypto-atmel.h>
@@ -1532,7 +1533,7 @@ static int atmel_aes_gcm_start(struct atmel_aes_dev *dd)
 	if (err)
 		return atmel_aes_complete(dd, err);
 
-	if (likely(ivsize == 12)) {
+	if (likely(ivsize == GCM_AES_IV_SIZE)) {
 		memcpy(ctx->j0, iv, ivsize);
 		ctx->j0[3] = cpu_to_be32(1);
 		return atmel_aes_gcm_process(dd);
@@ -1820,7 +1821,7 @@ static struct aead_alg aes_gcm_alg = {
 	.decrypt	= atmel_aes_gcm_decrypt,
 	.init		= atmel_aes_gcm_init,
 	.exit		= atmel_aes_gcm_exit,
-	.ivsize		= 12,
+	.ivsize		= GCM_AES_IV_SIZE,
 	.maxauthsize	= AES_BLOCK_SIZE,
 
 	.base = {
-- 
2.13.0
