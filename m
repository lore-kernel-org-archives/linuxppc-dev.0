Message-ID: <3AE47B3C.8DF8F330@matrox.com>
Date: Mon, 23 Apr 2001 14:58:04 -0400
From: Alexandre Nikolaev <anikolae@matrox.com>
Reply-To: Alexandre.Nikolaev@matrox.com
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc little-endian port
Content-Type: multipart/mixed;
 boundary="------------A978246CE89A3CEF95E95A4A"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------A978246CE89A3CEF95E95A4A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello everyone!

This is a port of Montavista's 2.4.0-test2 kernel to ppc running in
Little-Endian.
As a base, we used Sandpoint configuration, but disabled some irrelevant
code for our board (these changes are not in the patch).
We made it just for a board with CPU and RAM only, so if you want to use
anything extra (drives, PCI, etc.)
you have to look at the corresponding code and make changes accordingly
(if needed). Additionally, if you use different configuration scheme
(not sandpoint), you might have to do some other changes.

Sebastien Cote: cots01@gel.usherb.ca

Alexandre Nikoalev: anikolae@matrox.com

--
*****************************************
| Alexandre Nikolaev
| Software Designer
| Matrox Electronic Systems Ltd
| Imaging Department
| Tel. (514) 8226000 ext. 2323
| E-mail: Alexandre_Nikolaev@matrox.com
*****************************************:)


--------------A978246CE89A3CEF95E95A4A
Content-Type: text/plain; charset=us-ascii;
 name="linux-ppcle.patch"
Content-Disposition: inline;
 filename="linux-ppcle.patch"
Content-Transfer-Encoding: 7bit

diff -ru /usr/src/redhat/SOURCES/linux/arch/ppc/Makefile ./arch/ppc/Makefile
--- /usr/src/redhat/SOURCES/linux/arch/ppc/Makefile	Mon Jun 19 20:59:35 2000
+++ ./arch/ppc/Makefile	Fri Apr  6 14:03:29 2001
@@ -23,7 +23,7 @@
 CPPFLAGS	:= $(CPPFLAGS) -D__powerpc__
 CFLAGS		:= $(CFLAGS) -D__powerpc__ -fsigned-char \
 		-msoft-float -pipe -ffixed-r2 -Wno-uninitialized \
-		-mmultiple -mstring
+#		-mmultiple -mstring
 CPP		= $(CC) -E $(CFLAGS)

 ifdef CONFIG_4xx
diff -ru /usr/src/redhat/SOURCES/linux/arch/ppc/kernel/hashtable.S ./arch/ppc/kernel/hashtable.S
--- /usr/src/redhat/SOURCES/linux/arch/ppc/kernel/hashtable.S	Mon Jun 19 20:59:36 2000
+++ ./arch/ppc/kernel/hashtable.S	Fri Apr  6 15:05:24 2001
@@ -321,7 +321,7 @@

 	/* Search the primary PTEG for a PTE whose 1st word matches r5 */
 	mtctr	r2
-	addi	r3,r4,-8
+	addi	r3,r4,-4		/* Changed from -8 to -4 by me !!!! */
 1:	lwzu	r0,8(r3)		/* get next PTE */
 	cmp	0,r0,r5
 	bdnzf	2,1b			/* loop while ctr != 0 && !cr0.eq */
@@ -333,7 +333,7 @@
 hash_page_patch_B:
 	xoris	r3,r4,Hash_msk>>16	/* compute secondary hash */
 	xori	r3,r3,0xffc0
-	addi	r3,r3,-8
+	addi	r3,r3,-4		/* Changed from -8 to -4 by me !!!! */
 	mtctr	r2
 2:	lwzu	r0,8(r3)
 	cmp	0,r0,r5
@@ -343,7 +343,8 @@

 	/* Search the primary PTEG for an empty slot */
 10:	mtctr	r2
-	addi	r3,r4,-8		/* search primary PTEG */
+	addi	r3,r4,-4		/* search primary PTEG */
+					/* Changed from -8 to -4 by me !!!! */
 1:	lwzu	r0,8(r3)		/* get next PTE */
 	rlwinm.	r0,r0,0,0,0		/* only want to check valid bit */
 	bdnzf	2,1b			/* loop while ctr != 0 && !cr0.eq */
