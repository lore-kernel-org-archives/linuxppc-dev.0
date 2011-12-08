Return-Path: <anton@samba.org>
Date: Thu, 8 Dec 2011 16:02:27 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mikey@neuling.org,
 sukadev@linux.vnet.ibm.com, hbabu@us.ibm.com
Subject: [PATCH] powerpc: POWER7 optimised copy_to_user/copy_from_user using
 VMX
Message-ID: <20111208160227.2ef2d526@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Implement a POWER7 optimised copy_to_user/copy_from_user using VMX.
For large aligned copies this new loop is over 10% faster, and for
large unaligned copies it is over 200% faster.

If we take a fault we fall back to the old version, this keeps
things relatively simple and easy to verify.

On POWER7 unaligned stores rarely slow down - they only flush when
a store crosses a 4KB page boundary. Furthermore this flush is
handled completely in hardware and should be 20-30 cycles.

Unaligned loads on the other hand flush much more often - whenever
crossing a 128 byte cache line, or a 32 byte sector if either sector
is an L1 miss.

Considering this information we really want to get the loads aligned
and not worry about the alignment of the stores. Microbenchmarks
confirm that this approach is much faster than the current unaligned
copy loop that uses shifts and rotates to ensure both loads and
stores are aligned.

We also want to try and do the stores in cacheline aligned, cacheline
sized chunks. If the store queue is unable to merge an entire
cacheline of stores then the L2 cache will have to do a
read/modify/write. Even worse, we will serialise this with the stores
in the next iteration of the copy loop since both iterations hit
the same cacheline.

Based on this, the new loop does the following things:


1 - 127 bytes
Get the source 8 byte aligned and use 8 byte loads and stores. Pretty
boring and similar to how the current loop works.

128 - 4095 bytes
Get the source 8 byte aligned and use 8 byte loads and stores,
1 cacheline at a time. We aren't doing the stores in cacheline
aligned chunks so we will potentially serialise once per cacheline.
Even so it is much better than the loop we have today.

4096 - bytes
If both source and destination have the same alignment get them both
16 byte aligned, then get the destination cacheline aligned. Do
cacheline sized loads and stores using VMX.

If source and destination do not have the same alignment, we get the
destination cacheline aligned, and use permute to do aligned loads.

In both cases the VMX loop should be optimal - we always do aligned
loads and stores and are always doing stores in cacheline aligned,
cacheline sized chunks.

To be able to use VMX we must be careful about interrupts and
sleeping. We don't use the VMX loop when in an interrupt (which should
be rare anyway) and we wrap the VMX loop in disable/enable_pagefault
and fall back to the existing copy_tofrom_user loop if we do need to
sleep.

The VMX breakpoint of 4096 bytes was chosen using this microbenchmark:

http://ozlabs.org/~anton/junkcode/copy_to_user.c

Since we are using VMX and there is a cost to saving and restoring
the user VMX state there are two broad cases we need to benchmark:

- Best case - userspace never uses VMX

- Worst case - userspace always uses VMX

In reality a userspace process will sit somewhere between these two
extremes. Since we need to test both aligned and unaligned copies we
end up with 4 combinations. The point at which the VMX loop begins to
win is:

0% VMX
aligned		2048 bytes
unaligned	2048 bytes

100% VMX
aligned		16384 bytes
unaligned	8192 bytes

Considering this is a microbenchmark, the data is hot in cache and
the VMX loop has better store queue merging properties we set the
breakpoint to 4096 bytes, a little below the unaligned breakpoints.

Some future optimisations we can look at:

- Looking at the perf data, a significant part of the cost when a
  task is always using VMX is the extra exception we take to restore
  the VMX state. As such we should do something similar to the x86
  optimisation that restores FPU state for heavy users. ie:

        /*
         * If the task has used fpu the last 5 timeslices, just do a full
         * restore of the math state immediately to avoid the trap; the
         * chances of needing FPU soon are obviously high now
         */
        preload_fpu = tsk_used_math(next_p) && next_p->fpu_counter > 5;

  and 

        /*
         * fpu_counter contains the number of consecutive context switches
         * that the FPU is used. If this is over a threshold, the lazy fpu
         * saving becomes unlazy to save the trap. This is an unsigned char
         * so that after 256 times the counter wraps and the behavior turns
         * lazy again; this to deal with bursty apps that only use FPU for
         * a short time
         */

