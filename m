Return-Path: <joel.stan@gmail.com>
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DJ9C6yk3zF1QT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 17:46:39 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id t19-v6so6995769ply.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 00:46:39 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] powerpc: Disable -Wbuiltin-requires-header when setjmp is used
Date: Mon, 17 Sep 2018 17:16:21 +0930
Message-Id: <20180917074621.25066-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc kernel uses setjmp which causes a warning when building with
clang:

    CC      arch/powerpc/xmon/xmon.o
  In file included from arch/powerpc/xmon/xmon.c:51:
  ./arch/powerpc/include/asm/setjmp.h:15:13: error: declaration of
  built-in function 'setjmp' requires inclusion of the header <setjmp.h>
        [-Werror,-Wbuiltin-requires-header]
  extern long setjmp(long *);
              ^
  ./arch/powerpc/include/asm/setjmp.h:16:13: error: declaration of
  built-in function 'longjmp' requires inclusion of the header <setjmp.h>
        [-Werror,-Wbuiltin-requires-header]
  extern void longjmp(long *, long);
              ^

This *is* the header and we're not using the built-in setjump but
rather the one in arch/powerpc/kernel/misc.S. As the compiler warning
does not make sense, it for the files where setjmp is used.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
We could instead disable this for all of the kernel as I don't think the
warning is going to ever provide useful information for the kernel.

 arch/powerpc/kernel/Makefile | 3 +++
 arch/powerpc/xmon/Makefile   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1e64cfe22a83..9845a94f5f68 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -7,6 +7,9 @@ CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
+# Disable clang warning for using setjmp without setjmp.h header
+CFLAGS_crash.o		+= $(call cc-disable-warning, builtin-requires-header)
+
 ifdef CONFIG_PPC64
 CFLAGS_prom_init.o	+= $(NO_MINIMAL_TOC)
 endif
diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
index 93cc1f1b8b61..a38db48f9f6d 100644
--- a/arch/powerpc/xmon/Makefile
+++ b/arch/powerpc/xmon/Makefile
@@ -14,6 +14,9 @@ ccflags-$(CONFIG_PPC64) := $(NO_MINIMAL_TOC)
 
 obj-y			+= xmon.o nonstdio.o spr_access.o
 
+# Disable clang warning for using setjmp without setjmp.h header
+subdir-ccflags-y := $(call cc-disable-warning, builtin-requires-header)
+
 ifdef CONFIG_XMON_DISASSEMBLY
 obj-y			+= ppc-dis.o ppc-opc.o
 obj-$(CONFIG_SPU_BASE)	+= spu-dis.o spu-opc.o
-- 
2.17.1
