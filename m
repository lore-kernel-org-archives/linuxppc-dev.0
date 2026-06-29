Return-Path: <linuxppc-dev+bounces-23096-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B38FC43602
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 13:06:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpmky5xp7z2yT0;
	Mon, 29 Jun 2026 23:06:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782738410;
	cv=none; b=HqYu5QdP/gKk6klnEdagXvxAkUiE2o7IEk1trTLswvb/6vnkaRD23mBi0eAIhALYmpb1yWPcDiKYZgvyja1ylznn/XprSJTMK/Iu1U0F6t36sUy/iKVGMQapQMayDSZSkCV8nxV/8nNKzmix4mQMhayV35Q2OufndmBIwe4lMcMNFkSrxcnabf1RCASzB+G0eIKnQaDowHVnDxWIDNko7f27KunuTW0o0a68vwpmMEL17h3u1laGbU1v8r9eFVwc+CtwFmA3y5YfGSaBuA7JGykdUUh9ZH6VqzN6fUdqe79xAiO1hre5N+63TTpIQuL3Gcle+h1SkJyBmKzfgBqn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782738410; c=relaxed/relaxed;
	bh=oqt98KNiCfytd9je3A0RWaDEub1SoEsJvKXmHYAhpA0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jdULfd9JutjWxLp0ya5KA4UMw4n3ooPJd5GryyCRiCclFhVZ+54VoYZWTi+TcsxZIogyFQKojKplUZFgjkGQsxrMuOJGBlk8LVIR1q3WcrvGUBqG8notgksV6qpB8LtHoF2Lp/nJPAxp8FXYwdLZ45wOyj+O+Bx5Knum6ydHNJckd8l2WmuafL23DyEkP5AD8G+cTuhoyDDwnBqJr+34hvQGdBO7TctE3H0qfeCzsgEu53POHBMDvw3aNQfbHUjxuPt3yXNZBxl27H1Zp9uGlMhItBtapzekwei/MdPn3yPbS4bu63qEeP+4XT1Zi074UwahUJeAdNpI07y1bBUGXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ggJG6jKI; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ggJG6jKI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=ruanjinjie@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpmkv42Dfz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 23:06:44 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=oqt98KNiCfytd9je3A0RWaDEub1SoEsJvKXmHYAhpA0=;
	b=ggJG6jKIceMr3g60Z1K5gohGiSNMQdcy54004MjW9vQDl4Z3N88jP9qlz2LyqYwtKjt2Ro2Ql
	dcS+ZZElKSN+dQa6pVya75IHqaTPhjRhLpAzzwdE7tX8hwohhA97kSbBzrXBXKbFMyW3jMU6zI0
	YF/YokD8vYpNatFoteOUTNw=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gpmXc04PFzcbRd;
	Mon, 29 Jun 2026 20:57:51 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id EC0DF40579;
	Mon, 29 Jun 2026 21:06:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 21:06:34 +0800
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
Subject: [PATCH v16 00/18] arm64: entry: Convert to Generic Entry
Date: Mon, 29 Jun 2026 21:05:58 +0800
Message-ID: <20260629130616.642022-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)

This is the 16th iteration of the patch series. I would like to express
my sincere gratitude to everyone who has contributed to the reviews
and testing across the previous versions, which helped significantly
refine this work.

