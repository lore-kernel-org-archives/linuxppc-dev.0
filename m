Date: Fri, 31 Aug 2001 12:11:59 -0500 (CDT)
Message-Id: <200108311711.f7VHBxS14716@pacific.somerset.sps.mot.com>
From: Edward Swarthout <swarthou@ibmoto.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Assorted patches - number one
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I broke up my proposed set of patches into pieces.
The first is straight forward and should not be controversial.
Only #4 touches non-ppc specific files.

1. Add additional 7450 machine check decodes to traps.c

2. Add additional SPRs for 7450 to processor.h

3. Add debug information to the assembler files for gdb's use.
   This is useful when using kgdb or gdb on /proc/kcore.
   a. define some stab codes in ppc_asm.tmpl
   b. add stabs function statement to _GLOBAL() in processor.h
   c. add stabs filename strings to head.S, entry.S, and string.S
   d. change bare function .globl's to _GLOBAL in string.S

4. Include _GLOBAL functions in the tags index in ./Makefile

Ed.Swarthout@motorola.com

diff -rPu /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/kernel/traps.c linuxppc_2_4_devel_mot/arch/ppc/kernel/traps.c
--- /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/kernel/traps.c	Thu Aug 30 17:39:35 2001
+++ linuxppc_2_4_devel_mot/arch/ppc/kernel/traps.c	Thu Aug 30 18:08:43 2001
@@ -153,11 +153,12 @@
 #endif /* CONFIG_ALL_PPC */
 	printk("Machine check in kernel mode.\n");
 	printk("Caused by (from SRR1=%lx): ", regs->msr);
