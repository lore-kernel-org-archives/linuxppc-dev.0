Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40mGfq0t8ZzDr4q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 May 2018 00:15:14 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id u6-v6so504273pls.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 07:15:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: [PATCH v4 1/4] powerpc/kbuild: set default generic machine type for
 32-bit compile
Date: Thu, 17 May 2018 00:14:55 +1000
Message-Id: <20180516141458.18996-2-npiggin@gmail.com>
In-Reply-To: <20180516141458.18996-1-npiggin@gmail.com>
References: <20180516141458.18996-1-npiggin@gmail.com>
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
---
 arch/powerpc/Makefile | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 95813df90801..15ca4bafad82 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -24,9 +24,20 @@ ifeq ($(HAS_BIARCH),y)
 ifeq ($(CROSS32_COMPILE),)
 CROSS32CC	:= $(CC) -m32
 KBUILD_ARFLAGS	+= --target=elf32-powerpc
+
+ifdef CONFIG_PPC32
+# These options will be overridden by any -mcpu option that the CPU
+# or platform code sets later on the command line, but they are needed
+# to set a sane 32-bit cpu target for the 64-bit cross compiler which
+# may default to the wrong ISA.
+KBUILD_CFLAGS		+= -mcpu=powerpc
+KBUILD_AFLAGS		+= -mcpu=powerpc
+endif
+
 endif
 endif
 
+
 export CROSS32CC CROSS32AR
 
 ifeq ($(CROSS_COMPILE),)
-- 
2.17.0