Currently, architectures such as x86, Riscv, Loongarch use the Generic
Entry, which significantly eases maintenance burden and improves
code elegance. Given that arm64 has already successfully adopted
the Generic IRQ Entry in commit b3cf07851b6c ("arm64: entry: Switch to
generic IRQ entry"), it is now the right time to completely convert arm64
to the Generic Entry infrastructure.

The objective of this series is to bring arm64 in line with other major
architectures, reducing duplicated boilerplate code and simplifying the
sharing of future improvements in entry/exit paths, such as "Syscall User
Dispatch" and "rseq time slice extension" optimizations.

This patch set is rebased on v7.2-rc1. It contains the foundational
updates required for arm64. Following the suggestion from Linus Walleij,
these patches are being submitted separately for inclusion via
the arm64 tree.

Performance benchmarks were conducted on a "Kunpeng HIP09" platform with
kernel auditing enabled. The results are detailed below:

1. perf bench syscall usec/op (-ve is improvement)

        | Syscall | Base        | Generic Entry | change % |
        | ------- | ----------- | ------------- | -------- |
        | basic   | 0.223       | 0.218         | -2.25    |
        | execve  | 799.564     | 787.849       | -1.47    |
        | fork    | 1088.503    | 1096.920      | +0.77    |
        | getpgid | 0.218       |  0.122        | -0.47    |

2. perf bench syscall ops/sec (+ve is improvement)

        | Syscall | Base     | Generic Entry| change % |
        | ------- | -------- | ------------ | -------- |
        | basic   | 4475386  | 4578820      | +2.31    |
        | execve  | 1250     | 1269         | +1.54    |
        | fork    | 918      | 911          | -0.74    |
        | getpgid | 4587781  | 4607488      | +0.43    |

Overall, the syscall performance remains largely neutral, with minor
variations ranging from a 0.8% regression to a 2.3% improvement, which
is within normal measurement tolerance.

Tested successfully on "Kunpeng HIP09" using the following test cases:
 - stress-ng: CPU, Virtual Memory, Syscall, and Interrupt stress tests.
 - hackbench: Evaluated in both thread and pipe modes.
 - kselftests (ptrace): get_syscall_info, set_syscall_info, peeksiginfo.
 - kselftests (breakpoints): breakpoint_test_arm64.
 - kselftests (arm64/abi): syscall-abi and ptrace.
 - kselftests (arm64/fp): fp-ptrace, sve-ptrace, and za-ptrace.
 - kselftests (vDSO): vdso_test_getrandom.
 - Ptrace stress test: tracing stress-ng system calls under load.
 - Pseudo-NMI load test using perf.

Changes in v16:
- Rebased on v7.2-rc1.
- Convert __secure_computing() to return boolean as Thomas suggested.
- Introduce a weak vesion for arch_syscall_is_vdso_sigreturn()
  to simplify the code.
- Split out the implementation of arch_syscall_is_vdso_sigreturn()
  into a separate patch to facilitate reviewing.
- Break down the syscall_exit_to_user_mode_work() refactoring into
  5 smaller, bite-sized patches for easier review and justification.
- Update the comment and commit message as Ada suggeted.
- Clarify patch titles and align title prefixes for consistency.
- Collect Reviewed-by and Tesed-by.
- Link to v15: https://lore.kernel.org/all/20260511092103.1974980-1-ruanjinjie@huawei.com/

Changes in v15:
- Rebased on v7.1-rc1 and Mark's fix patch in [1].
- Solve issues Sashiko AI pointed out, "Fix potential syscall truncation
  in syscall_trace_enter()".
- Make syscall_exit_to_user_mode_work() __always_inline to keep
  the fast-path performance as Sashiko pointed out.

Changes in v14:
- Initialize ret = 0 in syscall_trace_enter().
- Split into two patch sets as Linus Walleij suggested, so this patch set
  can be applied separately to the arm64 tree.
- Rebased on arm64 for-next/core branch.
- Collect Reviewed-by and Acked-by.
- Link to v13 resend: https://lore.kernel.org/all/20260317082020.737779-15-ruanjinjie@huawei.com/

Changes in v13 resend:
- Fix exit_to_user_mode_prepare_legacy() issues.
- Also move TIF_SINGLESTEP to generic TIF infrastructure for loongarch.
- Use generic TIF bits for arm64 and moving TIF_SINGLESTEP to
  generic TIF for related architectures separately.
- Refactor syscall_trace_enter/exit() to accept flags and Use
  syscall_get_nr() helper separately.
- Tested with slice_test for rseq optimizations.
- Add acked-by.
- Link to v13: https://lore.kernel.org/all/20260313094738.3985794-1-ruanjinjie@huawei.com/

Changes in v13:
- Rebased on v7.0-rc3, so drop the firt applied arm64 patch.
- Use generic TIF bits to enables RSEQ optimization.
- Update most of the commit message to make it more clear.
- Link to v12: https://lore.kernel.org/all/20260203133728.848283-1-ruanjinjie@huawei.com/

Changes in v12:
- Rebased on "sched/core", so remove the four generic entry patches.
- Move "Expand secure_computing() in place" and
  "Use syscall_get_arguments() helper" patch forward, which will group all
  non-functional cleanups at the front.
- Adjust the explanation for moving rseq_syscall() before
  audit_syscall_exit().
- Link to v11: https://lore.kernel.org/all/20260128031934.3906955-1-ruanjinjie@huawei.com/

Changes in v11:
- Remove unused syscall in syscall_trace_enter().
- Update and provide a detailed explanation of the differences after
  moving rseq_syscall() before audit_syscall_exit().
- Rebased on arm64 (for-next/entry), and remove the first applied 3 patchs.
- syscall_exit_to_user_mode_work() for arch reuse instead of adding
  new syscall_exit_to_user_mode_work_prepare() helper.
- Link to v10: https://lore.kernel.org/all/20251222114737.1334364-1-ruanjinjie@huawei.com/

Changes in v10:
- Rebased on v6.19-rc1, rename syscall_exit_to_user_mode_prepare() to
  syscall_exit_to_user_mode_work_prepare() to avoid conflict.
- Also inline syscall_trace_enter().
- Support aarch64 for sud_benchmark.
- Update and correct the commit message.
- Add Reviewed-by.
- Link to v9: https://lore.kernel.org/all/20251204082123.2792067-1-ruanjinjie@huawei.com/

Changes in v9:
- Move "Return early for ptrace_report_syscall_entry() error" patch ahead
  to make it not introduce a regression.
- Not check _TIF_SECCOMP/SYSCALL_EMU for syscall_exit_work() in
  a separate patch.
- Do not report_syscall_exit() for PTRACE_SYSEMU_SINGLESTEP in a separate
  patch.
- Add two performance patch to improve the arm64 performance.
- Add Reviewed-by.
- Link to v8: https://lore.kernel.org/all/20251126071446.3234218-1-ruanjinjie@huawei.com/

Changes in v8:
- Rename "report_syscall_enter()" to "report_syscall_entry()".
- Add ptrace_save_reg() to avoid duplication.
- Remove unused _TIF_WORK_MASK in a standalone patch.
- Align syscall_trace_enter() return value with the generic version.
- Use "scno" instead of regs->syscallno in el0_svc_common().
- Move rseq_syscall() ahead in a standalone patch to clarify it clearly.
- Rename "syscall_trace_exit()" to "syscall_exit_work()".
- Keep the goto in el0_svc_common().
- No argument was passed to __secure_computing() and check -1 not -1L.
- Remove "Add has_syscall_work() helper" patch.
- Move "Add syscall_exit_to_user_mode_prepare() helper" patch later.
- Add miss header for asm/entry-common.h.
- Update the implementation of arch_syscall_is_vdso_sigreturn().
- Add "ARCH_SYSCALL_WORK_EXIT" to be defined as "SECCOMP | SYSCALL_EMU"
  to keep the behaviour unchanged.
- Add more testcases test.
- Add Reviewed-by.
- Update the commit message.
- Link to v7: https://lore.kernel.org/all/20251117133048.53182-1-ruanjinjie@huawei.com/

Jinjie Ruan (18):
  seccomp: Convert __secure_computing() to return boolean
  syscall_user_dispatch: Introduce a weak fallback for
    arch_syscall_is_vdso_sigreturn()
  arm64: ptrace: Pass thread flags to syscall_trace_enter/exit()
  arm64: ptrace: Use syscall_get_nr() helper for syscall_trace_enter()
  arm64: ptrace: Expand secure_computing() in place
  arm64: ptrace: Use syscall_get_arguments() helper for audit
  arm64: ptrace: Protect rseq_syscall() from tracer PC modifications
  arm64: ptrace: Rename syscall_trace_exit() to syscall_exit_work()
  arm64: syscall: Rework the syscall exit path in el0_svc_common()
  arm64: ptrace: Extract syscall_exit_to_user_mode_work() helper
  arm64: ptrace: Align syscall exit work semantics with generic entry
  arm64: syscall: Use exit-specific flags check in el0_svc_common()
  arm64: syscall: Simplify el0_svc_common() syscall exit path
  arm64: syscall: Simplify syscall exit path in el0_svc_common()
  arm64: ptrace: Skip syscall exit reporting for
    PTRACE_SYSEMU_SINGLESTEP
  arm64: entry: Convert to generic entry
  arm64: Inline el0_svc_common()
  arm64: vdso: Expose sigreturn address on vdso to the kernel

 arch/alpha/kernel/ptrace.c            |   2 +-
 arch/arm/kernel/ptrace.c              |   2 +-
 arch/arm64/Kconfig                    |   2 +-
 arch/arm64/include/asm/elf.h          |   1 +
 arch/arm64/include/asm/entry-common.h |  76 +++++++++++++++++
 arch/arm64/include/asm/syscall.h      |   4 +-
 arch/arm64/include/asm/thread_info.h  |  16 +---
 arch/arm64/kernel/debug-monitors.c    |   8 ++
 arch/arm64/kernel/ptrace.c            | 115 --------------------------
 arch/arm64/kernel/signal.c            |   2 +-
 arch/arm64/kernel/syscall.c           |  30 ++-----
 arch/arm64/kernel/vdso.c              |  16 ++++
 arch/csky/kernel/ptrace.c             |   2 +-
 arch/loongarch/include/asm/syscall.h  |   5 --
 arch/m68k/kernel/ptrace.c             |   2 +-
 arch/mips/kernel/ptrace.c             |   2 +-
 arch/parisc/kernel/ptrace.c           |   2 +-
 arch/powerpc/include/asm/syscall.h    |   5 --
 arch/riscv/include/asm/syscall.h      |   5 --
 arch/s390/include/asm/syscall.h       |   5 --
 arch/sh/kernel/ptrace_32.c            |   2 +-
 arch/um/kernel/skas/syscall.c         |   2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c |   2 +-
 arch/xtensa/kernel/ptrace.c           |   3 +-
 include/linux/entry-common.h          |   7 +-
 include/linux/seccomp.h               |  10 +--
 include/linux/syscall_user_dispatch.h |   1 +
 kernel/entry/syscall_user_dispatch.c  |   5 ++
 kernel/seccomp.c                      |  34 ++++----
 29 files changed, 154 insertions(+), 214 deletions(-)

-- 
2.34.1


