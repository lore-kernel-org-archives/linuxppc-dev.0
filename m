Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D436C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 18:19:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9D612133D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 18:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9D612133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Y0xM6L8wzDqJk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 05:19:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=vincenzo.frascino@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44XrLF2YPSzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 22:52:17 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8125315AD;
 Mon,  1 Apr 2019 04:52:16 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3F433F557;
 Mon,  1 Apr 2019 04:52:13 -0700 (PDT)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Subject: [PATCH 1/5] arm64: Fix vDSO clock_getres()
Date: Mon,  1 Apr 2019 12:51:48 +0100
Message-Id: <20190401115152.32751-2-vincenzo.frascino@arm.com>
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

Fix the arm64 vdso implementation of clock_getres keeping a copy of
hrtimer_resolution in vdso data and using that directly.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/vdso_datapage.h |  1 +
 arch/arm64/kernel/asm-offsets.c        |  2 +-
 arch/arm64/kernel/vdso.c               |  2 ++
 arch/arm64/kernel/vdso/gettimeofday.S  | 25 ++++++++++++++-----------
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/vdso_datapage.h b/arch/arm64/include/asm/vdso_datapage.h
index 2b9a63771eda..f89263c8e11a 100644
--- a/arch/arm64/include/asm/vdso_datapage.h
+++ b/arch/arm64/include/asm/vdso_datapage.h
@@ -38,6 +38,7 @@ struct vdso_data {
 	__u32 tz_minuteswest;	/* Whacky timezone stuff */
 	__u32 tz_dsttime;
 	__u32 use_syscall;
+	__u32 hrtimer_res;
 };
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 7f40dcbdd51d..e10e2a5d9ddc 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -94,7 +94,7 @@ int main(void)
   DEFINE(CLOCK_REALTIME,	CLOCK_REALTIME);
   DEFINE(CLOCK_MONOTONIC,	CLOCK_MONOTONIC);
   DEFINE(CLOCK_MONOTONIC_RAW,	CLOCK_MONOTONIC_RAW);
-  DEFINE(CLOCK_REALTIME_RES,	MONOTONIC_RES_NSEC);
+  DEFINE(CLOCK_REALTIME_RES,	offsetof(struct vdso_data, hrtimer_res));
   DEFINE(CLOCK_REALTIME_COARSE,	CLOCK_REALTIME_COARSE);
   DEFINE(CLOCK_MONOTONIC_COARSE,CLOCK_MONOTONIC_COARSE);
   DEFINE(CLOCK_COARSE_RES,	LOW_RES_NSEC);
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 2d419006ad43..47ba72345739 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -245,6 +245,8 @@ void update_vsyscall(struct timekeeper *tk)
 		vdso_data->cs_shift		= tk->tkr_mono.shift;
 	}
 
+	vdso_data->hrtimer_res			= hrtimer_resolution;
+
 	smp_wmb();
 	++vdso_data->tb_seq_count;
 }
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
index c39872a7b03c..7a2cd2f8e13a 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -296,32 +296,35 @@ ENDPROC(__kernel_clock_gettime)
 /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
 ENTRY(__kernel_clock_getres)
 	.cfi_startproc
+	adr	vdso_data, _vdso_data
 	cmp	w0, #CLOCK_REALTIME
 	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
 	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
-	b.ne	1f
+	b.ne	2f
 
-	ldr	x2, 5f
-	b	2f
-1:
+1:	/* Get hrtimer_res */
+	seqcnt_acquire
+	syscall_check fail=5f
+	ldr	x2, [vdso_data, #CLOCK_REALTIME_RES]
+	seqcnt_check fail=1b
+	b	3f
+2:
 	cmp	w0, #CLOCK_REALTIME_COARSE
 	ccmp	w0, #CLOCK_MONOTONIC_COARSE, #0x4, ne
-	b.ne	4f
+	b.ne	5f
 	ldr	x2, 6f
-2:
-	cbz	x1, 3f
+3:
+	cbz	x1, 4f
 	stp	xzr, x2, [x1]
 
-3:	/* res == NULL. */
+4:	/* res == NULL. */
 	mov	w0, wzr
 	ret
 
-4:	/* Syscall fallback. */
+5:	/* Syscall fallback. */
 	mov	x8, #__NR_clock_getres
 	svc	#0
 	ret
-5:
-	.quad	CLOCK_REALTIME_RES
 6:
 	.quad	CLOCK_COARSE_RES
 	.cfi_endproc
-- 
2.21.0