- We could create a paca bit to mirror the VMX enabled MSR bit and check
  that first, avoiding multiple calls to calling enable_kernel_altivec.
  That should help with iovec based system calls like readv.

- We could have two VMX breakpoints, one for when we know the user VMX
  state is loaded into the registers and one when it isn't. This could
  be a second bit in the paca so we can calculate the break points quickly.

- One suggestion from Ben was to save and restore the VSX registers
  we use inline instead of using enable_kernel_altivec.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/include/asm/cputable.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/cputable.h	2011-09-07 15:15:49.096458526 +1000
+++ linux-build/arch/powerpc/include/asm/cputable.h	2011-12-08 15:38:46.627313507 +1100
@@ -201,6 +201,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
 #define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
+#define CPU_FTR_POWER7			LONG_ASM_CONST(0x2000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -425,7 +426,7 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE)
+	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_POWER7)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
Index: linux-build/arch/powerpc/lib/copyuser_64.S
===================================================================
--- linux-build.orig/arch/powerpc/lib/copyuser_64.S	2011-09-07 15:15:49.146459439 +1000
+++ linux-build/arch/powerpc/lib/copyuser_64.S	2011-12-08 15:38:42.491238635 +1100
@@ -11,6 +11,12 @@
 
 	.align	7
 _GLOBAL(__copy_tofrom_user)
+BEGIN_FTR_SECTION
+	nop
+FTR_SECTION_ELSE
+	b	__copy_tofrom_user_power7
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_POWER7)
+_GLOBAL(__copy_tofrom_user_base)
 	/* first check for a whole page copy on a page boundary */
 	cmpldi	cr1,r5,16
 	cmpdi	cr6,r5,4096
