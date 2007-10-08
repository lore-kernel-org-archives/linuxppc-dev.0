Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0299CDDFDF
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 03:51:41 +1000 (EST)
Date: Mon, 8 Oct 2007 12:48:24 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] Move TASK_SIZE to 0xc0000000 for ppc32
Message-ID: <Pine.LNX.4.64.0710081242280.10079@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, Pantelis Antoniou <panto@intracom.gr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guys,

Here's a cut at a patch that cleans up the TASK_SIZE issue.  We now have
TASK_SIZE @ 0xc0000000 for everything except PREP and use PAGE_OFFSET in
SW TLB handlers.  I'm assuming 8xx will get a cleanup patch from
PAGE_OFFSET testing (Dan :).

Also, note that change in head_32.S for 603.  I made the test match with
what we don on 4xx/fsl-booke.  (Haven't tested this on a system yet).

I'll probably break this up into two patches if we all like this any
possible issues in the future are decoupled.

- k

---

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3180457..70e1f89 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -599,7 +599,8 @@ config TASK_SIZE_BOOL

 config TASK_SIZE
 	hex "Size of user task space" if TASK_SIZE_BOOL
-	default "0x80000000"
+	default "0x80000000" if PPC_PREP
+	default "0xc0000000"

 config CONSISTENT_START_BOOL
 	bool "Set custom consistent memory pool address"
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index d83f04e..a5b13ae 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -469,12 +469,12 @@ InstructionTLBMiss:
 	mfctr	r0
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_IMISS
-	lis	r1,KERNELBASE@h		/* check if kernel address */
-	cmplw	0,r3,r1
+	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
+	cmplw	0,r1,r3
 	mfspr	r2,SPRN_SPRG3
 	li	r1,_PAGE_USER|_PAGE_PRESENT /* low addresses tested as user */
 	lwz	r2,PGDIR(r2)
-	blt+	112f
+	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
 	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
@@ -543,12 +543,12 @@ DataLoadTLBMiss:
 	mfctr	r0
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_DMISS
-	lis	r1,KERNELBASE@h		/* check if kernel address */
-	cmplw	0,r3,r1
+	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
+	cmplw	0,r1,r3
 	mfspr	r2,SPRN_SPRG3
 	li	r1,_PAGE_USER|_PAGE_PRESENT /* low addresses tested as user */
 	lwz	r2,PGDIR(r2)
-	blt+	112f
+	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
 	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
@@ -615,12 +615,12 @@ DataStoreTLBMiss:
 	mfctr	r0
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_DMISS
-	lis	r1,KERNELBASE@h		/* check if kernel address */
-	cmplw	0,r3,r1
+	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
+	cmplw	0,r1,r3
 	mfspr	r2,SPRN_SPRG3
 	li	r1,_PAGE_RW|_PAGE_USER|_PAGE_PRESENT /* access flags */
 	lwz	r2,PGDIR(r2)
-	blt+	112f
+	bge-	112f
 	mfspr	r2,SPRN_SRR1		/* and MSR_PR bit from SRR1 */
 	rlwimi	r1,r2,32-12,29,29	/* shift MSR_PR to _PAGE_USER posn */
 	lis	r2,swapper_pg_dir@ha	/* if kernel address, use */
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index e312824..cfefc2d 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -289,7 +289,7 @@ label:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	lis	r11, TASK_SIZE@h
+	lis	r11, PAGE_OFFSET@h
 	cmplw	r10, r11
 	blt+	3f
 	lis	r11, swapper_pg_dir@h
@@ -481,7 +481,7 @@ label:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	lis	r11, TASK_SIZE@h
+	lis	r11, PAGE_OFFSET@h
 	cmplw	r10, r11
 	blt+	3f
 	lis	r11, swapper_pg_dir@h
@@ -581,7 +581,7 @@ label:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	lis	r11, TASK_SIZE@h
+	lis	r11, PAGE_OFFSET@h
 	cmplw	r10, r11
 	blt+	3f
 	lis	r11, swapper_pg_dir@h
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 864d63f..409db61 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -319,7 +319,7 @@ interrupt_base:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	lis	r11, TASK_SIZE@h
+	lis	r11, PAGE_OFFSET@h
 	cmplw	r10, r11
 	blt+	3f
 	lis	r11, swapper_pg_dir@h
@@ -458,7 +458,7 @@ interrupt_base:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	lis	r11, TASK_SIZE@h
+	lis	r11, PAGE_OFFSET@h
 	cmplw	r10, r11
 	blt+	3f
 	lis	r11, swapper_pg_dir@h
@@ -528,7 +528,7 @@ interrupt_base:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	lis	r11, TASK_SIZE@h
+	lis	r11, PAGE_OFFSET@h
 	cmplw	r10, r11
 	blt+	3f
 	lis	r11, swapper_pg_dir@h
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index ee33ddd..4b98227 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -461,8 +461,7 @@ interrupt_base:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	lis	r11, TASK_SIZE@h
-	ori	r11, r11, TASK_SIZE@l
+	lis	r11, PAGE_OFFSET@h
 	cmplw	0, r10, r11
 	bge	2f

@@ -584,8 +583,7 @@ interrupt_base:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	lis	r11, TASK_SIZE@h
-	ori	r11, r11, TASK_SIZE@l
+	lis	r11, PAGE_OFFSET@h
 	cmplw	5, r10, r11
 	blt	5, 3f
 	lis	r11, swapper_pg_dir@h
@@ -645,8 +643,7 @@ interrupt_base:
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
-	lis	r11, TASK_SIZE@h
-	ori	r11, r11, TASK_SIZE@l
+	lis	r11, PAGE_OFFSET@h
 	cmplw	5, r10, r11
 	blt	5, 3f
 	lis	r11, swapper_pg_dir@h
@@ -744,7 +741,7 @@ data_access:
  *	r10 - EA of fault
  *	r11 - TLB (info from Linux PTE)
  *	r12, r13 - available to use
- *	CR5 - results of addr < TASK_SIZE
+ *	CR5 - results of addr >= PAGE_OFFSET
  *	MAS0, MAS1 - loaded with proper value when we get here
  *	MAS2, MAS3 - will need additional info from Linux PTE
  *	Upon exit, we reload everything and RFI.
