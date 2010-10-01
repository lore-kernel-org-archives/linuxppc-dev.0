Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 998F8B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:06:20 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id o9172MZx001626
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:02:22 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9176Jul1478732
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:19 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9176IgA027666
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:19 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH 01/18] powerpc: Add ability to build little endian kernels
Date: Fri,  1 Oct 2010 17:05:54 +1000
Message-Id: <1285916771-18033-2-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michal Marek <mmarek@suse.cz>, Albert Herranz <albert_herranz@yahoo.es>,
	paulus@samba.org, Ian Munsie <imunsie@au1.ibm.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>,
	Torez Smith <lnxtorez@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch allows the kbuild system to successfully compile a kernel for
the little endian PowerPC architecture.

To build such a kernel a supported platform must be used and
CONFIG_CPU_LITTLE_ENDIAN must be set. CROSS_COMPILE must be set to a
suitable toolchain prefix (compiled for the powerpcle-elf target, or
patched to allow the powerpcle-linux target).

Since the system will always start in big endian mode, the zImage
wrapper must still be compiled with a big endian toolchain, which can be
specified via CROSS32_COMPILE.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/Makefile                   |   22 +++++++++++++++++++---
 arch/powerpc/boot/Makefile              |    3 ++-
 arch/powerpc/kernel/vdso32/vdso32.lds.S |    4 ++++
 arch/powerpc/platforms/Kconfig.cputype  |   16 ++++++++++++++++
 4 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index b7212b6..3eed685 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -56,11 +56,27 @@ endif
 
 UTS_MACHINE := $(OLDARCH)
 
+ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
+override CC	+= -mlittle-endian
+override AS	+= -mlittle-endian
+override LD	+= -EL
+LDEMULATION	:= lppc
+GNUTARGET	:= powerpcle
+MULTIPLEWORD	:= -mno-multiple
+else
+override CC	+= -mbig-endian
+override AS	+= -mbig-endian
+override LD	+= -EB
+LDEMULATION	:= ppc
+GNUTARGET	:= powerpc
+MULTIPLEWORD	:= -mmultiple
+endif
+
 ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(CONFIG_WORD_SIZE)
-override LD	+= -m elf$(CONFIG_WORD_SIZE)ppc
+override LD	+= -m elf$(CONFIG_WORD_SIZE)$(LDEMULATION)
 override CC	+= -m$(CONFIG_WORD_SIZE)
-override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-powerpc $(AR)
+override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-$(GNUTARGET) $(AR)
 endif
 
 LDFLAGS_vmlinux-yy := -Bstatic
@@ -68,7 +84,7 @@ LDFLAGS_vmlinux-$(CONFIG_PPC64)$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-yy)
 
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
-CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 -mmultiple
+CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
 KBUILD_CPPFLAGS	+= -Iarch/$(ARCH)
 KBUILD_AFLAGS	+= -Iarch/$(ARCH)
 KBUILD_CFLAGS	+= -msoft-float -pipe -Iarch/$(ARCH) $(CFLAGS-y)
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index fae8192..39f10a4 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -22,7 +22,8 @@ all: $(obj)/zImage
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
-		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
+		 -isystem $(shell $(CROSS32CC) -print-file-name=include) \
+		 -mbig-endian
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
 ifdef CONFIG_DEBUG_INFO
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 0546bcd..f4c6676 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -4,7 +4,11 @@
  */
 #include <asm/vdso.h>
 
+#ifdef __LITTLE_ENDIAN__
+OUTPUT_FORMAT("elf32-powerpcle", "elf32-powerpcle", "elf32-powerpcle")
+#else
 OUTPUT_FORMAT("elf32-powerpc", "elf32-powerpc", "elf32-powerpc")
+#endif
 OUTPUT_ARCH(powerpc:common)
 ENTRY(_start)
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index d361f81..074ff12 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -329,3 +329,19 @@ config CHECK_CACHE_COHERENCY
 	bool
 
 endmenu
+
+config ARCH_SUPPORTS_LITTLE_ENDIAN
+	bool
+
+config CPU_LITTLE_ENDIAN
+	bool "Build little endian kernel"
+	depends on ARCH_SUPPORTS_LITTLE_ENDIAN && EXPERIMENTAL
+	default n
+	help
+	  This option selects whether a big endian or little endian kernel will
+	  be built.
+
+	  Note that if building a little endian kernel, CROSS_COMPILE must
+	  point to a toolchain capable of targetting little endian powerpc,
+	  while the toolchain specified by CROSS32_COMPILE must be capable of
+	  targetting *BIG* endian PowerPC.
-- 
1.7.1
