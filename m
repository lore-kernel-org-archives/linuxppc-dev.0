Return-Path: <dgibson@ozlabs.org>
Date: Mon, 9 Nov 2009 13:07:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.ozlabs.org
Subject: Allow overriding of CC in powerpc kernel build
Message-ID: <20091109020746.GC3370@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


arch/powerpc/Makefile uses make 'override' directives to add -m32 or
-m64 depending on config to the CC variable, and matching options to
the AS, LD and AR variables to correctly use a biarch compiler.

Unfortunately this doesn't work as intended if you actually attempt to
set CC from the make command line.  They correctly augment the given
CC variable in the top-level make instance, but at least some of the
second-level make invocations don't include arch/powerpc/Makefile, so
the command line override is used directly, and we attempt to compile
without the correct -m64 or similar option.

This patch alters the way we set up the biarch flags so that CC can be
overriden from the command line as expected (this is useful when using
ccontrol as a compiler wrapper).  The approach is based roughly on the
way x86 handles the analagous problem for i386/x86_64 biarch
compilers, with some additional hacks to make the VDSO compilation
work.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: linux-a2/arch/powerpc/Makefile
===================================================================
--- linux-a2.orig/arch/powerpc/Makefile	2009-11-06 14:17:15.000000000 +1100
+++ linux-a2/arch/powerpc/Makefile	2009-11-06 15:36:05.000000000 +1100
@@ -57,10 +57,10 @@ endif
 UTS_MACHINE := $(OLDARCH)
 
 ifeq ($(HAS_BIARCH),y)
-override AS	+= -a$(CONFIG_WORD_SIZE)
-override LD	+= -m elf$(CONFIG_WORD_SIZE)ppc
-override CC	+= -m$(CONFIG_WORD_SIZE)
-override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-powerpc $(AR)
+	KBUILD_AFLAGS += -m$(CONFIG_WORD_SIZE)
+	KBUILD_CFLAGS += -m$(CONFIG_WORD_SIZE)
+	LDFLAGS := -m elf$(CONFIG_WORD_SIZE)ppc
+	override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-powerpc $(AR)
 endif
 
 LDFLAGS_vmlinux-yy := -Bstatic
Index: linux-a2/arch/powerpc/kernel/vdso32/Makefile
===================================================================
--- linux-a2.orig/arch/powerpc/kernel/vdso32/Makefile	2009-11-06 15:45:36.000000000 +1100
+++ linux-a2/arch/powerpc/kernel/vdso32/Makefile	2009-11-06 15:47:03.000000000 +1100
@@ -40,10 +40,13 @@ $(obj-vdso32): %.o: %.S
 	$(call if_changed_dep,vdso32as)
 
 # actual build commands
+biarch	:= $(call cc-option, -m32)
+c_flags_32 = $(filter-out -m64,$(c_flags)) $(biarch)
+a_flags_32 = $(filter-out -m64,$(a_flags)) $(biarch)
 quiet_cmd_vdso32ld = VDSO32L $@
-      cmd_vdso32ld = $(CROSS32CC) $(c_flags) -Wl,-T $^ -o $@
+      cmd_vdso32ld = $(CROSS32CC) $(c_flags_32) -Wl,-T $^ -o $@
 quiet_cmd_vdso32as = VDSO32A $@
-      cmd_vdso32as = $(CROSS32CC) $(a_flags) -c -o $@ $<
+      cmd_vdso32as = $(CROSS32CC) $(a_flags_32) -c -o $@ $<
 
 # install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
