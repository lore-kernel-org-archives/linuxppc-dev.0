Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 528581A2A7C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 18:22:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: leosilva@linux.vnet.ibm.com, herbert@gondor.apana.org.au,
 Paul Mackerras <paulus@samba.org>, tim.gardner@canonical.com,
 linux-crypto@vger.kernel.org
Subject: [PATCH v2] crypto: vmx - VMX crypto should depend on CONFIG_VSX
Date: Wed,  9 Sep 2015 18:22:35 +1000
Message-Id: <1441786955-6249-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code uses FP (floating point), Altivec and VSX (Vector-Scalar
Extension). It can just depend on CONFIG_VSX though, because that
already depends on FP and Altivec.

Otherwise we get lots of link errors such as:

  drivers/built-in.o: In function `.p8_aes_setkey':
  aes.c:(.text+0x2d325c): undefined reference to `.enable_kernel_altivec'
  aes.c:(.text+0x2d326c): undefined reference to `.enable_kernel_vsx'

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

v2: Spell out VSX, and CC linux-crypto.

 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 07bc7aa6b224..d234719065a5 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -461,7 +461,7 @@ config CRYPTO_DEV_QCE
 
 config CRYPTO_DEV_VMX
 	bool "Support for VMX cryptographic acceleration instructions"
-	depends on PPC64
+	depends on PPC64 && VSX
 	help
 	  Support for VMX cryptographic acceleration instructions.
 
-- 
2.1.4
