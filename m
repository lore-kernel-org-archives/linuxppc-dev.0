Return-Path: <marcelo.cerri@canonical.com>
Received: from mail-qk0-x22b.google.com (mail-qk0-x22b.google.com
 [IPv6:2607:f8b0:400d:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skk5y2qqhzDrZc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Sep 2016 02:43:02 +1000 (AEST)
Received: by mail-qk0-x22b.google.com with SMTP id z190so52608319qkc.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 09:43:02 -0700 (PDT)
From: Marcelo Cerri <marcelo.cerri@canonical.com>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
 Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
 "Leonidas S. Barbosa" <leosilva@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 George Wilson <gcwilson@us.ibm.com>,
 Marcelo Cerri <marcelo.cerri@canonical.com>
Subject: [PATCH 3/3] crypto: vmx - Ensure ghash-generic is enabled
Date: Wed, 28 Sep 2016 13:42:11 -0300
Message-Id: <1475080931-7926-4-git-send-email-marcelo.cerri@canonical.com>
In-Reply-To: <1475080931-7926-1-git-send-email-marcelo.cerri@canonical.com>
References: <1475080931-7926-1-git-send-email-marcelo.cerri@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add CRYPTO_GHASH as a dependency for vmx_crypto since p8_ghash uses it
as the fallback implementation.

Signed-off-by: Marcelo Cerri <marcelo.cerri@canonical.com>
---
 drivers/crypto/vmx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/vmx/Kconfig b/drivers/crypto/vmx/Kconfig
index a83ead1..c21b09a 100644
--- a/drivers/crypto/vmx/Kconfig
+++ b/drivers/crypto/vmx/Kconfig
@@ -1,6 +1,6 @@
 config CRYPTO_DEV_VMX_ENCRYPT
 	tristate "Encryption acceleration support on P8 CPU"
-	depends on CRYPTO_DEV_VMX
+	depends on CRYPTO_DEV_VMX || CRYPTO_GHASH
 	default m
 	help
 	  Support for VMX cryptographic acceleration instructions on Power8 CPU.
-- 
2.7.4
