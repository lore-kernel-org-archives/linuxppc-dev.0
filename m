Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cDwx0sdlzF2Vv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2018 22:29:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, mhcerri@linux.vnet.ibm.com,
 pfsmorigo@linux.vnet.ibm.com
Subject: [PATCH 2/2] crypto: vmx - Remove overly verbose printk from AES XTS
 init
Date: Thu,  3 May 2018 22:29:30 +1000
Message-Id: <20180503122930.17448-2-mpe@ellerman.id.au>
In-Reply-To: <20180503122930.17448-1-mpe@ellerman.id.au>
References: <20180503122930.17448-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In p8_aes_xts_init() we do a printk(KERN_INFO ...) to report the
fallback implementation we're using. However with a slow console this
can significantly affect the speed of crypto operations. So remove it.

Fixes: c07f5d3da643 ("crypto: vmx - Adding support for XTS")
Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/crypto/vmx/aes_xts.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/crypto/vmx/aes_xts.c b/drivers/crypto/vmx/aes_xts.c
index 8cd6e62e4c90..8bd9aff0f55f 100644
--- a/drivers/crypto/vmx/aes_xts.c
+++ b/drivers/crypto/vmx/aes_xts.c
@@ -53,8 +53,6 @@ static int p8_aes_xts_init(struct crypto_tfm *tfm)
 			alg, PTR_ERR(fallback));
 		return PTR_ERR(fallback);
 	}
-	printk(KERN_INFO "Using '%s' as fallback implementation.\n",
-		crypto_skcipher_driver_name(fallback));
 
 	crypto_skcipher_set_flags(
 		fallback,
-- 
2.14.1
