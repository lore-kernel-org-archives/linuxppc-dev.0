Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hM0q1p21zF2SM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 15:17:15 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id o76-v6so492447pfi.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 22:17:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/5] powerpc/kbuild: set default generic machine type for
 32-bit compile
Date: Thu, 10 May 2018 15:16:55 +1000
Message-Id: <20180510051659.15356-2-npiggin@gmail.com>
In-Reply-To: <20180510051659.15356-1-npiggin@gmail.com>
References: <20180510051659.15356-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 64-bit toolchain uses the wrong ISA variant for compiling 32-bit
kernels, eve with -m32. Set -mcpu=powerpc which is the generic 32-bit
powerpc machine type and scheduling model. 32-bit platforms and CPUs
can override this with -mcpu= options that come later on the command
line.

This fixes a lot of build failures due to incompatible assembly when
compiling 32-bit kernel with 64-bit toolchain.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 95813df90801..7034b1ad50e0 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -27,6 +27,14 @@ KBUILD_ARFLAGS	+= --target=elf32-powerpc
 endif
 endif
 
+ifdef CONFIG_PPC32
+# These options will be overridden by any -mcpu option that comes
+# later on the command line, but they are needed to set a sane
+# 32-bit cpu target for the 64-bit cross compiler.
+KBUILD_CFLAGS		+= -mcpu=powerpc
+KBUILD_AFLAGS		+= -mcpu=powerpc
+endif
+
 export CROSS32CC CROSS32AR
 
 ifeq ($(CROSS_COMPILE),)
-- 
2.17.0