-	switch (regs->msr & 0xF0000) {
+	switch( regs->msr & 0x601F0000) {
 	case 0x80000:
 		printk("Machine check signal\n");
 		break;
 	case 0x40000:
+	case 0x140000: /* 7450 MSS error and TEA */
 		printk("Transfer error ack signal\n");
 		break;
 	case 0x20000:
@@ -166,6 +167,15 @@
 	case 0x10000:
 		printk("Address parity error signal\n");
 		break;
+	case 0x20000000:
+		printk("L1 Data Cache error\n");
+		break;
+	case 0x40000000:
+		printk("L1 Instruction Cache error\n");
+		break;
+	case 0x00100000:
+		printk("L2 data cache parity error\n");
+		break;
 	default:
 		printk("Unknown values in msr\n");
 	}
diff -rPu /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/kernel/ppc_asm.tmpl linuxppc_2_4_devel_mot/arch/ppc/kernel/ppc_asm.tmpl
--- /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/kernel/ppc_asm.tmpl	Thu Aug 30 17:39:26 2001
+++ linuxppc_2_4_devel_mot/arch/ppc/kernel/ppc_asm.tmpl	Fri Aug 31 10:29:50 2001
@@ -113,3 +113,9 @@
 #define	vr29	29
 #define	vr30	30
 #define	vr31	31
+
+/* some stab codes */
+#define N_FUN 36
+#define N_RSYM 64
+#define N_SLINE 68
+#define N_SO 100
diff -rPu /usr/src/mirror/linuxppc_2_4_devel_10pre2/include/asm-ppc/processor.h linuxppc_2_4_devel_mot/include/asm-ppc/processor.h
--- /usr/src/mirror/linuxppc_2_4_devel_10pre2/include/asm-ppc/processor.h	Thu Aug 30 17:39:01 2001
+++ linuxppc_2_4_devel_mot/include/asm-ppc/processor.h	Thu Aug 30 18:08:44 2001
@@ -243,6 +243,10 @@
 #define	  HID0_NOPTI	(1<<0)		/* No-op dcbt and dcbst instr. */

 #define	SPRN_HID1	0x3F1	/* Hardware Implementation Register 1 */
+#define	  HID1_EMCP   	(1<<31)		/* 7450 Machine Check Pin Enable */
+#define	  HID1_SYNCBE 	(1<<11)		/* 7450 ABE for sync, eieio */
+#define	  HID1_ABE 	(1<<10)		/* 7450 Address Broadcast Enable */
+#define	SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */
 #define	SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */
 #define	SPRN_IAC1	0x3F4	/* Instruction Address Compare 1 */
 #define	SPRN_IAC2	0x3F5	/* Instruction Address Compare 2 */
@@ -291,7 +295,20 @@
 #define L2CR_L2SL		0x00008000	/* L2 DLL slow */
 #define L2CR_L2DF		0x00004000	/* L2 differential clock */
 #define L2CR_L2BYP		0x00002000	/* L2 DLL bypass */
+#define L2CR_L2HWF		0x00000800	/* Hardware Flush */
+#define L2CR_L2IO		0x00000400	/* Instruction Only */
 #define L2CR_L2IP		0x00000001	/* L2 GI in progress */
+#define	SPRN_L3CR	0x3FA	/* 1018 Level 3 Cache Control Register on 7450 */
+#define L3CR_L3E		0x80000000	/* Enable */
+#define L3CR_L3PE		0x40000000	/* Parity Enable */
+#define L3CR_L3CLKEN		0x08000000	/* Clock enable  */
+#define L3CR_L3IO		0x00200000	/* Instruction Only */
+#define L3CR_L3DO		0x00000020	/* Data Only */
+#define L3CR_L3HWF		0x00000800	/* Hardware Flush */
+#define L3CR_L3I		0x00000400	/* global invalidate */
+#define L3CR_L3RT		0x00000100	/* SRAM type DDR=0, LW=1 */
+#define L3CR_L3DMEM		0x00000004	/* Direct Map enable */
+#define	SPRN_L3PROCDET	0x3D8	/* 984 Level 3 Cache Process Detect Register on 7450 */
 #define	SPRN_LR		0x008	/* Link Register */
 #define	SPRN_MMCR0	0x3B8	/* Monitor Mode Control Register 0 */
 #define	SPRN_MMCR1	0x3BC	/* Monitor Mode Control Register 1 */
@@ -326,6 +343,10 @@
 #define	SPRN_SRR1	0x01B	/* Save/Restore Register 1 */
 #define	SPRN_SRR2	0x3DE	/* Save/Restore Register 2 */
 #define	SPRN_SRR3 	0x3DF	/* Save/Restore Register 3 */
+#define	SPRN_TBHI	0x3DC	/* Time Base High */
+#define	SPRN_TBHU	0x3CC	/* Time Base High User-mode */
+#define	SPRN_TBLO	0x3DD	/* Time Base Low */
+#define	SPRN_TBLU	0x3CD	/* Time Base Low User-mode */
 #define	SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
 #define	SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
 #define	SPRN_TBWL	0x11C	/* Time Base Lower Register (supervisor, R/W) */
@@ -385,6 +406,14 @@
 #define SPRN_VRSAVE	0x100	/* Vector Register Save Register */
 #define	SPRN_XER	0x001	/* Fixed Point Exception Register */
 #define	SPRN_ZPR	0x3B0	/* Zone Protection Register */
+#define	SPRN_TLBMISS	0x3D4	/* 980 7450 TLB Miss Register */
+#define	SPRN_PTEHI	0x3D5	/* 981 7450 PTEHI */
+#define	SPRN_PTELO	0x3D6	/* 982 7450 PTELO */
+#define	SPRN_ICTRL 	0x3F3	/* 1011 7450 ICTRL */
+#define   ICTRL_EICE         (0x08000000)   /* EICE */
+#define   ICTRL_EDCE         (0x04000000)   /* EIDE */
+#define   ICTRL_EICP         (0x00000100)   /* EICP */
+#define	SPRN_LDSTDB	0x3F4	/* 1012 7450 LDSTDB */

 /* Short-hand versions for a number of the above SPRNs */

@@ -421,6 +450,7 @@
 #define	IMISS	SPRN_IMISS	/* Instruction TLB Miss Register */
 #define	IMMR	SPRN_IMMR      	/* PPC 860/821 Internal Memory Map Register */
 #define	L2CR	SPRN_L2CR    	/* PPC 750 L2 control register */
+#define	L3CR	SPRN_L3CR    	/* PPC 7450 L3 Cache control register */
 #define	LR	SPRN_LR
 #define	PVR	SPRN_PVR	/* Processor Version */
 #define	RPA	SPRN_RPA	/* Required Physical Address Register */
@@ -496,6 +526,7 @@
 #define	PVR_750P	PVR_740P
 #define	PVR_7400	0x000C0000
 #define	PVR_7410	0x800C0000
+#define	PVR_7450	0x80000000
 /*
  * For the 8xx processors, all of them report the same PVR family for
  * the PowerPC core. The various versions of these processors must be
@@ -507,7 +538,7 @@
 #define	PVR_850		PVR_821
 #define	PVR_860		PVR_821
 #define	PVR_8240	0x00810100
-#define	PVR_8245	0x80810100
+#define	PVR_8245	0x80811014
 #define	PVR_8260	PVR_8240

 /* We only need to define a new _MACH_xxx for machines which are part of
@@ -528,7 +559,9 @@
 #define _CHRP_Motorola 0x04  /* motorola chrp, the cobra */
 #define _CHRP_IBM      0x05  /* IBM chrp, the longtrail and longtrail 2 */

+#define __stringify(a) #a
 #define _GLOBAL(n)\
+        .stabs __stringify(n:F-1),N_FUN,0,0,n;\
 	.globl n;\
 n:

diff -rPu /usr/src/mirror/linuxppc_2_4_devel_10pre2/Makefile linuxppc_2_4_devel_mot/Makefile
--- /usr/src/mirror/linuxppc_2_4_devel_10pre2/Makefile	Thu Aug 30 17:39:58 2001
+++ linuxppc_2_4_devel_mot/Makefile	Thu Aug 30 18:08:43 2001
@@ -333,6 +333,7 @@

 TAGS: dummy
 	etags `find include/asm-$(ARCH) -name '*.h'`
+	etags --regex='/_GLOBAL(\(.*\))/' `find arch/$(ARCH) -name '*.S'` -a
 	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name '*.h' -print | xargs etags -a
 	find $(SUBDIRS) init -name '*.[ch]' | xargs etags -a

diff -rPu /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/kernel/entry.S linuxppc_2_4_devel_mot/arch/ppc/kernel/entry.S
--- /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/kernel/entry.S	Thu Aug 30 17:39:18 2001
+++ linuxppc_2_4_devel_mot/arch/ppc/kernel/entry.S	Thu Aug 30 18:08:43 2001
@@ -46,6 +46,10 @@
  * Handle a system call.
  */
 	.text
+	.stabs	"arch/ppc/kernel/",N_SO,0,0,0f
+	.stabs	"entry.S",N_SO,0,0,0f
+0:
+
 _GLOBAL(DoSyscall)
 	stw	r0,THREAD+LAST_SYSCALL(r2)
 	lwz	r11,_CCR(r1)	/* Clear SO bit in CR */
@@ -392,8 +396,7 @@
  * On CHRP, the Run-Time Abstraction Services (RTAS) have to be
  * called with the MMU off.
  */
-	.globl	enter_rtas
-enter_rtas:
+_GLOBAL(enter_rtas)
 	mflr	r0
 	stw	r0,20(r1)
 	lis	r4,rtas_data@ha
diff -rPu /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/kernel/head.S linuxppc_2_4_devel_mot/arch/ppc/kernel/head.S
--- /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/kernel/head.S	Thu Aug 30 17:39:26 2001
+++ linuxppc_2_4_devel_mot/arch/ppc/kernel/head.S	Thu Aug 30 17:44:39 2001
@@ -70,6 +70,9 @@
 #endif /* CONFIG_PPC64BRIDGE */

 	.text
+	.stabs	"arch/ppc/kernel/",N_SO,0,0,0f
+	.stabs	"head.S",N_SO,0,0,0f
+0:
 	.globl	_stext
 _stext:

diff -rPu /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/kernel/mpc10x.h linuxppc_2_4_devel_mot/arch/ppc/kernel/mpc10x.h
--- /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/kernel/mpc10x.h	Thu Aug 30 17:39:15 2001
+++ linuxppc_2_4_devel_mot/arch/ppc/kernel/mpc10x.h	Wed Aug 22 18:12:12 2001
@@ -139,8 +139,14 @@
 #define MPC10X_EUMB_ATU_SIZE		0x00001000 /* Addr xlate reg size  */
 #define MPC10X_EUMB_I2C_OFFSET		0x00003000 /* I2C Unit reg offset */
 #define MPC10X_EUMB_I2C_SIZE		0x00001000 /* I2C Unit reg size  */
+#define MPC10X_EUMB_DUART_OFFSET	0x00004000 /* DUART Unit reg offset (8245) */
+#define MPC10X_EUMB_DUART_SIZE		0x00001000 /* DUART Unit reg size (8245) */
 #define	MPC10X_EUMB_EPIC_OFFSET		0x00040000 /* EPIC offset in EUMB */
 #define	MPC10X_EUMB_EPIC_SIZE		0x00030000 /* EPIC size */
+#define MPC10X_EUMB_PM_OFFSET		0x000fe000 /* Performance Monitor reg offset (8245) */
+#define MPC10X_EUMB_PM_SIZE		0x00001000 /* Performance Monitor reg size (8245) */
+#define MPC10X_EUMB_WP_OFFSET		0x000ff000 /* Data path diagnostic, watchpoint reg offset */
+#define MPC10X_EUMB_WP_SIZE		0x00001000 /* Data path diagnostic, watchpoint reg size */

 /*
  * Define some recommended places to put the EUMB regs.

diff -rPu /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/lib/string.S linuxppc_2_4_devel_mot/arch/ppc/lib/string.S
--- /usr/src/mirror/linuxppc_2_4_devel_10pre2/arch/ppc/lib/string.S	Thu Aug 30 17:39:21 2001
+++ linuxppc_2_4_devel_mot/arch/ppc/lib/string.S	Thu Aug 30 17:31:28 2001
@@ -63,13 +63,16 @@
 	.long	8 ## n ## 6b,9 ## n ## 1b;	\
 	.long	8 ## n ## 7b,9 ## n ## 1b;	\
 .text
+	.text
+	.stabs	"arch/ppc/lib/",N_SO,0,0,0f
+	.stabs	"string.S",N_SO,0,0,0f
+0:

 CACHELINE_BYTES = L1_CACHE_LINE_SIZE
 LG_CACHELINE_BYTES = LG_L1_CACHE_LINE_SIZE
 CACHELINE_MASK = (L1_CACHE_LINE_SIZE-1)

-	.globl	strcpy
-strcpy:
+_GLOBAL(strcpy)
 	addi	r5,r3,-1
 	addi	r4,r4,-1
 1:	lbzu	r0,1(r4)
@@ -77,9 +80,8 @@
 	stbu	r0,1(r5)
 	bne	1b
 	blr
-
-	.globl	strncpy
-strncpy:
+
+_GLOBAL(strncpy)
 	cmpwi	0,r5,0
 	beqlr
 	mtctr	r5
@@ -91,8 +93,7 @@
 	bdnzf	2,1b		/* dec ctr, branch if ctr != 0 && !cr0.eq */
 	blr

-	.globl	strcat
-strcat:
+_GLOBAL(strcat)
 	addi	r5,r3,-1
 	addi	r4,r4,-1
 1:	lbzu	r0,1(r5)
@@ -105,8 +106,7 @@
 	bne	1b
 	blr

-	.globl	strcmp
-strcmp:
+_GLOBAL(strcmp)
 	addi	r5,r3,-1
 	addi	r4,r4,-1
 1:	lbzu	r3,1(r5)
@@ -117,8 +117,7 @@
 	beq	1b
 	blr

-	.globl	strlen
-strlen:
+_GLOBAL(strlen)
 	addi	r4,r3,-1
 1:	lbzu	r0,1(r4)
 	cmpwi	0,r0,0
@@ -131,8 +130,7 @@
  * to set them to zero.  This requires that the destination
  * area is cacheable.  -- paulus
  */
-	.globl	cacheable_memzero
-cacheable_memzero:
+_GLOBAL(cacheable_memzero)
 	mr	r5,r4
 	li	r4,0
 	addi	r6,r3,-4
@@ -182,8 +180,7 @@
 	bdnz	8b
 	blr

-	.globl	memset
-memset:
+_GLOBAL(memset)
 	rlwimi	r4,r4,8,16,23
 	rlwimi	r4,r4,16,0,15
 	addi	r6,r3,-4
@@ -208,8 +205,7 @@
 	bdnz	8b
 	blr

-	.globl	bcopy
-bcopy:
+_GLOBAL(bcopy)
 	mr	r6,r3
 	mr	r3,r4
 	mr	r4,r6
@@ -222,8 +218,7 @@
  * We only use this version if the source and dest don't overlap.
  * -- paulus.
  */
-	.global	cacheable_memcpy
-cacheable_memcpy:
+_GLOBAL(cacheable_memcpy)
 	add	r7,r3,r5		/* test if the src & dst overlap */
 	add	r8,r4,r5
 	cmplw	0,r4,r7
@@ -297,14 +292,12 @@
 	bdnz	40b
 65:	blr

-	.globl	memmove
-memmove:
+_GLOBAL(memmove)
 	cmplw	0,r3,r4
 	bgt	backwards_memcpy
 	/* fall through */

-	.globl	memcpy
-memcpy:
+_GLOBAL(memcpy)
 	srwi.	r7,r5,3
 	addi	r6,r3,-4
 	addi	r4,r4,-4
@@ -345,8 +338,7 @@
 	mtctr	r7
 	b	1b

-	.globl	backwards_memcpy
-backwards_memcpy:
+_GLOBAL(backwards_memcpy)
 	rlwinm.	r7,r5,32-3,3,31		/* r0 = r5 >> 3 */
 	add	r6,r3,r5
 	add	r4,r4,r5
@@ -382,8 +374,7 @@
 	mtctr	r7
 	b	1b

-	.globl	memcmp
-memcmp:
+_GLOBAL(memcmp)
 	cmpwi	0,r5,0
 	ble-	2f
 	mtctr	r5
@@ -397,8 +388,7 @@
 2:	li	r3,0
 	blr

-	.global	memchr
-memchr:
+_GLOBAL(memchr)
 	cmpwi	0,r5,0
 	ble-	2f
 	mtctr	r5
@@ -410,8 +400,7 @@
 2:	li	r3,0
 	blr

-	.globl	__copy_tofrom_user
-__copy_tofrom_user:
+_GLOBAL(__copy_tofrom_user)
 	addi	r4,r4,-4
 	addi	r6,r3,-4
 	neg	r0,r3
@@ -604,8 +593,7 @@
 	.long	114b,120b
 	.text

-	.globl	__clear_user
-__clear_user:
+_GLOBAL(__clear_user)
 	addi	r6,r3,-4
 	li	r3,0
 	li	r5,0
@@ -642,8 +630,7 @@
 	.long	8b,99b
 	.text

-	.globl	__strncpy_from_user
-__strncpy_from_user:
+_GLOBAL(__strncpy_from_user)
 	addi	r6,r3,-1
 	addi	r4,r4,-1
 	cmpwi	0,r5,0
@@ -666,8 +653,7 @@
 	.text

 /* r3 = str, r4 = len (> 0), r5 = top (highest addr) */
-	.globl	__strnlen_user
-__strnlen_user:
+_GLOBAL(__strnlen_user)
 	addi	r7,r3,-1
 	subf	r6,r7,r5	/* top+1 - str */
 	cmplw	0,r4,r6


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
