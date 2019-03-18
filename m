Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFACDC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 17:26:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C64420854
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 17:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C64420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NNQc29chzDqL2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 04:26:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=sudeep.holla@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44NNNg3DKSzDqK5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 04:25:06 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37CCA1650;
 Mon, 18 Mar 2019 10:25:03 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 683063F614;
 Mon, 18 Mar 2019 10:25:00 -0700 (PDT)
Date: Mon, 18 Mar 2019 17:24:57 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 4/6] powerpc: use common ptrace_syscall_enter hook to
 handle _TIF_SYSCALL_EMU
Message-ID: <20190318172457.GD18196@e107155-lin>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-5-sudeep.holla@arm.com>
 <20190318172024.GB23521@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318172024.GB23521@redhat.com>
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
 Bin Lu <bin.lu@arm.com>, Richard Weinberger <richard@nod.at>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 18, 2019 at 06:20:24PM +0100, Oleg Nesterov wrote:
> On 03/18, Sudeep Holla wrote:
> >
> > --- a/arch/powerpc/kernel/ptrace.c
> > +++ b/arch/powerpc/kernel/ptrace.c
> > @@ -3278,35 +3278,29 @@ long do_syscall_trace_enter(struct pt_regs *regs)
> >
> >  	user_exit();
> >
> > -	flags = READ_ONCE(current_thread_info()->flags) &
> > -		(_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE);
> > -
> > -	if (flags) {
> > -		int rc = tracehook_report_syscall_entry(regs);
> > +	if (unlikely(ptrace_syscall_enter(regs))) {
> > +		/*
> > +		 * A nonzero return code from tracehook_report_syscall_entry()
> > +		 * tells us to prevent the syscall execution, but we are not
> > +		 * going to execute it anyway.
> > +		 *
> > +		 * Returning -1 will skip the syscall execution. We want to
> > +		 * avoid clobbering any registers, so we don't goto the skip
> > +		 * label below.
> > +		 */
> > +		return -1;
> > +	}
> >
> > -		if (unlikely(flags & _TIF_SYSCALL_EMU)) {
> > -			/*
> > -			 * A nonzero return code from
> > -			 * tracehook_report_syscall_entry() tells us to prevent
> > -			 * the syscall execution, but we are not going to
> > -			 * execute it anyway.
> > -			 *
> > -			 * Returning -1 will skip the syscall execution. We want
> > -			 * to avoid clobbering any registers, so we don't goto
> > -			 * the skip label below.
> > -			 */
> > -			return -1;
> > -		}
> > +	flags = READ_ONCE(current_thread_info()->flags) & _TIF_SYSCALL_TRACE;
>
> Why do we need READ_ONCE() with this change?
>
> And now that we change a single bit "flags" doesn't look like a good name.
>
> Again, to me this patch just makes the code look worse. Honestly, I don't
> think that the new (badly named) ptrace_syscall_enter() hook makes any sense.
>

Worse because we end up reading current_thread_info->flags twice ?

--
Regards,
Sudeep
