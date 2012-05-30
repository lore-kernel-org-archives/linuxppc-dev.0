Return-Path: <anton@samba.org>
Date: Wed, 30 May 2012 15:33:12 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc: POWER7 optimised copy_page using VMX and
 enhanced prefetch
Message-ID: <20120530153312.3b46f57c@kryten>
In-Reply-To: <20120530153124.6a27d10d@kryten>
References: <20120530153124.6a27d10d@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Implement a POWER7 optimised copy_page using VMX and enhanced
prefetch instructions. We use enhanced prefetch hints to prefetch
both the load and store side. We copy a cacheline at a time and
fall back to regular loads and stores if we are unable to use VMX
(eg we are in an interrupt).

The following microbenchmark was used to assess the impact of
the patch:

http://ozlabs.org/~anton/junkcode/page_fault_file.c

We test MAP_PRIVATE page faults across a 1GB file, 100 times:

# time ./page_fault_file -p -l 1G -i 100

Before: 22.25s
After:  18.89s

17% faster

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/lib/copypage_power7.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-build/arch/powerpc/lib/copypage_power7.S	2012-05-30 14:20:32.457035092 +1000
@@ -0,0 +1,168 @@
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
+ * Copyright (C) IBM Corporation, 2012
+ *
+ * Author: Anton Blanchard <anton@au.ibm.com>
+ */
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+
+#define STACKFRAMESIZE	256
+#define STK_REG(i)	(112 + ((i)-14)*8)
+
+_GLOBAL(copypage_power7)
+	/*
+	 * We prefetch both the source and destination using enhanced touch
+	 * instructions. We use a stream ID of 0 for the load side and
+	 * 1 for the store side. Since source and destination are page
+	 * aligned we don't need to clear the bottom 7 bits of either
+	 * address.
+	 */
+	ori	r9,r3,1		/* stream=1 */
+
+#ifdef CONFIG_PPC_64K_PAGES
+	lis	r7,0x0E01	/* depth=7, units=512 */
+#else
+	lis	r7,0x0E00	/* depth=7 */
+	ori	r7,r7,0x1000	/* units=32 */
+#endif
+	ori	r10,r7,1	/* stream=1 */
+
+	lis	r8,0x8000	/* GO=1 */
+	clrldi	r8,r8,32
+
+.machine push
+.machine "power4"
+	dcbt	r0,r4,0b01000
+	dcbt	r0,r7,0b01010
+	dcbtst	r0,r9,0b01000
+	dcbtst	r0,r10,0b01010
+	eieio
+	dcbt	r0,r8,0b01010	/* GO */
+.machine pop
+
+#ifdef CONFIG_ALTIVEC
+	mflr	r0
+	std	r3,48(r1)
+	std	r4,56(r1)
+	std	r0,16(r1)
+	stdu	r1,-STACKFRAMESIZE(r1)
+	bl	.enter_vmx_copy
+	cmpwi	r3,0
+	ld	r0,STACKFRAMESIZE+16(r1)
+	ld	r3,STACKFRAMESIZE+48(r1)
+	ld	r4,STACKFRAMESIZE+56(r1)
+	mtlr	r0
+
+	li	r0,(PAGE_SIZE/128)
+	mtctr	r0
+
+	beq	.Lnonvmx_copy
+
+	addi	r1,r1,STACKFRAMESIZE
+
+	li	r6,16
+	li	r7,32
+	li	r8,48
+	li	r9,64
+	li	r10,80
+	li	r11,96
+	li	r12,112
+
+	.align	5
+1:	lvx	vr7,r0,r4
+	lvx	vr6,r4,r6
+	lvx	vr5,r4,r7
+	lvx	vr4,r4,r8
+	lvx	vr3,r4,r9
+	lvx	vr2,r4,r10
+	lvx	vr1,r4,r11
+	lvx	vr0,r4,r12
+	addi	r4,r4,128
+	stvx	vr7,r0,r3
+	stvx	vr6,r3,r6
+	stvx	vr5,r3,r7
+	stvx	vr4,r3,r8
+	stvx	vr3,r3,r9
+	stvx	vr2,r3,r10
+	stvx	vr1,r3,r11
+	stvx	vr0,r3,r12
+	addi	r3,r3,128
+	bdnz	1b
+
+	b	.exit_vmx_copy		/* tail call optimise */
+
+#else
+	li	r0,(PAGE_SIZE/128)
+	mtctr	r0
+
+	stdu	r1,-STACKFRAMESIZE(r1)
+#endif
+
+.Lnonvmx_copy:
+	std	r14,STK_REG(r14)(r1)
+	std	r15,STK_REG(r15)(r1)
+	std	r16,STK_REG(r16)(r1)
+	std	r17,STK_REG(r17)(r1)
+	std	r18,STK_REG(r18)(r1)
+	std	r19,STK_REG(r19)(r1)
+	std	r20,STK_REG(r20)(r1)
+
+1:	ld	r0,0(r4)
+	ld	r5,8(r4)
+	ld	r6,16(r4)
+	ld	r7,24(r4)
+	ld	r8,32(r4)
+	ld	r9,40(r4)
+	ld	r10,48(r4)
+	ld	r11,56(r4)
+	ld	r12,64(r4)
+	ld	r14,72(r4)
+	ld	r15,80(r4)
+	ld	r16,88(r4)
+	ld	r17,96(r4)
+	ld	r18,104(r4)
+	ld	r19,112(r4)
+	ld	r20,120(r4)
+	addi	r4,r4,128
+	std	r0,0(r3)
+	std	r5,8(r3)
+	std	r6,16(r3)
+	std	r7,24(r3)
+	std	r8,32(r3)
+	std	r9,40(r3)
+	std	r10,48(r3)
+	std	r11,56(r3)
+	std	r12,64(r3)
+	std	r14,72(r3)
+	std	r15,80(r3)
+	std	r16,88(r3)
+	std	r17,96(r3)
+	std	r18,104(r3)
+	std	r19,112(r3)
+	std	r20,120(r3)
+	addi	r3,r3,128
+	bdnz	1b
+
+	ld	r14,STK_REG(r14)(r1)
+	ld	r15,STK_REG(r15)(r1)
+	ld	r16,STK_REG(r16)(r1)
+	ld	r17,STK_REG(r17)(r1)
+	ld	r18,STK_REG(r18)(r1)
+	ld	r19,STK_REG(r19)(r1)
+	ld	r20,STK_REG(r20)(r1)
+	addi	r1,r1,STACKFRAMESIZE
+	blr
Index: linux-build/arch/powerpc/lib/Makefile
===================================================================
--- linux-build.orig/arch/powerpc/lib/Makefile	2012-05-30 10:53:03.442309322 +1000
+++ linux-build/arch/powerpc/lib/Makefile	2012-05-30 11:07:54.361827650 +1000
@@ -17,7 +17,7 @@ obj-$(CONFIG_HAS_IOMEM)	+= devres.o
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o \
 			   checksum_wrappers_64.o hweight_64.o \
