Return-Path: <B32721@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 589572C0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 19:34:01 +1000 (EST)
Received: from mail190-tx2 (localhost [127.0.0.1])	by
 mail190-tx2-R.bigfish.com (Postfix) with ESMTP id 09BCA3000D6	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 09:33:57 +0000 (UTC)
Received: from TX2EHSMHS032.bigfish.com (unknown [10.9.14.247])	by
 mail190-tx2.bigfish.com (Postfix) with ESMTP id D90642C00E4	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 09:33:54 +0000 (UTC)
From: Udma Catalin-Dan-B32721 <B32721@freescale.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: Update compilation flags with core specific options
Date: Mon, 1 Jul 2013 09:33:53 +0000
Message-ID: <FE751157F0442848A159F3AB4CB1F55B3DBA47@039-SN1MPN1-001.039d.mgd.msft.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Udma Catalin-Dan-B32721 <B32721@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Catalin Udma <catalin.udma@freescale.com>

If CONFIG_E500 is enabled, the compilation flags are updated
specifying the target core -mcpu=3De5500/e500mc/8540
Also remove -Wa,-me500, being incompatible with -mcpu=3De5500/e6500
The assembler option is redundant if the -mcpu=3D flag is set.
The patch fixes the kernel compilation problem for e5500/e6500
when using gcc option -mcpu=3De5500/e6500.

Signed-off-by: Catalin Udma <catalin.udma@freescale.com>
---
 arch/powerpc/Makefile |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 0624909..82808b5 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -140,6 +140,18 @@ ifeq ($(CONFIG_6xx),y)
 KBUILD_CFLAGS		+=3D -mcpu=3Dpowerpc
 endif
=20
+ifeq ($(CONFIG_E500),y)
+ifeq ($(CONFIG_64BIT),y)
+KBUILD_CFLAGS		+=3D -mcpu=3De5500
+else
+ifeq ($(CONFIG_PPC_E500MC),y)
+KBUILD_CFLAGS		+=3D -mcpu=3De500mc
+else
+KBUILD_CFLAGS		+=3D -mcpu=3D8540
+endif
+endif
+endif
+
 # Work around a gcc code-gen bug with -fno-omit-frame-pointer.
 ifeq ($(CONFIG_FUNCTION_TRACER),y)
 KBUILD_CFLAGS		+=3D -mno-sched-epilog
@@ -147,7 +159,6 @@ endif
=20
 cpu-as-$(CONFIG_4xx)		+=3D -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+=3D -Wa,-maltivec
-cpu-as-$(CONFIG_E500)		+=3D -Wa,-me500
 cpu-as-$(CONFIG_E200)		+=3D -Wa,-me200
=20
 KBUILD_AFLAGS +=3D $(cpu-as-y)
--=20
1.7.8
