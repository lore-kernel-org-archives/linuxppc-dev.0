Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmF7L1RPSzF1Bx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:06:05 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id y26so336014pgv.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 14:06:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 7/9] powerpc/64/le: add GENERIC_CPU support
Date: Wed, 21 Feb 2018 05:08:30 +1000
Message-Id: <20180220190832.1872-8-npiggin@gmail.com>
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

Add GENERIC_CPU support for little-endian rather than using POWER8
specific selection for POWER9 and above.

Restrict GENERIC_CPU to POWER8 and above on little endian.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile                  | 5 +++++
 arch/powerpc/platforms/Kconfig.cputype | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 2265d53023f4..973b1a1b98d2 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -144,8 +144,13 @@ CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
 
 ifeq ($(CONFIG_PPC_BOOK3S_64),y)
+ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
+CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=power8
+CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power8)
+else
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power7,$(call cc-option,-mtune=power5))
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mcpu=power5,-mcpu=power4)
+endif
 else
 CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
 endif
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 560466cc5170..ad878990c896 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -87,7 +87,6 @@ endchoice
 choice
 	prompt "CPU selection"
 	depends on PPC64
-	default POWER8_CPU if CPU_LITTLE_ENDIAN
 	default GENERIC_CPU
 	help
 	  This will create a kernel which is optimised for a particular CPU.
@@ -96,8 +95,9 @@ choice
 	  If unsure, select Generic.
 
 config GENERIC_CPU
-	bool "Generic"
-	depends on !CPU_LITTLE_ENDIAN
+	bool "Generic" if !CPU_LITTLE_ENDIAN
+	bool "Generic (POWER8 and above)" if CPU_LITTLE_ENDIAN
+	select ARCH_HAS_FAST_MULTIPLIER if CPU_LITTLE_ENDIAN
 
 config CELL_CPU
 	bool "Cell Broadband Engine"
-- 
2.16.1