@@ -355,7 +356,7 @@
 hash_page_patch_C:
 	xoris	r3,r4,Hash_msk>>16	/* compute secondary hash */
 	xori	r3,r3,0xffc0
-	addi	r3,r3,-8
+	addi	r3,r3,-4		/* Changed from -8 to -4 by me !!!! */
 	mtctr	r2
 2:
 	lwzu	r0,8(r3)
@@ -380,6 +381,7 @@
 	andi.	r2,r2,0x38
 	stw	r2,next_slot@l(r3)
 	add	r3,r4,r2
+	addi	r3,r3,4			/* Add 4 to realign data, by me !!!! */
 11:
 	/* update counter of evicted pages */
 	lis	r2,htab_evicts@ha
@@ -393,7 +395,7 @@
 found_empty:
 	stw	r5,0(r3)
 found_slot:
-	stw	r6,4(r3)
+	stw	r6,-4(r3)	/* Changed to -4 to preserve LE by me !!!! */
 	sync

 #else /* CONFIG_SMP */
@@ -543,7 +545,7 @@
 	lwz	r6,Hash_size@l(r6)	/* size in bytes */
 	srwi	r6,r6,3			/* # PTEs */
 	mtctr	r6
-	addi	r5,r5,-8
+	addi	r5,r5,-4		/* Changed from -8 to -4 by me !!!! */
 	li	r0,0
 1:	lwzu	r6,8(r5)		/* get next tag word */
 	cmplw	0,r6,r3
@@ -642,7 +644,7 @@
 	add	r6,r6,r7		/* address of primary PTEG */
 	li	r8,8
 	mtctr	r8
-	addi	r7,r6,-8
+	addi	r7,r6,-4		/* Changed from -8 to -4 by me !!!! */
 1:	lwzu	r0,8(r7)		/* get next PTE */
 	cmpw	0,r0,r3			/* see if tag matches */
 	bdnzf	2,1b			/* while --ctr != 0 && !cr0.eq */
@@ -650,7 +652,7 @@
 	ori	r3,r3,0x40		/* set H (alt. hash) bit */
 	xor	r6,r6,r5		/* address of secondary PTEG */
 	mtctr	r8
-	addi	r7,r6,-8
+	addi	r7,r6,-4		/* Changed from -8 to -4 by me !!!! */
 2:	lwzu	r0,8(r7)		/* get next PTE */
 	cmpw	0,r0,r3			/* see if tag matches */
 	bdnzf	2,2b			/* while --ctr != 0 && !cr0.eq */
diff -ru /usr/src/redhat/SOURCES/linux/arch/ppc/kernel/head.S ./arch/ppc/kernel/head.S
--- /usr/src/redhat/SOURCES/linux/arch/ppc/kernel/head.S	Fri Apr  6 13:56:40 2001
+++ ./arch/ppc/kernel/head.S	Mon Apr 23 09:10:11 2001
@@ -292,11 +299,14 @@
 label:						\
 	EXCEPTION_PROLOG;			\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;	\
-	li	r20,MSR_KERNEL;			\
+	lis	r20,MSR_KERNEL@ha;		\
+	addi	r20,r20,MSR_KERNEL@l;		\
 	bl	transfer_to_handler; 		\
 	.long	hdlr;				\
 	.long	ret_from_except

+	/* Loading of MSR_KERNEL changed by me !!!! */
+
 /* System reset */
 #ifdef CONFIG_SMP /* MVME/MTX and gemini start the secondary here */
 #ifdef CONFIG_GEMINI
@@ -333,7 +343,9 @@
 	mfspr	r4,DAR
 	stw	r4,_DAR(r21)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL*/
+        lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
 	bl	transfer_to_handler
 	.long	do_page_fault
@@ -347,7 +359,9 @@
 	mfspr	r4,DAR
 	stw	r4,_DAR(r21)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL  Replaced by me !!!!*/
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
 	bl	transfer_to_handler
 	.long	UnknownException
@@ -372,7 +386,9 @@
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	mr	r4,r22
 	mr	r5,r23
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL Replaced by me !!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
 	bl	transfer_to_handler
 	.long	do_page_fault
@@ -384,7 +400,9 @@
 	b	InstructionSegment
 InstructionSegmentCont:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL  Replaced by me !!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
 	bl	transfer_to_handler
 	.long	UnknownException
