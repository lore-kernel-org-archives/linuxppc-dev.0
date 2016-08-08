Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7XZp4Yq7zDqdG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 08:46:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linux-crypto@vger.kernel.org
Cc: <linuxppc-dev@ozlabs.org>, Anton Blanchard <anton@samba.org>,
 Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH v2] crypto: powerpc - CRYPT_CRC32C_VPMSUM should depend on
 ALTIVEC
Date: Tue,  9 Aug 2016 08:46:15 +1000
Message-Id: <1470696375-22023-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The optimised crc32c implementation depends on VMX (aka. Altivec)
instructions, so the kernel must be built with Altivec support in order
for the crc32c code to build.

Fixes: 6dd7a82cc54e ("crypto: powerpc - Add POWER8 optimised crc32c")
Acked-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2: No change. Send to linux-crypto.

diff --git a/crypto/Kconfig b/crypto/Kconfig
index a9377bef25e3..84d71482bf08 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -439,7 +439,7 @@ config CRYPTO_CRC32C_INTEL
 
 config CRYPT_CRC32C_VPMSUM
 	tristate "CRC32c CRC algorithm (powerpc64)"
-	depends on PPC64
+	depends on PPC64 && ALTIVEC
 	select CRYPTO_HASH
 	select CRC32
 	help
-- 
2.7.4
