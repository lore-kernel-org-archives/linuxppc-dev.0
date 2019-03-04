Return-Path: <SRS0=bgOd=RH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B94BC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:09:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BC820835
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 10:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BC820835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CbNk4tYyzDqGl
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 21:09:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=sudeep.holla@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44CbLv067mzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 21:08:05 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71338EBD;
 Mon,  4 Mar 2019 02:08:02 -0800 (PST)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A4103F703;
 Mon,  4 Mar 2019 02:07:59 -0800 (PST)
Date: Mon, 4 Mar 2019 10:07:56 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
Message-ID: <20190304100756.GB32379@e107155-lin>
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
 <CALCETrVOJV0uBX3CbpmuwSGQa98Fabq3-GoRbGMb79m_OoJkmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVOJV0uBX3CbpmuwSGQa98Fabq3-GoRbGMb79m_OoJkmQ@mail.gmail.com>
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
 Catalin Marinas <catalin.marinas@arm.com>, Jeff Dike <jdike@addtoit.com>,
 X86 ML <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Bin Lu <bin.lu@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 02, 2019 at 05:11:40PM -0800, Andy Lutomirski wrote:
> On Thu, Feb 28, 2019 at 10:32 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > Now that we have a new hook ptrace_syscall_enter that can be called from
> > syscall entry code and it handles PTRACE_SYSEMU in generic code, we
> > can do some cleanup using the same in syscall_trace_enter.
> >
> > Further the extra logic to find single stepping PTRACE_SYSEMU_SINGLESTEP
> > in syscall_slow_exit_work seems unnecessary. Let's remove the same.
>
> I wasn't cc'd on the whole series, so I can't easily review this.  Do
> you have a test case to make sure that emulation still works?  Are
> there adequate tests in tools/testing/selftests/x86?  Do they still
> pass after this patch?
>

I will ensure you are cc-ed on the whole threads, sorry for missing.
I remember seeing some selftests, but I haven't run them yet.

--
Regards,
Sudeep
