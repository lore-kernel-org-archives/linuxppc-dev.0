Return-Path: <cyrilbur@gmail.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9AE71A065B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 14:46:40 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Mon, 25 May 2015 14:46:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 02D603578057
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 14:46:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4P4kQlr20316264
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 14:46:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4P4k26d024128
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 14:46:02 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Henrique Cerri <mhcerri@linux.vnet.ibm.com>,
 Fionnuala Gunter <fin@linux.vnet.ibm.com>,
 linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] crypto: nx - tweak Makefile dependencies
Date: Mon, 25 May 2015 14:45:16 +1000
Message-Id: <1432529116-21279-1-git-send-email-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Selecting CRYPTO_DEV_NX causes a conditional include of nx/Kconfig but
options within nx/Kconfig do not depend on it. The included options should
depend on CRYPTO_DEV_NX since currently CRYPTO_DEV_NX cannot be built for
little endian. While Kconfig appears to understand this convoluted
dependency situation, it isn't explicitly stated.

This patch addresses the missing dependencies for CRYPTO_DEV_NX_ENCRYPT and
CRYPTO_DEV_NX_COMPRESS which should depend on CRYPTO_DEV_NX. It also makes
more sense to put all three options into the nx/Kconfig file and have the
file included unconditionally.

CC: Marcelo Henrique Cerri <mhcerri@linux.vnet.ibm.com>
CC: Fionnuala Gunter <fin@linux.vnet.ibm.com>
CC: linux-crypto@vger.kernel.org
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 drivers/crypto/Kconfig    | 11 +----------
 drivers/crypto/nx/Kconfig | 11 +++++++++--
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 033c0c8..cc96a7d 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -311,16 +311,7 @@ config CRYPTO_DEV_S5P
 	  Select this to offload Samsung S5PV210 or S5PC110, Exynos from AES
 	  algorithms execution.
 
-config CRYPTO_DEV_NX
-	bool "Support for IBM Power7+ in-Nest cryptographic acceleration"
-	depends on PPC64 && IBMVIO && !CPU_LITTLE_ENDIAN
-	default n
-	help
-	  Support for Power7+ in-Nest cryptographic acceleration.
-
-if CRYPTO_DEV_NX
-	source "drivers/crypto/nx/Kconfig"
-endif
+source "drivers/crypto/nx/Kconfig"
 
 config CRYPTO_DEV_UX500
 	tristate "Driver for ST-Ericsson UX500 crypto hardware acceleration"
diff --git a/drivers/crypto/nx/Kconfig b/drivers/crypto/nx/Kconfig
index f826166..0726f12 100644
--- a/drivers/crypto/nx/Kconfig
+++ b/drivers/crypto/nx/Kconfig
@@ -1,6 +1,13 @@
+config CRYPTO_DEV_NX
+	bool "Support for IBM Power7+ in-Nest cryptographic acceleration"
+	depends on PPC64 && IBMVIO && !CPU_LITTLE_ENDIAN
+	default n
+	help
+	  Support for Power7+ in-Nest cryptographic acceleration.
+
 config CRYPTO_DEV_NX_ENCRYPT
 	tristate "Encryption acceleration support"
-	depends on PPC64 && IBMVIO
+	depends on CRYPTO_DEV_NX
 	default y
 	select CRYPTO_AES
 	select CRYPTO_CBC
@@ -18,7 +25,7 @@ config CRYPTO_DEV_NX_ENCRYPT
 
 config CRYPTO_DEV_NX_COMPRESS
 	tristate "Compression acceleration support"
-	depends on PPC64 && IBMVIO
+	depends on CRYPTO_DEV_NX
 	default y
 	help
 	  Support for Power7+ in-Nest compression acceleration. This
-- 
1.9.1
