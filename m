Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmFGL65lSzF18G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:12:10 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id a6so4023797pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 14:12:10 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 9/9] powerpc/64s: add POWER9 CPU type selection
Date: Wed, 21 Feb 2018 05:08:32 +1000
Message-Id: <20180220190832.1872-10-npiggin@gmail.com>
In-Reply-To: <20180220190832.1872-1-npiggin@gmail.com>
References: <20180220190832.1872-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile                  | 3 ++-
 arch/powerpc/platforms/Kconfig.cputype | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 973b1a1b98d2..f46b6cf364d7 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -146,7 +146,7 @@ CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
 ifeq ($(CONFIG_PPC_BOOK3S_64),y)
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=power8
-CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power8)
+CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power9,-mtune=power8)
 else
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power7,$(call cc-option,-mtune=power5))
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mcpu=power5,-mcpu=power4)
@@ -175,6 +175,7 @@ CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
 CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
 CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
 CFLAGS-$(CONFIG_POWER8_CPU) += $(call cc-option,-mcpu=power8)
+CFLAGS-$(CONFIG_POWER9_CPU) += $(call cc-option,-mcpu=power9)
 
 # Altivec option not allowed with e500mc64 in GCC.
 ifeq ($(CONFIG_ALTIVEC),y)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index ad878990c896..69be65450c0c 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -121,6 +121,11 @@ config POWER8_CPU
 	depends on PPC_BOOK3S_64
 	select ARCH_HAS_FAST_MULTIPLIER
 
+config POWER9_CPU
+	bool "POWER9"
+	depends on PPC_BOOK3S_64
+	select ARCH_HAS_FAST_MULTIPLIER
+
 config E5500_CPU
 	bool "Freescale e5500"
 	depends on E500
-- 
2.16.1
