Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537FAC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 12:27:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CBA82070B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 12:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CBA82070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CfS433XLzDq5x
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 23:27:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CfN74CPqzDqDS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 23:24:22 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x24CNZlQ031671;
 Mon, 4 Mar 2019 06:23:35 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x24CNWqJ031670;
 Mon, 4 Mar 2019 06:23:32 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 4 Mar 2019 06:23:32 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/6] ptrace: introduce ptrace_syscall_enter to consolidate
 PTRACE_SYSEMU handling
Message-ID: <20190304122331.GG3969@gate.crashing.org>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-3-sudeep.holla@arm.com>
 <f3441e63-c54d-3b9d-2919-8a3955cbee69@arm.com>
 <20190304104643.GA28643@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304104643.GA28643@e107155-lin>
User-Agent: Mutt/1.4.2.3i
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

On Mon, Mar 04, 2019 at 10:46:43AM +0000, Sudeep Holla wrote:
> On Mon, Mar 04, 2019 at 08:03:47AM +0000, Haibo Xu (Arm Technology China) wrote:
> > On 2019/3/1 2:32, Sudeep Holla wrote:
> > > +long ptrace_syscall_enter(struct pt_regs *regs)
> > > +{
> > > +#ifdef TIF_SYSCALL_EMU
> > > +	if (test_thread_flag(TIF_SYSCALL_EMU)) {
> > > +		if (tracehook_report_syscall_entry(regs));
> > 
> > Shall we remove the semi-colon at end of the above line?
> 
> Added intentionally to keep GCC happy.

GCC warns because the user explicitly asked for it, with __must_check.
If you want to do things with an "if" like this, you should write e.g.

		if (tracehook_report_syscall_entry(regs))
			/*
			 * We can ignore the return code here, because of
			 * X and Y and Z.
			 */
			;

Or it probably is nicer to use a block:

		if (tracehook_report_syscall_entry(regs)) {
			/*
			 * We can ignore the return code here, because of
			 * X and Y and Z.
			 */
		}

The point is, you *always* should have a nice fat comment if you are
ignoring the return code of a __must_check function.


Segher
