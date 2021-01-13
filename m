Return-Path: <SRS0=WgSo=GQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F82C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 07:36:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6975523139
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 07:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6975523139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DFzlC3B6ZzDqyd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Jan 2021 18:36:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533;
 helo=mail-pg1-x533.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ujoDQrIm; dkim-atps=neutral
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DFzg12R7KzDqn4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2021 18:32:25 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id i5so966023pgo.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2021 23:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ijAPLTPTvYFGN/6ZGRqFSkj1E09aF6OaFjRBrNNT9wc=;
 b=ujoDQrImDKlhY7avTQZy55e6g7E9CCMHtHCUbP7nczKsP5deo0a1cPl0qiApMpnITd
 NhAhV5AZnisLzblvKF1+VYmS5M8Vx6Tnwb0NP8aUB9loXF4cuB1HV2BmjaHHB+SUwuyD
 YbpvMeMO5rlwiZLNouo6UlFI2iBJhmnS9HFKmmZrA5nq+KYWKU8LnGZ/wJwwuWWSfBA5
 QGzUZ+VvgG0y6ZkN9Zc2JrNKLASWvb2zzhOJQSxsHCDNWjFL9sk9oa1zgIl2r3ev3Jmf
 9ASz09JHkSAT9MfuKcbuO1SmtDPIO+GTTRDd9D9lh+Z4AnCmOGX1//wEKJou5wvI2IFp
 bj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ijAPLTPTvYFGN/6ZGRqFSkj1E09aF6OaFjRBrNNT9wc=;
 b=Uew8Btu/Red1Ar7KY/tJhMRet6rh0GYtcZF9Fgrh7aNKyVxlqCXihKxgxKq5PVawRu
 4EDJqAqR2dOcUGIpNXDSwRKHnzdpJb7YFVGdaUiMhg9fLCVn8mZXnx17W8Amfr7gSyRk
 p4ISqxs9NnokAgZfiguq0Klob/r+llmZmfGdV0I5TEo5gZ4YAqGnyvkvAQT4vcxzTWtb
 MbYpXwcEtqtJmpqdmM+XE4T6KxqAwrvF1bi96JBptEOncTrtdPAEk+9lHexLclXPp8+g
 FPdZu/wkTSR+ESPKRMC9KY8VyvYAOLP3iXzuNhKlEjApnb6LG1dLDUu/2aDJie0ZYN8J
 oFDg==
X-Gm-Message-State: AOAM532y9BZ0EpkMkB0eGSiEPdfh7GJ8ZfJUQ11r8CIRsPB35blrZDsX
 jskXdpCZNvMfRsneZeqiU5Z2dvrFR+0=
X-Google-Smtp-Source: ABdhPJx8SvD+tjXvuqC9qyHq7v5Lh0Tql62ODDAWuo+PBccxMtxpvMLaP/QYShzCEP9/Lq7usuoUtQ==
X-Received: by 2002:a62:1617:0:b029:1a3:c265:a50c with SMTP id
 23-20020a6216170000b02901a3c265a50cmr824314pfw.77.1610523143461; 
 Tue, 12 Jan 2021 23:32:23 -0800 (PST)
Received: from bobo.ibm.com ([124.170.13.62])
 by smtp.gmail.com with ESMTPSA id m77sm1394264pfd.105.2021.01.12.23.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 23:32:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 00/21] powerpc: interrupt wrappers
Date: Wed, 13 Jan 2021 17:31:54 +1000
Message-Id: <20210113073215.516986-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
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
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds interrupt handler wrapper functions, similar to the
generic / x86 code, and moves several common operations into them
from either asm or open coded in the individual handlers.

Since v1:
- Fixed a couple of compile issues
- Fixed perf weirdness (sometimes NMI, sometimes not)
- Also move irq_enter/exit into wrappers

Since v2:
- Rebased upstream
- Took code in patch 3 from Christophe
- Fixed some compile errors from 0day

Since v3:
- Rebased
- Split Christophe's 32s DABR patch into its own patch
- Fixed missing asm from 32s on patch 3 noticed by Christophe.
- Moved changes around, split out one more patch (patch 9) to make
  changes more logical and atomic.
- Add comments explaining _RAW handlers (SLB, HPTE) interrupts better

Since v4:
- Rebased (on top of scv fallback flush fix)
- Rearranged a few changes into different patches from Christophe,
  e.g., the ___do_page_fault change from patch 2 to 10. I didn't
  do everything (e.g., splitting to update __hash_page to drop the
  msr argument before the bulk of patch 2 seemed like churn without
  much improvement), and also other things like removing the new
  ___do_page_fault variant if we can change hash fault context tracking
  I didn't get time to completely investigate and implement. I think
  this shouldn't be a showstopper though we can make more improvements
  as we go.

