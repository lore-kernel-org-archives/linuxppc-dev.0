Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Mon, 14 Nov 2005 14:55:58 +1100
Message-Id: <1131940559.5504.118.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"tom_gall@mac.com" <tom_gall@mac.com>,
	David Woodhouse <dwmw2@infradead.org>, Steve Munroe <sjmunroe@us.ibm.com>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: vdso fixes (take #2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes various errors in the new functions added in the vDSO's,
I've now verified all functions on both 32 and 64 bits vDSOs. It also
fix a sign extension bug getting the initial time of day at boot that
could cause the monotonic clock value to be completely on bogus for
64 bits applications (with either the vDSO or the syscall) on
powermacs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/asm-offsets.c	2005-11-14 11:06:58.000000000 +1100
+++ linux-work/arch/powerpc/kernel/asm-offsets.c	2005-11-14 13:09:57.000000000 +1100
@@ -270,13 +270,15 @@
 	DEFINE(TVAL64_TV_USEC, offsetof(struct timeval, tv_usec));
 	DEFINE(TVAL32_TV_SEC, offsetof(struct compat_timeval, tv_sec));
 	DEFINE(TVAL32_TV_USEC, offsetof(struct compat_timeval, tv_usec));
+	DEFINE(TSPC64_TV_SEC, offsetof(struct timespec, tv_sec));
+	DEFINE(TSPC64_TV_NSEC, offsetof(struct timespec, tv_nsec));
 	DEFINE(TSPC32_TV_SEC, offsetof(struct compat_timespec, tv_sec));
 	DEFINE(TSPC32_TV_NSEC, offsetof(struct compat_timespec, tv_nsec));
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
--- linux-work.orig/arch/powerpc/kernel/vdso32/gettimeofday.S	2005-11-14 11:06:58.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vdso32/gettimeofday.S	2005-11-14 12:06:27.000000000 +1100
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
@@ -173,10 +173,14 @@
 	add	r4,r4,r7
 	lis	r5,NSEC_PER_SEC@h
 	ori	r5,r5,NSEC_PER_SEC@l
-	cmpli	cr0,r4,r5
+	cmpl	cr0,r4,r5
+	cmpli	cr1,r4,0
 	blt	1f
 	subf	r4,r5,r4
 	addi	r3,r3,1
+1:	bge	cr1,1f
+	addi	r3,r3,-1
+	add	r4,r4,r5
 1:	stw	r3,TSPC32_TV_SEC(r11)
 	stw	r4,TSPC32_TV_NSEC(r11)
 
@@ -210,7 +214,7 @@
 	/* Check for supported clock IDs */
 	cmpwi	cr0,r3,CLOCK_REALTIME
 	cmpwi	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0,cr0,cr1
+	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
 	li	r3,0
Index: linux-work/arch/powerpc/kernel/vdso64/gettimeofday.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso64/gettimeofday.S	2005-11-14 11:06:58.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vdso64/gettimeofday.S	2005-11-14 14:38:51.000000000 +1100
@@ -1,4 +1,5 @@
-/*
+
+	/*
  * Userland implementation of gettimeofday() for 64 bits processes in a
  * ppc64 kernel for use in the vDSO
  *
@@ -68,7 +69,7 @@
 	/* Check for supported clock IDs */
 	cmpwi	cr0,r3,CLOCK_REALTIME
 	cmpwi	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0,cr0,cr1
+	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
 	mflr	r12			/* r12 saves lr */
@@ -84,16 +85,17 @@
 
 	bl	V_LOCAL_FUNC(__do_get_xsec)	/* get xsec from tb & kernel */
 
-	lis     r7,0x3b9a		/* r7 = 1000000000 = NSEC_PER_SEC */
-	ori     r7,r7,0xca00
+	lis     r7,15			/* r7 = 1000000 = USEC_PER_SEC */
+	ori     r7,r7,16960
 	rldicl  r5,r4,44,20		/* r5 = sec = xsec / XSEC_PER_SEC */
 	rldicr  r6,r5,20,43		/* r6 = sec * XSEC_PER_SEC */
 	std	r5,TSPC64_TV_SEC(r11)	/* store sec in tv */
 	subf	r0,r6,r4		/* r0 = xsec = (xsec - r6) */
-	mulld   r0,r0,r7		/* nsec = (xsec * NSEC_PER_SEC) /
+	mulld   r0,r0,r7		/* usec = (xsec * USEC_PER_SEC) /
 					 * XSEC_PER_SEC
 					 */
 	rldicl  r0,r0,44,20
+	mulli	r0,r0,1000		/* nsec = usec * 1000 */
 	std	r0,TSPC64_TV_NSEC(r11)	/* store nsec in tp */
 
 	mtlr	r12
@@ -106,15 +108,16 @@
 
 50:	bl	V_LOCAL_FUNC(__do_get_xsec)	/* get xsec from tb & kernel */
 
-	lis     r7,0x3b9a		/* r7 = 1000000000 = NSEC_PER_SEC */
-	ori     r7,r7,0xca00
+	lis     r7,15			/* r7 = 1000000 = USEC_PER_SEC */
+	ori     r7,r7,16960
 	rldicl  r5,r4,44,20		/* r5 = sec = xsec / XSEC_PER_SEC */
 	rldicr  r6,r5,20,43		/* r6 = sec * XSEC_PER_SEC */
 	subf	r0,r6,r4		/* r0 = xsec = (xsec - r6) */
-	mulld   r0,r0,r7		/* nsec = (xsec * NSEC_PER_SEC) /
+	mulld   r0,r0,r7		/* usec = (xsec * USEC_PER_SEC) /
 					 * XSEC_PER_SEC
 					 */
 	rldicl  r6,r0,44,20
+	mulli	r6,r6,1000		/* nsec = usec * 1000 */
 
 	/* now we must fixup using wall to monotonic. We need to snapshot
 	 * that value and do the counter trick again. Fortunately, we still
@@ -123,8 +126,8 @@
 	 * can be used
 	 */
 
-	lwz	r4,WTOM_CLOCK_SEC(r9)
-	lwz	r7,WTOM_CLOCK_NSEC(r9)
+	lwa	r4,WTOM_CLOCK_SEC(r3)
+	lwa	r7,WTOM_CLOCK_NSEC(r3)
 
 	/* We now have our result in r4,r7. We create a fake dependency
 	 * on that result and re-check the counter
@@ -144,10 +147,14 @@
 	add	r7,r7,r6
 	lis	r9,NSEC_PER_SEC@h
 	ori	r9,r9,NSEC_PER_SEC@l
-	cmpli	cr0,r7,r9
+	cmpl	cr0,r7,r9
+	cmpli	cr1,r7,0
 	blt	1f
 	subf	r7,r9,r7
 	addi	r4,r4,1
+1:	bge	cr1,1f
+	addi	r4,r4,-1
+	add	r7,r7,r9
 1:	std	r4,TSPC64_TV_SEC(r11)
 	std	r7,TSPC64_TV_NSEC(r11)
 
@@ -181,7 +188,7 @@
 	/* Check for supported clock IDs */
 	cmpwi	cr0,r3,CLOCK_REALTIME
 	cmpwi	cr1,r3,CLOCK_MONOTONIC
-	cror	cr0,cr0,cr1
+	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
 	bne	cr0,99f
 
 	li	r3,0
Index: linux-work/arch/powerpc/kernel/vdso32/datapage.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso32/datapage.S	2005-11-14 11:06:58.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vdso32/datapage.S	2005-11-14 11:07:11.000000000 +1100
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
--- linux-work.orig/arch/powerpc/kernel/vdso64/datapage.S	2005-11-14 11:06:58.000000000 +1100
+++ linux-work/arch/powerpc/kernel/vdso64/datapage.S	2005-11-14 11:07:11.000000000 +1100
@@ -80,5 +80,6 @@
 	bl	V_LOCAL_FUNC(__get_datapage)
 	ld	r3,CFG_TB_TICKS_PER_SEC(r3)
 	mtlr	r12
+	blr
   .cfi_endproc
 V_FUNCTION_END(__kernel_get_tbfreq)
Index: linux-work/include/asm-powerpc/vdso_datapage.h
===================================================================
--- linux-work.orig/include/asm-powerpc/vdso_datapage.h	2005-11-14 10:42:00.000000000 +1100
+++ linux-work/include/asm-powerpc/vdso_datapage.h	2005-11-14 11:52:12.000000000 +1100
@@ -73,7 +73,7 @@
 	/* those additional ones don't have to be located anywhere
 	 * special as they were not part of the original systemcfg
 	 */
-	__s64 wtom_clock_sec;			/* Wall to monotonic clock */
+	__s32 wtom_clock_sec;			/* Wall to monotonic clock */
 	__s32 wtom_clock_nsec;
    	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
    	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
Index: linux-work/arch/powerpc/platforms/powermac/time.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/time.c	2005-11-01 14:13:53.000000000 +1100
+++ linux-work/arch/powerpc/platforms/powermac/time.c	2005-11-14 14:28:10.000000000 +1100
@@ -102,7 +102,7 @@
 static unsigned long cuda_get_time(void)
 {
 	struct adb_request req;
-	unsigned long now;
+	unsigned int now;
 
 	if (cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME) < 0)
 		return 0;
@@ -113,7 +113,7 @@
 		       req.reply_len);
 	now = (req.reply[3] << 24) + (req.reply[4] << 16)
 		+ (req.reply[5] << 8) + req.reply[6];
-	return now - RTC_OFFSET;
+	return ((unsigned long)now) - RTC_OFFSET;
 }
 
 #define cuda_get_rtc_time(tm)	to_rtc_time(cuda_get_time(), (tm))
@@ -146,7 +146,7 @@
 static unsigned long pmu_get_time(void)
 {
 	struct adb_request req;
-	unsigned long now;
+	unsigned int now;
 
 	if (pmu_request(&req, NULL, 1, PMU_READ_RTC) < 0)
 		return 0;
@@ -156,7 +156,7 @@
 		       req.reply_len);
 	now = (req.reply[0] << 24) + (req.reply[1] << 16)
 		+ (req.reply[2] << 8) + req.reply[3];
-	return now - RTC_OFFSET;
+	return ((unsigned long)now) - RTC_OFFSET;
 }
 
 #define pmu_get_rtc_time(tm)	to_rtc_time(pmu_get_time(), (tm))
