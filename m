Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP2j0539NzDwL6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 00:08:52 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id e9so1099390pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 05:08:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Alan Modra <amodra@gmail.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: [RFC][PATCH] powerpc/64be: use ELFv2 ABI for big endian kernels
Date: Thu, 24 Nov 2016 00:08:40 +1100
Message-Id: <20161123130840.1877-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Question, are there any fundamental reasons we shouldn't use the ELFv2
ABI to build big endian kernels if the compiler supports it?

Thanks,
Nick

---
 arch/powerpc/Makefile      | 15 +++++----------
 arch/powerpc/boot/Makefile |  2 +-
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 902da6e..b4867fc 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -72,18 +72,19 @@ GNUTARGET	:= powerpc
 MULTIPLEWORD	:= -mmultiple
 endif
 
+ifeq ($(CONFIG_PPC64),y)
+cflags-y				+= $(call cc-option,-mabi=elfv2)
+aflags-y				+= $(call cc-option,-mabi=elfv2)
+endif
+
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
-cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
-cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
 ifneq ($(cc-name),clang)
   cflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mno-strict-align
 endif
 
 aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
-aflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
 aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mlittle-endian
-aflags-$(CONFIG_CPU_LITTLE_ENDIAN)	+= -mabi=elfv2
 
 ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(BITS)
@@ -113,14 +114,8 @@ endif
 endif
 
 CFLAGS-$(CONFIG_PPC64)	:= $(call cc-option,-mtraceback=no)
-ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
-else
-CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcall-aixdesc)
-CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
-AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
-endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1d50d41..ef2499b 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -33,7 +33,7 @@ BOOTCFLAGS	+= -m64
 endif
 ifdef CONFIG_CPU_BIG_ENDIAN
 BOOTCFLAGS	+= -mbig-endian
-BOOTCFLAGS	+= $(call cc-option,-mabi=elfv1)
+BOOTCFLAGS	+= $(call cc-option,-mabi=elfv2)
 else
 BOOTCFLAGS	+= -mlittle-endian
 BOOTCFLAGS	+= $(call cc-option,-mabi=elfv2)
-- 
2.10.2
