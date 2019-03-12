Return-Path: <SRS0=8MIQ=RP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E40C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 03:06:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087CB2087C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 03:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhLPLge7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087CB2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JKcm6pbBzDqHq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Mar 2019 14:06:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="qhLPLge7"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JKZx1NTCzDqDY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 14:04:56 +1100 (AEDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0F0732183E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Mar 2019 03:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1552359894;
 bh=TJ+Rb5mqWxqCRiRg4al+kBb8fJTf3b0F/zjChCx8u4w=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qhLPLge7AiIhlT2T1XQN1NLoFI+glVf7ql/5U+UGd/7jja453wuyn+uxmVos2cCdL
 jTFjFoH6rdzwu2lxCS8JNDt6igwllhNFenz0OIc64CgH6NjlK4TzV+BtnAJReVW1xu
 VSzsCrCDU0bEU3nROAdhcw/shiELLm55apWtDDJA=
Received: by mail-wr1-f48.google.com with SMTP id o9so981764wrv.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Mar 2019 20:04:53 -0700 (PDT)
X-Gm-Message-State: APjAAAU5jfXogNGQdTYbMPhCir8NX71E+eu0yh+0K3h+1M67+j1qAnQX
 TJboebuUCMu6hpH9ubkCe1HnnP611HDuTYgWoZUBEw==
X-Google-Smtp-Source: APXvYqyPI4aXMLrCNqmVrAn74b7qe8Wt8qYFSCiTLfmHs0/t5pZUN3WHt5YNwapSR+6VuxnbG+W0XcBvhmkTBkMwVwU=
X-Received: by 2002:adf:e54b:: with SMTP id z11mr12966624wrm.330.1552359892352; 
 Mon, 11 Mar 2019 20:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
 <eb9ef619-4af8-71e1-5aee-0b6294ac488b@arm.com>
 <20190304101205.GA1504@e107155-lin>
 <96d59a68-e5e2-86d9-c707-a79aad438b76@arm.com>
 <20190311183403.GA31062@e107155-lin>
 <65b00ea1-f784-4fb4-2a98-49fa44d9fa8f@arm.com>
In-Reply-To: <65b00ea1-f784-4fb4-2a98-49fa44d9fa8f@arm.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Mon, 11 Mar 2019 20:04:39 -0700
X-Gmail-Original-Message-ID: <CALCETrWiF5FKUTmt4jOZJxJr6B_66NFj9TaA3Tnv1uorfkwTMg@mail.gmail.com>
Message-ID: <CALCETrWiF5FKUTmt4jOZJxJr6B_66NFj9TaA3Tnv1uorfkwTMg@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
To: "Haibo Xu (Arm Technology China)" <Haibo.Xu@arm.com>
Content-Type: text/plain; charset="UTF-8"
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
 Andy Lutomirski <luto@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Bin Lu \(Arm Technology China\)" <Bin.Lu@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 11, 2019 at 6:35 PM Haibo Xu (Arm Technology China)
<Haibo.Xu@arm.com> wrote:
>
> On 2019/3/12 2:34, Sudeep Holla wrote:
> > (I thought I had sent this email, last Tuesday itself, but saw this in my
> > draft today, something went wrong, sorry for the delay)
> >
> > On Tue, Mar 05, 2019 at 02:14:47AM +0000, Haibo Xu (Arm Technology China) wrote:
> >> On 2019/3/4 18:12, Sudeep Holla wrote:
> >>> On Mon, Mar 04, 2019 at 08:25:28AM +0000, Haibo Xu (Arm Technology China) wrote:
> >>>> On 2019/3/1 2:32, Sudeep Holla wrote:
> >>>>> Now that we have a new hook ptrace_syscall_enter that can be called from
> >>>>> syscall entry code and it handles PTRACE_SYSEMU in generic code, we
> >>>>> can do some cleanup using the same in syscall_trace_enter.
> >>>>>
> >>>>> Further the extra logic to find single stepping PTRACE_SYSEMU_SINGLESTEP
> >>>>> in syscall_slow_exit_work seems unnecessary. Let's remove the same.
> >>>>
> >>>> I think we should not change the logic here. Is so, it will double the report of syscall
> >>>> when PTRACE_SYSEMU_SINGLESTEP is enabled.
> >>>>
> >>>
> >>> I don't think that should happen, but I may be missing something.
> >>> Can you explain how ?
> >>>
> >>
> >> When PTRACE_SYSEMU_SINGLESTEP is enabled, both the _TIF_SYSCALL_EMU and
> >> _TIF_SINGLESTEP flags are set, but ptrace only need to report(send SIGTRAP)
> >> at the entry of a system call, no need to report at the exit of a system
> >> call.
> >>
> > Sorry, but I still not get it, we have:
> >
> > step = ((flags & (_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)) == _TIF_SINGLESTEP);
> >
> > For me, this is same as:
> > step = ((flags & _TIF_SINGLESTEP) == _TIF_SINGLESTEP)
> > or
> > if (flags & _TIF_SINGLESTEP)
> > step = true;
> >
>
> I don't think so! As I mentioned in the last email loop, when PTRACE_SYSEMU_SINGLESTEP
> is enabled, both the _TIF_SYSCALL_EMU and _TIF_SINGLESTEP flags are set, in which case
> the step should be "false" for the old logic. But with the new logic, the step is "true".
>
> > So when PTRACE_SYSEMU_SINGLESTEP, _TIF_SYSCALL_EMU and _TIF_SINGLESTEP
> > are set and step evaluates to true.
> >
> > So dropping _TIF_SYSCALL_EMU here should be fine. Am I still missing
> > something ?
> >
> > --
> > Regards,
> > Sudeep
> >
>
> For the PTRACE_SYSEMU_SINGLESTEP request, ptrace only need to report(send SIGTRAP)
> at the entry of a system call, no need to report at the exit of a system call.That's
> why the old logic-{step = ((flags & (_TIF_SINGLESTEP | _TIF_SYSCALL_EMU)) == _TIF_SINGLESTEP)}
> here try to filter out the special case(PTRACE_SYSEMU_SINGLESTEP).
>
> Another way to make sure the logic is fine, you can run some tests with respect to both logic,
> and to check whether they have the same behavior.


tools/testing/selftests/x86/ptrace_syscall.c has a test intended to
exercise this.  Can one of you either confirm that it does exercise it
and that it still passes or can you improve the test?

Thanks,
Andy
