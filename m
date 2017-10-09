Return-Path: <santosh@fossix.org>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y9XwT6gQszDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Oct 2017 19:10:01 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id i23so25827372pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Oct 2017 01:10:00 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v4] powerpc/vdso64: Add support for
 CLOCK_{REALTIME/MONOTONIC}_COARSE
Date: Mon,  9 Oct 2017 13:39:49 +0530
Message-Id: <20171009080949.25913-1-santosh@fossix.org>
In-Reply-To: <20171006112528.zryd4l2yl2k6xk2h@naverao1-tp.localdomain>
References: <20171006112528.zryd4l2yl2k6xk2h@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current vDSO64 implementation does not have support for coarse clocks
(CLOCK_MONOTONIC_COARSE, CLOCK_REALTIME_COARSE), for which it falls back
to system call, increasing the response time, vDSO implementation reduces
the cycle time. Below is a benchmark of the difference in execution times.

(Non-coarse clocks are also included just for completion)

clock-gettime-realtime: syscall: 172 nsec/call
clock-gettime-realtime:    libc: 28 nsec/call
clock-gettime-realtime:    vdso: 22 nsec/call
clock-gettime-monotonic: syscall: 171 nsec/call
clock-gettime-monotonic:    libc: 30 nsec/call
clock-gettime-monotonic:    vdso: 25 nsec/call
clock-gettime-realtime-coarse: syscall: 153 nsec/call
clock-gettime-realtime-coarse:    libc: 16 nsec/call
clock-gettime-realtime-coarse:    vdso: 10 nsec/call
clock-gettime-monotonic-coarse: syscall: 167 nsec/call
clock-gettime-monotonic-coarse:    libc: 17 nsec/call
clock-gettime-monotonic-coarse:    vdso: 11 nsec/call

CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/kernel/asm-offsets.c         |  2 +
 arch/powerpc/kernel/vdso64/gettimeofday.S | 67 ++++++++++++++++++++++++++-----
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 8cfb20e38cfe..b55c68c54dc1 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -396,6 +396,8 @@ int main(void)
 	/* Other bits used by the vdso */
 	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
 	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
+	DEFINE(CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
+	DEFINE(CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
 	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
 	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
 
diff --git a/arch/powerpc/kernel/vdso64/gettimeofday.S b/arch/powerpc/kernel/vdso64/gettimeofday.S
index 382021324883..729dded195ce 100644
--- a/arch/powerpc/kernel/vdso64/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso64/gettimeofday.S
@@ -64,6 +64,12 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	cmpwi	cr0,r3,CLOCK_REALTIME
 	cmpwi	cr1,r3,CLOCK_MONOTONIC
 	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
+
+	cmpwi	cr5,r3,CLOCK_REALTIME_COARSE
+	cmpwi	cr6,r3,CLOCK_MONOTONIC_COARSE
+	cror	cr5*4+eq,cr5*4+eq,cr6*4+eq
+
+	cror	cr0*4+eq,cr0*4+eq,cr5*4+eq
 	bne	cr0,99f
 
 	mflr	r12			/* r12 saves lr */
@@ -72,6 +78,7 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	bl	V_LOCAL_FUNC(__get_datapage)	/* get data page */
 	lis	r7,NSEC_PER_SEC@h	/* want nanoseconds */
 	ori	r7,r7,NSEC_PER_SEC@l
+	beq	cr5,70f
 50:	bl	V_LOCAL_FUNC(__do_get_tspec)	/* get time from tb & kernel */
 	bne	cr1,80f			/* if not monotonic, all done */
 
@@ -97,19 +104,57 @@ V_FUNCTION_BEGIN(__kernel_clock_gettime)
 	ld	r0,CFG_TB_UPDATE_COUNT(r3)
         cmpld   cr0,r0,r8		/* check if updated */
 	bne-	50b
+	b	78f
 
-	/* Add wall->monotonic offset and check for overflow or underflow.
+	/*
+	 * For coarse clocks we get data directly from the vdso data page, so
+	 * we don't need to call __do_get_tspec, but we still need to do the
+	 * counter trick.
 	 */
-	add	r4,r4,r6
-	add	r5,r5,r9
-	cmpd	cr0,r5,r7
-	cmpdi	cr1,r5,0
-	blt	1f
-	subf	r5,r7,r5
-	addi	r4,r4,1
-1:	bge	cr1,80f
-	addi	r4,r4,-1
-	add	r5,r5,r7
+70:	ld      r8,CFG_TB_UPDATE_COUNT(r3)
+	andi.   r0,r8,1                 /* pending update ? loop */
+	bne-    70b
+	xor     r0,r8,r8                /* create dependency */
+	add     r3,r3,r0
+
+	/*
+	 * CLOCK_REALTIME_COARSE, below values are needed for MONOTONIC_COARSE
+	 * too
+	 */
+	ld      r4,STAMP_XTIME+TSPC64_TV_SEC(r3)
+	ld      r5,STAMP_XTIME+TSPC64_TV_NSEC(r3)
+	bne     cr6,75f
+
+	/* CLOCK_MONOTONIC_COARSE */
+	lwa     r6,WTOM_CLOCK_SEC(r3)
+	lwa     r9,WTOM_CLOCK_NSEC(r3)
+
+	/* check if counter has updated */
+75:	or      r0,r6,r9
+	or	r0,r4,r5
+	xor     r0,r0,r0
+	add     r3,r3,r0
+	ld      r0,CFG_TB_UPDATE_COUNT(r3)
+	cmpld   cr0,r0,r8               /* check if updated */
+	bne-    70b
+
+	/* Counter has not updated, so continue calculating proper values for
+	 * sec and nsec if monotonic coarse, or just return with the proper
+	 * values for realtime.
+	*/
+	bne     cr6,80f
+
+	/* Add wall->monotonic offset and check for overflow or underflow */
+78:	add     r4,r4,r6
+	add     r5,r5,r9
+	cmpd    cr0,r5,r7
+	cmpdi   cr1,r5,0
+	blt     79f
+	subf    r5,r7,r5
+	addi    r4,r4,1
+79:	bge     cr1,80f
+	addi    r4,r4,-1
+	add     r5,r5,r7
 
 80:	std	r4,TSPC64_TV_SEC(r11)
 	std	r5,TSPC64_TV_NSEC(r11)
-- 
2.13.6
