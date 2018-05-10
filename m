Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hDYl5ZNgzF2RP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 10:26:51 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id g20-v6so165146pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 May 2018 17:26:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/kbuild: set generic machine type for compile with
 64-bit toolchain
Date: Thu, 10 May 2018 10:26:37 +1000
Message-Id: <20180510002637.3069-1-npiggin@gmail.com>
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
 arch/powerpc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 95813df90801..aa6464c81a9f 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -24,6 +24,12 @@ ifeq ($(HAS_BIARCH),y)
 ifeq ($(CROSS32_COMPILE),)
 CROSS32CC	:= $(CC) -m32
 KBUILD_ARFLAGS	+= --target=elf32-powerpc
+
+# These options will be overridden by any -mcpu option that comes
+# later on the command line, but they are needed to set a sane
+# 32-bit cpu target for the 64-bit cross compiler.
+KBUILD_CFLAGS		+= -mcpu=powerpc
+KBUILD_AFLAGS		+= -mcpu=powerpc
 endif
 endif
 
-- 
2.17.0
