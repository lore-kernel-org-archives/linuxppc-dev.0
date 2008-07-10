Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E955DDFF5
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 07:17:44 +1000 (EST)
Date: Thu, 10 Jul 2008 16:16:21 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <for-27-patch1-0@bga.com>
Message-Id: <for-27-patch2-2@bga.com>
Subject: [2/3] powerpc: head_64.S: put irq vectors in .text.head
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We rely on careful placement of the start of the kernel, and use org from
the start of our image to line up the exception handlers.

When building a large kernel, the linker will insert stubs to call from one
toc to the next, breaking our careful placement.  In addition, kexec does
not (currently) look at the entry address specified in the header but assumes
that the begining of the load segment is the entry point.

Move the first 0x8000 bytes to .text.head so it will be linked first.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index ecced1e..4ad435a 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -21,6 +21,7 @@
  *  2 of the License, or (at your option) any later version.
  */
 
+#include <linux/init.h>
 #include <linux/threads.h>
 #include <asm/reg.h>
 #include <asm/page.h>
@@ -70,10 +71,11 @@
  *   2. The kernel is entered at system_reset_iSeries
  */
 
-	.text
+	__HEAD /* should be, but is ... */
+	.section ".text.head"
 	.globl  _stext
 _stext:
-_GLOBAL(__start)
+_HEAD_GLOBAL(__start)
 	/* NOP this out unconditionally */
 BEGIN_FTR_SECTION
 	b	.__start_initialization_multiplatform
@@ -110,7 +112,7 @@ __secondary_hold_acknowledge:
  * is relocated to physical address 0x60 before prom_init is run.
  * All of it must fit below the first exception vector at 0x100.
  */
-_GLOBAL(__secondary_hold)
+_HEAD_GLOBAL(__secondary_hold)
 	mfmsr	r24
 	ori	r24,r24,MSR_RI
 	mtmsrd	r24			/* RI on */
@@ -142,7 +144,7 @@ _GLOBAL(__secondary_hold)
 	.section ".toc","aw"
 exception_marker:
 	.tc	ID_72656773_68657265[TC],0x7265677368657265
-	.text
+	.previous
 
 /*
  * This is the start of the interrupt handlers for pSeries
@@ -614,7 +616,7 @@ unrecov_user_slb:
  * r3 is saved in paca->slb_r3
  * We assume we aren't going to take any exceptions during this procedure.
  */
-_GLOBAL(slb_miss_realmode)
+_HEAD_GLOBAL(slb_miss_realmode)
 	mflr	r10
 
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
@@ -776,7 +778,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
  * switch (ie, no lazy save of the vector registers).
  * On entry: r13 == 'current' && last_task_used_altivec != 'current'
  */
-_STATIC(load_up_altivec)
+_HEAD_STATIC(load_up_altivec)
 	mfmsr	r5			/* grab the current MSR */
 	oris	r5,r5,MSR_VEC@h
 	mtmsrd	r5			/* enable use of VMX now */
@@ -865,7 +867,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
  * been saved already.
  * On entry: r13 == 'current' && last_task_used_vsx != 'current'
  */
-_STATIC(load_up_vsx)
+_HEAD_STATIC(load_up_vsx)
 /* Load FP and VSX registers if they haven't been done yet */
 	andi.	r5,r12,MSR_FP
 	beql+	load_up_fpu		/* skip if already loaded */
@@ -905,7 +907,7 @@ _STATIC(load_up_vsx)
  * Hash table stuff
  */
 	.align	7
-_STATIC(do_hash_page)
+_HEAD_STATIC(do_hash_page)
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
 
@@ -1035,7 +1037,7 @@ do_ste_alloc:
  * We assume (DAR >> 60) == 0xc.
  */
 	.align	7
-_GLOBAL(do_stab_bolted)
+_HEAD_GLOBAL(do_stab_bolted)
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r11,PACA_EXSLB+EX_SRR0(r13)	/* save SRR0 in exc. frame */
 
@@ -1416,7 +1418,7 @@ copy_to_here:
  * On PowerMac, secondary processors starts from the reset vector, which
  * is temporarily turned into a call to one of the functions below.
  */
-	.section ".text";
+	#.section ".text";
 	.align 2 ;
 
 	.globl	__secondary_start_pmac_0
