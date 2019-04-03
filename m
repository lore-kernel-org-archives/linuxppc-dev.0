Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9BAC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 16:52:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A626F206DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 16:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A626F206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ZBvZ3N5YzDqJL
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Apr 2019 03:52:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=will.deacon@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 44ZBsr3gSTzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2019 03:50:55 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9501EBD;
 Wed,  3 Apr 2019 09:50:52 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.72.51.249])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7B9E3F68F;
 Wed,  3 Apr 2019 09:50:49 -0700 (PDT)
Date: Wed, 3 Apr 2019 17:50:42 +0100
From: Will Deacon <will.deacon@arm.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 4/6] powerpc: use common ptrace_syscall_enter hook to
 handle _TIF_SYSCALL_EMU
Message-ID: <20190403165042.GB17500@fuggles.cambridge.arm.com>
References: <20190318104925.16600-1-sudeep.holla@arm.com>
 <20190318104925.16600-5-sudeep.holla@arm.com>
 <20190318172024.GB23521@redhat.com>
 <20190318172457.GD18196@e107155-lin>
 <20190318173341.GD23521@redhat.com>
 <20190318174028.GE18196@e107155-lin>
 <20190319170804.GA11525@redhat.com>
 <20190319173233.GB11525@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319173233.GB11525@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
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
 linux-kernel@vger.kernel.org, Bin Lu <bin.lu@arm.com>,
 Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Oleg,

On Tue, Mar 19, 2019 at 06:32:33PM +0100, Oleg Nesterov wrote:
> On 03/19, Oleg Nesterov wrote:
> >
> > Well, personally I see no point... Again, after the trivial simplification
> > x86 does
> >
> > 	if (work & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
> > 		ret = tracehook_report_syscall_entry(regs);
> > 		if (ret || (work & _TIF_SYSCALL_EMU))
> > 			return -1L;
> > 	}
> >
> > this looks simple enough for copy-and-paste.
> >
> > > If there's a better way to achieve the same
> >
> > I can only say that if we add a common helper, I think it should absorb
> > tracehook_report_syscall_entry() and handle both TIF's just like the code
> > above does. Not sure this makes any sense.
> 
> this won't work, looking at 6/6 I see that arm64 needs to distinguish
> _TRACE and _EMU ... I don't understand this code, but it looks suspicious.
> If tracehook_report_syscall_entry() returns nonzero the tracee was killed,
> syscall_trace_enter() should just return.
> 
> To me this is another indication that consolidation makes no sense ;)

The reason I'm pushing for consolidation here is because I think it's the
only sane way to maintain the tracing and debug hooks on the syscall
entry/exit paths. Having to look at all the different arch implementations
and distil the portable semantics is a nightmare and encourages gradual
divergence over time. Given that we don't support this SYSCALL_EMU stuff
on arm64 today, we have the opportunity to make this generic and allow other
architectures (e.g. riscv) to hook in the same way that we do. It clearly
shouldn't affect the behaviour of existing architectures which already
support the functionality.

However, I also agree that this patch series looks dodgy as it stands -- we
shouldn't have code paths that can result in calling
tracehook_report_syscall_entry() twice.

Will
