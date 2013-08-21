Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 94C6B2C010D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 12:13:40 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/4] powerpc/85xx: Remove -Wa,-me500
Date: Tue, 20 Aug 2013 21:12:40 -0500
Message-ID: <1377051162-2588-3-git-send-email-scottwood@freescale.com>
In-Reply-To: <1377051162-2588-1-git-send-email-scottwood@freescale.com>
References: <1377051162-2588-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Catalin Udma <catalin.udma@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This caused lwsync to be converted to sync on 64-bit (on 32-bit lwsync
is generated at runtime, and so wasn't affected).  Not using lwsync
caused a significant slowdown on certain workloads.

Setting this flag for any e500-enabled build is also not friendly to
multiplatform kernels.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 967fd23..6930c93 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -139,7 +139,6 @@ endif
 
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= -Wa,-maltivec
-cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
 KBUILD_AFLAGS += $(cpu-as-y)
-- 
1.8.1.2
