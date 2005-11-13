Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Sun, 13 Nov 2005 11:27:39 +1100
Message-Id: <1131841660.5504.5.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>, Steve Munroe <sjmunroe@us.ibm.com>,
	"tom_gall@mac.com" <tom_gall@mac.com>
Subject: [PATCH] powerpc: vdso fixes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes various errors in the new functions added in the vDSO's,
I've been able to test the 32 bits version and I get consistent results
with the corresponding syscalls.

There is still a question about get_tbfreq() though. It currently
returns the value that the kernel keeps in tb_ticks_per_sec. This value
is obtained from the timebase at boot, but it's truncated to HZ
precision:

	tb_ticks_per_jiffy = ppc_tb_freq / HZ;
	tb_ticks_per_sec = tb_ticks_per_jiffy * HZ;

And it's later on modified by the ppc_adjtimex() code.

This is different from the value exposed in /proc/cpuinfo for the
timebase which is a straight copy of ppc_tb_freq, which is the
calibration value obtained at boot and unmodified.

The question at this point are: Is that "rouding" to HZ done by the
kernel correct ? And should the vDSO return this value that gets
adjusted or the fixed initial calibration value, or both.

In the later case, should I add an argument to get_tbfreq() or add a
separate function ?

In the meantime, please apply this patch as it fixes a few annoying bug
in the vDSO implementation currently in -rc1.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/asm-offsets.c	2005-11-13 10:34:07.000000000 +1100
+++ linux-work/arch/powerpc/kernel/asm-offsets.c	2005-11-13 10:34:50.000000000 +1100
@@ -275,8 +275,8 @@
 #else
 	DEFINE(TVAL32_TV_SEC, offsetof(struct timeval, tv_sec));
 	DEFINE(TVAL32_TV_USEC, offsetof(struct timeval, tv_usec));
-	DEFINE(TSPEC32_TV_SEC, offsetof(struct timespec, tv_sec));
-	DEFINE(TSPEC32_TV_NSEC, offsetof(struct timespec, tv_nsec));
+	DEFINE(TSPC32_TV_SEC, offsetof(struct timespec, tv_sec));
+	DEFINE(TSPC32_TV_NSEC, offsetof(struct timespec, tv_nsec));
 #endif
 	/* timeval/timezone offsets for use by vdso */
 	DEFINE(TZONE_TZ_MINWEST, offsetof(struct timezone, tz_minuteswest));
Index: linux-work/arch/powerpc/kernel/vdso32/gettimeofday.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso32/gettimeofday.S	2005-11-13 10:34:07.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vdso32/gettimeofday.S	2005-11-13 10:55:55.000000000 +1100
@@ -83,7 +83,7 @@
 	/* Check for supported clock IDs */
 	cmpli	cr0,r3,CLOCK_REALTIME
 	cmpli	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0,cr0,cr1
+	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
 	mflr	r12			/* r12 saves lr */
@@ -91,7 +91,7 @@
 	mr	r10,r3			/* r10 saves id */
 	mr	r11,r4			/* r11 saves tp */
 	bl	__get_datapage@local	/* get data page */
-	mr	r9, r3			/* datapage ptr in r9 */
+	mr	r9,r3			/* datapage ptr in r9 */
 	beq	cr1,50f			/* if monotonic -> jump there */
 
 	/*
@@ -210,7 +210,7 @@
 	/* Check for supported clock IDs */
 	cmpwi	cr0,r3,CLOCK_REALTIME
 	cmpwi	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0,cr0,cr1
+	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
 	li	r3,0
Index: linux-work/arch/powerpc/kernel/vdso64/gettimeofday.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso64/gettimeofday.S	2005-11-13 10:34:07.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vdso64/gettimeofday.S	2005-11-13 10:56:08.000000000 +1100
@@ -68,7 +68,7 @@
 	/* Check for supported clock IDs */
 	cmpwi	cr0,r3,CLOCK_REALTIME
 	cmpwi	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0,cr0,cr1
+	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
 	mflr	r12			/* r12 saves lr */
@@ -181,7 +181,7 @@
 	/* Check for supported clock IDs */
 	cmpwi	cr0,r3,CLOCK_REALTIME
 	cmpwi	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0,cr0,cr1
+	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
 	li	r3,0
Index: linux-work/arch/powerpc/kernel/vdso32/datapage.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso32/datapage.S	2005-11-12 08:27:18.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vdso32/datapage.S	2005-11-13 11:06:39.000000000 +1100
@@ -77,8 +77,9 @@
 	mflr	r12
   .cfi_register lr,r12
 	bl	__get_datapage@local
-	lwz	r3,CFG_TB_TICKS_PER_SEC(r3)
 	lwz	r4,(CFG_TB_TICKS_PER_SEC + 4)(r3)
+	lwz	r3,CFG_TB_TICKS_PER_SEC(r3)
 	mtlr	r12
+	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_get_tbfreq)
Index: linux-work/arch/powerpc/kernel/vdso64/datapage.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso64/datapage.S	2005-11-12 08:27:19.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vdso64/datapage.S	2005-11-13 10:58:45.000000000 +1100
@@ -80,5 +80,6 @@
 	bl	V_LOCAL_FUNC(__get_datapage)
 	ld	r3,CFG_TB_TICKS_PER_SEC(r3)
 	mtlr	r12
+	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_get_tbfreq)
