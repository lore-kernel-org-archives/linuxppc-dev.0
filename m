Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHbKt0jgWzDqnd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 23:19:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/boot: Fix 64-bit boot wrapper build with non-biarch
 compiler
Date: Wed, 26 Jul 2017 23:19:04 +1000
Message-Id: <1501075144-20582-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Historically the boot wrapper was always built 32-bit big endian, even
for 64-bit kernels. That was because old firmwares didn't necessarily
support booting a 64-bit image. Because of that arch/powerpc/boot/Makefile
uses CROSS32CC for compilation.

However when we added 64-bit little endian support, we also added
support for building the boot wrapper 64-bit. However we kept using
CROSS32CC, because in most cases it is just CC and everything works.

However if the user doesn't specify CROSS32_COMPILE (which no one ever
does AFAIK), and CC is *not* biarch (32/64-bit capable), then CROSS32CC
becomes just "gcc". On native systems that is probably OK, but if we're
cross building it definitely isn't, leading to eg:

  gcc ... -m64 -mlittle-endian -mabi=elfv2 ... arch/powerpc/boot/cpm-serial.c
  gcc: error: unrecognized argument in option ‘-mabi=elfv2’
  gcc: error: unrecognized command line option ‘-mlittle-endian’
  make: *** [zImage] Error 2

To fix it, stop using CROSS32CC, because we may or may not be building
32-bit. Instead setup a BOOTCC, which defaults to CC, and only use
CROSS32_COMPILE if it's set and we're building for 32-bit.

Fixes: 147c05168fc8 ("powerpc/boot: Add support for 64bit little endian wrapper")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index a7814a7b1523..6f952fe1f084 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -25,12 +25,20 @@ compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
-		 -isystem $(shell $(CROSS32CC) -print-file-name=include) \
 		 -D$(compress-y)
 
+BOOTCC := $(CC)
 ifdef CONFIG_PPC64_BOOT_WRAPPER
 BOOTCFLAGS	+= -m64
+else
+BOOTCFLAGS	+= -m32
+ifdef CROSS32_COMPILE
+    BOOTCC := $(CROSS32_COMPILE)gcc
+endif
 endif
+
+BOOTCFLAGS	+= -isystem $(shell $(BOOTCC) -print-file-name=include)
+
 ifdef CONFIG_CPU_BIG_ENDIAN
 BOOTCFLAGS	+= -mbig-endian
 else
@@ -183,10 +191,10 @@ clean-files := $(zlib-) $(zlibheader-) $(zliblinuxheader-) \
 		empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
 
 quiet_cmd_bootcc = BOOTCC  $@
-      cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
+      cmd_bootcc = $(BOOTCC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
 
 quiet_cmd_bootas = BOOTAS  $@
-      cmd_bootas = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
+      cmd_bootas = $(BOOTCC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
 
 quiet_cmd_bootar = BOOTAR  $@
       cmd_bootar = $(CROSS32AR) -cr$(KBUILD_ARFLAGS) $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
-- 
2.7.4
