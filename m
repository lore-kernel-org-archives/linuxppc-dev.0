Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7v966MlNzDqQp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 22:43:54 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Nick Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 <imunsie@au.ibm.com>
Subject: [PATCH] powerpc/Makefile: Use cflags-y/aflags-y for setting endian
 options
Date: Tue,  9 Aug 2016 22:43:46 +1000
Message-Id: <1470746626-1989-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we introduced the little endian support, we added the endian flags
to CC directly using override. I don't know the history of why we did
that, I suspect no one does.

Although this mostly works, it has one bug, which is that CROSS32CC
doesn't get -mbig-endian. That means when the compiler is little endian
by default and the user is building big endian, vdso32 is incorrectly
compiled as little endian and the kernel fails to build.

Instead we can add the endian flags to cflags-y/aflags-y, and then
append those to KBUILD_CFLAGS/KBUILD_AFLAGS.

This has the advantage of being 1) less ugly, 2) the documented way of
adding flags in the arch Makefile and 3) it fixes building vdso32 with a
LE toolchain.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ca254546cd05..1934707bf321 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -66,29 +66,28 @@ endif
 UTS_MACHINE := $(OLDARCH)
 
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
-override CC	+= -mlittle-endian
-ifneq ($(cc-name),clang)
-override CC	+= -mno-strict-align
-endif
-override AS	+= -mlittle-endian
 override LD	+= -EL
-override CROSS32CC += -mlittle-endian
 override CROSS32AS += -mlittle-endian
 LDEMULATION	:= lppc
 GNUTARGET	:= powerpcle
 MULTIPLEWORD	:= -mno-multiple
 KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-save-toc-indirect)
 else
-ifeq ($(call cc-option-yn,-mbig-endian),y)
-override CC	+= -mbig-endian
-override AS	+= -mbig-endian
-endif
 override LD	+= -EB
 LDEMULATION	:= ppc
 GNUTARGET	:= powerpc
 MULTIPLEWORD	:= -mmultiple
 endif
 
+cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
+cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
+ifneq ($(cc-name),clang)
+  cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
+endif
+
+aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
+aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
+
 ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(CONFIG_WORD_SIZE)
 override LD	+= -m elf$(CONFIG_WORD_SIZE)$(LDEMULATION)
@@ -232,6 +231,9 @@ cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)
 
+KBUILD_AFLAGS += $(aflags-y)
+KBUILD_CFLAGS += $(cflags-y)
+
 head-y				:= arch/powerpc/kernel/head_$(CONFIG_WORD_SIZE).o
 head-$(CONFIG_8xx)		:= arch/powerpc/kernel/head_8xx.o
 head-$(CONFIG_40x)		:= arch/powerpc/kernel/head_40x.o
-- 
2.7.4
