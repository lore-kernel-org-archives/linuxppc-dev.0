Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hM0t3FqCzF2SZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 15:17:18 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id p9-v6so436583pgc.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 22:17:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/5] powerpc/kbuild: remove CROSS32 defines from top level
 powerpc Makefile
Date: Thu, 10 May 2018 15:16:56 +1000
Message-Id: <20180510051659.15356-3-npiggin@gmail.com>
In-Reply-To: <20180510051659.15356-1-npiggin@gmail.com>
References: <20180510051659.15356-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Switch VDSO32 build over to use CROSS32_COMPILE directly, and have
it pass in -m32 after the standard c_flags. This allows endianness
overrides to be removed and the endian and bitness flags moved into
standard flags variables.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile               | 12 ------------
 arch/powerpc/boot/Makefile          | 16 +++++++++++-----
 arch/powerpc/kernel/vdso32/Makefile | 15 +++++++++++----
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 7034b1ad50e0..a40f59ca2afe 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -17,16 +17,6 @@ HAS_BIARCH	:= $(call cc-option-yn, -m32)
 # Set default 32 bits cross compilers for vdso and boot wrapper
 CROSS32_COMPILE ?=
 
-CROSS32CC		:= $(CROSS32_COMPILE)gcc
-CROSS32AR		:= $(CROSS32_COMPILE)ar
-
-ifeq ($(HAS_BIARCH),y)
-ifeq ($(CROSS32_COMPILE),)
-CROSS32CC	:= $(CC) -m32
-KBUILD_ARFLAGS	+= --target=elf32-powerpc
-endif
-endif
-
 ifdef CONFIG_PPC32
 # These options will be overridden by any -mcpu option that comes
 # later on the command line, but they are needed to set a sane
@@ -35,8 +25,6 @@ KBUILD_CFLAGS		+= -mcpu=powerpc
 KBUILD_AFLAGS		+= -mcpu=powerpc
 endif
 
-export CROSS32CC CROSS32AR
-
 ifeq ($(CROSS_COMPILE),)
 KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
 else
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 26d5d2a5b8e9..49767e06202c 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -23,19 +23,23 @@ all: $(obj)/zImage
 compress-$(CONFIG_KERNEL_GZIP) := CONFIG_KERNEL_GZIP
 compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
 
+ifdef CROSS32_COMPILE
+    BOOTCC := $(CROSS32_COMPILE)gcc
+    BOOTAR := $(CROSS32_COMPILE)ar
+else
+    BOOTCC := $(CC)
+    BOOTAR := $(AR)
+endif
+
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
 		 -D$(compress-y)
 
-BOOTCC := $(CC)
 ifdef CONFIG_PPC64_BOOT_WRAPPER
 BOOTCFLAGS	+= -m64
 else
 BOOTCFLAGS	+= -m32
-ifdef CROSS32_COMPILE
-    BOOTCC := $(CROSS32_COMPILE)gcc
-endif
 endif
 
 BOOTCFLAGS	+= -isystem $(shell $(BOOTCC) -print-file-name=include)
@@ -49,6 +53,8 @@ endif
 
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
+BOOTARFLAGS	:= -cr$(KBUILD_ARFLAGS)
+
 ifdef CONFIG_DEBUG_INFO
 BOOTCFLAGS	+= -g
 endif
@@ -202,7 +208,7 @@ quiet_cmd_bootas = BOOTAS  $@
       cmd_bootas = $(BOOTCC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
 
 quiet_cmd_bootar = BOOTAR  $@
-      cmd_bootar = $(CROSS32AR) -cr$(KBUILD_ARFLAGS) $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
+      cmd_bootar = $(BOOTAR) $(BOOTARFLAGS) $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
 
 $(obj-libfdt): $(obj)/%.o: $(srctree)/scripts/dtc/libfdt/%.c FORCE
 	$(call if_changed_dep,bootcc)
diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vdso32/Makefile
index b8c434d1d459..50112d4473bb 100644
--- a/arch/powerpc/kernel/vdso32/Makefile
+++ b/arch/powerpc/kernel/vdso32/Makefile
@@ -8,8 +8,15 @@ obj-vdso32 = sigtramp.o gettimeofday.o datapage.o cacheflush.o note.o \
 
 # Build rules
 
-ifeq ($(CONFIG_PPC32),y)
-CROSS32CC := $(CC)
+ifdef CROSS32_COMPILE
+    VDSOCC := $(CROSS32_COMPILE)gcc
+else
+    VDSOCC := $(CC)
+endif
+
+CC32FLAGS :=
+ifdef CONFIG_PPC64
+CC32FLAGS += -m32
 endif
 
 targets := $(obj-vdso32) vdso32.so vdso32.so.dbg
@@ -45,9 +52,9 @@ $(obj-vdso32): %.o: %.S FORCE
 
 # actual build commands
 quiet_cmd_vdso32ld = VDSO32L $@
-      cmd_vdso32ld = $(CROSS32CC) $(c_flags) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
+      cmd_vdso32ld = $(VDSOCC) $(c_flags) $(CC32FLAGS) -o $@ -Wl,-T$(filter %.lds,$^) $(filter %.o,$^)
 quiet_cmd_vdso32as = VDSO32A $@
-      cmd_vdso32as = $(CROSS32CC) $(a_flags) -c -o $@ $<
+      cmd_vdso32as = $(VDSOCC) $(a_flags) $(CC32FLAGS) -c -o $@ $<
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
-- 
2.17.0
