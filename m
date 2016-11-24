Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPYDg6v3szDvnV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 20:04:35 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id c4so1682990pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 01:04:35 -0800 (PST)
Date: Thu, 24 Nov 2016 20:04:23 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH 2/3] powerpc: allow compilation on cross-endian toolchain
Message-ID: <20161124200423.45c5ec87@roar.ozlabs.ibm.com>
In-Reply-To: <20161123130209.1667-3-npiggin@gmail.com>
References: <20161123130209.1667-1-npiggin@gmail.com>
 <20161123130209.1667-3-npiggin@gmail.com>
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

On Thu, 24 Nov 2016 00:02:08 +1100
Nicholas Piggin <npiggin@gmail.com> wrote:

> GCC can compile with either endian, but the ABI version always
> defaults to the default endian. Alan Modra says:

Okay I was missing mcall-aixdesc, thanks again to Alan for pointing
it out.

This updated patch seems to do better, and it builds BE kernel with
powerpc64le-gcc, and LE with powerpc64-gcc here (I did see a link
failure but then couldn't reproduce it so it might have been a stale
file hanging around somewhere).


From: Nicholas Piggin <npiggin@gmail.com>
Date: Wed, 23 Nov 2016 17:27:39 +1100
Subject: [PATCH] powerpc: allow compilation on cross-endian toolchain

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
 arch/powerpc/boot/Makefile | 1 +
 2 files changed, 8 insertions(+)

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
