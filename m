Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7KJZ74FkzDvHp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Nov 2016 16:18:38 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id s8so10615353pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 22:18:38 -0700 (PDT)
Date: Tue, 1 Nov 2016 16:18:28 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alan Modra <amodra@gmail.com>
Subject: Re: [PATCH] powerpc: fpr save/restore function cleanups
Message-ID: <20161101161828.6075f836@roar.ozlabs.ibm.com>
In-Reply-To: <20161101154112.1516b5cb@roar.ozlabs.ibm.com>
References: <20161101042219.25587-1-npiggin@gmail.com>
 <20161101154112.1516b5cb@roar.ozlabs.ibm.com>
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

On Tue, 1 Nov 2016 15:41:12 +1100
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Tue,  1 Nov 2016 15:22:19 +1100
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > The powerpc64 linker generates fpr save/restore functions on-demand,
> > placing them in the .sfpr section. So remove the explicitly coded ones
> > from the 64 build.
> > 
> > Have 32-bit put save/restore functions into .sfpr section rather than
> > .text, to match 64-bit.
> > 
> > And explicitly have the linker script place the section rather than
> > leaving it as orphan.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > 
> > I tested this with 64-bit optimize-for-size build with modules,
> > and that works okay.  
> 
> No I didn't, it's broken. I'll send an update shortly.

Working (hopefully) patch this time. I also removed the 32-bit changes
which aren't really necessary:

The powerpc64 linker generates fpr save/restore functions on-demand,
placing them in the .sfpr section. Module linking (because it's a
"non-final" link) requires --save-restore-funcs for this.

Remove the explicitly coded save/restore functions from the 64 build.

And explicitly have the linker script place the section rather than
leaving it as orphan.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Makefile             |   4 +
 arch/powerpc/boot/Makefile        |   3 +-
 arch/powerpc/boot/crtsavres.S     |   8 +-
 arch/powerpc/kernel/vmlinux.lds.S |   6 +
 arch/powerpc/lib/Makefile         |   5 +-
 arch/powerpc/lib/crtsavres.S      | 238 +-------------------------------------
 6 files changed, 22 insertions(+), 242 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index fe76cfe..8ea7c9e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -179,7 +179,11 @@ else
 CHECKFLAGS	+= -D__LITTLE_ENDIAN__
 endif
 
+ifeq ($(CONFIG_PPC32),y)
 KBUILD_LDFLAGS_MODULE += arch/powerpc/lib/crtsavres.o
+else
+KBUILD_LDFLAGS_MODULE += --save-restore-funcs
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
index f3d9b35..085fb2b 100644
--- a/arch/powerpc/boot/crtsavres.S
+++ b/arch/powerpc/boot/crtsavres.S
@@ -37,12 +37,13 @@
  *    the executable file might be covered by the GNU General Public License.
  */
 
+#ifdef __powerpc64__
+#error "On PPC64, FPR save/restore functions are provided by the linker."
+#endif
+
 	.file	"crtsavres.S"
 	.section ".text"
 
-/* On PowerPC64 Linux, these functions are provided by the linker.  */
-#ifndef __powerpc64__
-
 #define _GLOBAL(name) \
 	.type name,@function; \
 	.globl name; \
@@ -230,4 +231,3 @@ _GLOBAL(_rest32gpr_31_x)
 	mtlr	0
 	mr	1,11
 	blr
-#endif
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index a09c666..63775d9 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -84,6 +84,12 @@ SECTIONS
 		KPROBES_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
+		/*
+		 * Linker puts .sfpr at the beginning of a group of input
+		 * sections, which can break start-of-text offset if it is
+		 * included with the main text sections.
+		 */
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
index 18af0b3..b311607 100644
--- a/arch/powerpc/lib/crtsavres.S
+++ b/arch/powerpc/lib/crtsavres.S
@@ -40,12 +40,14 @@
 
 #include <asm/ppc_asm.h>
 
+#ifdef __powerpc64__
+#error "On PPC64, FPR save/restore functions are provided by the linker."
+#endif
+
 	.file	"crtsavres.S"
 
 #ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 
-#ifndef CONFIG_PPC64
-
 	.section ".text"
 
 /* Routines for saving integer registers, called by the compiler.  */
@@ -312,236 +314,4 @@ _GLOBAL(_restvr_31)
 
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
