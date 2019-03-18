Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28DBC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 10:51:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA9852082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 10:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA9852082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NCff2txpzDqNw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 21:51:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=sudeep.holla@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44NCcM5kqbzDq9n
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 21:49:38 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84F9980D;
 Mon, 18 Mar 2019 03:49:35 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8FC6F3F614;
 Mon, 18 Mar 2019 03:49:32 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/6] ptrace: consolidate PTRACE_SYSEMU handling and add
 support for arm64
Date: Mon, 18 Mar 2019 10:49:19 +0000
Message-Id: <20190318104925.16600-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Haibo Xu <haibo.xu@arm.com>, Steve Capper <Steve.Capper@arm.com>,
 jdike@addtoit.com, Sudeep Holla <sudeep.holla@arm.com>,
 Will Deacon <will.deacon@arm.com>, Oleg Nesterov <oleg@redhat.com>,
 Bin Lu <bin.lu@arm.com>, Richard Weinberger <richard@nod.at>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

This patchset evolved from the discussion in the thread[0][1]. When we
wanted to add PTRACE_SYSEMU support to ARM64, we thought instead of
duplicating what other architectures like x86 and powerpc have done,
let consolidate the existing support and move it to the core as there's
nothing arch specific in it.

v1->v2:
	- added comment for empty statement after tracehook_report_syscall_entry
	- dropped x86 change in syscall_slow_exit_work as I had ended
	  up changing logic unintentionally
	- removed spurious change in powerpc moving user_exit()

Regards,
Sudeep

[0] https://patchwork.kernel.org/patch/10585505/
[1] https://patchwork.kernel.org/patch/10675237/


Sudeep Holla (6):
  ptrace: move clearing of TIF_SYSCALL_EMU flag to core
  ptrace: introduce ptrace_syscall_enter to consolidate PTRACE_SYSEMU handling
  x86: clean up _TIF_SYSCALL_EMU handling using ptrace_syscall_enter hook
  powerpc: use common ptrace_syscall_enter hook to handle _TIF_SYSCALL_EMU
  arm64: add PTRACE_SYSEMU{,SINGLESTEP} definations to uapi headers
  arm64: ptrace: add support for syscall emulation

 arch/arm64/include/asm/thread_info.h |  5 ++-
 arch/arm64/include/uapi/asm/ptrace.h |  3 ++
 arch/arm64/kernel/ptrace.c           |  3 ++
 arch/powerpc/kernel/ptrace.c         | 49 ++++++++++++----------------
 arch/x86/entry/common.c              | 12 ++-----
 arch/x86/kernel/ptrace.c             |  3 --
 include/linux/ptrace.h               |  1 +
 kernel/ptrace.c                      | 26 +++++++++++++++
 8 files changed, 61 insertions(+), 41 deletions(-)

--
2.17.1

