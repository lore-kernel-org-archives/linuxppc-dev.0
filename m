Return-Path: <B32721@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F01E42C009E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 21:23:39 +1000 (EST)
Received: from mail159-va3 (localhost [127.0.0.1])	by
 mail159-va3-R.bigfish.com (Postfix) with ESMTP id 129011C0166	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 11:23:34 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.252])	by
 mail159-va3.bigfish.com (Postfix) with ESMTP id 806CB42007C	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 11:23:32 +0000 (UTC)
From: Catalin Udma <catalin.udma@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Update compilation flags with core specific options
Date: Tue, 2 Jul 2013 14:20:04 +0300
Message-ID: <1372764004-18896-1-git-send-email-catalin.udma@freescale.com>
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
 arch/powerpc/Makefile |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 0624909..82808b5 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -140,6 +140,18 @@ ifeq ($(CONFIG_6xx),y)
 KBUILD_CFLAGS		+= -mcpu=powerpc
 endif
 
+ifeq ($(CONFIG_E500),y)
+ifeq ($(CONFIG_64BIT),y)
+KBUILD_CFLAGS		+= -mcpu=e5500
+else
+ifeq ($(CONFIG_PPC_E500MC),y)
+KBUILD_CFLAGS		+= -mcpu=e500mc
+else
+KBUILD_CFLAGS		+= -mcpu=8540
+endif
+endif
+endif
+
 # Work around a gcc code-gen bug with -fno-omit-frame-pointer.
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
 KBUILD_CFLAGS		+= -mno-sched-epilog
@@ -147,7 +159,6 @@ endif
 
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= -Wa,-maltivec
-cpu-as-$(CONFIG_E500)		+= -Wa,-me500
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
 KBUILD_AFLAGS += $(cpu-as-y)
-- 
1.7.8
