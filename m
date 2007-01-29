Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id BC088DE242
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:40:41 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0TKedAA013108
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:40:39 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKecND000867
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:40:38 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TKMmkn020278
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:22:48 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id A2AE74B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:40:37 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKeb86014111
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:40:37 -0600
Date: Mon, 29 Jan 2007 14:40:37 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/18] bootwrapper: Set -msoft-float and assembler target
	options.
Message-ID: <20070129204037.GA14087@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070129201154.GB13485@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Without -msoft-float, floating point state saving code can be executed
(at least with certain buggy versions of GCC, which don't clear bit 6 of
CR before calling a varargs function with no varargs parameters).

Without the assembler target option, the assembler will use the old
dedicated mftb/mftbu instructions, rather than mfspr.  This causes the
boot to hang on e500, which doesn't have the dedicated instructions.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Oops, I accidentally had -msoft-float in there twice for the bootwrapper
(once from PLATFORM_CFLAGS, and once directly specified).  This fixes it.

 arch/powerpc/Makefile      |   10 +++++++---
 arch/powerpc/boot/Makefile |    6 ++++--
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a00fe72..8e93565 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -69,7 +69,7 @@ CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc
 CFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH) -ffixed-r2 -mmultiple
 CPPFLAGS	+= $(CPPFLAGS-y)
 AFLAGS		+= $(AFLAGS-y)
-CFLAGS		+= -msoft-float -pipe $(CFLAGS-y)
+CFLAGS		+= -pipe $(CFLAGS-y)
 CPP		= $(CC) -E $(CFLAGS)
 # Temporary hack until we have migrated to asm-powerpc
 LINUXINCLUDE-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)/include
@@ -116,8 +116,12 @@ cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltive
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
index 98392fb..df92f06 100644
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
1.4.4
