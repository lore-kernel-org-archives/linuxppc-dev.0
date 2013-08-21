Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB7AB2C0322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 12:13:42 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/4] powerpc/e500: Set -mcpu flag for 32-bit e500
Date: Tue, 20 Aug 2013 21:12:42 -0500
Message-ID: <1377051162-2588-5-git-send-email-scottwood@freescale.com>
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

Unlike 64-bit, we don't currently support multiplatform between e500
and non-e500, so the -mcpu is not configurable at this time.

-msoft-float is specified when testing for -mcpu=8540 because otherwise
some older toolchains will fail with "error: E500 and FPRs not
supported".

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 32dfd5d..51cfb78 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -104,6 +104,14 @@ E5500_CPU := $(call cc-option,-mcpu=e500mc64,-mcpu=powerpc64)
 CFLAGS-$(CONFIG_E5500_CPU) += $(E5500_CPU)
 CFLAGS-$(CONFIG_E6500_CPU) += $(call cc-option,-mcpu=e6500,$(E5500_CPU))
 
+ifeq ($(CONFIG_PPC32),y)
+ifeq ($(CONFIG_PPC_E500MC),y)
+CFLAGS-y += $(call cc-option,-mcpu=e500mc,-mcpu=powerpc)
+else
+CFLAGS-$(CONFIG_E500) += $(call cc-option,-mcpu=8540 -msoft-float,-mcpu=powerpc)
+endif
+endif
+
 CFLAGS-$(CONFIG_TUNE_CELL) += $(call cc-option,-mtune=cell)
 
 KBUILD_CPPFLAGS	+= -Iarch/$(ARCH)
-- 
1.8.1.2
