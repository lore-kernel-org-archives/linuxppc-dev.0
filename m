Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 141621A0E1D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 08:53:42 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 behanw@converseincode.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] powerpc: Only use -mtraceback=no,
 -mno-string and -msoft-float if toolchain supports it
Date: Tue, 26 May 2015 08:53:27 +1000
Message-Id: <1432594410-31198-4-git-send-email-anton@samba.org>
In-Reply-To: <1432594410-31198-1-git-send-email-anton@samba.org>
References: <1432594410-31198-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These options are not recognised on LLVM, so use call cc-option to check
for support.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 7a0daad..7c08b4e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -111,7 +111,7 @@ else
 endif
 endif
 
-CFLAGS-$(CONFIG_PPC64)	:= -mtraceback=no
+CFLAGS-$(CONFIG_PPC64)	:= $(call cc-option,-mtraceback=no)
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,-mcall-aixdesc)
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
@@ -158,7 +158,8 @@ asinstr := $(call as-instr,lis 9$(comma)foo@high,-DHAVE_AS_ATHIGH=1)
 
 KBUILD_CPPFLAGS	+= -Iarch/$(ARCH) $(asinstr)
 KBUILD_AFLAGS	+= -Iarch/$(ARCH) $(AFLAGS-y)
-KBUILD_CFLAGS	+= -msoft-float -pipe -Iarch/$(ARCH) $(CFLAGS-y)
+KBUILD_CFLAGS	+= $(call cc-option,-msoft-float)
+KBUILD_CFLAGS	+= -pipe -Iarch/$(ARCH) $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
 CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
@@ -190,7 +191,7 @@ KBUILD_CFLAGS	+= $(call cc-option,-fno-dwarf2-cfi-asm)
 
 # Never use string load/store instructions as they are
 # often slow when they are implemented at all
-KBUILD_CFLAGS		+= -mno-string
+KBUILD_CFLAGS		+= $(call cc-option,-mno-string)
 
 ifeq ($(CONFIG_6xx),y)
 KBUILD_CFLAGS		+= -mcpu=powerpc
-- 
2.1.4
