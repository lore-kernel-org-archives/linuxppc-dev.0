Return-Path: <sjenning@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 642FEB701F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 04:24:31 +1000 (EST)
Received: from /spool/local
 by e6.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sjenning@linux.vnet.ibm.com>;
 Wed, 13 Jun 2012 14:24:24 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 0A7246E8071
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 14:23:25 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5DINO5I147966
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 14:23:24 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5DINJhj032531
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 14:23:24 -0400
From: Seth Jennings <sjenning@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] drivers: crypto: move nx build to driver/crypto Makefile
Date: Wed, 13 Jun 2012 13:22:42 -0500
Message-Id: <1339611763-14603-1-git-send-email-sjenning@linux.vnet.ibm.com>
Cc: Seth Jennings <sjenning@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linux-crypto@vger.kernel.org,
 Kent Yoder <key@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the nx driver was pulled, the Makefile that actually
builds it is arch/powerpc/Makefile. This is unnatural.

This patch moves the line that builds the nx driver from
arch/powerpc/Makefile to drivers/crypto/Makefile where it
belongs.

Cc: Kent Yoder <key@linux.vnet.ibm.com>
Signed-off-by: Seth Jennings <sjenning@linux.vnet.ibm.com>
---
 arch/powerpc/Makefile   |    1 -
 drivers/crypto/Makefile |    3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 950d1f7..159e94f 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -149,7 +149,6 @@ core-$(CONFIG_KVM) 		+= arch/powerpc/kvm/
 core-$(CONFIG_PERF_EVENTS)	+= arch/powerpc/perf/
 
 drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
-drivers-$(CONFIG_CRYPTO_DEV_NX) += drivers/crypto/nx/
 
 # Default to zImage, override when needed
 all: zImage
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 0139032..67b4fbf 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_CRYPTO_DEV_OMAP_AES) += omap-aes.o
 obj-$(CONFIG_CRYPTO_DEV_PICOXCELL) += picoxcell_crypto.o
 obj-$(CONFIG_CRYPTO_DEV_S5P) += s5p-sss.o
 obj-$(CONFIG_CRYPTO_DEV_TEGRA_AES) += tegra-aes.o
-obj-$(CONFIG_CRYPTO_DEV_UX500) += ux500/
\ No newline at end of file
+obj-$(CONFIG_CRYPTO_DEV_UX500) += ux500/
+obj-$(CONFIG_CRYPTO_DEV_NX) += nx/
-- 
1.7.9.5
