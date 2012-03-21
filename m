Return-Path: <key@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 68F4CB6EF3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 08:40:51 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Wed, 21 Mar 2012 17:40:48 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3038138C803A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 17:40:46 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q2LLej3C3629302
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 17:40:45 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q2LLejfb001432
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 18:40:45 -0300
Message-ID: <1332366097.3858.54.camel@key-ThinkPad-W510>
Subject: [PATCH 16/17] powerpc: crypto: Build files for the nx device driver
From: Kent Yoder <key@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 21 Mar 2012 16:41:37 -0500
In-Reply-To: <1332365297.3858.5.camel@key-ThinkPad-W510>
References: <1332365297.3858.5.camel@key-ThinkPad-W510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: rcj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org
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
 arch/powerpc/Makefile           |    1 +
 arch/powerpc/crypto/nx/Makefile |   11 +++++++++++
 drivers/crypto/Kconfig          |   18 ++++++++++++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/crypto/nx/Makefile

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index b8b105c..4977c65 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -159,6 +159,7 @@ core-$(CONFIG_XMON)		+= arch/powerpc/xmon/
 core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
+drivers-$(CONFIG_CRYPTO_DEV_NX) += arch/powerpc/crypto/nx/
 
 # Default to zImage, override when needed
 all: zImage
diff --git a/arch/powerpc/crypto/nx/Makefile b/arch/powerpc/crypto/nx/Makefile
new file mode 100644
index 0000000..39a283f
--- /dev/null
+++ b/arch/powerpc/crypto/nx/Makefile
@@ -0,0 +1,11 @@
+obj-$(CONFIG_CRYPTO_DEV_NX) += nx-crypto.o
+nx-crypto-objs := nx.o \
+		  nx_sysfs.o \
+		  nx-aes-cbc.o \
+		  nx-aes-ecb.o \
+		  nx-aes-gcm.o \
+		  nx-aes-ccm.o \
+		  nx-aes-ctr.o \
+		  nx-aes-xcbc.o \
+		  nx-sha256.o \
+		  nx-sha512.o
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 6d16b4b..f438ca5 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -293,4 +293,22 @@ config CRYPTO_DEV_S5P
 	  Select this to offload Samsung S5PV210 or S5PC110 from AES
 	  algorithms execution.
 
+
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
-- 
1.7.1