@@ -396,7 +414,9 @@
 HardwareInterrupt:
 	EXCEPTION_PROLOG;
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL	Replaced by me !!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 #ifndef CONFIG_APUS
 	li	r4,0
 	bl	transfer_to_handler
@@ -417,7 +437,9 @@
 	mfspr	r5,DSISR
 	stw	r5,_DSISR(r21)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL	Replaced by me !!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
 	bl	transfer_to_handler
 	.long	AlignmentException
@@ -428,7 +450,9 @@
 ProgramCheck:
 	EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL	Replaced by me !!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
 	bl	transfer_to_handler
 	.long	ProgramCheckException
@@ -438,8 +462,17 @@
 	. = 0x800
 FPUnavailable:
 	EXCEPTION_PROLOG
 	bne	load_up_fpu		/* if from user, just load it up */
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL	Replaced by me !!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	bl	transfer_to_handler	/* if from kernel, take a trap */
 	.long	KernelFP
 	.long	ret_from_except
@@ -448,7 +481,9 @@
 Decrementer:
 	EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL	Replaced by me !!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	bl	transfer_to_handler
 	.globl timer_interrupt_intercept
 timer_interrupt_intercept:
@@ -463,7 +498,9 @@
 SystemCall:
 	EXCEPTION_PROLOG
 	stw	r3,ORIG_GPR3(r21)
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL	Replaced by me !!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	rlwimi	r20,r23,0,16,16		/* copy EE bit from saved MSR */
 	bl	transfer_to_handler
 	.long	DoSyscall
@@ -484,7 +521,9 @@
 	b	Trap_0f
 trap_0f_cont:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL	Replaced by me !!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	bl	transfer_to_handler
 	.long	UnknownException
 	.long	ret_from_except
@@ -706,8 +745,17 @@
 #ifdef CONFIG_ALTIVEC
 AltiVecUnavailable:
 	EXCEPTION_PROLOG
 	bne	load_up_altivec		/* if from user, just load it up */
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL	Replaced by me !!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	bl	transfer_to_handler	/* if from kernel, take a trap */
 	.long	KernelAltiVec
 	.long	ret_from_except
@@ -785,7 +839,9 @@
 	addi	r1,r1,TASK_UNION_SIZE-STACK_FRAME_OVERHEAD
 	lis	r24,StackOverflow@ha
 	addi	r24,r24,StackOverflow@l
-	li	r20,MSR_KERNEL
+	/*li	r20,MSR_KERNEL Replaced by me !!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	FIX_SRR1(r20,r22)
 	mtspr	SRR0,r24
 	mtspr	SRR1,r20
@@ -1213,7 +1269,9 @@
 	stw	r3,(_CCR+4)(r21);

 	addi	r3,r1,STACK_FRAME_OVERHEAD;
-	li	r20,MSR_KERNEL;
+	/*li	r20,MSR_KERNEL;	Replaced by me !!!!! */
+	lis	r20,MSR_KERNEL@ha
+	addi	r20,r20,MSR_KERNEL@l
 	bl	transfer_to_handler;
 	.long	do_IRQ;
 	.long	ret_from_except
@@ -1288,7 +1346,9 @@
 	mtspr	SPRG2,r3	/* 0 => r1 has kernel sp */

 	/* enable MMU and jump to start_secondary */
-	li	r4,MSR_KERNEL
+	/*li	r4,MSR_KERNEL	Replaced by me !!!! */
+	lis	r4,MSR_KERNEL@ha
+	addi	r4,r4,MSR_KERNEL@l
 	lis	r3,start_secondary@h
 	ori	r3,r3,start_secondary@l
 	mtspr	SRR0,r3
@@ -1452,7 +1516,9 @@
 	lis	r4,2f@h
 	ori	r4,r4,2f@l
 	tophys(r4,r4)
-	li	r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)
+	/*li	r3,MSR_KERNEL & ~(MSR_IR|MSR_DR)    Replaced by me !!!! */
+	lis	r3,(MSR_KERNEL & ~(MSR_IR|MSR_DR))@ha
+	addi	r3,r3,(MSR_KERNEL & ~(MSR_IR|MSR_DR))@l
 	FIX_SRR1(r3,r5)
 	mtspr	SRR0,r4
 	mtspr	SRR1,r3
