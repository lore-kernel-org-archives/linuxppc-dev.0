Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHbK96fP2zDqnP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 23:18:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/Makefile: Fix ld version check with 64-bit LE-only
 toolchain
Date: Wed, 26 Jul 2017 23:18:31 +1000
Message-Id: <1501075111-20198-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit efe0160cfd40 ("powerpc/64: Linker on-demand sfpr functions
for modules"), we added an ld version check early in the powerpc
top-level Makefile.

Because the Makefile runs before the kernel config is setup, the
checks for CONFIG_CPU_LITTLE_ENDIAN etc. all take the default case. So
we end up configuring ld for 32-bit big endian.

That would be OK, except that for historical (or perhaps no) reason,
we use 'override LD' to add the endian flags to the LD variable
itself, rather than the normal approach of adding them to LDFLAGS.

The end result is that when we check the ld version we run it as:

  $(CROSS_COMPILE)ld -EB -m elf32ppc --version

This often works, unless you are using a 64-bit only and/or little
endian only, toolchain. In which case you see something like:

  $ make defconfig
  powerpc64le-linux-ld: unrecognised emulation mode: elf32ppc
  Supported emulations: elf64lppc elf32lppc elf32lppclinux elf32lppcsim
  /bin/sh: 1: [: -ge: unexpected operator

The proper fix is to stop using 'override LD', but that will require a
fair bit of testing. Instead we can fix it for now just by reordering
the Makefile to do the version check earlier.

Fixes: efe0160cfd40 ("powerpc/64: Linker on-demand sfpr functions for modules")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8d4ed73d5490..e2b3e7a00c9e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -59,6 +59,19 @@ machine-$(CONFIG_PPC64) += 64
 machine-$(CONFIG_CPU_LITTLE_ENDIAN) += le
 UTS_MACHINE := $(subst $(space),,$(machine-y))
 
+# XXX This needs to be before we override LD below
+ifdef CONFIG_PPC32
+KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
+else
+ifeq ($(call ld-ifversion, -ge, 225000000, y),y)
+# Have the linker provide sfpr if possible.
+# There is a corresponding test in arch/powerpc/lib/Makefile
+KBUILD_LDFLAGS_MODULE += --save-restore-funcs
+else
+KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
+endif
+endif
+
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 override LD	+= -EL
 LDEMULATION	:= lppc
@@ -190,18 +203,6 @@ else
 CHECKFLAGS	+= -D__LITTLE_ENDIAN__
 endif
 
-ifdef CONFIG_PPC32
-KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
-else
-ifeq ($(call ld-ifversion, -ge, 225000000, y),y)
-# Have the linker provide sfpr if possible.
-# There is a corresponding test in arch/powerpc/lib/Makefile
-KBUILD_LDFLAGS_MODULE += --save-restore-funcs
-else
-KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
-endif
-endif
-
 ifeq ($(CONFIG_476FPE_ERR46),y)
 	KBUILD_LDFLAGS_MODULE += --ppc476-workaround \
 		-T $(srctree)/arch/powerpc/platforms/44x/ppc476_modules.lds
-- 
2.7.4