Index: linux-build/arch/powerpc/lib/copyuser_power7.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-build/arch/powerpc/lib/copyuser_power7.S	2011-12-08 15:38:44.655277808 +1100
@@ -0,0 +1,669 @@
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
+ * Copyright (C) IBM Corporation, 2011
+ *
+ * Author: Anton Blanchard <anton@au.ibm.com>
+ */
+#include <asm/ppc_asm.h>
+
+#define STACKFRAMESIZE	256
+#define STK_REG(i)	(112 + ((i)-14)*8)
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
+	ld	r16,STK_REG(r16)(r1)
+	ld	r15,STK_REG(r15)(r1)
+	ld	r14,STK_REG(r14)(r1)
+.Ldo_err3:
+	bl	.exit_vmx_copy
+	ld	r0,STACKFRAMESIZE+16(r1)
+	mtlr	r0
+	b	.Lexit
+
+.Ldo_err2:
+	ld	r22,STK_REG(r22)(r1)
+	ld	r21,STK_REG(r21)(r1)
+	ld	r20,STK_REG(r20)(r1)
+	ld	r19,STK_REG(r19)(r1)
+	ld	r18,STK_REG(r18)(r1)
+	ld	r17,STK_REG(r17)(r1)
+	ld	r16,STK_REG(r16)(r1)
+	ld	r15,STK_REG(r15)(r1)
+	ld	r14,STK_REG(r14)(r1)
+.Lexit:
+	addi	r1,r1,STACKFRAMESIZE
+.Ldo_err1:
+	ld	r3,48(r1)
+	ld	r4,56(r1)
+	ld	r5,64(r1)
+	b	__copy_tofrom_user_base
+
+
+_GLOBAL(__copy_tofrom_user_power7)
+	cmpldi	r5,16
+	cmpldi	cr1,r5,4096
+
+	std	r3,48(r1)
+	std	r4,56(r1)
+	std	r5,64(r1)
+
+	blt	.Lshort_copy
+	bgt	cr1,.Lvmx_copy
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
+	cmpldi	r5,128
+	blt	5f
+
+	mflr	r0
+	stdu	r1,-STACKFRAMESIZE(r1)
+	std	r14,STK_REG(r14)(r1)
+	std	r15,STK_REG(r15)(r1)
+	std	r16,STK_REG(r16)(r1)
+	std	r17,STK_REG(r17)(r1)
+	std	r18,STK_REG(r18)(r1)
+	std	r19,STK_REG(r19)(r1)
+	std	r20,STK_REG(r20)(r1)
+	std	r21,STK_REG(r21)(r1)
+	std	r22,STK_REG(r22)(r1)
+	std	r0,STACKFRAMESIZE+16(r1)
+
+	srdi	r6,r5,7
+	mtctr	r6
+
+	/* Now do cacheline (128B) sized loads and stores. */
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
+err2;	ld	r14,64(r4)
+err2;	ld	r15,72(r4)
+err2;	ld	r16,80(r4)
+err2;	ld	r17,88(r4)
+err2;	ld	r18,96(r4)
+err2;	ld	r19,104(r4)
+err2;	ld	r20,112(r4)
+err2;	ld	r21,120(r4)
+	addi	r4,r4,128
+err2;	std	r0,0(r3)
+err2;	std	r6,8(r3)
+err2;	std	r7,16(r3)
+err2;	std	r8,24(r3)
+err2;	std	r9,32(r3)
+err2;	std	r10,40(r3)
+err2;	std	r11,48(r3)
+err2;	std	r12,56(r3)
+err2;	std	r14,64(r3)
+err2;	std	r15,72(r3)
+err2;	std	r16,80(r3)
+err2;	std	r17,88(r3)
+err2;	std	r18,96(r3)
+err2;	std	r19,104(r3)
+err2;	std	r20,112(r3)
+err2;	std	r21,120(r3)
+	addi	r3,r3,128
+	bdnz	4b
+
+	clrldi	r5,r5,(64-7)
+
+	ld	r14,STK_REG(r14)(r1)
+	ld	r15,STK_REG(r15)(r1)
+	ld	r16,STK_REG(r16)(r1)
+	ld	r17,STK_REG(r17)(r1)
+	ld	r18,STK_REG(r18)(r1)
+	ld	r19,STK_REG(r19)(r1)
+	ld	r20,STK_REG(r20)(r1)
+	ld	r21,STK_REG(r21)(r1)
+	ld	r22,STK_REG(r22)(r1)
+	addi	r1,r1,STACKFRAMESIZE
+
+	/* Up to 127B to go */
+5:	srdi	r6,r5,4
+	mtocrf	0x01,r6
+
+6:	bf	cr7*4+1,7f
+err1;	ld	r0,0(r4)
+err1;	ld	r6,8(r4)
+err1;	ld	r7,16(r4)
+err1;	ld	r8,24(r4)
+err1;	ld	r9,32(r4)
+err1;	ld	r10,40(r4)
+err1;	ld	r11,48(r4)
+err1;	ld	r12,56(r4)
+	addi	r4,r4,64
+err1;	std	r0,0(r3)
+err1;	std	r6,8(r3)
+err1;	std	r7,16(r3)
+err1;	std	r8,24(r3)
+err1;	std	r9,32(r3)
+err1;	std	r10,40(r3)
+err1;	std	r11,48(r3)
+err1;	std	r12,56(r3)
+	addi	r3,r3,64
+
+	/* Up to 63B to go */
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
+.Lshort_copy:
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
+.Lvmx_copy:
+	mflr	r0
+	std	r0,16(r1)
+	stdu	r1,-STACKFRAMESIZE(r1)
+	bl	.enter_vmx_copy
+	cmpwi	r3,0
+	ld	r0,STACKFRAMESIZE+16(r1)
+	ld	r3,STACKFRAMESIZE+48(r1)
+	ld	r4,STACKFRAMESIZE+56(r1)
+	ld	r5,STACKFRAMESIZE+64(r1)
+	mtlr	r0
+
+	beq	.Lunwind_stack_nonvmx_copy
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
+	/* Get the desination 128B aligned */
+	neg	r6,r3
+	srdi	r7,r6,4
+	mtocrf	0x01,r7
+	clrldi	r6,r6,(64-7)
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
+5:	bf	cr7*4+2,6f
+err3;	lvx	vr1,r0,r4
+err3;	lvx	vr0,r4,r9
+	addi	r4,r4,32
+err3;	stvx	vr1,r0,r3
+err3;	stvx	vr0,r3,r9
+	addi	r3,r3,32
+
+6:	bf	cr7*4+1,7f
+err3;	lvx	vr3,r0,r4
+err3;	lvx	vr2,r4,r9
+err3;	lvx	vr1,r4,r10
+err3;	lvx	vr0,r4,r11
+	addi	r4,r4,64
+err3;	stvx	vr3,r0,r3
+err3;	stvx	vr2,r3,r9
+err3;	stvx	vr1,r3,r10
+err3;	stvx	vr0,r3,r11
+	addi	r3,r3,64
+
+7:	sub	r5,r5,r6
+	srdi	r6,r5,7
+
+	std	r14,STK_REG(r14)(r1)
+	std	r15,STK_REG(r15)(r1)
+	std	r16,STK_REG(r16)(r1)
+
+	li	r12,64
+	li	r14,80
+	li	r15,96
+	li	r16,112
+
+	mtctr	r6
+
+	/*
+	 * Now do cacheline sized loads and stores. By this stage the
+	 * cacheline stores are also cacheline aligned.
+	 */
+	.align	5
+8:
+err4;	lvx	vr7,r0,r4
+err4;	lvx	vr6,r4,r9
+err4;	lvx	vr5,r4,r10
+err4;	lvx	vr4,r4,r11
+err4;	lvx	vr3,r4,r12
+err4;	lvx	vr2,r4,r14
+err4;	lvx	vr1,r4,r15
+err4;	lvx	vr0,r4,r16
+	addi	r4,r4,128
+err4;	stvx	vr7,r0,r3
+err4;	stvx	vr6,r3,r9
+err4;	stvx	vr5,r3,r10
+err4;	stvx	vr4,r3,r11
+err4;	stvx	vr3,r3,r12
+err4;	stvx	vr2,r3,r14
+err4;	stvx	vr1,r3,r15
+err4;	stvx	vr0,r3,r16
+	addi	r3,r3,128
+	bdnz	8b
+
+	ld	r14,STK_REG(r14)(r1)
+	ld	r15,STK_REG(r15)(r1)
+	ld	r16,STK_REG(r16)(r1)
+
+	/* Up to 127B to go */
+	clrldi	r5,r5,(64-7)
+	srdi	r6,r5,4
+	mtocrf	0x01,r6
+
+	bf	cr7*4+1,9f
+err3;	lvx	vr3,r0,r4
+err3;	lvx	vr2,r4,r9
+err3;	lvx	vr1,r4,r10
+err3;	lvx	vr0,r4,r11
+	addi	r4,r4,64
+err3;	stvx	vr3,r0,r3
+err3;	stvx	vr2,r3,r9
+err3;	stvx	vr1,r3,r10
+err3;	stvx	vr0,r3,r11
+	addi	r3,r3,64
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
+	b	.exit_vmx_copy		/* tail call optimise */
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
+	/* Get the desination 128B aligned */
+	neg	r6,r3
+	srdi	r7,r6,4
+	mtocrf	0x01,r7
+	clrldi	r6,r6,(64-7)
+
+	li	r9,16
+	li	r10,32
+	li	r11,48
+
+	lvsl	vr16,0,r4	/* Setup permute control vector */
+err3;	lvx	vr0,0,r4
+	addi	r4,r4,16
+
+	bf	cr7*4+3,5f
+err3;	lvx	vr1,r0,r4
+	vperm	vr8,vr0,vr1,vr16
+	addi	r4,r4,16
+err3;	stvx	vr8,r0,r3
+	addi	r3,r3,16
+	vor	vr0,vr1,vr1
+
+5:	bf	cr7*4+2,6f
+err3;	lvx	vr1,r0,r4
+	vperm	vr8,vr0,vr1,vr16
+err3;	lvx	vr0,r4,r9
+	vperm	vr9,vr1,vr0,vr16
+	addi	r4,r4,32
+err3;	stvx	vr8,r0,r3
+err3;	stvx	vr9,r3,r9
+	addi	r3,r3,32
+
+6:	bf	cr7*4+1,7f
+err3;	lvx	vr3,r0,r4
+	vperm	vr8,vr0,vr3,vr16
+err3;	lvx	vr2,r4,r9
+	vperm	vr9,vr3,vr2,vr16
+err3;	lvx	vr1,r4,r10
+	vperm	vr10,vr2,vr1,vr16
+err3;	lvx	vr0,r4,r11
+	vperm	vr11,vr1,vr0,vr16
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
+	std	r14,STK_REG(r14)(r1)
+	std	r15,STK_REG(r15)(r1)
+	std	r16,STK_REG(r16)(r1)
+
+	li	r12,64
+	li	r14,80
+	li	r15,96
+	li	r16,112
+
+	mtctr	r6
+
+	/*
+	 * Now do cacheline sized loads and stores. By this stage the
+	 * cacheline stores are also cacheline aligned.
+	 */
+	.align	5
+8:
+err4;	lvx	vr7,r0,r4
+	vperm	vr8,vr0,vr7,vr16
+err4;	lvx	vr6,r4,r9
+	vperm	vr9,vr7,vr6,vr16
+err4;	lvx	vr5,r4,r10
+	vperm	vr10,vr6,vr5,vr16
+err4;	lvx	vr4,r4,r11
+	vperm	vr11,vr5,vr4,vr16
+err4;	lvx	vr3,r4,r12
+	vperm	vr12,vr4,vr3,vr16
+err4;	lvx	vr2,r4,r14
+	vperm	vr13,vr3,vr2,vr16
+err4;	lvx	vr1,r4,r15
+	vperm	vr14,vr2,vr1,vr16
+err4;	lvx	vr0,r4,r16
+	vperm	vr15,vr1,vr0,vr16
+	addi	r4,r4,128
+err4;	stvx	vr8,r0,r3
+err4;	stvx	vr9,r3,r9
+err4;	stvx	vr10,r3,r10
+err4;	stvx	vr11,r3,r11
+err4;	stvx	vr12,r3,r12
+err4;	stvx	vr13,r3,r14
+err4;	stvx	vr14,r3,r15
+err4;	stvx	vr15,r3,r16
+	addi	r3,r3,128
+	bdnz	8b
+
+	ld	r14,STK_REG(r14)(r1)
+	ld	r15,STK_REG(r15)(r1)
+	ld	r16,STK_REG(r16)(r1)
+
+	/* Up to 127B to go */
+	clrldi	r5,r5,(64-7)
+	srdi	r6,r5,4
+	mtocrf	0x01,r6
+
+	bf	cr7*4+1,9f
+err3;	lvx	vr3,r0,r4
+	vperm	vr8,vr0,vr3,vr16
+err3;	lvx	vr2,r4,r9
+	vperm	vr9,vr3,vr2,vr16
+err3;	lvx	vr1,r4,r10
+	vperm	vr10,vr2,vr1,vr16
+err3;	lvx	vr0,r4,r11
+	vperm	vr11,vr1,vr0,vr16
+	addi	r4,r4,64
+err3;	stvx	vr8,r0,r3
+err3;	stvx	vr9,r3,r9
+err3;	stvx	vr10,r3,r10
+err3;	stvx	vr11,r3,r11
+	addi	r3,r3,64
+
+9:	bf	cr7*4+2,10f
+err3;	lvx	vr1,r0,r4
+	vperm	vr8,vr0,vr1,vr16
+err3;	lvx	vr0,r4,r9
+	vperm	vr9,vr1,vr0,vr16
+	addi	r4,r4,32
+err3;	stvx	vr8,r0,r3
+err3;	stvx	vr9,r3,r9
+	addi	r3,r3,32
+
+10:	bf	cr7*4+3,11f
+err3;	lvx	vr1,r0,r4
+	vperm	vr8,vr0,vr1,vr16
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
+	b	.exit_vmx_copy		/* tail call optimise */
Index: linux-build/arch/powerpc/lib/Makefile
===================================================================
--- linux-build.orig/arch/powerpc/lib/Makefile	2011-09-07 15:15:49.146459439 +1000
+++ linux-build/arch/powerpc/lib/Makefile	2011-12-08 15:17:29.000000000 +1100
@@ -16,7 +16,8 @@ obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
-			   checksum_wrappers_64.o hweight_64.o
+			   checksum_wrappers_64.o hweight_64.o \
+			   copyuser_power7.o copyuser_power7_vmx.o
 obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
 obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o ldstfp.o
Index: linux-build/arch/powerpc/lib/copyuser_power7_vmx.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-build/arch/powerpc/lib/copyuser_power7_vmx.c	2011-12-08 15:38:44.639277518 +1100
@@ -0,0 +1,44 @@
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
+ * Copyright (C) IBM Corporation, 2011
+ *
+ * Authors: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
+ *          Anton Blanchard <anton@au.ibm.com>
+ */
+#include <linux/uaccess.h>
+#include <linux/hardirq.h>
+
+int enter_vmx_copy(void)
+{
+	if (in_interrupt())
+		return 0;
+
+	enable_kernel_altivec();
+
+	pagefault_disable();
+
+	return 1;
+}
+
+/*
+ * This function must return 0 because we tail call optimise when calling
+ * from __copy_tofrom_user_power7 which returns 0 on success.
+ */
+int exit_vmx_copy(void)
+{
+	pagefault_enable();
+	return 0;
+}
