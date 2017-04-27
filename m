Return-Path: <mort@bork.org>
Received: from darwin.bork.org (darwin.bork.org [IPv6:2001:470:1f05:998::1])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDLsH59fyzDq9K
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Apr 2017 01:46:27 +1000 (AEST)
Date: Thu, 27 Apr 2017 11:40:46 -0400
From: Martin Hicks <mort@bork.org>
To: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: talitos: Extend max key length for SHA384/512-HMAC
Message-ID: <20170427154046.GA5041@darwin.bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The max keysize for both of these is 128, not 96.  Before, with keysizes
over 96, the memcpy in ahash_setkey() would overwrite memory beyond the
key field.

Signed-off-by: Martin Hicks <mort@bork.org>
---
 drivers/crypto/talitos.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 0bba6a1..97dc85e 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -816,7 +816,7 @@ static void talitos_unregister_rng(struct device *dev)
  * HMAC_SNOOP_NO_AFEA (HSNA) instead of type IPSEC_ESP
  */
 #define TALITOS_CRA_PRIORITY_AEAD_HSNA	(TALITOS_CRA_PRIORITY - 1)
-#define TALITOS_MAX_KEY_SIZE		96
+#define TALITOS_MAX_KEY_SIZE		SHA512_BLOCK_SIZE /* SHA512 has the largest keysize input */
 #define TALITOS_MAX_IV_LENGTH		16 /* max of AES_BLOCK_SIZE, DES3_EDE_BLOCK_SIZE */
 
 struct talitos_ctx {
-- 
1.7.10.4


-- 
Martin Hicks P.Eng.    |      mort@bork.org
Bork Consulting Inc.   |  +1 (613) 266-2296
