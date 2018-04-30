Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Z6JQ4mTVzF257
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 11:24:06 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id j11-v6so5257342pgf.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2018 18:24:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 1/2] powerpc/kbuild: Use flags variables rather than
 overriding LD/CC/AS
Date: Mon, 30 Apr 2018 11:23:50 +1000
Message-Id: <20180430012351.28814-2-npiggin@gmail.com>
In-Reply-To: <20180430012351.28814-1-npiggin@gmail.com>
References: <20180430012351.28814-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc toolchain can compile combinations of 32/64 bit and
big/little endian, so it's convenient to consider, e.g.,

  CC -m64 -mbig-endian

To be the C compiler for the purpose of invoking it to build
target artifacts.

Rather than override, use kbuild defined variables to pass these
flags around. Importantly, they must be passed to things like
cc-option, so the usual cflags-y is not sufficient. This multitude
of inconsistently named variables is a mess, but it's marginally
better than overriding the toolchain because it matches what other
architectures do.

This allows powerpc builds to work with the new kconfig macro
language branch. XXX: not exactly sure why it fails in the first
place.

XXX: 32-bit builds with 64-bit toolchain gain some additional options
like -funit-at-a-time from cc-option. Unclear why that is. Build
appears to be correct otherwise.
---
 arch/powerpc/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 95813df90801..046b5dde9ff5 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -74,13 +74,15 @@ endif
 endif
 
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
-override LD	+= -EL
+KBUILD_CPPFLAGS	+= -mlittle-endian
+LDFLAGS		+= -EL
 LDEMULATION	:= lppc
 GNUTARGET	:= powerpcle
 MULTIPLEWORD	:= -mno-multiple
 KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-save-toc-indirect)
 else
-override LD	+= -EB
+KBUILD_CPPFLAGS += $(call cc-option,-mbig-endian)
+LDFLAGS		+= -EB
 LDEMULATION	:= ppc
 GNUTARGET	:= powerpc
 MULTIPLEWORD	:= -mmultiple
@@ -93,8 +95,6 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
 endif
 
-cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
-cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
 ifneq ($(cc-name),clang)
   cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
 endif
@@ -103,9 +103,9 @@ aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
 aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
 
 ifeq ($(HAS_BIARCH),y)
-override AS	+= -a$(BITS)
-override LD	+= -m elf$(BITS)$(LDEMULATION)
-override CC	+= -m$(BITS)
+KBUILD_CPPFLAGS	+= -m$(BITS)
+KBUILD_AFLAGS	+= -m$(BITS) -Wl,-a$(BITS)
+LDFLAGS		+= -m elf$(BITS)$(LDEMULATION)
 KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
 endif
 
-- 
2.17.0
