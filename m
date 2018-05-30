Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x242.google.com (mail-pl0-x242.google.com
 [IPv6:2607:f8b0:400e:c01::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wqQy2brrzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 22:19:38 +1000 (AEST)
Received: by mail-pl0-x242.google.com with SMTP id n10-v6so10991807plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 05:19:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v5 1/4] powerpc/kbuild: set default generic machine type for
 32-bit compile
Date: Wed, 30 May 2018 22:19:19 +1000
Message-Id: <20180530121922.22122-2-npiggin@gmail.com>
In-Reply-To: <20180530121922.22122-1-npiggin@gmail.com>
References: <20180530121922.22122-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some 64-bit toolchains uses the wrong ISA variant for compiling 32-bit
kernels, even with -m32. Debian's powerpc64le is one such case, and
that is because it is built with --with-cpu=power8.

So when cross compiling a 32-bit kernel with a 64-bit toolchain, set
-mcpu=powerpc initially, which is the generic 32-bit powerpc machine
type and scheduling model. CPU and platform code can override this
with subsequent -mcpu flags if necessary.

This is not done for 32-bit toolchains otherwise it would override
their defaults, which are presumably set appropriately for the
environment (moreso than a 64-bit cross compiler).

This fixes a lot of build failures due to incompatible assembly when
compiling 32-bit kernel with th Debian powerpc64le 64-bit toolchain.

Cc: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Since v1: reworded changelog to explain the cause of the problem (thanks
Segher) and moved the flags into the 64-32 cross compile case.
---
 arch/powerpc/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 95813df90801..d628724087c6 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -24,6 +24,14 @@ ifeq ($(HAS_BIARCH),y)
 ifeq ($(CROSS32_COMPILE),)
 CROSS32CC	:= $(CC) -m32
 KBUILD_ARFLAGS	+= --target=elf32-powerpc
+ifdef CONFIG_PPC32
+# These options will be overridden by any -mcpu option that the CPU
+# or platform code sets later on the command line, but they are needed
+# to set a sane 32-bit cpu target for the 64-bit cross compiler which
+# may default to the wrong ISA.
+KBUILD_CFLAGS		+= -mcpu=powerpc
+KBUILD_AFLAGS		+= -mcpu=powerpc
+endif
 endif
 endif
 
-- 
2.17.0
