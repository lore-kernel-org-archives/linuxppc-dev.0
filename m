Return-Path: <B32721@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6312B2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 21:39:33 +1000 (EST)
Received: from mail158-db8 (localhost [127.0.0.1])	by
 mail158-db8-R.bigfish.com (Postfix) with ESMTP id 6BD8F200224	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 11:39:24 +0000 (UTC)
Received: from DB8EHSMHS032.bigfish.com (unknown [10.174.8.236])	by
 mail158-db8.bigfish.com (Postfix) with ESMTP id 07E813E0045	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 11:39:23 +0000 (UTC)
From: Catalin Udma <catalin.udma@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v3] powerpc: Update compilation flags with core specific
 options
Date: Tue, 30 Jul 2013 14:39:24 +0300
Message-ID: <1375184364-9283-1-git-send-email-catalin.udma@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Catalin Udma <catalin.udma@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If CONFIG_E500 is enabled, the compilation flags are updated
specifying the target core -mcpu=e5500/e500mc/8540
Also remove -Wa,-me500, being incompatible with -mcpu=e5500/e6500
The assembler option is redundant if the -mcpu= flag is set.
The patch fixes the kernel compilation problem for e5500/e6500
when using gcc option -mcpu=e5500/e6500.

Signed-off-by: Catalin Udma <catalin.udma@freescale.com>
---
changes for v2:
    - update also KBUILD_AFLAGS with -mcpu and -msoft-float flags
changes for v3:
    - add -msoft-float to KBUILD_AFLAGS one time instead of adding it
      for each e500 core.

 arch/powerpc/Makefile |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 0624909..1893fb9 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -101,7 +101,7 @@ CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
 CFLAGS-$(CONFIG_TUNE_CELL) += $(call cc-option,-mtune=cell)
 
 KBUILD_CPPFLAGS	+= -Iarch/$(ARCH)
-KBUILD_AFLAGS	+= -Iarch/$(ARCH)
+KBUILD_AFLAGS	+= -msoft-float -Iarch/$(ARCH)
 KBUILD_CFLAGS	+= -msoft-float -pipe -Iarch/$(ARCH) $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
@@ -140,6 +140,21 @@ ifeq ($(CONFIG_6xx),y)
 KBUILD_CFLAGS		+= -mcpu=powerpc
 endif
 
+ifeq ($(CONFIG_E500),y)
+ifeq ($(CONFIG_64BIT),y)
+KBUILD_CFLAGS		+= -mcpu=e5500
+KBUILD_AFLAGS		+= -mcpu=e5500
+else
+ifeq ($(CONFIG_PPC_E500MC),y)
+KBUILD_CFLAGS		+= -mcpu=e500mc
+KBUILD_AFLAGS		+= -mcpu=e500mc
+else
+KBUILD_CFLAGS		+= -mcpu=8540
+KBUILD_AFLAGS		+= -mcpu=8540
+endif
+endif
+endif
+
 # Work around a gcc code-gen bug with -fno-omit-frame-pointer.
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
 KBUILD_CFLAGS		+= -mno-sched-epilog
@@ -147,7 +162,6 @@ endif
 
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= -Wa,-maltivec
-cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
 KBUILD_AFLAGS += $(cpu-as-y)
-- 
1.7.8
