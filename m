Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP2Yk4Dk3zDw29
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 00:02:34 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 3so1096247pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 05:02:34 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Alan Modra <amodra@gmail.com>
Subject: [PATCH 2/3] powerpc: allow compilation on cross-endian toolchain
Date: Thu, 24 Nov 2016 00:02:08 +1100
Message-Id: <20161123130209.1667-3-npiggin@gmail.com>
In-Reply-To: <20161123130209.1667-1-npiggin@gmail.com>
References: <20161123130209.1667-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

GCC can compile with either endian, but the ABI version always
defaults to the default endian. Alan Modra says:

  you need both -mbig and -mabi=elfv1 to make a powerpc64le gcc
  generate powerpc64 code

The opposite is true for powerpc64 when generating -mlittle it
requires -mabi=elfv2 to generate v2 ABI. This change adds abi
annotations together with endianness.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile      | 6 ++++++
 arch/powerpc/boot/Makefile | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 617dece..902da6e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -73,13 +73,17 @@ MULTIPLEWORD	:= -mmultiple
 endif
 
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
+cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
+cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
 ifneq ($(cc-name),clang)
   cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
 endif
 
 aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
+aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
+aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
 
 ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(BITS)
@@ -114,6 +118,8 @@ CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-a
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
 else
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcall-aixdesc)
+CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
+AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index eae2dc8..1d50d41 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -33,6 +33,7 @@ BOOTCFLAGS	+= -m64
 endif
 ifdef CONFIG_CPU_BIG_ENDIAN
 BOOTCFLAGS	+= -mbig-endian
+BOOTCFLAGS	+= $(call cc-option,-mabi=elfv1)
 else
 BOOTCFLAGS	+= -mlittle-endian
 BOOTCFLAGS	+= $(call cc-option,-mabi=elfv2)
-- 
2.10.2
