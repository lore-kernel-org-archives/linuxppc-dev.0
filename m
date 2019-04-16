Return-Path: <SRS0=rc36=SS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F56C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 16:24:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22F620868
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Apr 2019 16:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22F620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44k9gW1GQTzDqMq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Apr 2019 02:24:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=vincenzo.frascino@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44k9ST0H0ZzDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Apr 2019 02:15:04 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 685921682;
 Tue, 16 Apr 2019 09:15:03 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com
 [10.1.196.72])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 971853F59C;
 Tue, 16 Apr 2019 09:15:00 -0700 (PDT)
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/5] nds32: Fix vDSO clock_getres()
Date: Tue, 16 Apr 2019 17:14:33 +0100
Message-Id: <20190416161434.32691-5-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190416161434.32691-1-vincenzo.frascino@arm.com>
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fix the nds32 vdso implementation of clock_getres keeping a copy of
hrtimer_resolution in vdso data and using that directly.

Cc: Greentime Hu <green.hu@gmail.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/nds32/include/asm/vdso_datapage.h | 1 +
 arch/nds32/kernel/vdso.c               | 1 +
 arch/nds32/kernel/vdso/gettimeofday.c  | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/nds32/include/asm/vdso_datapage.h b/arch/nds32/include/asm/vdso_datapage.h
index 79db5a12ca5e..34d80548297f 100644
--- a/arch/nds32/include/asm/vdso_datapage.h
+++ b/arch/nds32/include/asm/vdso_datapage.h
@@ -20,6 +20,7 @@ struct vdso_data {
 	u32 xtime_clock_sec;	/* CLOCK_REALTIME - seconds */
 	u32 cs_mult;		/* clocksource multiplier */
 	u32 cs_shift;		/* Cycle to nanosecond divisor (power of two) */
+	u32 hrtimer_res;	/* hrtimer resolution */
 
 	u64 cs_cycle_last;	/* last cycle value */
 	u64 cs_mask;		/* clocksource mask */
diff --git a/arch/nds32/kernel/vdso.c b/arch/nds32/kernel/vdso.c
index 016f15891f6d..90bcae6f8554 100644
--- a/arch/nds32/kernel/vdso.c
+++ b/arch/nds32/kernel/vdso.c
@@ -220,6 +220,7 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_data->xtime_coarse_sec = tk->xtime_sec;
 	vdso_data->xtime_coarse_nsec = tk->tkr_mono.xtime_nsec >>
 	    tk->tkr_mono.shift;
+	vdso_data->hrtimer_res = hrtimer_resolution;
 	vdso_write_end(vdso_data);
 }
 
diff --git a/arch/nds32/kernel/vdso/gettimeofday.c b/arch/nds32/kernel/vdso/gettimeofday.c
index 038721af40e3..b02581891c33 100644
--- a/arch/nds32/kernel/vdso/gettimeofday.c
+++ b/arch/nds32/kernel/vdso/gettimeofday.c
@@ -208,6 +208,8 @@ static notrace int clock_getres_fallback(clockid_t _clk_id,
 
 notrace int __vdso_clock_getres(clockid_t clk_id, struct timespec *res)
 {
+	struct vdso_data *vdata = __get_datapage();
+
 	if (res == NULL)
 		return 0;
 	switch (clk_id) {
@@ -215,7 +217,7 @@ notrace int __vdso_clock_getres(clockid_t clk_id, struct timespec *res)
 	case CLOCK_MONOTONIC:
 	case CLOCK_MONOTONIC_RAW:
 		res->tv_sec = 0;
-		res->tv_nsec = CLOCK_REALTIME_RES;
+		res->tv_nsec = vdata->hrtimer_res;
 		break;
 	case CLOCK_REALTIME_COARSE:
 	case CLOCK_MONOTONIC_COARSE:
-- 
2.21.0

