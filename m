Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B546C10F00
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 14:57:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F6F20872
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 14:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F6F20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NK6D3gsPzDqJB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 01:57:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=sudeep.holla@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44NK474dj3zDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 01:55:34 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E6301650;
 Mon, 18 Mar 2019 07:55:32 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3873D3F59C;
 Mon, 18 Mar 2019 07:55:29 -0700 (PDT)
Date: Mon, 18 Mar 2019 14:55:23 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v2 2/6] ptrace: introduce ptrace_syscall_enter to
 consolidate PTRACE_SYSEMU handling
Message-ID: <20190318145523.GA18196@e107155-lin>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-3-sudeep.holla@arm.com>
 <20190318143147.GB27941@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318143147.GB27941@altlinux.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 Catalin Marinas <catalin.marinas@arm.com>, jdike@addtoit.com, x86@kernel.org,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 Oleg Nesterov <oleg@redhat.com>, Richard Weinberger <richard@nod.at>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Bin Lu <bin.lu@arm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 18, 2019 at 05:31:47PM +0300, Dmitry V. Levin wrote:
> On Mon, Mar 18, 2019 at 10:49:21AM +0000, Sudeep Holla wrote:
> > Currently each architecture handles PTRACE_SYSEMU in very similar way.
> > It's completely arch independent and can be handled in the code helping
> > to consolidate PTRACE_SYSEMU handling.
> > 
> > Let's introduce a hook 'ptrace_syscall_enter' that arch specific syscall
> > entry code can call.
> > 
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  include/linux/ptrace.h |  1 +
> >  kernel/ptrace.c        | 22 ++++++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
> > index edb9b040c94c..e30f51e3363e 100644
> > --- a/include/linux/ptrace.h
> > +++ b/include/linux/ptrace.h
> > @@ -407,6 +407,7 @@ static inline void user_single_step_report(struct pt_regs *regs)
> >  #define current_user_stack_pointer() user_stack_pointer(current_pt_regs())
> >  #endif
> >  
> > +extern long ptrace_syscall_enter(struct pt_regs *regs);
> >  extern int task_current_syscall(struct task_struct *target, long *callno,
> >  				unsigned long args[6], unsigned int maxargs,
> >  				unsigned long *sp, unsigned long *pc);
> > diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> > index 4fa3b7f4c3c7..c9c505c483df 100644
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/hw_breakpoint.h>
> >  #include <linux/cn_proc.h>
> >  #include <linux/compat.h>
> > +#include <linux/tracehook.h>
> >  
> >  /*
> >   * Access another process' address space via ptrace.
> > @@ -557,6 +558,27 @@ static int ptrace_detach(struct task_struct *child, unsigned int data)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Hook to check and report for PTRACE_SYSEMU, can be called from arch
> > + * arch syscall entry code
> > + */
> > +long ptrace_syscall_enter(struct pt_regs *regs)
> > +{
> > +#ifdef TIF_SYSCALL_EMU
> > +	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> > +		if (tracehook_report_syscall_entry(regs))
> > +			/*
> > +			 * We can ignore the return code here as we need
> > +			 * return -1 always for syscall emulation irrespective
> > +			 * of whether the tracehook report fails or succeed.
> > +			 */
> > +			;
> 
> This is problematic as it causes build errors with -Werror=empty-body,
> see https://lore.kernel.org/lkml/20181218205305.26647-1-malat@debian.org/
> 

Thanks for the pointer, will update.

--
Regards,
Sudeep
