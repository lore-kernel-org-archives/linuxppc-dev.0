Return-Path: <SRS0=/OnI=RO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F819C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 18:36:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3EE20657
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Mar 2019 18:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3EE20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44J6Hk5SgszDqCx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 05:36:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=sudeep.holla@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44J6Fj1dL7zDqGN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 05:34:16 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD7E8374;
 Mon, 11 Mar 2019 11:34:12 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6A9F3F614;
 Mon, 11 Mar 2019 11:34:09 -0700 (PDT)
Date: Mon, 11 Mar 2019 18:34:03 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Message-ID: <20190311183403.GA31062@e107155-lin>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
 <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com>
 <20190304101205.GA1504@e107155-lin>
 <96d59a68-e5e2-86d9-c707-a79aad438b76@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96d59a68-e5e2-86d9-c707-a79aad438b76@arm.com>
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
Cc: Steve Capper <Steve.Capper@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "jdike@addtoit.com" <jdike@addtoit.com>, "x86@kernel.org" <x86@kernel.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Richard Weinberger <richard@nod.at>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Bin Lu \(Arm Technology China\)" <Bin.Lu@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

(I thought I had sent this email, last Tuesday itself, but saw this in my
draft today, something went wrong, sorry for the delay)

On Tue, Mar 05, 2019 at 02:14:47AM +0000, Haibo Xu (Arm Technology China) wrote:
> On 2019/3/4 18:12, Sudeep Holla wrote:
> > On Mon, Mar 04, 2019 at 08:25:28AM +0000, Haibo Xu (Arm Technology China) wrote:
> >> On 2019/3/1 2:32, Sudeep Holla wrote:
> >>> Now that we have a new hook ptrace_syscall_enter that can be called from
> >>> syscall entry code and it handles PTRACE_SYSEMU in generic code, we
> >>> can do some cleanup using the same in syscall_trace_enter.
> >>>
> >>> Further the extra logic to find single stepping PTRACE_SYSEMU_SINGLESTEP
> >>> in syscall_slow_exit_work seems unnecessary. Let's remove the same.
> >>
> >> I think we should not change the logic here. Is so, it will double the report of syscall
> >> when PTRACE_SYSEMU_SINGLESTEP is enabled.
> >>
> >
> > I don't think that should happen, but I may be missing something.
> > Can you explain how ?
> >
>
> When PTRACE_SYSEMU_SINGLESTEP is enabled, both the _TIF_SYSCALL_EMU and
> _TIF_SINGLESTEP flags are set, but ptrace only need to report(send SIGTRAP)
> at the entry of a system call, no need to report at the exit of a system
> call.
>
Sorry, but I still not get it, we have:

	step = ((flags & (_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)) == _TIF_SINGLESTEP);

For me, this is same as:
	step = ((flags & _TIF_SINGLESTEP) == _TIF_SINGLESTEP)
	or
	if (flags & _TIF_SINGLESTEP)
		step = true;

So when PTRACE_SYSEMU_SINGLESTEP, _TIF_SYSCALL_EMU and _TIF_SINGLESTEP
are set and step evaluates to true.

So dropping _TIF_SYSCALL_EMU here should be fine. Am I still missing
something ?

--
Regards,
Sudeep
