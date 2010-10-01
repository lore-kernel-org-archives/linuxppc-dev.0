Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9985FB6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  1 Oct 2010 17:06:20 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp01.au.ibm.com (8.14.4/8.13.1) with ESMTP id o9173Ilj020070
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:03:18 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9176JNd2150452
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:19 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9176Id2005583
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:06:19 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: [PATCH 02/18] powerpc: Add CROSSBE_COMPILE to build big endian boot
	wrapper
Date: Fri,  1 Oct 2010 17:05:55 +1000
Message-Id: <1285916771-18033-3-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
Cc: Michal Marek <mmarek@suse.cz>, Albert Herranz <albert_herranz@yahoo.es>,
	paulus@samba.org, Ian Munsie <imunsie@au1.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Since the boot wrapper must be built by a big endian 32bit toolchain
regardless of what the rest of the kernel is using introduce a new
parameter to specify that toolchain - CROSSBE_COMPILE.

We already have CROSS32_COMPILE which is already used for the boot
wrapper, but it is also used to build the 32bit vdso which should be
build in the same endianness as the rest of the kernel, so it is
necessary to be able to specify the toolchain to build the boot wrapper
separately from that used to build the vdso and again separately from
that used to build the main kernel.

CROSSBE_COMPILE should be pointed to a toolchain capable of targeting
32bit big endian powerpc, either specifically targetted at 32bit or
bi-arch 64 and 32bit. If CROSSBE_COMPILE is not specified it will fall
back to CROSS32_COMPILE to maintain compatibility with big endian
targets.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/Makefile      |   19 +++++++++++++++++--
 arch/powerpc/boot/Makefile |   25 +++++++++++++++----------
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 3eed685..ab69b0e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -14,7 +14,7 @@
 
 HAS_BIARCH	:= $(call cc-option-yn, -m32)
 
-# Set default 32 bits cross compilers for vdso and boot wrapper
+# Set default 32 bits cross compilers for vdso
 CROSS32_COMPILE ?=
 
 CROSS32CC		:= $(CROSS32_COMPILE)gcc
@@ -27,7 +27,22 @@ CROSS32AR	:= GNUTARGET=elf32-powerpc $(AR)
 endif
 endif
 
-export CROSS32CC CROSS32AR
+# Set default big endian 32 bits cross compiler for boot wrapper
+ifeq ($(CROSSBE_COMPILE),)
+CROSSBECC	:= $(CROSS32CC)
+CROSSBEAR	:= $(CROSS32AR)
+else
+CROSSBECC	:= $(CROSSBE_COMPILE)gcc
+CROSSBEAR	:= $(CROSSBE_COMPILE)ar
+endif
+
+ifeq ($(call try-run,\
+	$(CROSSBECC) -m32 -c -xc /dev/null -o "$$TMP",y,n),y)
+CROSSBECC	:= $(CROSSBECC) -m32
+CROSSBEAR	:= GNUTARGET=elf32-powerpc $(CROSSBEAR)
+endif
+
+export CROSS32CC CROSS32AR CROSSBECC CROSSBEAR
 
 ifeq ($(CROSS_COMPILE),)
 KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 39f10a4..79d7e69 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -6,23 +6,24 @@
 # Based on coffboot by Paul Mackerras
 # Simplified for ppc64 by Todd Inglett
 #
-# NOTE:	this code is built for 32 bit in ELF32 format even though
-#	it packages a 64 bit kernel.  We do this to simplify the
+# NOTE:	this code is built for 32 bit big endian in ELF32 format even
+#	though it packages a 64 bit kernel.  We do this to simplify the
 #	bootloader and increase compatibility with OpenFirmware.
 #
-#	To this end we need to define BOOTCC, etc, as the tools
-#	needed to build the 32 bit image.  That's normally the same
+#	To this end we need to define BOOTCC, etc, as the tools needed
+#	to build the 32 bit big endian image.  That's normally the same
 #	compiler for the rest of the kernel, with the -m32 flag added.
 #	To make it easier to setup a cross compiler,
-#	CROSS32_COMPILE is setup as a prefix just like CROSS_COMPILE
-#	in the toplevel makefile.
+#	CROSSBE_COMPILE is setup as a prefix just like CROSS_COMPILE
+#	in the toplevel makefile. If building a big endian kernel,
+#	CROSS32_COMPILE may be used in it's place.
 
 all: $(obj)/zImage
 
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
-		 -isystem $(shell $(CROSS32CC) -print-file-name=include) \
+		 -isystem $(shell $(CROSSBECC) -print-file-name=include) \
 		 -mbig-endian
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
@@ -122,13 +123,13 @@ clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
 		empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
 
 quiet_cmd_bootcc = BOOTCC  $@
-      cmd_bootcc = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
+      cmd_bootcc = $(CROSSBECC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
 
 quiet_cmd_bootas = BOOTAS  $@
-      cmd_bootas = $(CROSS32CC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
+      cmd_bootas = $(CROSSBECC) -Wp,-MD,$(depfile) $(BOOTAFLAGS) -c -o $@ $<
 
 quiet_cmd_bootar = BOOTAR  $@
-      cmd_bootar = $(CROSS32AR) -cr $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
+      cmd_bootar = $(CROSSBEAR) -cr $@.$$$$ $(filter-out FORCE,$^); mv $@.$$$$ $@
 
 $(obj-libfdt): $(obj)/%.o: $(srctree)/scripts/dtc/libfdt/%.c FORCE
 	$(call if_changed_dep,bootcc)
@@ -157,6 +158,9 @@ wrapperbits	:= $(extra-y) $(addprefix $(obj)/,addnote hack-coff mktree) \
 #############
 # Bits for building various flavours of zImage
 
+ifneq ($(CROSSBE_COMPILE),)
+CROSSWRAP := -C "$(CROSSBE_COMPILE)"
+else
 ifneq ($(CROSS32_COMPILE),)
 CROSSWRAP := -C "$(CROSS32_COMPILE)"
 else
@@ -164,6 +168,7 @@ ifneq ($(CROSS_COMPILE),)
 CROSSWRAP := -C "$(CROSS_COMPILE)"
 endif
 endif
+endif
 
 # args (to if_changed): 1 = (this rule), 2 = platform, 3 = dts 4=dtb 5=initrd
 quiet_cmd_wrap	= WRAP    $@
-- 
1.7.1
