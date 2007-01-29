Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 77A95DE06A
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:11:58 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0TKBuT2012936
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:11:56 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKBt9c022420
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:11:56 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJs5DC014707
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:54:05 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id CDD434B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:11:54 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKBs3l013506
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:11:54 -0600
Date: Mon, 29 Jan 2007 14:11:54 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/18] bootwrapper: Set -msoft-float and assembler target
	options.
Message-ID: <20070129201154.GB13485@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ca1ac163-f732-45ce-9629-e6f4a8c3a880@ld0162-tx32.am.freescale.net>
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
+		   $(PLATFORM_CFLAGS) -msoft-float
+BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc \
+		   $(PLATFORM_AFLAGS)
 
 ifeq ($(call cc-option-yn, -fstack-protector),y)
 BOOTCFLAGS	+= -fno-stack-protector
-- 
1.4.4