@@ -1470,7 +1536,10 @@

 	bl	load_up_mmu
 /* Now turn on the MMU for real! */
-	li	r4,MSR_KERNEL
+	/*li	r4,MSR_KERNEL Replaced by me !!!! */
+	lis	r4,MSR_KERNEL@ha
+	addi	r4,r4,MSR_KERNEL@l
+
 	FIX_SRR1(r4,r5)
 	lis	r3,start_kernel@h
 	ori	r3,r3,start_kernel@l
diff -ru /usr/src/redhat/SOURCES/linux/arch/ppc/kernel/irq.c ./arch/ppc/kernel/irq.c
--- /usr/src/redhat/SOURCES/linux/arch/ppc/kernel/irq.c	Mon Jun 19 20:59:36 2000
+++ ./arch/ppc/kernel/irq.c	Fri Apr  6 15:29:33 2001
@@ -349,7 +349,8 @@
 	else
 		once++;

-	ppc_md.init_IRQ();
+	if (ppc_md.init_IRQ)       /* Added by me !!!! */
+	        ppc_md.init_IRQ();
 }

 #ifdef CONFIG_SMP
Only in /usr/src/redhat/SOURCES/linux/arch/ppc/mbxboot: vmlinux.lds
Only in /usr/src/redhat/SOURCES/linux/drivers/pcmcia: Config.in.orig
diff -ru /usr/src/redhat/SOURCES/linux/include/asm-ppc/bitops.h ./include/asm-ppc/bitops.h
--- /usr/src/redhat/SOURCES/linux/include/asm-ppc/bitops.h	Mon Jun 19 20:59:37 2000
+++ ./include/asm-ppc/bitops.h	Wed Apr 11 13:50:25 2001
@@ -242,8 +242,12 @@
  * test_and_{set,clear}_bit guarantee atomicity without
  * disabling interrupts.
  */
+#if 0
 #define ext2_set_bit(nr, addr)		test_and_set_bit((nr) ^ 0x18, addr)
 #define ext2_clear_bit(nr, addr)	test_and_clear_bit((nr) ^ 0x18, addr)
+#endif /* Replaced by me !!!! (to remove XOR) */
+#define ext2_set_bit(nr, addr)		test_and_set_bit((nr), addr)
+#define ext2_clear_bit(nr, addr)	test_and_clear_bit((nr), addr)

 #else
 extern __inline__ int ext2_set_bit(int nr, void * addr)
diff -ru /usr/src/redhat/SOURCES/linux/include/asm-ppc/byteorder.h ./include/asm-ppc/byteorder.h
--- /usr/src/redhat/SOURCES/linux/include/asm-ppc/byteorder.h	Mon Jun 19 20:59:37 2000
+++ ./include/asm-ppc/byteorder.h	Fri Apr  6 14:34:22 2001
@@ -9,7 +9,7 @@

 #ifdef __GNUC__

-extern __inline__ unsigned ld_le16(const volatile unsigned short *addr)
+extern __inline__ unsigned ld_be16(const volatile unsigned short *addr)
 {
 	unsigned val;

@@ -17,12 +17,12 @@
 	return val;
 }

