Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id F2289DDDF0
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:41:45 +1100 (EST)
Date: Mon, 12 Mar 2007 14:41:40 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 02/19] bootwrapper: Set -msoft-float and assembler target
	options.
Message-ID: <20070312204140.GB28545@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The bootwrapper should be built with the same target options as the
kernel.  In particular, -msoft-float and the assembler target need to be
set.

Without -msoft-float, floating point code can be executed (causing
problems on chips without FP).

Without the assembler target option, the assembler will use the old
dedicated mftb/mftbu instructions, rather than mfspr.  This causes the
boot to hang on e500, which doesn't have the dedicated instructions.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Makefile      |   10 +++++++---
 arch/powerpc/boot/Makefile |    6 ++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a00fe72..8e93565 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -69,7 +69,7 @@ CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH) -ffixed-r2 -mmultiple
 CPPFLAGS	+= $(CPPFLAGS-y)
 AFLAGS		+= $(AFLAGS-y)
-CFLAGS		+= -msoft-float -pipe $(CFLAGS-y)
+CFLAGS		+= -pipe $(CFLAGS-y)
 CPP		= $(CC) -E $(CFLAGS)
 # Temporary hack until we have migrated to asm-powerpc
 LINUXINCLUDE-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)/include
@@ -116,8 +116,12 @@ cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
-AFLAGS += $(cpu-as-y)
-CFLAGS += $(cpu-as-y)
+PLATFORM_AFLAGS += $(cpu-as-y)
+PLATFORM_CFLAGS += $(cpu-as-y) -msoft-float
+export PLATFORM_AFLAGS PLATFORM_CFLAGS
+
+AFLAGS += $(PLATFORM_AFLAGS)
+CFLAGS += $(PLATFORM_CFLAGS)
 
 head-y				:= arch/powerpc/kernel/head_32.o
 head-$(CONFIG_PPC64)		:= arch/powerpc/kernel/head_64.o
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index b1fc029..3c1202c 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -24,8 +24,10 @@ all: $(obj)/zImage
 
 HOSTCC		:= gcc
 BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem \
-		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC
-BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
+		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC \
+		   $(PLATFORM_CFLAGS)
+BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc \
+		   $(PLATFORM_AFLAGS)
 
 ifeq ($(call cc-option-yn, -fstack-protector),y)
 BOOTCFLAGS	+= -fno-stack-protector
-- 
1.5.0.3
