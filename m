Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 2D875DDE37
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 09:50:33 +1000 (EST)
Date: Tue, 26 Jun 2007 09:50:32 +1000
To: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH v2] Fix VDSO gettimeofday() when called with NULL struct
	timeval.
Message-ID: <20070625235032.GH9768@bakeyournoodle.com>
References: <20070625105836.GE9768@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070625105836.GE9768@bakeyournoodle.com>
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated to include feedback from Ben and Segher, also reposition the
compare in the 64bit VDSO to catch all the references to tv.

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
Also fixes some whitespace damage at the top of vdso64/gettimeofday.S

 arch/powerpc/kernel/vdso32/gettimeofday.S |   13 +++++++------
 arch/powerpc/kernel/vdso64/gettimeofday.S |    8 +++++---
 2 files changed, 12 insertions(+), 9 deletions(-)

Index: working/arch/powerpc/kernel/vdso32/gettimeofday.S
===================================================================
--- working.orig/arch/powerpc/kernel/vdso32/gettimeofday.S
+++ working/arch/powerpc/kernel/vdso32/gettimeofday.S
@@ -32,6 +32,8 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	mr	r11,r4			/* r11 saves tz */
 	bl	__get_datapage@local	/* get data page */
 	mr	r9, r3			/* datapage ptr in r9 */
+	cmplwi	r10,0			/* check if tv is NULL */
+	beq	3f
 	bl	__do_get_xsec@local	/* get xsec from tb & kernel */
 	bne-	2f			/* out of line -> do syscall */
 
@@ -50,7 +52,7 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	mulhwu	r5,r5,r6
 	stw	r5,TVAL32_TV_USEC(r10)
 
-	cmpli	cr0,r11,0		/* check if tz is NULL */
+3:	cmplwi	r11,0			/* check if tz is NULL */
 	beq	1f
 	lwz	r4,CFG_TZ_MINUTEWEST(r9)/* fill tz */
 	lwz	r5,CFG_TZ_DSTTIME(r9)
Index: working/arch/powerpc/kernel/vdso64/gettimeofday.S
===================================================================
--- working.orig/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ working/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -1,5 +1,4 @@
-
-	/*
+/*
  * Userland implementation of gettimeofday() for 64 bits processes in a
  * ppc64 kernel for use in the vDSO
  *
@@ -32,6 +31,8 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 	mr	r11,r3			/* r11 holds tv */
 	mr	r10,r4			/* r10 holds tz */
 	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
+	cmpldi	r10,0			/* check if tv is NULL */
+	beq	2f
 	bl	V_LOCAL_FUNC(__do_get_xsec)	/* get xsec from tb & kernel */
 	lis     r7,15			/* r7 = 1000000 = USEC_PER_SEC */
 	ori     r7,r7,16960
@@ -43,8 +44,8 @@ V_FUNCTION_BEGIN(__kernel_gettimeofday)
 					 * XSEC_PER_SEC
 					 */
 	rldicl  r0,r0,44,20
-	cmpldi	cr0,r10,0		/* check if tz is NULL */
 	std	r0,TVAL64_TV_USEC(r11)	/* store usec in tv */
+2:	cmpldi	r10,0			/* check if tz is NULL */
 	beq	1f
 	lwz	r4,CFG_TZ_MINUTEWEST(r3)/* fill tz */
 	lwz	r5,CFG_TZ_DSTTIME(r3)

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
