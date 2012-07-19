Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e2.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BDF932C0275
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 00:55:04 +1000 (EST)
Received: from /spool/local
 by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Thu, 19 Jul 2012 10:44:21 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 888546E804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 10:43:48 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6JEhlni376302
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 10:43:48 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6JEgqDi019954
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2012 08:42:54 -0600
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc/crypto: rework Kconfig
Date: Thu, 19 Jul 2012 09:42:38 -0500
Message-Id: <1342708961-28587-2-git-send-email-sjenning@linux.vnet.ibm.com>
In-Reply-To: <1342708961-28587-1-git-send-email-sjenning@linux.vnet.ibm.com>
References: <1342708961-28587-1-git-send-email-sjenning@linux.vnet.ibm.com>
Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>,
 Kent Yoder <key@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Robert Jennings <rcj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch creates a new submenu for the NX cryptographic
hardware accelerator and breaks the NX options into their own
Kconfig file under drivers/crypto/nx/Kconfig.

This will permit additional NX functionality to be easily
and more cleanly added in the future without touching
drivers/crypto/Makefile|Kconfig.

Signed-off-by: Seth Jennings <sjenning@linux.vnet.ibm.com>
---
 drivers/crypto/Kconfig     |   20 +++++++-------------
 drivers/crypto/nx/Kconfig  |   17 +++++++++++++++++
 drivers/crypto/nx/Makefile |    2 +-
 3 files changed, 25 insertions(+), 14 deletions(-)
 create mode 100644 drivers/crypto/nx/Kconfig

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 7d74d09..662588a 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -298,21 +298,15 @@ config CRYPTO_DEV_TEGRA_AES
 	  will be called tegra-aes.
 
 config CRYPTO_DEV_NX
-	tristate "Support for Power7+ in-Nest cryptographic acceleration"
+	bool "Support for IBM Power7+ in-Nest cryptographic acceleration"
 	depends on PPC64 && IBMVIO
-	select CRYPTO_AES
-	select CRYPTO_CBC
-	select CRYPTO_ECB
-	select CRYPTO_CCM
-	select CRYPTO_GCM
-	select CRYPTO_AUTHENC
-	select CRYPTO_XCBC
-	select CRYPTO_SHA256
-	select CRYPTO_SHA512
+	default n
 	help
-	  Support for Power7+ in-Nest cryptographic acceleration. This
-	  module supports acceleration for AES and SHA2 algorithms. If you
-	  choose 'M' here, this module will be called nx_crypto.
+	  Support for Power7+ in-Nest cryptographic acceleration.
+
+if CRYPTO_DEV_NX
+	source "drivers/crypto/nx/Kconfig"
+endif
 
 config CRYPTO_DEV_UX500
 	tristate "Driver for ST-Ericsson UX500 crypto hardware acceleration"
diff --git a/drivers/crypto/nx/Kconfig b/drivers/crypto/nx/Kconfig
new file mode 100644
index 0000000..dedde53
--- /dev/null
+++ b/drivers/crypto/nx/Kconfig
@@ -0,0 +1,17 @@
+config CRYPTO_DEV_NX_ENCRYPT
+	tristate "Encryption acceleration support"
+	depends on PPC64 && IBMVIO
+	default y
+	select CRYPTO_AES
+	select CRYPTO_CBC
+	select CRYPTO_ECB
+	select CRYPTO_CCM
+	select CRYPTO_GCM
+	select CRYPTO_AUTHENC
+	select CRYPTO_XCBC
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	help
+	  Support for Power7+ in-Nest encryption acceleration. This
+	  module supports acceleration for AES and SHA2 algorithms. If you
+	  choose 'M' here, this module will be called nx_crypto.
diff --git a/drivers/crypto/nx/Makefile b/drivers/crypto/nx/Makefile
index 411ce59..7f110e4 100644
--- a/drivers/crypto/nx/Makefile
+++ b/drivers/crypto/nx/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_CRYPTO_DEV_NX) += nx-crypto.o
+obj-$(CONFIG_CRYPTO_DEV_NX_ENCRYPT) += nx-crypto.o
 nx-crypto-objs := nx.o \
 		  nx_debugfs.o \
 		  nx-aes-cbc.o \
-- 
1.7.9.5
