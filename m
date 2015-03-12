Return-Path: <Kim.Phillips@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0135.outbound.protection.outlook.com [207.46.100.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 069FA1A0394
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 09:51:14 +1100 (AEDT)
Date: Thu, 12 Mar 2015 17:45:49 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <scottwood@freescale.com>, Anton Blanchard <anton@samba.org>
Subject: [RFC] powerpc: e6500 optimised copy_to_user/copy_from_user
Message-ID: <20150312174549.2b735117897e772bc91e29a4@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This mimics commit a66086b8197da8dc83b698642d5947ff850e708d "powerpc:
POWER7 optimised copy_to_user/copy_from_user using VMX", but for
the e6500, or BOOK3S_64.  Changes have been made for the smaller
cacheline size (64 bytes on e6500), and data cache block touch (dcbt)
instructions have been rewritten to prefetch 8 lines ahead, based
on preliminary benchmark results and perf -e L1-dcache-prefetches
and misses observations.

We see a gain of 5% in large netperf benchmarks between two T4240s,
both in terms of throughput, and latency.  The same netperf
lo(opback) test improves 27%.

Anton's microbenchmark results show a clear linear improvement path
with sizes 32KB and above, where, below that, the additional overhead
over the existing copyuser_64 implementation shows its head: e.g., 6%
for 1448 byte copies.  The observed transfer sizes under large,
netperf benchmarks show the TCP stack is invoking copies on the
order of a few 10's of KB, however. 1MB transfers are 30% better-off
on wall clock time.

RFC because of the following known issues:
- unsure if PPC_BOOK3E_64 vs. PPC_BOOK3S_64 build-time switch to
  re-target __copy_tofrom_user_vmx is appropriate (ppc64_defconfig
  builds fine, however)
- syscalls report deficits when folding vmx_unaligned_copy to a 64B
  cacheline (undone for this RFC)
- any consideration for the e5500?
- asm branch label re-enumeration
- ..I'm sure I've missed another couple of things, possibly
including how to fix lower-sized transfer performance

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
applies to Linus' ToT today (commit 09d35919b06),
since Scott's tree seems a bit outdated.

 arch/powerpc/include/asm/cputable.h |   2 +-
 arch/powerpc/lib/Makefile           |   5 +-
 arch/powerpc/lib/copyuser_64.S      |   2 +-
 arch/powerpc/lib/copyuser_e6500.S   | 768 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/lib/copyuser_power7.S  |   2 +-
 5 files changed, 775 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/lib/copyuser_e6500.S

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 5cf5a6d..66ca94a 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -391,7 +391,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP | \
-	    CPU_FTR_CELL_TB_BUG | CPU_FTR_SMT)
+	    CPU_FTR_CELL_TB_BUG | CPU_FTR_SMT | CPU_FTR_VMX_COPY)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 7902802..c85e05d 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -15,12 +15,15 @@ obj-y += string.o alloc.o crtsavres.o ppc_ksyms.o code-patching.o \
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 
 obj64-y	+= copypage_64.o copyuser_64.o usercopy_64.o mem_64.o hweight_64.o \
-	   copyuser_power7.o string_64.o copypage_power7.o memcpy_power7.o \
+	   string_64.o copypage_power7.o memcpy_power7.o \
 	   memcpy_64.o memcmp_64.o
 
 obj64-$(CONFIG_SMP)	+= locks.o
 obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 
+obj64-$(CONFIG_PPC_BOOK3S_64)	+= copyuser_power7.o
+obj64-$(CONFIG_PPC_BOOK3E_64)	+= copyuser_e6500.o
+
 ifeq ($(CONFIG_GENERIC_CSUM),)
 obj-y			+= checksum_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC64)	+= checksum_wrappers_64.o
diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index f09899e..0cf9253 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -22,7 +22,7 @@ _GLOBAL_TOC(__copy_tofrom_user)
 BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
