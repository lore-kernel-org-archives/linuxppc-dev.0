Return-Path: <key@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DE5F3B7539
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2012 01:14:27 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Tue, 10 Apr 2012 09:14:24 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1611119D8053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 09:10:58 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3AFAWRV118666
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 09:10:36 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3AFAT4f000324
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 09:10:30 -0600
Message-ID: <1334070681.16827.33.camel@key-ThinkPad-W510>
Subject: [PATCH v2 16/17] powerpc: crypto: Build files for the nx device driver
From: Kent Yoder <key@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2012 10:11:21 -0500
In-Reply-To: <1334070249.16827.1.camel@key-ThinkPad-W510>
References: <1334070249.16827.1.camel@key-ThinkPad-W510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: key@linux.vnet.ibm.com, rcj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These files support configuring and building the nx device driver.

Signed-off-by: Kent Yoder <key@linux.vnet.ibm.com>
---
 arch/powerpc/Makefile      |    1 +
 drivers/crypto/Kconfig     |   17 +++++++++++++++++
 drivers/crypto/nx/Makefile |   11 +++++++++++
 3 files changed, 29 insertions(+), 0 deletions(-)
 create mode 100644 drivers/crypto/nx/Makefile

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6524c6e..16e1bd7 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -160,6 +160,7 @@ core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
 core-$(CONFIG_PERF_EVENTS)	+= arch/powerpc/perf/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
+drivers-$(CONFIG_CRYPTO_DEV_NX) += drivers/crypto/nx/
 
 # Default to zImage, override when needed
 all: zImage
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index ab9abb4..4319248 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -295,4 +295,21 @@ config CRYPTO_DEV_TEGRA_AES
 	  To compile this driver as a module, choose M here: the module
 	  will be called tegra-aes.
 
+config CRYPTO_DEV_NX
+	tristate "Support for Power7+ in-Nest cryptographic accleration"
+	depends on PPC64 && IBMVIO
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
+	  Support for Power7+ in-Nest cryptographic acceleration. This
+	  module supports acceleration for AES and SHA2 algorithms. If you
+	  choose 'M' here, this module will be called nx_crypto.
+
 endif # CRYPTO_HW
diff --git a/drivers/crypto/nx/Makefile b/drivers/crypto/nx/Makefile
new file mode 100644
index 0000000..411ce59
--- /dev/null
+++ b/drivers/crypto/nx/Makefile
@@ -0,0 +1,11 @@
+obj-$(CONFIG_CRYPTO_DEV_NX) += nx-crypto.o
+nx-crypto-objs := nx.o \
+		  nx_debugfs.o \
+		  nx-aes-cbc.o \
+		  nx-aes-ecb.o \
+		  nx-aes-gcm.o \
+		  nx-aes-ccm.o \
+		  nx-aes-ctr.o \
+		  nx-aes-xcbc.o \
+		  nx-sha256.o \
+		  nx-sha512.o
-- 
1.7.1