-			   copyuser_power7.o string_64.o
+			   copyuser_power7.o string_64.o copypage_power7.o
 obj-$(CONFIG_XMON)	+= sstep.o ldstfp.o
 obj-$(CONFIG_KPROBES)	+= sstep.o ldstfp.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= sstep.o ldstfp.o
Index: linux-build/arch/powerpc/lib/copypage_64.S
===================================================================
--- linux-build.orig/arch/powerpc/lib/copypage_64.S	2012-05-30 10:53:03.430309112 +1000
+++ linux-build/arch/powerpc/lib/copypage_64.S	2012-05-30 11:07:54.361827650 +1000
@@ -17,7 +17,11 @@ PPC64_CACHES:
         .section        ".text"
 
 _GLOBAL(copy_page)
+BEGIN_FTR_SECTION
 	lis	r5,PAGE_SIZE@h
+FTR_SECTION_ELSE
+	b	.copypage_power7
+ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
 	ori	r5,r5,PAGE_SIZE@l
 BEGIN_FTR_SECTION
 	ld      r10,PPC64_CACHES@toc(r2)
Index: linux-build/arch/powerpc/lib/vmx-helper.c
===================================================================
--- linux-build.orig/arch/powerpc/lib/vmx-helper.c	2012-05-30 10:53:03.454309531 +1000
+++ linux-build/arch/powerpc/lib/vmx-helper.c	2012-05-30 14:20:38.637144276 +1000
@@ -49,3 +49,26 @@ int exit_vmx_usercopy(void)
 	pagefault_enable();
 	return 0;
 }
+
+int enter_vmx_copy(void)
+{
+	if (in_interrupt())
+		return 0;
+
+	preempt_disable();
+
+	enable_kernel_altivec();
+
+	return 1;
+}
+
+/*
+ * All calls to this function will be optimised into tail calls. We are
+ * passed a pointer to the destination which we return as required by a
+ * memcpy implementation.
+ */
+void *exit_vmx_copy(void *dest)
+{
+	preempt_enable();
+	return dest;
+}
