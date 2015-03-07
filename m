Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0138.outbound.protection.outlook.com [65.55.169.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8FF941A0246
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 11:51:49 +1100 (AEDT)
Date: Fri, 6 Mar 2015 18:46:21 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>
Subject: [PATCH] crypto: powerpc - move files to fix build error
Message-ID: <20150306184621.c2d277457bb1b3112b1d3a64@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Markus Stockhausen <stockhausen@collogia.de>,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current cryptodev-2.6 tree commits:

d9850fc529ef ("crypto: powerpc/sha1 - kernel config")
50ba29aaa7b0 ("crypto: powerpc/sha1 - glue")

failed to properly place files under arch/powerpc/crypto, which
leads to build errors:

make[1]: *** No rule to make target 'arch/powerpc/crypto/sha1-spe-asm.o', needed by 'arch/powerpc/crypto/sha1-ppc-spe.o'.  Stop.
make[1]: *** No rule to make target 'arch/powerpc/crypto/sha1_spe_glue.o', needed by 'arch/powerpc/crypto/sha1-ppc-spe.o'.  Stop.
Makefile:947: recipe for target 'arch/powerpc/crypto' failed

Move the two sha1 spe files under crypto/, and whilst there, rename
other powerpc crypto files with underscores to use dashes for
consistency.

Cc: Markus Stockhausen <stockhausen@collogia.de>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
applies to today's cryptodev-2.6.

 arch/powerpc/crypto/Makefile                                 | 8 ++++----
 arch/powerpc/crypto/{aes_spe_glue.c => aes-spe-glue.c}       | 0
 arch/powerpc/crypto/{md5_glue.c => md5-glue.c}               | 0
 arch/powerpc/{ => crypto}/sha1-spe-asm.S                     | 0
 arch/powerpc/{sha1_spe_glue.c => crypto/sha1-spe-glue.c}     | 0
 arch/powerpc/crypto/{sha256_spe_glue.c => sha256-spe-glue.c} | 0
 6 files changed, 4 insertions(+), 4 deletions(-)
 rename arch/powerpc/crypto/{aes_spe_glue.c => aes-spe-glue.c} (100%)
 rename arch/powerpc/crypto/{md5_glue.c => md5-glue.c} (100%)
 rename arch/powerpc/{ => crypto}/sha1-spe-asm.S (100%)
 rename arch/powerpc/{sha1_spe_glue.c => crypto/sha1-spe-glue.c} (100%)
 rename arch/powerpc/crypto/{sha256_spe_glue.c => sha256-spe-glue.c} (100%)

diff --git a/arch/powerpc/crypto/Makefile b/arch/powerpc/crypto/Makefile
index c6b25cba..9c221b6 100644
--- a/arch/powerpc/crypto/Makefile
+++ b/arch/powerpc/crypto/Makefile
@@ -10,8 +10,8 @@ obj-$(CONFIG_CRYPTO_SHA1_PPC) += sha1-powerpc.o
 obj-$(CONFIG_CRYPTO_SHA1_PPC_SPE) += sha1-ppc-spe.o
 obj-$(CONFIG_CRYPTO_SHA256_PPC_SPE) += sha256-ppc-spe.o
 
-aes-ppc-spe-y := aes-spe-core.o aes-spe-keys.o aes-tab-4k.o aes-spe-modes.o aes_spe_glue.o
-md5-ppc-y := md5-asm.o md5_glue.o
+aes-ppc-spe-y := aes-spe-core.o aes-spe-keys.o aes-tab-4k.o aes-spe-modes.o aes-spe-glue.o
+md5-ppc-y := md5-asm.o md5-glue.o
 sha1-powerpc-y := sha1-powerpc-asm.o sha1.o
-sha1-ppc-spe-y := sha1-spe-asm.o sha1_spe_glue.o
-sha256-ppc-spe-y := sha256-spe-asm.o sha256_spe_glue.o
+sha1-ppc-spe-y := sha1-spe-asm.o sha1-spe-glue.o
+sha256-ppc-spe-y := sha256-spe-asm.o sha256-spe-glue.o
diff --git a/arch/powerpc/crypto/aes_spe_glue.c b/arch/powerpc/crypto/aes-spe-glue.c
similarity index 100%
rename from arch/powerpc/crypto/aes_spe_glue.c
rename to arch/powerpc/crypto/aes-spe-glue.c
diff --git a/arch/powerpc/crypto/md5_glue.c b/arch/powerpc/crypto/md5-glue.c
similarity index 100%
rename from arch/powerpc/crypto/md5_glue.c
rename to arch/powerpc/crypto/md5-glue.c
diff --git a/arch/powerpc/sha1-spe-asm.S b/arch/powerpc/crypto/sha1-spe-asm.S
similarity index 100%
rename from arch/powerpc/sha1-spe-asm.S
rename to arch/powerpc/crypto/sha1-spe-asm.S
diff --git a/arch/powerpc/sha1_spe_glue.c b/arch/powerpc/crypto/sha1-spe-glue.c
similarity index 100%
rename from arch/powerpc/sha1_spe_glue.c
rename to arch/powerpc/crypto/sha1-spe-glue.c
diff --git a/arch/powerpc/crypto/sha256_spe_glue.c b/arch/powerpc/crypto/sha256-spe-glue.c
similarity index 100%
rename from arch/powerpc/crypto/sha256_spe_glue.c
rename to arch/powerpc/crypto/sha256-spe-glue.c
-- 
2.3.1
