Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4gHy0PddzDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 16:38:38 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 herbert@gondor.apana.org.au, davem@davemloft.net
Cc: alastair@d-silva.org, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
Subject: [PATCH] crypto: crc32c-vpmsum - Convert to CPU feature based module
 autoloading
Date: Thu,  4 Aug 2016 16:38:15 +1000
Message-Id: <1470292695-9829-1-git-send-email-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

This patch utilises the GENERIC_CPU_AUTOPROBE infrastructure
to automatically load the crc32c-vpmsum module if the CPU supports
it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/crypto/crc32c-vpmsum_glue.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/crypto/crc32c-vpmsum_glue.c b/arch/powerpc/crypto/crc32c-vpmsum_glue.c
index bfe3d37..9fa046d 100644
--- a/arch/powerpc/crypto/crc32c-vpmsum_glue.c
+++ b/arch/powerpc/crypto/crc32c-vpmsum_glue.c
@@ -4,6 +4,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/cpufeature.h>
 #include <asm/switch_to.h>
 
 #define CHKSUM_BLOCK_SIZE	1
@@ -157,7 +158,7 @@ static void __exit crc32c_vpmsum_mod_fini(void)
 	crypto_unregister_shash(&alg);
 }
 
-module_init(crc32c_vpmsum_mod_init);
+module_cpu_feature_match(PPC_MODULE_FEATURE_VEC_CRYPTO, crc32c_vpmsum_mod_init);
 module_exit(crc32c_vpmsum_mod_fini);
 
 MODULE_AUTHOR("Anton Blanchard <anton@samba.org>");
-- 
2.7.4
