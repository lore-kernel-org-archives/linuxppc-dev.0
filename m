Return-Path: <linuxppc-dev+bounces-23110-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA9EC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 13:08:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpmm059Jcz302K;
	Mon, 29 Jun 2026 23:07:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782738464;
	cv=none; b=HGtc0xtyti5RXT6KFo+PhgJd4E6hRh4gDVkI8Ik7EPBauXlNfKNLbiExFw/Rlqrj8No+wwE8NZL/vyqLFeYXlz/lhQSCAEHB0Edzv9o19Xdp8BV1sYz3Vtt9yC5Quti9DNYROlLLtweerQPPRGAGvnuGDxNOKpuH3uVrt3oYeZjrfy5Wh3XLZ0kRuxbZIX1aZk65uaEeWJl8j3cuCLmcNEfz9frMY0yLpfBmA9oPD3bBydMkI+RZmOUufJv5wldcUCA5ar2ylD5/tvCpwv3V//WPx/IUT1y9ck9hphD10AMd2jiwd0xJfRVzB+uin58ydIY+28anfsrM88rwZPzbsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782738464; c=relaxed/relaxed;
	bh=FRrvuMXzaYK6HUR0cuKvFuvToTthZqw4duYY3VtWyyU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+0iWNcOfvHVkYgJdJntznopC4WXsbZmCB9nReWTdIcrifZ0T6jH3iMJLEP2TAVTLae/gi+A/Od2OAfJbEO8a1cVTzstAWmgVjdr3AXtq26ACWJgNzvgTIj6NzRwFu37Bpi0+jYv+D+eo+jaPTZV2ihCD9J76t+15qXY0XjRZ2awenqmO/VJ0Qx/TYeje36KC+H5jf+r7JsQcIPSHr4CeWjmoMCUVX+Rft2Lhti79AdjWbSntQdGaWz00gUCc5cMAkr7+Yh2mQt09yIWtjaPJp3JsKf1szCWtW3VjHdVzuZGyZ6i6Zf9m0oMymjhfbzweJv/79qG9terHnwlrHNpCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=RYtyy34k; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=RYtyy34k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpmlz5gSSz309y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 23:07:43 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FRrvuMXzaYK6HUR0cuKvFuvToTthZqw4duYY3VtWyyU=;
	b=RYtyy34kDkosU1+WmQBuulXKUnMrfVd8npdPpPN9UHFmGzxLygei2ZZYz4n8eWcB5VbipDq32
	s14zl1Nyg8PgRu7X/8Ui0YmbSgThw4mzNWZRTa94HP6JR4MMibMzO6/d6RcJG+/xJQyd6dqq92m
	YFIE8NhHSho8g4AhoiG7huc=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gpmYP5JfKzRhV6;
	Mon, 29 Jun 2026 20:58:33 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id EE15E40575;
	Mon, 29 Jun 2026 21:07:40 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 21:07:36 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <oleg@redhat.com>, <richard.henderson@linaro.org>, <mattst88@gmail.com>,
	<linmag7@gmail.com>, <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kees@kernel.org>, <guoren@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <geert@linux-m68k.org>,
	<tsbogend@alpha.franken.de>, <James.Bottomley@HansenPartnership.com>,
	<deller@gmx.de>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
	<luto@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <chris@zankel.net>,
	<jcmvbkbc@gmail.com>, <peterz@infradead.org>, <wad@chromium.org>,
	<ruanjinjie@huawei.com>, <thuth@redhat.com>, <mark.rutland@arm.com>,
	<ada.coupriediaz@arm.com>, <kevin.brodsky@arm.com>, <linusw@kernel.org>,
	<yeoreum.yun@arm.com>, <song@kernel.org>, <james.morse@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <liqiang01@kylinos.cn>,
	<pengcan@kylinos.cn>, <ryan.roberts@arm.com>, <yangtiezhu@loongson.cn>,
	<sshegde@linux.ibm.com>, <mchauras@linux.ibm.com>, <austin.kim@lge.com>,
	<jchrist@linux.ibm.com>, <arnd@arndb.de>, <thomas.weissschuh@linutronix.de>,
	<sohil.mehta@intel.com>, <andrew.cooper3@citrix.com>, <jgross@suse.com>,
	<kas@kernel.org>, <x86@kernel.org>, <linux-alpha@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-csky@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-um@lists.infradead.org>
Subject: [PATCH v16 15/18] arm64: ptrace: Skip syscall exit reporting for PTRACE_SYSEMU_SINGLESTEP
Date: Mon, 29 Jun 2026 21:06:13 +0800
Message-ID: <20260629130616.642022-16-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629130616.642022-1-ruanjinjie@huawei.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Align the syscall exit reporting logic with the generic entry
framework by skipping the exit stop when PTRACE_SYSEMU_SINGLESTEP is
in effect.

[Rationale]
When a tracer uses PTRACE_SYSEMU_SINGLESTEP, both _TIF_SYSCALL_EMU
and _TIF_SINGLESTEP flags are set. Currently, arm64 reports a syscall
exit stop whenever _TIF_SINGLESTEP is set, regardless of the
emulation state.

However, as per the generic entry implementation (see
include/linux/entry-common.h):
"If SYSCALL_EMU is set, then the only reason to report is when SINGLESTEP
is set (i.e. PTRACE_SYSEMU_SINGLESTEP). This syscall instruction has been
already reported in syscall_trace_enter()."

Since PTRACE_SYSEMU intercepts and skips the actual syscall
execution, reporting a subsequent exit stop is redundant and
inconsistent with the expected behavior of emulated system calls.

[Changes]
- Introduce report_single_step(): Add a helper to encapsulate the
  logic for deciding whether to report a single-step stop at syscall
  exit. It returns false if _TIF_SYSCALL_EMU is set, ensuring the
  emulated syscall does not trigger a duplicate report.

- Update syscall_exit_work(): Use the new helper to determine
  the stepping state instead of directly checking _TIF_SINGLESTEP.

[Impact]
- PTRACE_SINGLESTEP: Continues to report exit stops for actual
  instructions.

- PTRACE_SYSEMU: Continues to skip exit stops.

- PTRACE_SYSEMU_SINGLESTEP: Now correctly skips the redundant exit
  stop, aligning arm64 with the generic entry infrastructure.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/kernel/ptrace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 05ceb9f2d038..650db9b47373 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2452,14 +2452,25 @@ int syscall_trace_enter(struct pt_regs *regs, unsigned long flags)
 	return syscall;
 }
 
+static inline bool report_single_step(unsigned long flags)
+{
+	if (flags & _TIF_SYSCALL_EMU)
+		return false;
+
+	return flags & _TIF_SINGLESTEP;
+}
+
 void syscall_exit_work(struct pt_regs *regs, unsigned long flags)
 {
+	bool step;
+
 	audit_syscall_exit(regs);
 
 	if (flags & _TIF_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
-	if (flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP))
+	step = report_single_step(flags);
+	if (step || flags & _TIF_SYSCALL_TRACE)
 		report_syscall_exit(regs);
 }
 
-- 
2.34.1