Thanks,
Nick

Christophe Leroy (1):
  powerpc/32s: Do DABR match out of handle_page_fault()

Nicholas Piggin (20):
  powerpc/64s: move the last of the page fault handling logic to C
  powerpc: remove arguments from fault handler functions
  powerpc: bad_page_fault, do_break get registers from regs
  powerpc/perf: move perf irq/nmi handling details into traps.c
  powerpc: interrupt handler wrapper functions
  powerpc: add interrupt wrapper entry / exit stub functions
  powerpc: add interrupt_cond_local_irq_enable helper
  powerpc/64: context tracking remove _TIF_NOHZ
  powerpc/64s/hash: improve context tracking of hash faults
  powerpc/64: context tracking move to interrupt wrappers
  powerpc/64: add context tracking to asynchronous interrupts
  powerpc: handle irq_enter/irq_exit in interrupt handler wrappers
  powerpc/64s: move context tracking exit to interrupt exit path
  powerpc/64s: reconcile interrupts in C
  powerpc/64: move account_stolen_time into its own function
  powerpc/64: entry cpu time accounting in C
  powerpc: move NMI entry/exit code into wrapper
  powerpc/64s: move NMI soft-mask handling to C
  powerpc/64s: runlatch interrupt handling in C
  powerpc/64s: power4 nap fixup in C

 arch/powerpc/Kconfig                       |   1 -
 arch/powerpc/include/asm/asm-prototypes.h  |  29 --
 arch/powerpc/include/asm/bug.h             |   7 +-
 arch/powerpc/include/asm/cputime.h         |  15 +
 arch/powerpc/include/asm/debug.h           |   3 +-
 arch/powerpc/include/asm/hw_irq.h          |   9 -
 arch/powerpc/include/asm/interrupt.h       | 418 +++++++++++++++++++++
 arch/powerpc/include/asm/ppc_asm.h         |  24 --
 arch/powerpc/include/asm/processor.h       |   1 +
 arch/powerpc/include/asm/thread_info.h     |  10 +-
 arch/powerpc/include/asm/time.h            |   2 +
 arch/powerpc/kernel/dbell.c                |  15 +-
 arch/powerpc/kernel/entry_32.S             |  24 +-
 arch/powerpc/kernel/exceptions-64e.S       |   6 +-
 arch/powerpc/kernel/exceptions-64s.S       | 307 ++-------------
 arch/powerpc/kernel/head_40x.S             |  10 +-
 arch/powerpc/kernel/head_8xx.S             |  11 +-
 arch/powerpc/kernel/head_book3s_32.S       |  14 +-
 arch/powerpc/kernel/head_booke.h           |   4 +-
 arch/powerpc/kernel/idle_book3s.S          |   4 +
 arch/powerpc/kernel/irq.c                  |   7 +-
 arch/powerpc/kernel/mce.c                  |  16 +-
 arch/powerpc/kernel/process.c              |   7 +-
 arch/powerpc/kernel/ptrace/ptrace.c        |   4 -
 arch/powerpc/kernel/signal.c               |   4 -
 arch/powerpc/kernel/syscall_64.c           |  30 +-
 arch/powerpc/kernel/tau_6xx.c              |   5 +-
 arch/powerpc/kernel/time.c                 |   7 +-
 arch/powerpc/kernel/traps.c                | 231 ++++++------
 arch/powerpc/kernel/watchdog.c             |  15 +-
 arch/powerpc/kvm/book3s_hv.c               |   1 +
 arch/powerpc/kvm/book3s_hv_builtin.c       |   1 +
 arch/powerpc/kvm/booke.c                   |   1 +
 arch/powerpc/mm/book3s64/hash_utils.c      |  92 +++--
 arch/powerpc/mm/book3s64/slb.c             |  36 +-
 arch/powerpc/mm/fault.c                    |  92 +++--
 arch/powerpc/perf/core-book3s.c            |  35 +-
 arch/powerpc/perf/core-fsl-emb.c           |  25 --
 arch/powerpc/platforms/8xx/machine_check.c |   2 +-
 arch/powerpc/platforms/powernv/idle.c      |   1 +
 40 files changed, 813 insertions(+), 713 deletions(-)
 create mode 100644 arch/powerpc/include/asm/interrupt.h

-- 
2.23.0

