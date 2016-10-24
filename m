Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2L6Z3H1FzDvWS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 13:37:42 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id s8so15028299pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 19:37:42 -0700 (PDT)
Date: Mon, 24 Oct 2016 13:37:28 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org, Michael Ellerman
 <mpe@ellerman.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] powerpc: fpr save/restore function cleanups (was Re:
 [powerpc:test 24/28] powerpc64-linux-gnu-ld: warning: orphan section
 `.text.save.restore' from `arch/powerpc/lib/built-in.o' being placed in
 section `.text.save.restore'.)
Message-ID: <20161024133728.48a9e9a0@roar.ozlabs.ibm.com>
In-Reply-To: <20161024125734.549354e0@roar.ozlabs.ibm.com>
References: <201610221500.IwR3ltdg%fengguang.wu@intel.com>
 <20161024125734.549354e0@roar.ozlabs.ibm.com>
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

On Mon, 24 Oct 2016 12:57:34 +1100
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Sat, 22 Oct 2016 15:53:03 +0800
> kbuild test robot <fengguang.wu@intel.com> wrote:
> 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git test
> > head:   8a4fd950c8ac67ad98135db4107ed6cae412606c
> > commit: b09fa228be430ba2745102ac8e668ad869320bd9 [24/28] powerpc: link warning for orphan sections
> > config: powerpc-ps3_defconfig (attached as .config)
> > compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> > reproduce:
> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout b09fa228be430ba2745102ac8e668ad869320bd9
> >         # save the attached .config to linux build tree
> >         make.cross ARCH=powerpc 
> > 
> > All warnings (new ones prefixed by >>):
> >   
> > >> powerpc64-linux-gnu-ld: warning: orphan section `.text.save.restore' from `arch/powerpc/lib/built-in.o' being placed in section `.text.save.restore'.
> > >> powerpc64-linux-gnu-ld: warning: orphan section `.text.save.restore' from `arch/powerpc/lib/built-in.o' being placed in section `.text.save.restore'.
> > >> powerpc64-linux-gnu-ld: warning: orphan section `.text.save.restore' from `arch/powerpc/lib/built-in.o' being placed in section `.text.save.restore'.    
> 
> On powerpc64, ld creates these for us when required, and puts them into
> section ".sfpr". So we can avoid compiling in lib/crtsavres.S entirely
> there, I think.
> 
> When I do that, I see the save/restore functions getting located at
> 0x8000. That actually works with my .linker_stub_catch patch, but there
> is probably no good reason to put those sections there, so I'll change
> .sfpr in the linker script to be near the end of the main text output
> section.

Something like this (appropriately split up and tested) might be the go
for 4.10. I just have to work out why these were added for 64-bit in
7fca5dc8aa7 ("powerpc: Fix module building for gcc 4.5 and 64 bit"). Must
have been some issues with early toolchains.



The powerpc64 linker generates fpr save/restore functions on-demand,
placing them in the .sfpr section. so 64 does not require these functions,
so remove them from the 64 build.

However the linker places .sfpr at the beginning of a group of input
sections, so the current linker script ends up locating them at the
start of main .text (right after head text), which is not necessary.
Move those to the end of the .text output section.

Have 32-bit put save/restore functions into .sfpr section, to match
64-bit.
---
 arch/powerpc/Makefile             |   2 +
 arch/powerpc/boot/Makefile        |   3 +-
 arch/powerpc/boot/crtsavres.S     |   3 +-
 arch/powerpc/kernel/vmlinux.lds.S |   3 +-
 arch/powerpc/lib/Makefile         |   5 +-
 arch/powerpc/lib/crtsavres.S      | 238 +-------------------------------------
 6 files changed, 12 insertions(+), 242 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 093094c..113e057 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -180,7 +180,9 @@ else
 CHECKFLAGS	+= -D__LITTLE_ENDIAN__
 endif
 
+ifeq ($(CONFIG_PPC32),y)
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
+endif
 
 ifeq ($(CONFIG_476FPE_ERR46),y)
 	KBUILD_LDFLAGS_MODULE += --ppc476-workaround \
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index eae2dc8..6abee93 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -95,12 +95,13 @@ libfdtheader := fdt.h libfdt.h libfdt_internal.h
 $(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o opal.o): \
 	$(addprefix $(obj)/,$(libfdtheader))
 
-src-wlib-y := string.S crt0.S crtsavres.S stdio.c decompress.c main.c \
+src-wlib-y := string.S crt0.S stdio.c decompress.c main.c \
 		$(libfdt) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
 		elf_util.c $(zlib-y) devtree.c stdlib.c \
 		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
 		uartlite.c mpc52xx-psc.c opal.c opal-calls.S
+src-wlib-$(CONFIG_PPC32) += crtsavres.S
 src-wlib-$(CONFIG_40x) += 4xx.c planetcore.c
 src-wlib-$(CONFIG_44x) += 4xx.c ebony.c bamboo.c
 src-wlib-$(CONFIG_8xx) += mpc8xx.c planetcore.c fsl-soc.c
diff --git a/arch/powerpc/boot/crtsavres.S b/arch/powerpc/boot/crtsavres.S
index f3d9b35..8c77437 100644
--- a/arch/powerpc/boot/crtsavres.S
+++ b/arch/powerpc/boot/crtsavres.S
@@ -38,10 +38,9 @@
  */
 
 	.file	"crtsavres.S"
-	.section ".text"
+	.section ".sfpr","ax",@progbits
 
 /* On PowerPC64 Linux, these functions are provided by the linker.  */
-#ifndef __powerpc64__
 
 #define _GLOBAL(name) \
 	.type name,@function; \
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 534c8df..01d09e9 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -76,13 +76,14 @@ SECTIONS
 		*(.linker_stub_catch);
 		. = . ;
 		/* careful! __ftr_alt_* sections need to be close to .text */
-		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text .sfpr);
+		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
+		*(.sfpr);
 		MEM_KEEP(init.text)
 		MEM_KEEP(exit.text)
 
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 309361e8..b1304113 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -9,10 +9,9 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 CFLAGS_REMOVE_code-patching.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_feature-fixups.o = $(CC_FLAGS_FTRACE)
 
-obj-y += string.o alloc.o crtsavres.o code-patching.o \
-	 feature-fixups.o
+obj-y += string.o alloc.o code-patching.o feature-fixups.o
 
-obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
+obj-$(CONFIG_PPC32)	+= div64.o copy_32.o crtsavres.o
 
 obj64-y	+= copypage_64.o copyuser_64.o usercopy_64.o mem_64.o hweight_64.o \
 	   copyuser_power7.o string_64.o copypage_power7.o memcpy_power7.o \
diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
index 18af0b3..0c6ea3b 100644
--- a/arch/powerpc/lib/crtsavres.S
+++ b/arch/powerpc/lib/crtsavres.S
@@ -42,11 +42,11 @@
 
 	.file	"crtsavres.S"
 
-#ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
+/* On PowerPC64 Linux, these functions are provided by the linker.  */
 
-#ifndef CONFIG_PPC64
+#ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 
-	.section ".text"
+	.section ".sfpr","ax",@progbits
 
 /* Routines for saving integer registers, called by the compiler.  */
 /* Called with r11 pointing to the stack header word of the caller of the */
@@ -312,236 +312,4 @@ _GLOBAL(_restvr_31)
 
 #endif /* CONFIG_ALTIVEC */
 
-#else /* CONFIG_PPC64 */
-
-	.section ".text.save.restore","ax",@progbits
-
-.globl	_savegpr0_14
-_savegpr0_14:
-	std	r14,-144(r1)
-.globl	_savegpr0_15
-_savegpr0_15:
-	std	r15,-136(r1)
-.globl	_savegpr0_16
-_savegpr0_16:
-	std	r16,-128(r1)
-.globl	_savegpr0_17
-_savegpr0_17:
-	std	r17,-120(r1)
-.globl	_savegpr0_18
-_savegpr0_18:
-	std	r18,-112(r1)
-.globl	_savegpr0_19
-_savegpr0_19:
-	std	r19,-104(r1)
-.globl	_savegpr0_20
-_savegpr0_20:
-	std	r20,-96(r1)
-.globl	_savegpr0_21
-_savegpr0_21:
-	std	r21,-88(r1)
-.globl	_savegpr0_22
-_savegpr0_22:
-	std	r22,-80(r1)
-.globl	_savegpr0_23
-_savegpr0_23:
-	std	r23,-72(r1)
-.globl	_savegpr0_24
-_savegpr0_24:
-	std	r24,-64(r1)
-.globl	_savegpr0_25
-_savegpr0_25:
-	std	r25,-56(r1)
-.globl	_savegpr0_26
-_savegpr0_26:
-	std	r26,-48(r1)
-.globl	_savegpr0_27
-_savegpr0_27:
-	std	r27,-40(r1)
-.globl	_savegpr0_28
-_savegpr0_28:
-	std	r28,-32(r1)
-.globl	_savegpr0_29
-_savegpr0_29:
-	std	r29,-24(r1)
-.globl	_savegpr0_30
-_savegpr0_30:
-	std	r30,-16(r1)
-.globl	_savegpr0_31
-_savegpr0_31:
-	std	r31,-8(r1)
-	std	r0,16(r1)
-	blr
-
-.globl	_restgpr0_14
-_restgpr0_14:
-	ld	r14,-144(r1)
-.globl	_restgpr0_15
-_restgpr0_15:
-	ld	r15,-136(r1)
-.globl	_restgpr0_16
-_restgpr0_16:
-	ld	r16,-128(r1)
-.globl	_restgpr0_17
-_restgpr0_17:
-	ld	r17,-120(r1)
-.globl	_restgpr0_18
-_restgpr0_18:
-	ld	r18,-112(r1)
-.globl	_restgpr0_19
-_restgpr0_19:
-	ld	r19,-104(r1)
-.globl	_restgpr0_20
-_restgpr0_20:
-	ld	r20,-96(r1)
-.globl	_restgpr0_21
-_restgpr0_21:
-	ld	r21,-88(r1)
-.globl	_restgpr0_22
-_restgpr0_22:
-	ld	r22,-80(r1)
-.globl	_restgpr0_23
-_restgpr0_23:
-	ld	r23,-72(r1)
-.globl	_restgpr0_24
-_restgpr0_24:
-	ld	r24,-64(r1)
-.globl	_restgpr0_25
-_restgpr0_25:
-	ld	r25,-56(r1)
-.globl	_restgpr0_26
-_restgpr0_26:
-	ld	r26,-48(r1)
-.globl	_restgpr0_27
-_restgpr0_27:
-	ld	r27,-40(r1)
-.globl	_restgpr0_28
-_restgpr0_28:
-	ld	r28,-32(r1)
-.globl	_restgpr0_29
-_restgpr0_29:
-	ld	r0,16(r1)
-	ld	r29,-24(r1)
-	mtlr	r0
-	ld	r30,-16(r1)
-	ld	r31,-8(r1)
-	blr
-
-.globl	_restgpr0_30
-_restgpr0_30:
-	ld	r30,-16(r1)
-.globl	_restgpr0_31
-_restgpr0_31:
-	ld	r0,16(r1)
-	ld	r31,-8(r1)
-	mtlr	r0
-	blr
-
-#ifdef CONFIG_ALTIVEC
-/* Called with r0 pointing just beyond the end of the vector save area.  */
-
-.globl	_savevr_20
-_savevr_20:
-	li	r12,-192
-	stvx	v20,r12,r0
-.globl	_savevr_21
-_savevr_21:
-	li	r12,-176
-	stvx	v21,r12,r0
-.globl	_savevr_22
-_savevr_22:
-	li	r12,-160
-	stvx	v22,r12,r0
-.globl	_savevr_23
-_savevr_23:
-	li	r12,-144
-	stvx	v23,r12,r0
-.globl	_savevr_24
-_savevr_24:
-	li	r12,-128
-	stvx	v24,r12,r0
-.globl	_savevr_25
-_savevr_25:
-	li	r12,-112
-	stvx	v25,r12,r0
-.globl	_savevr_26
-_savevr_26:
-	li	r12,-96
-	stvx	v26,r12,r0
-.globl	_savevr_27
-_savevr_27:
-	li	r12,-80
-	stvx	v27,r12,r0
-.globl	_savevr_28
-_savevr_28:
-	li	r12,-64
-	stvx	v28,r12,r0
-.globl	_savevr_29
-_savevr_29:
-	li	r12,-48
-	stvx	v29,r12,r0
-.globl	_savevr_30
-_savevr_30:
-	li	r12,-32
-	stvx	v30,r12,r0
-.globl	_savevr_31
-_savevr_31:
-	li	r12,-16
-	stvx	v31,r12,r0
-	blr
-
-.globl	_restvr_20
-_restvr_20:
-	li	r12,-192
-	lvx	v20,r12,r0
-.globl	_restvr_21
-_restvr_21:
-	li	r12,-176
-	lvx	v21,r12,r0
-.globl	_restvr_22
-_restvr_22:
-	li	r12,-160
-	lvx	v22,r12,r0
-.globl	_restvr_23
-_restvr_23:
-	li	r12,-144
-	lvx	v23,r12,r0
-.globl	_restvr_24
-_restvr_24:
-	li	r12,-128
-	lvx	v24,r12,r0
-.globl	_restvr_25
-_restvr_25:
-	li	r12,-112
-	lvx	v25,r12,r0
-.globl	_restvr_26
-_restvr_26:
-	li	r12,-96
-	lvx	v26,r12,r0
-.globl	_restvr_27
-_restvr_27:
-	li	r12,-80
-	lvx	v27,r12,r0
-.globl	_restvr_28
-_restvr_28:
-	li	r12,-64
-	lvx	v28,r12,r0
-.globl	_restvr_29
-_restvr_29:
-	li	r12,-48
-	lvx	v29,r12,r0
-.globl	_restvr_30
-_restvr_30:
-	li	r12,-32
-	lvx	v30,r12,r0
-.globl	_restvr_31
-_restvr_31:
-	li	r12,-16
-	lvx	v31,r12,r0
-	blr
-
-#endif /* CONFIG_ALTIVEC */
-
-#endif /* CONFIG_PPC64 */
-
 #endif
-- 
2.9.3