-	b	__copy_tofrom_user_power7
+	b	__copy_tofrom_user_vmx
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
 _GLOBAL(__copy_tofrom_user_base)
 	/* first check for a whole page copy on a page boundary */
diff --git a/arch/powerpc/lib/copyuser_e6500.S b/arch/powerpc/lib/copyuser_e6500.S
new file mode 100644
index 0000000..efd4251
--- /dev/null
+++ b/arch/powerpc/lib/copyuser_e6500.S
@@ -0,0 +1,768 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright Freescale Semiconductor, 2015
+ *
+ * based on code with:
+ * Copyright (C) IBM Corporation, 2011
+ *
+ * Author: Anton Blanchard <anton@au.ibm.com>
+ */
+#include <asm/ppc_asm.h>
+
+#ifdef __BIG_ENDIAN__
+#define LVS(VRT,RA,RB)		lvsl	VRT,RA,RB
+#define VPERM(VRT,VRA,VRB,VRC)	vperm	VRT,VRA,VRB,VRC
+#else
+#define LVS(VRT,RA,RB)		lvsr	VRT,RA,RB
+#define VPERM(VRT,VRA,VRB,VRC)	vperm	VRT,VRB,VRA,VRC
+#endif
+
+	.macro err1
+100:
+	.section __ex_table,"a"
+	.align 3
+	.llong 100b,.Ldo_err1
+	.previous
+	.endm
+
+	.macro err2
+200:
+	.section __ex_table,"a"
+	.align 3
+	.llong 200b,.Ldo_err2
+	.previous
+	.endm
+
+#ifdef CONFIG_ALTIVEC
+	.macro err3
+300:
+	.section __ex_table,"a"
+	.align 3
+	.llong 300b,.Ldo_err3
+	.previous
+	.endm
+
+	.macro err4
+400:
+	.section __ex_table,"a"
+	.align 3
+	.llong 400b,.Ldo_err4
+	.previous
+	.endm
+
+
+.Ldo_err4:
+.Ldo_err3:
+	bl	exit_vmx_usercopy
+	ld	r0,STACKFRAMESIZE+16(r1)
+	mtlr	r0
+	b	.Lexit
+#endif /* CONFIG_ALTIVEC */
+
+.Ldo_err2:
+	ld	r14,STK_REG(R15)(r1)
+	ld	r14,STK_REG(R14)(r1)
+.Lexit:
+	addi	r1,r1,STACKFRAMESIZE
+.Ldo_err1:
+	ld	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
+	ld	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
+	ld	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
+	b	__copy_tofrom_user_base
+
+
+_GLOBAL(__copy_tofrom_user_vmx)
+	dcbt	0,r4
+	dcbtst	0,r3
+#ifdef CONFIG_ALTIVEC
+	cmpldi	r5,64
+	cmpldi	cr1,r5,4096
+
+	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
+	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
+	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
+
+	blt	.Lshort_copy
+	bgt	cr1,.Lvmx_copy
+#else
+	cmpldi	r5,64
+
+	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
+	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
+	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
+
+	blt	.Lshort_copy
+#endif
+
+.Lnonvmx_copy:
+	/* Get the source 8B aligned */
+	neg	r6,r4
+	mtocrf	0x01,r6
+	clrldi	r6,r6,(64-3)
+
+	bf	cr7*4+3,1f
+err1;	lbz	r0,0(r4)
+	addi	r4,r4,1
+err1;	stb	r0,0(r3)
+	addi	r3,r3,1
+
+1:	bf	cr7*4+2,2f
+err1;	lhz	r0,0(r4)
+	addi	r4,r4,2
+err1;	sth	r0,0(r3)
+	addi	r3,r3,2
+
+2:	bf	cr7*4+1,3f
+err1;	lwz	r0,0(r4)
+	addi	r4,r4,4
+err1;	stw	r0,0(r3)
+	addi	r3,r3,4
+
+3:	sub	r5,r5,r6
+	cmpldi	r5,64
+	blt	5f
+
+	mflr	r0
+	stdu	r1,-STACKFRAMESIZE(r1)
+	std	r14,STK_REG(R14)(r1)
+	std	r15,STK_REG(R15)(r1)
+	std	r0,STACKFRAMESIZE+16(r1)
+
+#define LINES_AHEAD 8
+	/*
+	 * We prefetch both the source and destination using regular touch
+	 * instructions.
+	 */
+	clrrdi	r6,r4,6
+	clrrdi	r9,r3,6
+
+	srdi	r7,r5,6		/* length in cachelines, capped at LINES_AHEAD*/
+	cmpldi	r7,LINES_AHEAD
+	ble	111f		/* continue if cachelines <= LINES_AHEAD */
+	li	r7,LINES_AHEAD	/* otherwise, r7 <- LINES_AHEAD */
+111:	lis	r0,0
+
+	mtctr	r7
+222:
+	addi	r6,r6,64
+	addi	r9,r9,64
+
+	dcbt	r0,r6   /* addr from */
+	dcbtst	r0,r9   /* addr to */
+
+	bdnz	222b
+
+	li	r14,64*LINES_AHEAD
+
+	srdi	r15,r5,6	/* length in cachelines */
+	cmpldi	r15,LINES_AHEAD
+	ble	442f		/* don't prefetch if cachelines <= LINES_AHEAD */
+	subi	r15,r15,LINES_AHEAD	/* otherwise, r15 <- r15 - LINES_AHEAD */
+	mtctr	r15
+
+	/* Now do cacheline (64B) sized loads and stores WITH prefetches. */
+	.align	5
+4:
+err2;	ld	r0,0(r4)
+err2;	ld	r6,8(r4)
+err2;	ld	r7,16(r4)
+err2;	ld	r8,24(r4)
+err2;	ld	r9,32(r4)
+err2;	ld	r10,40(r4)
+err2;	ld	r11,48(r4)
+err2;	ld	r12,56(r4)
+
+	addi	r4,r4,64
+	dcbt	r14,r4
+err2;	std	r0,0(r3)
+err2;	std	r6,8(r3)
+err2;	std	r7,16(r3)
+err2;	std	r8,24(r3)
+err2;	std	r9,32(r3)
+err2;	std	r10,40(r3)
+err2;	std	r11,48(r3)
+err2;	std	r12,56(r3)
+
+	addi	r3,r3,64
+	dcbtst	r14,r3
+	bdnz	4b
+
+	srdi	r7,r5,6		/* length in cachelines */
+	subf	r15,r15,r7	/* r15 = r7 - r15 */
+442:
+	mtctr	r15
+
+	/* remainder cacheline (64B) sized loads and stores WITHOUT prefetches*/
+	.align	5
+444:
+err2;	ld	r0,0(r4)
+err2;	ld	r6,8(r4)
+err2;	ld	r7,16(r4)
+err2;	ld	r8,24(r4)
+err2;	ld	r9,32(r4)
+err2;	ld	r10,40(r4)
+err2;	ld	r11,48(r4)
+err2;	ld	r12,56(r4)
+
+	addi	r4,r4,64
+err2;	std	r0,0(r3)
+err2;	std	r6,8(r3)
+err2;	std	r7,16(r3)
+err2;	std	r8,24(r3)
+err2;	std	r9,32(r3)
+err2;	std	r10,40(r3)
+err2;	std	r11,48(r3)
+err2;	std	r12,56(r3)
+
+	addi	r3,r3,64
+	bdnz	444b
+
+	clrldi	r5,r5,(64-6)
+
+	ld	r14,STK_REG(R14)(r1)
+	ld	r15,STK_REG(R15)(r1)
+	addi	r1,r1,STACKFRAMESIZE
+
+	/* Up to 63B to go */
+.Lshort_copy:
+5:	srdi	r6,r5,4
+	mtocrf	0x01,r6
+
+7:	bf	cr7*4+2,8f
+err1;	ld	r0,0(r4)
+err1;	ld	r6,8(r4)
+err1;	ld	r7,16(r4)
+err1;	ld	r8,24(r4)
+	addi	r4,r4,32
+err1;	std	r0,0(r3)
+err1;	std	r6,8(r3)
+err1;	std	r7,16(r3)
+err1;	std	r8,24(r3)
+	addi	r3,r3,32
+
+	/* Up to 31B to go */
+8:	bf	cr7*4+3,9f
+err1;	ld	r0,0(r4)
+err1;	ld	r6,8(r4)
+	addi	r4,r4,16
+err1;	std	r0,0(r3)
+err1;	std	r6,8(r3)
+	addi	r3,r3,16
+
+9:	clrldi	r5,r5,(64-4)
+
+	/* Up to 15B to go */
+	mtocrf	0x01,r5
+	bf	cr7*4+0,12f
+err1;	lwz	r0,0(r4)	/* Less chance of a reject with word ops */
+err1;	lwz	r6,4(r4)
+	addi	r4,r4,8
+err1;	stw	r0,0(r3)
+err1;	stw	r6,4(r3)
+	addi	r3,r3,8
+
+12:	bf	cr7*4+1,13f
+err1;	lwz	r0,0(r4)
+	addi	r4,r4,4
+err1;	stw	r0,0(r3)
+	addi	r3,r3,4
+
+13:	bf	cr7*4+2,14f
+err1;	lhz	r0,0(r4)
+	addi	r4,r4,2
+err1;	sth	r0,0(r3)
+	addi	r3,r3,2
+
+14:	bf	cr7*4+3,15f
+err1;	lbz	r0,0(r4)
+err1;	stb	r0,0(r3)
+
+15:	li	r3,0
+	blr
+
+.Lunwind_stack_nonvmx_copy:
+	addi	r1,r1,STACKFRAMESIZE
+	b	.Lnonvmx_copy
+
+#ifdef CONFIG_ALTIVEC
+.Lvmx_copy:
+	mflr	r0
+	std	r0,16(r1)
+	stdu	r1,-STACKFRAMESIZE(r1)
+	bl	enter_vmx_usercopy
+	cmpwi	cr1,r3,0
+	ld	r0,STACKFRAMESIZE+16(r1)
+	ld	r3,STK_REG(R31)(r1)
+	ld	r4,STK_REG(R30)(r1)
+	ld	r5,STK_REG(R29)(r1)
+	mtlr	r0
+
+	/*
+	 * We prefetch both the source and destination using regular touch
+	 * instructions.
+	 */
+	clrrdi	r6,r4,6
+	clrrdi	r9,r3,6
+
+	srdi	r7,r5,6		/* length in cachelines, capped at LINES_AHEAD*/
+	cmpldi	r7,LINES_AHEAD
+	ble	333f
+	li	r7,LINES_AHEAD
+333:	lis	r0,0
+
+	mtctr	r7
+444:
+	addi	r6,r6,64
+	addi	r9,r9,64
+
+	dcbt	r0,r6   /* addr from */
+	dcbtst	r0,r9   /* addr to */
+
+	bdnz	444b
+
+	beq	cr1,.Lunwind_stack_nonvmx_copy
+
+	/*
+	 * If source and destination are not relatively aligned we use a
+	 * slower permute loop.
+	 */
+	xor	r6,r4,r3
+	rldicl.	r6,r6,0,(64-4)
+	bne	.Lvmx_unaligned_copy
+
+	/* Get the destination 16B aligned */
+	neg	r6,r3
+	mtocrf	0x01,r6
+	clrldi	r6,r6,(64-4)
+
+	bf	cr7*4+3,1f
+err3;	lbz	r0,0(r4)
+	addi	r4,r4,1
+err3;	stb	r0,0(r3)
+	addi	r3,r3,1
+
+1:	bf	cr7*4+2,2f
+err3;	lhz	r0,0(r4)
+	addi	r4,r4,2
+err3;	sth	r0,0(r3)
+	addi	r3,r3,2
+
+2:	bf	cr7*4+1,3f
+err3;	lwz	r0,0(r4)
+	addi	r4,r4,4
+err3;	stw	r0,0(r3)
+	addi	r3,r3,4
+
+3:	bf	cr7*4+0,4f
+err3;	ld	r0,0(r4)
+	addi	r4,r4,8
+err3;	std	r0,0(r3)
+	addi	r3,r3,8
+
+4:	sub	r5,r5,r6
+
+	/* Get the destination 64B aligned */
+	neg	r6,r3
+	srdi	r7,r6,4
+	mtocrf	0x01,r7
+	clrldi	r6,r6,(64-6)
+
+	li	r9,16
+	li	r10,32
+	li	r11,48
+
+	bf	cr7*4+3,5f
+err3;	lvx	vr1,r0,r4
+	addi	r4,r4,16
+err3;	stvx	vr1,r0,r3
+	addi	r3,r3,16
+
+5:	bf	cr7*4+2,7f
+err3;	lvx	vr1,r0,r4
+err3;	lvx	vr0,r4,r9
+	addi	r4,r4,32
+err3;	stvx	vr1,r0,r3
+err3;	stvx	vr0,r3,r9
+	addi	r3,r3,32
+
+7:	sub	r5,r5,r6	/* r5 <- r6 - r5 */
+	srdi	r6,r5,6
+
+	cmpldi	r6,LINES_AHEAD
+	ble	882f		/* branch if cachelines <= LINES_AHEAD */
+	subi	r6,r6,LINES_AHEAD	/* otherwise, r6 <- r6 - LINES_AHEAD */
+
+	li	r12,64*LINES_AHEAD
+
+	mtctr	r6
+
+	/*
+	 * Now do cacheline (64B) sized loads and stores WITH prefetches.
+	 * By this stage the cacheline stores are also cacheline aligned.
+	 */
+	.align	5
+8:
+err4;	lvx	vr7,r0,r4
+err4;	lvx	vr6,r4,r9
+err4;	lvx	vr5,r4,r10
+err4;	lvx	vr4,r4,r11
+
+	addi	r4,r4,64
+
+	dcbt	r12,r4
+
+err4;	stvx	vr7,r0,r3
+err4;	stvx	vr6,r3,r9
+err4;	stvx	vr5,r3,r10
+err4;	stvx	vr4,r3,r11
+
+	addi	r3,r3,64
+
+	dcbtst	r12,r3
+
+	bdnz	8b
+
+	srdi	r7,r5,6		/* length in cachelines */
+	subf	r6,r6,r7	/* r6 = r7 - r6 */
+882:
+	mtctr	r6
+	/* remainder cacheline (64B) sized loads and stores WITHOUT prefetches.  */
+	.align	5
+88:
+err4;	lvx	vr7,r0,r4
+err4;	lvx	vr6,r4,r9
+err4;	lvx	vr5,r4,r10
+err4;	lvx	vr4,r4,r11
+
+	addi	r4,r4,64
+
+err4;	stvx	vr7,r0,r3
+err4;	stvx	vr6,r3,r9
+err4;	stvx	vr5,r3,r10
+err4;	stvx	vr4,r3,r11
+
+	addi	r3,r3,64
+
+	bdnz	88b
+
+	/* Up to 63B to go */
+	clrldi	r5,r5,(64-6)
+	srdi	r6,r5,4
+	mtocrf	0x01,r6
+
+9:	bf	cr7*4+2,10f
+err3;	lvx	vr1,r0,r4
+err3;	lvx	vr0,r4,r9
+	addi	r4,r4,32
+err3;	stvx	vr1,r0,r3
+err3;	stvx	vr0,r3,r9
+	addi	r3,r3,32
+
+10:	bf	cr7*4+3,11f
+err3;	lvx	vr1,r0,r4
+	addi	r4,r4,16
+err3;	stvx	vr1,r0,r3
+	addi	r3,r3,16
+
+	/* Up to 15B to go */
+11:	clrldi	r5,r5,(64-4)
+	mtocrf	0x01,r5
+	bf	cr7*4+0,12f
+err3;	ld	r0,0(r4)
+	addi	r4,r4,8
+err3;	std	r0,0(r3)
+	addi	r3,r3,8
+
+12:	bf	cr7*4+1,13f
+err3;	lwz	r0,0(r4)
+	addi	r4,r4,4
+err3;	stw	r0,0(r3)
+	addi	r3,r3,4
+
+13:	bf	cr7*4+2,14f
+err3;	lhz	r0,0(r4)
+	addi	r4,r4,2
+err3;	sth	r0,0(r3)
+	addi	r3,r3,2
+
+14:	bf	cr7*4+3,15f
+err3;	lbz	r0,0(r4)
+err3;	stb	r0,0(r3)
+
+15:	addi	r1,r1,STACKFRAMESIZE
+	b	exit_vmx_usercopy	/* tail call optimise */
+
+.Lvmx_unaligned_copy:
+	/* Get the destination 16B aligned */
+	neg	r6,r3
+	mtocrf	0x01,r6
+	clrldi	r6,r6,(64-4)
+
+	bf	cr7*4+3,1f
+err3;	lbz	r0,0(r4)
+	addi	r4,r4,1
+err3;	stb	r0,0(r3)
+	addi	r3,r3,1
+
+1:	bf	cr7*4+2,2f
+err3;	lhz	r0,0(r4)
+	addi	r4,r4,2
+err3;	sth	r0,0(r3)
+	addi	r3,r3,2
+
+2:	bf	cr7*4+1,3f
+err3;	lwz	r0,0(r4)
+	addi	r4,r4,4
+err3;	stw	r0,0(r3)
+	addi	r3,r3,4
+
+3:	bf	cr7*4+0,4f
+err3;	lwz	r0,0(r4)	/* Less chance of a reject with word ops */
+err3;	lwz	r7,4(r4)
+	addi	r4,r4,8
+err3;	stw	r0,0(r3)
+err3;	stw	r7,4(r3)
+	addi	r3,r3,8
+
+4:	sub	r5,r5,r6
+
+	/* Get the destination 128B aligned */
+	neg	r6,r3
+	srdi	r7,r6,4
+	mtocrf	0x01,r7
+	clrldi	r6,r6,(64-7)
+
+	li	r9,16
+	li	r10,32
+	li	r11,48
+
+	LVS(vr16,0,r4)		/* Setup permute control vector */
+err3;	lvx	vr0,0,r4
+	addi	r4,r4,16
+
+	bf	cr7*4+3,5f
+err3;	lvx	vr1,r0,r4
+	VPERM(vr8,vr0,vr1,vr16)
+	addi	r4,r4,16
+err3;	stvx	vr8,r0,r3
+	addi	r3,r3,16
+	vor	vr0,vr1,vr1
+
+5:	bf	cr7*4+2,6f
+err3;	lvx	vr1,r0,r4
+	VPERM(vr8,vr0,vr1,vr16)
+err3;	lvx	vr0,r4,r9
+	VPERM(vr9,vr1,vr0,vr16)
+	addi	r4,r4,32
+err3;	stvx	vr8,r0,r3
+err3;	stvx	vr9,r3,r9
+	addi	r3,r3,32
+
+6:	bf	cr7*4+1,7f
+err3;	lvx	vr3,r0,r4
+	VPERM(vr8,vr0,vr3,vr16)
+err3;	lvx	vr2,r4,r9
+	VPERM(vr9,vr3,vr2,vr16)
+err3;	lvx	vr1,r4,r10
+	VPERM(vr10,vr2,vr1,vr16)
+err3;	lvx	vr0,r4,r11
+	VPERM(vr11,vr1,vr0,vr16)
+	addi	r4,r4,64
+err3;	stvx	vr8,r0,r3
+err3;	stvx	vr9,r3,r9
+err3;	stvx	vr10,r3,r10
+err3;	stvx	vr11,r3,r11
+	addi	r3,r3,64
+
+7:	sub	r5,r5,r6
+	srdi	r6,r5,7
+
+	cmpldi	r6,LINES_AHEAD
+	ble	982f		/* branch if cachelines <= LINES_AHEAD */
+	subi	r6,r6,LINES_AHEAD	/* otherwise, r6 <- r6 - LINES_AHEAD */
+
+	std	r14,STK_REG(R14)(r1)
+	std	r15,STK_REG(R15)(r1)
+	std	r16,STK_REG(R16)(r1)
+
+	li	r12,64
+	li	r14,80
+	li	r15,96
+	li	r16,112
+
+	li	r8,64*LINES_AHEAD
+
+	mtctr	r6
+
+	/*
+	 * Now do cacheline (128B) sized loads and stores WITH prefetches.
+	 * By this stage the cacheline stores are also cacheline aligned.
+	 */
+	.align	5
+8:
+err4;	lvx	vr7,r0,r4
+	VPERM(vr8,vr0,vr7,vr16)
+err4;	lvx	vr6,r4,r9
+	VPERM(vr9,vr7,vr6,vr16)
+err4;	lvx	vr5,r4,r10
+	VPERM(vr10,vr6,vr5,vr16)
+err4;	lvx	vr4,r4,r11
+	VPERM(vr11,vr5,vr4,vr16)
+err4;	lvx	vr3,r4,r12
+	VPERM(vr12,vr4,vr3,vr16)
+err4;	lvx	vr2,r4,r14
+	VPERM(vr13,vr3,vr2,vr16)
+err4;	lvx	vr1,r4,r15
+	VPERM(vr14,vr2,vr1,vr16)
+err4;	lvx	vr0,r4,r16
+	VPERM(vr15,vr1,vr0,vr16)
+
+	addi    r4,r4,64
+	dcbt	r8,r4
+	addi    r4,r4,64
+	dcbt	r8,r4
+
+err4;	stvx	vr8,r0,r3
+err4;	stvx	vr9,r3,r9
+err4;	stvx	vr10,r3,r10
+err4;	stvx	vr11,r3,r11
+err4;	stvx	vr12,r3,r12
+err4;	stvx	vr13,r3,r14
+err4;	stvx	vr14,r3,r15
+err4;	stvx	vr15,r3,r16
+ 
+	addi    r3,r3,64
+	dcbtst	r8,r3
+	addi    r3,r3,64
+	dcbtst	r8,r3
+
+	bdnz	8b
+
+	srdi	r7,r5,7		/* length in double-cachelines */
+	subf	r6,r6,r7	/* r6 = r7 - r6 */
+982:
+	mtctr	r6
+	/*
+	 * remainder double-cacheline (128B) sized loads and stores
+	 * WITHOUT prefetches.
+	 */
+	.align	5
+98:
+err4;	lvx	vr7,r0,r4
+	VPERM(vr8,vr0,vr7,vr16)
+err4;	lvx	vr6,r4,r9
+	VPERM(vr9,vr7,vr6,vr16)
+err4;	lvx	vr5,r4,r10
+	VPERM(vr10,vr6,vr5,vr16)
+err4;	lvx	vr4,r4,r11
+	VPERM(vr11,vr5,vr4,vr16)
+err4;	lvx	vr3,r4,r12
+	VPERM(vr12,vr4,vr3,vr16)
+err4;	lvx	vr2,r4,r14
+	VPERM(vr13,vr3,vr2,vr16)
+err4;	lvx	vr1,r4,r15
+	VPERM(vr14,vr2,vr1,vr16)
+err4;	lvx	vr0,r4,r16
+	VPERM(vr15,vr1,vr0,vr16)
+
+	addi    r4,r4,128
+
+err4;	stvx	vr8,r0,r3
+err4;	stvx	vr9,r3,r9
+err4;	stvx	vr10,r3,r10
+err4;	stvx	vr11,r3,r11
+err4;	stvx	vr12,r3,r12
+err4;	stvx	vr13,r3,r14
+err4;	stvx	vr14,r3,r15
+err4;	stvx	vr15,r3,r16
+ 
+	addi    r3,r3,128
+
+	bdnz	98b
+
+	ld	r14,STK_REG(R14)(r1)
+	ld	r15,STK_REG(R15)(r1)
+	ld	r16,STK_REG(R16)(r1)
+
+	/* Up to 127B to go */
+	clrldi	r5,r5,(64-7)
+	srdi	r6,r5,4
+	mtocrf	0x01,r6
+
+	bf      cr7*4+1,9f
+err3;	lvx     vr3,r0,r4
+	VPERM(vr8,vr0,vr3,vr16)
+err3;	lvx     vr2,r4,r9
+	VPERM(vr9,vr3,vr2,vr16)
+err3;	lvx     vr1,r4,r10
+	VPERM(vr10,vr2,vr1,vr16)
+err3;	lvx     vr0,r4,r11
+	VPERM(vr11,vr1,vr0,vr16)
+	addi    r4,r4,64
+err3;	stvx    vr8,r0,r3
+err3;	stvx    vr9,r3,r9
+err3;	stvx    vr10,r3,r10
+err3;	stvx    vr11,r3,r11
+	addi    r3,r3,64
+
+9:	bf	cr7*4+2,10f
+err3;	lvx	vr1,r0,r4
+	VPERM(vr8,vr0,vr1,vr16)
+err3;	lvx	vr0,r4,r9
+	VPERM(vr9,vr1,vr0,vr16)
+	addi	r4,r4,32
+err3;	stvx	vr8,r0,r3
+err3;	stvx	vr9,r3,r9
+	addi	r3,r3,32
+
+10:	bf	cr7*4+3,11f
+err3;	lvx	vr1,r0,r4
+	VPERM(vr8,vr0,vr1,vr16)
+	addi	r4,r4,16
+err3;	stvx	vr8,r0,r3
+	addi	r3,r3,16
+
+	/* Up to 15B to go */
+11:	clrldi	r5,r5,(64-4)
+	addi	r4,r4,-16	/* Unwind the +16 load offset */
+	mtocrf	0x01,r5
+	bf	cr7*4+0,12f
+err3;	lwz	r0,0(r4)	/* Less chance of a reject with word ops */
+err3;	lwz	r6,4(r4)
+	addi	r4,r4,8
+err3;	stw	r0,0(r3)
+err3;	stw	r6,4(r3)
+	addi	r3,r3,8
+
+12:	bf	cr7*4+1,13f
+err3;	lwz	r0,0(r4)
+	addi	r4,r4,4
+err3;	stw	r0,0(r3)
+	addi	r3,r3,4
+
+13:	bf	cr7*4+2,14f
+err3;	lhz	r0,0(r4)
+	addi	r4,r4,2
+err3;	sth	r0,0(r3)
+	addi	r3,r3,2
+
+14:	bf	cr7*4+3,15f
+err3;	lbz	r0,0(r4)
+err3;	stb	r0,0(r3)
+
+15:	addi	r1,r1,STACKFRAMESIZE
+	b	exit_vmx_usercopy	/* tail call optimise */
+#endif /* CONFIG_ALTIVEC */
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index 92ee840..258e6fc 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -91,7 +91,7 @@
 	b	__copy_tofrom_user_base
 
 
-_GLOBAL(__copy_tofrom_user_power7)
+_GLOBAL(__copy_tofrom_user_vmx)
 #ifdef CONFIG_ALTIVEC
 	cmpldi	r5,16
 	cmpldi	cr1,r5,4096
-- 
2.3.2
