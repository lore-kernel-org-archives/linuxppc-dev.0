Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id CDED9DDEE8
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2007 20:58:37 +1000 (EST)
Date: Mon, 25 Jun 2007 20:58:36 +1000
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH] Fix VDSO gettimeofday() when called with NULL struct timeval.
Message-ID: <20070625105836.GE9768@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,
	It'd be nice if this made it into 2.6.22, esp. now that more
distros are shipping glibc's that will use the VDSO.

I think I got the asm right, it works on pSerie, either way feedback
welcome.

From: Tony Breeds <tony@bakeyournoodle.com>

Fix VDSO gettimeofday() when called with NULL struct timeval.

Consider the prototype for gettimeofday():
	int gettimofday(struct timeval *tv, struct timezone *tz);

AFAICT it is valid to call with /either/ tv or tz being NULL, the C version
of sys_gettimeofday() supports this, the current version of gettimeofday() in
the VDSO will SEGV if called with a NULL tv.

This patch fixes this.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---

 arch/powerpc/kernel/vdso32/gettimeofday.S |   13 +++++++------
 arch/powerpc/kernel/vdso64/gettimeofday.S |    8 +++++---
 2 files changed, 12 insertions(+), 9 deletions(-)

Index: working/arch/powerpc/kernel/vdso32/gettimeofday.S
===================================================================
--- working.orig/arch/powerpc/kernel/vdso32/gettimeofday.S	2007-06-25 19:35:47.000000000 +1000
+++ working/arch/powerpc/kernel/vdso32/gettimeofday.S	2007-06-25 19:40:34.000000000 +1000
@@ -32,8 +32,10 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	mr	r11,r4			/* r11 saves tz */
 	bl	__get_datapage@local	/* get data page */
 	mr	r9, r3			/* datapage ptr in r9 */
+	cmpli	cr0,r10,0		/* check if tv is NULL */
+	beq	1f
 	bl	__do_get_xsec@local	/* get xsec from tb & kernel */
-	bne-	2f			/* out of line -> do syscall */
+	bne-	3f			/* out of line -> do syscall */
 
 	/* seconds are xsec >> 20 */
 	rlwinm	r5,r4,12,20,31
@@ -50,20 +52,19 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	mulhwu	r5,r5,r6
 	stw	r5,TVAL32_TV_USEC(r10)
 
-	cmpli	cr0,r11,0		/* check if tz is NULL */
-	beq	1f
+1:	cmpli	cr0,r11,0		/* check if tz is NULL */
+	beq	2f
 	lwz	r4,CFG_TZ_MINUTEWEST(r9)/* fill tz */
 	lwz	r5,CFG_TZ_DSTTIME(r9)
 	stw	r4,TZONE_TZ_MINWEST(r11)
 	stw	r5,TZONE_TZ_DSTTIME(r11)
 
-1:	mtlr	r12
+2:	mtlr	r12
 	crclr	cr0*4+so
 	li	r3,0
 	blr
 
-2:
-	mtlr	r12
+3:	mtlr	r12
 	mr	r3,r10
 	mr	r4,r11
 	li	r0,__NR_gettimeofday
Index: working/arch/powerpc/kernel/vdso64/gettimeofday.S
===================================================================
--- working.orig/arch/powerpc/kernel/vdso64/gettimeofday.S	2007-06-25 19:35:52.000000000 +1000
+++ working/arch/powerpc/kernel/vdso64/gettimeofday.S	2007-06-25 19:42:45.000000000 +1000
@@ -32,6 +32,8 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	mr	r11,r3			/* r11 holds tv */
 	mr	r10,r4			/* r10 holds tz */
 	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
+	cmpldi	cr0,r11,0		/* check if tv is NULL */
+	beq	1f
 	bl	V_LOCAL_FUNC(__do_get_xsec)	/* get xsec from tb & kernel */
 	lis     r7,15			/* r7 = 1000000 = USEC_PER_SEC */
 	ori     r7,r7,16960
@@ -43,14 +45,14 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 					 * XSEC_PER_SEC
 					 */
 	rldicl  r0,r0,44,20
-	cmpldi	cr0,r10,0		/* check if tz is NULL */
+1:	cmpldi	cr0,r10,0		/* check if tz is NULL */
 	std	r0,TVAL64_TV_USEC(r11)	/* store usec in tv */
-	beq	1f
+	beq	2f
 	lwz	r4,CFG_TZ_MINUTEWEST(r3)/* fill tz */
 	lwz	r5,CFG_TZ_DSTTIME(r3)
 	stw	r4,TZONE_TZ_MINWEST(r10)
 	stw	r5,TZONE_TZ_DSTTIME(r10)
-1:	mtlr	r12
+2:	mtlr	r12
 	crclr	cr0*4+so
 	li	r3,0			/* always success */
 	blr

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
