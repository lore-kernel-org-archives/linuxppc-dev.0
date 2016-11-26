Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQd3S4FrdzDvwK
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 14:00:19 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id x23so6945559pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 19:00:19 -0800 (PST)
Date: Sat, 26 Nov 2016 14:00:04 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 2/3] powerpc: allow compilation on cross-endian toolchain
Message-ID: <20161126140004.607d8f86@roar.ozlabs.ibm.com>
In-Reply-To: <20161124200423.45c5ec87@roar.ozlabs.ibm.com>
References: <20161123130209.1667-1-npiggin@gmail.com>
 <20161123130209.1667-3-npiggin@gmail.com>
 <20161124200423.45c5ec87@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 24 Nov 2016 20:04:23 +1100
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Thu, 24 Nov 2016 00:02:08 +1100
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > GCC can compile with either endian, but the ABI version always
> > defaults to the default endian. Alan Modra says:  
> 
> Okay I was missing mcall-aixdesc, thanks again to Alan for pointing
> it out.

Final patch here which just slightly changes how the boot code flags
are set (don't introduce unnecessary setting of elfv1 on 32-bit builds).
--

GCC can compile with either endian, but the ABI version always
defaults to the default endian. Alan Modra says:

  you need both -mbig and -mabi=elfv1 to make a powerpc64le gcc
  generate powerpc64 code

The opposite is true for powerpc64 when generating -mlittle it
requires -mabi=elfv2 to generate v2 ABI. This change adds ABI
annotations together with endianness. The kernel with ELFv2 ABI
also uses -mcall-aixdesc, but boot/ does not.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile      | 7 +++++++
 arch/powerpc/boot/Makefile | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 617dece..8828807 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -73,13 +73,18 @@ MULTIPLEWORD	:= -mmultiple
 endif
 
 cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mbig-endian)
+cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mabi=elfv1)
+cflags-$(CONFIG_CPU_BIG_ENDIAN)		+= $(call cc-option,-mcall-aixdesc)
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
@@ -113,7 +118,9 @@ ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,$(call cc-option,-mcall-aixdesc))
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
 else
+CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcall-aixdesc)
+AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv1)
 endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,$(call cc-option,-mminimal-toc))
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index eae2dc8..7c46cf3 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -28,14 +28,16 @@ BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -isystem $(shell $(CROSS32CC) -print-file-name=include) \
 		 -D$(compress-y)
 
+# PPC64_BOOT_WRAPPER is little-endian specific.
 ifdef CONFIG_PPC64_BOOT_WRAPPER
 BOOTCFLAGS	+= -m64
+BOOTCFLAGS	+= $(call cc-option,-mabi=elfv2)
 endif
+
 ifdef CONFIG_CPU_BIG_ENDIAN
 BOOTCFLAGS	+= -mbig-endian
 else
 BOOTCFLAGS	+= -mlittle-endian
-BOOTCFLAGS	+= $(call cc-option,-mabi=elfv2)
 endif
 
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
-- 
2.10.2
