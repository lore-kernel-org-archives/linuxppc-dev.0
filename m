Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C26FC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 12:29:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D8A2070B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 12:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D8A2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CfVF0ycMzDqDh
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 23:29:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=sudeep.holla@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44CfRc2wRXzDqGY
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 23:27:22 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 436BDA78;
 Mon,  4 Mar 2019 04:27:19 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 960DB3F575;
 Mon,  4 Mar 2019 04:27:16 -0800 (PST)
Date: Mon, 4 Mar 2019 12:27:11 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] ptrace: introduce ptrace_syscall_enter to
 consolidate PTRACE_SYSEMU handling
Message-ID: <20190304122711.GA28624@e107155-lin>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-3-sudeep.holla@arm.com>
 <f3441e63-c54d-3b9d-2919-8a3955cbee69@arm.com>
 <20190304104643.GA28643@e107155-lin>
 <20190304122331.GG3969@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304122331.GG3969@gate.crashing.org>
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
Cc: "Haibo Xu \(Arm Technology China\)" <Haibo.Xu@arm.com>,
 Steve Capper <Steve.Capper@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>,
 "jdike@addtoit.com" <jdike@addtoit.com>, "x86@kernel.org" <x86@kernel.org>,
 Will Deacon <Will.Deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Richard Weinberger <richard@nod.at>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Bin Lu \(Arm Technology China\)" <Bin.Lu@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 04, 2019 at 06:23:32AM -0600, Segher Boessenkool wrote:
> On Mon, Mar 04, 2019 at 10:46:43AM +0000, Sudeep Holla wrote:
> > On Mon, Mar 04, 2019 at 08:03:47AM +0000, Haibo Xu (Arm Technology China) wrote:
> > > On 2019/3/1 2:32, Sudeep Holla wrote:
> > > > +long ptrace_syscall_enter(struct pt_regs *regs)
> > > > +{
> > > > +#ifdef TIF_SYSCALL_EMU
> > > > +	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> > > > +		if (tracehook_report_syscall_entry(regs));
> > >
> > > Shall we remove the semi-colon at end of the above line?
> >
> > Added intentionally to keep GCC happy.
>
> GCC warns because the user explicitly asked for it, with __must_check.
> If you want to do things with an "if" like this, you should write e.g.
>
> 		if (tracehook_report_syscall_entry(regs))
> 			/*
> 			 * We can ignore the return code here, because of
> 			 * X and Y and Z.
> 			 */
> 			;
>
> Or it probably is nicer to use a block:
>
> 		if (tracehook_report_syscall_entry(regs)) {
> 			/*
> 			 * We can ignore the return code here, because of
> 			 * X and Y and Z.
> 			 */
> 		}
>
> The point is, you *always* should have a nice fat comment if you are
> ignoring the return code of a __must_check function.
>

Agreed, will add the comment.

--
Regards,
Sudeep
