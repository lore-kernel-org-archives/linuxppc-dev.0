Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 705EC1A2753
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 16:15:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: leosilva@linux.vnet.ibm.com, herbert@gondor.apana.org.au,
 Paul Mackerras <paulus@samba.org>, tim.gardner@canonical.com
Subject: [PATCH] crypto: vmx - VMX crypto should depend on CONFIG_VSX
Date: Wed,  9 Sep 2015 16:15:23 +1000
Message-Id: <1441779323-901-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code uses FP (floating point), Altivec and VSX. It can just depend on
CONFIG_VSX though, because that already depends on FP and Altivec.

Otherwise we get lots of link errors such as:

  drivers/built-in.o: In function `.p8_aes_setkey':
  aes.c:(.text+0x2d325c): undefined reference to `.enable_kernel_altivec'
  aes.c:(.text+0x2d326c): undefined reference to `.enable_kernel_vsx'

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
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