-extern __inline__ void st_le16(volatile unsigned short *addr, const unsigned val)
+extern __inline__ void st_be16(volatile unsigned short *addr, const unsigned val)
 {
 	__asm__ __volatile__ ("sthbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
 }

-extern __inline__ unsigned ld_le32(const volatile unsigned *addr)
+extern __inline__ unsigned ld_be32(const volatile unsigned *addr)
 {
 	unsigned val;

@@ -30,7 +30,7 @@
 	return val;
 }

-extern __inline__ void st_le32(volatile unsigned *addr, const unsigned val)
+extern __inline__ void st_be32(volatile unsigned *addr, const unsigned val)
 {
 	__asm__ __volatile__ ("stwbrx %1,0,%2" : "=m" (*addr) : "r" (val), "r" (addr));
 }
@@ -71,18 +71,21 @@
 #endif

 /* The same, but returns converted value from the location pointer by addr. */
-#define __arch__swab16p(addr) ld_le16(addr)
-#define __arch__swab32p(addr) ld_le32(addr)
+#define __arch__swab16p(addr) ld_be16(addr)
+#define __arch__swab32p(addr) ld_be32(addr)

 /* The same, but do the conversion in situ, ie. put the value back to addr. */
-#define __arch__swab16s(addr) st_le16(addr,*addr)
-#define __arch__swab32s(addr) st_le32(addr,*addr)
+#define __arch__swab16s(addr) st_be16(addr,*addr)
+#define __arch__swab32s(addr) st_be32(addr,*addr)

 #endif /* __GNUC__ */

+/* All "le" changed to "be", and vice-versa, by me !!!! */
+
 #if defined(__GNUC__) && !defined(__STRICT_ANSI__)
 #define __BYTEORDER_HAS_U64__
 #endif
-#include <linux/byteorder/big_endian.h>
+#include <linux/byteorder/little_endian.h>
+/* Changed from big_endian to little_endian by me !!!! */

 #endif /* _PPC_BYTEORDER_H */
diff -ru /usr/src/redhat/SOURCES/linux/include/asm-ppc/io.h ./include/asm-ppc/io.h
--- /usr/src/redhat/SOURCES/linux/include/asm-ppc/io.h	Mon Jun 19 20:59:37 2000
+++ ./include/asm-ppc/io.h	Wed Apr 11 13:50:26 2001
@@ -231,7 +231,7 @@
 	__asm__ __volatile__("stb%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
 }

-extern inline int in_le16(volatile unsigned short *addr)
+extern inline int in_be16(volatile unsigned short *addr)
 {
 	int ret;

@@ -240,7 +240,7 @@
 	return ret;
 }

-extern inline int in_be16(volatile unsigned short *addr)
+extern inline int in_le16(volatile unsigned short *addr)
 {
 	int ret;

@@ -248,18 +248,18 @@
 	return ret;
 }

-extern inline void out_le16(volatile unsigned short *addr, int val)
+extern inline void out_be16(volatile unsigned short *addr, int val)
 {
 	__asm__ __volatile__("sthbrx %1,0,%2; eieio" : "=m" (*addr) :
 			      "r" (val), "r" (addr));
 }

-extern inline void out_be16(volatile unsigned short *addr, int val)
+extern inline void out_le16(volatile unsigned short *addr, int val)
 {
 	__asm__ __volatile__("sth%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
 }

-extern inline unsigned in_le32(volatile unsigned *addr)
+extern inline unsigned in_be32(volatile unsigned *addr)
 {
 	unsigned ret;

@@ -268,7 +268,7 @@
 	return ret;
 }

-extern inline unsigned in_be32(volatile unsigned *addr)
+extern inline unsigned in_le32(volatile unsigned *addr)
 {
 	unsigned ret;

@@ -276,13 +276,13 @@
 	return ret;
 }

-extern inline void out_le32(volatile unsigned *addr, int val)
+extern inline void out_be32(volatile unsigned *addr, int val)
 {
 	__asm__ __volatile__("stwbrx %1,0,%2; eieio" : "=m" (*addr) :
 			     "r" (val), "r" (addr));
 }

-extern inline void out_be32(volatile unsigned *addr, int val)
+extern inline void out_le32(volatile unsigned *addr, int val)
 {
 	__asm__ __volatile__("stw%U0%X0 %1,%0; eieio" : "=m" (*addr) : "r" (val));
 }
diff -ru /usr/src/redhat/SOURCES/linux/include/asm-ppc/processor.h ./include/asm-ppc/processor.h
--- /usr/src/redhat/SOURCES/linux/include/asm-ppc/processor.h	Fri Apr  6 13:56:37 2001
+++ ./include/asm-ppc/processor.h	Wed Apr 11 13:50:25 2001
@@ -45,7 +45,8 @@
 #ifdef CONFIG_APUS_FAST_EXCEPT
 #define MSR_		MSR_ME|MSR_IP|MSR_RI
 #else
-#define MSR_		MSR_ME|MSR_RI
+#define MSR_		MSR_ME|MSR_RI|MSR_LE|MSR_ILE
+/* MSD_LE and MSR_ILE added by me !!!! */
 #endif
 #define MSR_KERNEL      MSR_|MSR_IR|MSR_DR
 #define MSR_USER	MSR_KERNEL|MSR_PR|MSR_EE

--------------A978246CE89A3CEF95E95A4A--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
