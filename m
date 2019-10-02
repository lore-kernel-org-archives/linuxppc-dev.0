Return-Path: <SRS0=frIq=X3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1C7C35280
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Oct 2019 08:22:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C4C321783
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Oct 2019 08:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4C321783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46jpzV4kyvzDqFD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Oct 2019 18:22:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.de
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46jpxF63wGzDqWR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Oct 2019 18:20:48 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BA8F9AE3A;
 Wed,  2 Oct 2019 08:20:43 +0000 (UTC)
Date: Wed, 2 Oct 2019 10:20:42 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 00/27] current interrupt series plus scv syscall
Message-ID: <20190924093302.GF18205@kitsune.suse.cz>
References: <20190915012813.29317-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190915012813.29317-1-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Tulio Magno Quites Machado Filho <tuliom@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

can you mark the individual patches with RFC rather than the wole
series?

Thanks

Michal

On Sun, Sep 15, 2019 at 11:27:46AM +1000, Nicholas Piggin wrote:
> My interrupt entry patches have finally collided with syscall and
> interrupt exit patches, so I'll merge the series. Most patches have
> been seen already, however there have been a number of small changes
> and fixes throughout the series.
> 
> The final two patches add support for 'scv' and 'rfscv' instructions.
> 
> I'm posting this out now so we can start considering ABI and userspace
> support. We have the PPC_FEATURE2_SCV hwcap for this.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (27):
>   powerpc/64s/exception: Introduce INT_DEFINE parameter block for code
>     generation
>   powerpc/64s/exception: Add GEN_COMMON macro that uses INT_DEFINE
>     parameters
>   powerpc/64s/exception: Add GEN_KVM macro that uses INT_DEFINE
>     parameters
>   powerpc/64s/exception: Expand EXC_COMMON and EXC_COMMON_ASYNC macros
>   powerpc/64s/exception: Move all interrupt handlers to new style code
>     gen macros
>   powerpc/64s/exception: Remove old INT_ENTRY macro
>   powerpc/64s/exception: Remove old INT_COMMON macro
>   powerpc/64s/exception: Remove old INT_KVM_HANDLER
>   powerpc/64s/exception: Add ISIDE option
>   powerpc/64s/exception: move real->virt switch into the common handler
>   powerpc/64s/exception: move soft-mask test to common code
>   powerpc/64s/exception: move KVM test to common code
>   powerpc/64s/exception: remove confusing IEARLY option
>   powerpc/64s/exception: remove the SPR saving patch code macros
>   powerpc/64s/exception: trim unused arguments from KVMTEST macro
>   powerpc/64s/exception: hdecrementer avoid touching the stack
>   powerpc/64s/exception: re-inline some handlers
>   powerpc/64s/exception: Clean up SRR specifiers
>   powerpc/64s/exception: add more comments for interrupt handlers
>   powerpc/64s/exception: only test KVM in SRR interrupts when PR KVM is
>     supported
>   powerpc/64s/exception: soft nmi interrupt should not use
>     ret_from_except
>   powerpc/64: system call remove non-volatile GPR save optimisation
>   powerpc/64: system call implement the bulk of the logic in C
>   powerpc/64s: interrupt return in C
>   powerpc/64s/exception: remove lite interrupt return
>   powerpc/64s/exception: treat NIA below __end_interrupts as soft-masked
>   powerpc/64s: system call support for scv/rfscv instructions
> 
>  arch/powerpc/include/asm/asm-prototypes.h     |   11 -
>  .../powerpc/include/asm/book3s/64/kup-radix.h |   24 +-
>  arch/powerpc/include/asm/cputime.h            |   24 +
>  arch/powerpc/include/asm/exception-64s.h      |    4 -
>  arch/powerpc/include/asm/head-64.h            |    2 +-
>  arch/powerpc/include/asm/hw_irq.h             |    4 +
>  arch/powerpc/include/asm/ppc_asm.h            |    2 +
>  arch/powerpc/include/asm/processor.h          |    2 +-
>  arch/powerpc/include/asm/ptrace.h             |    3 +
>  arch/powerpc/include/asm/signal.h             |    3 +
>  arch/powerpc/include/asm/switch_to.h          |   11 +
>  arch/powerpc/include/asm/time.h               |    4 +-
>  arch/powerpc/kernel/Makefile                  |    3 +-
>  arch/powerpc/kernel/cpu_setup_power.S         |    2 +-
>  arch/powerpc/kernel/dt_cpu_ftrs.c             |    1 +
>  arch/powerpc/kernel/entry_64.S                |  964 ++------
>  arch/powerpc/kernel/exceptions-64e.S          |  254 +-
>  arch/powerpc/kernel/exceptions-64s.S          | 2046 ++++++++++++-----
>  arch/powerpc/kernel/process.c                 |    2 +
>  arch/powerpc/kernel/signal.h                  |    2 -
>  arch/powerpc/kernel/syscall_64.c              |  422 ++++
>  arch/powerpc/kernel/syscalls/syscall.tbl      |   22 +-
>  arch/powerpc/kernel/systbl.S                  |    9 +-
>  arch/powerpc/kernel/time.c                    |    9 -
>  arch/powerpc/kernel/vector.S                  |    2 +-
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S       |   11 -
>  arch/powerpc/kvm/book3s_segment.S             |    7 -
>  27 files changed, 2458 insertions(+), 1392 deletions(-)
>  create mode 100644 arch/powerpc/kernel/syscall_64.c
> 
> -- 
> 2.23.0
> 
