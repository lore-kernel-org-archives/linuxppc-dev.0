Return-Path: <mohicks@gmail.com>
Received: from mail-ie0-x22e.google.com (mail-ie0-x22e.google.com
 [IPv6:2607:f8b0:4001:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 60E4B1A0F47
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 03:21:52 +1100 (AEDT)
Received: by iecat20 with SMTP id at20so8901019iec.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 08:21:50 -0800 (PST)
Sender: Martin Hicks <mohicks@gmail.com>
From: Martin Hicks <mort@bork.org>
To: Kim Phillips <kim.phillips@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/5] crypto: talitos: Remove MD5_BLOCK_SIZE
Date: Fri, 20 Feb 2015 11:21:13 -0500
Message-Id: <1424449276-5288-3-git-send-email-mort@bork.org>
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

This is properly defined in the md5 header file.
---
 drivers/crypto/talitos.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index c49d977..89cf4d5 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -637,8 +637,6 @@ static void talitos_unregister_rng(struct device *dev)
 #define TALITOS_MAX_KEY_SIZE		96
 #define TALITOS_MAX_IV_LENGTH		16 /* max of AES_BLOCK_SIZE, DES3_EDE_BLOCK_SIZE */
 
-#define MD5_BLOCK_SIZE    64
-
 struct talitos_ctx {
 	struct device *dev;
 	int ch;
@@ -2195,7 +2193,7 @@ static struct talitos_alg_template driver_algs[] = {
 			.halg.base = {
 				.cra_name = "md5",
 				.cra_driver_name = "md5-talitos",
-				.cra_blocksize = MD5_BLOCK_SIZE,
+				.cra_blocksize = MD5_HMAC_BLOCK_SIZE,
 				.cra_flags = CRYPTO_ALG_TYPE_AHASH |
 					     CRYPTO_ALG_ASYNC,
 			}
@@ -2285,7 +2283,7 @@ static struct talitos_alg_template driver_algs[] = {
 			.halg.base = {
 				.cra_name = "hmac(md5)",
 				.cra_driver_name = "hmac-md5-talitos",
-				.cra_blocksize = MD5_BLOCK_SIZE,
+				.cra_blocksize = MD5_HMAC_BLOCK_SIZE,
 				.cra_flags = CRYPTO_ALG_TYPE_AHASH |
 					     CRYPTO_ALG_ASYNC,
 			}
-- 
1.7.10.4
