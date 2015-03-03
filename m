Return-Path: <mohicks@gmail.com>
Received: from mail-ig0-x233.google.com (mail-ig0-x233.google.com
 [IPv6:2607:f8b0:4001:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9BA71A0259
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 00:21:52 +1100 (AEDT)
Received: by igdh15 with SMTP id h15so27163909igd.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Mar 2015 05:21:50 -0800 (PST)
Sender: Martin Hicks <mohicks@gmail.com>
From: Martin Hicks <mort@bork.org>
To: Kim Phillips <kim.phillips@freescale.com>,
 Scott Wood <scottwood@freescale.com>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 2/5] crypto: talitos: Remove MD5_BLOCK_SIZE
Date: Tue,  3 Mar 2015 08:21:34 -0500
Message-Id: <1425388897-5434-3-git-send-email-mort@bork.org>
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

This is properly defined in the md5 header file.

Signed-off-by: Martin Hicks <mort@bork.org>
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
