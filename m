Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CCDC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 18:23:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E38A720883
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 18:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38A720883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Y11B0fq3zDqLd
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 05:23:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=vincenzo.frascino@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44XrLJ4D68zDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 22:52:23 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BDBE1682;
 Mon,  1 Apr 2019 04:52:22 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE92C3F557;
 Mon,  1 Apr 2019 04:52:19 -0700 (PDT)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/5] s390: Fix vDSO clock_getres()
Date: Mon,  1 Apr 2019 12:51:50 +0100
Message-Id: <20190401115152.32751-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401115152.32751-1-vincenzo.frascino@arm.com>
References: <20190401115152.32751-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Apr 2019 05:16:29 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Vincent Chen <deanbo422@gmail.com>,
 Shuah Khan <shuah@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

clock_getres in the vDSO library has to preserve the same behaviour
of posix_get_hrtimer_res().

In particular, posix_get_hrtimer_res() does:
    sec = 0;
    ns = hrtimer_resolution;
and hrtimer_resolution depends on the enablement of the high
resolution timers that can happen either at compile or at run time.

Fix the s390 vdso implementation of clock_getres keeping a copy of
hrtimer_resolution in vdso data and using that directly.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/s390/include/asm/vdso.h           |  1 +
 arch/s390/kernel/asm-offsets.c         |  2 +-
 arch/s390/kernel/time.c                |  1 +
 arch/s390/kernel/vdso32/clock_getres.S | 17 ++++++++++++-----
 arch/s390/kernel/vdso64/clock_getres.S | 15 ++++++++++-----
 5 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index 169d7604eb80..f3ba84fa9bd1 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -36,6 +36,7 @@ struct vdso_data {
 	__u32 tk_shift;			/* Shift used for xtime_nsec	0x60 */
 	__u32 ts_dir;			/* TOD steering direction	0x64 */
 	__u64 ts_end;			/* TOD steering end		0x68 */
+	__u32 hrtimer_res;		/* hrtimer resolution		0x70 */
 };
 
 struct vdso_per_cpu_data {
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 164bec175628..36db4a9ee703 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -75,6 +75,7 @@ int main(void)
 	OFFSET(__VDSO_TK_SHIFT, vdso_data, tk_shift);
 	OFFSET(__VDSO_TS_DIR, vdso_data, ts_dir);
 	OFFSET(__VDSO_TS_END, vdso_data, ts_end);
+	OFFSET(__VDSO_CLOCK_REALTIME_RES, vdso_data, hrtimer_res);
 	OFFSET(__VDSO_ECTG_BASE, vdso_per_cpu_data, ectg_timer_base);
 	OFFSET(__VDSO_ECTG_USER, vdso_per_cpu_data, ectg_user_time);
 	OFFSET(__VDSO_CPU_NR, vdso_per_cpu_data, cpu_nr);
@@ -86,7 +87,6 @@ int main(void)
 	DEFINE(__CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
 	DEFINE(__CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
 	DEFINE(__CLOCK_THREAD_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID);
-	DEFINE(__CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
 	DEFINE(__CLOCK_COARSE_RES, LOW_RES_NSEC);
 	BLANK();
 	/* idle data offsets */
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index e8766beee5ad..8ea9db599d38 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -310,6 +310,7 @@ void update_vsyscall(struct timekeeper *tk)
 
 	vdso_data->tk_mult = tk->tkr_mono.mult;
 	vdso_data->tk_shift = tk->tkr_mono.shift;
+	vdso_data->hrtimer_res = hrtimer_resolution;
 	smp_wmb();
 	++vdso_data->tb_update_count;
 }
diff --git a/arch/s390/kernel/vdso32/clock_getres.S b/arch/s390/kernel/vdso32/clock_getres.S
index eaf9cf1417f6..00fc50ad228c 100644
--- a/arch/s390/kernel/vdso32/clock_getres.S
+++ b/arch/s390/kernel/vdso32/clock_getres.S
@@ -18,20 +18,27 @@
 __kernel_clock_getres:
 	CFI_STARTPROC
 	basr	%r1,0
-	la	%r1,4f-.(%r1)
+10:	al	%r1,4f-10b(%r1)
+11:	l	%r4,__VDSO_UPD_COUNT+4(%r1)	/* load update counter */
+	tml	%r4,0x0001			/* pending update ? loop */
+	jnz	11b
+	l	%r0,__VDSO_CLOCK_REALTIME_RES(%r1)
+	cl	%r4,__VDSO_UPD_COUNT+4(%r1)	/* check update counter */
+	jne	11b
 	chi	%r2,__CLOCK_REALTIME
 	je	0f
 	chi	%r2,__CLOCK_MONOTONIC
 	je	0f
-	la	%r1,5f-4f(%r1)
+	basr	%r1,0
+	la	%r1,5f-.(%r1)
+	l	%r0,0(%r1)
 	chi	%r2,__CLOCK_REALTIME_COARSE
 	je	0f
 	chi	%r2,__CLOCK_MONOTONIC_COARSE
 	jne	3f
 0:	ltr	%r3,%r3
 	jz	2f				/* res == NULL */
-1:	l	%r0,0(%r1)
-	xc	0(4,%r3),0(%r3)			/* set tp->tv_sec to zero */
+1:	xc	0(4,%r3),0(%r3)			/* set tp->tv_sec to zero */
 	st	%r0,4(%r3)			/* store tp->tv_usec */
 2:	lhi	%r2,0
 	br	%r14
@@ -39,6 +46,6 @@ __kernel_clock_getres:
 	svc	0
 	br	%r14
 	CFI_ENDPROC
-4:	.long	__CLOCK_REALTIME_RES
+4:	.long	_vdso_data - 10b
 5:	.long	__CLOCK_COARSE_RES
 	.size	__kernel_clock_getres,.-__kernel_clock_getres
diff --git a/arch/s390/kernel/vdso64/clock_getres.S b/arch/s390/kernel/vdso64/clock_getres.S
index 081435398e0a..1400a8df9802 100644
--- a/arch/s390/kernel/vdso64/clock_getres.S
+++ b/arch/s390/kernel/vdso64/clock_getres.S
@@ -17,12 +17,19 @@
 	.type  __kernel_clock_getres,@function
 __kernel_clock_getres:
 	CFI_STARTPROC
-	larl	%r1,4f
+	larl	%r1,3f
+	lg	%r0,0(%r1)
 	cghi	%r2,__CLOCK_REALTIME_COARSE
 	je	0f
 	cghi	%r2,__CLOCK_MONOTONIC_COARSE
 	je	0f
-	larl	%r1,3f
+	larl	%r1,_vdso_data
+11:	lg	%r4,__VDSO_UPD_COUNT(%r1)	/* load update counter */
+	tmll	%r4,0x0001			/* pending update ? loop */
+	jnz	11b
+	l	%r0,__VDSO_CLOCK_REALTIME_RES(%r1)
+	clg	%r4,__VDSO_UPD_COUNT(%r1)	/* check update counter */
+	jne	11b
 	cghi	%r2,__CLOCK_REALTIME
 	je	0f
 	cghi	%r2,__CLOCK_MONOTONIC
@@ -36,7 +43,6 @@ __kernel_clock_getres:
 	jz	2f
 0:	ltgr	%r3,%r3
 	jz	1f				/* res == NULL */
-	lg	%r0,0(%r1)
 	xc	0(8,%r3),0(%r3)			/* set tp->tv_sec to zero */
 	stg	%r0,8(%r3)			/* store tp->tv_usec */
 1:	lghi	%r2,0
@@ -45,6 +51,5 @@ __kernel_clock_getres:
 	svc	0
 	br	%r14
 	CFI_ENDPROC
-3:	.quad	__CLOCK_REALTIME_RES
-4:	.quad	__CLOCK_COARSE_RES
+3:	.quad	__CLOCK_COARSE_RES
 	.size	__kernel_clock_getres,.-__kernel_clock_getres
-- 
2.21.0

