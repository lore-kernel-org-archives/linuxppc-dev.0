Return-Path: <SRS0=weZV=RG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD460C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Mar 2019 01:13:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 480D520863
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Mar 2019 01:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMOI3BDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 480D520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44BlXW1Z25zDqNk
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Mar 2019 12:13:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=luto@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="iMOI3BDx"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44BlVh3x9ZzDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2019 12:11:55 +1100 (AEDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D3F7220838
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Mar 2019 01:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1551575513;
 bh=aeQcNudQANa/9O58tlI+sqExs+mP6kZ+zGbCittOyEk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=iMOI3BDxBhhvdZdIcqElKOqDFlfv3W9qoWzA76mmfi84rfF1boPaOJ7z8ss2KewJK
 B1YFnvAra/1ejgoMuHGEvS/k6zP1Cs8HPpPTzKL7pGhf184GnqVnlFO1ELJ8A8TZ06
 U3kfnUleQqTJJ7VsrYr6LTppFm6hUSR9auA4C7gE=
Received: by mail-wr1-f47.google.com with SMTP id w17so1682351wrn.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 02 Mar 2019 17:11:52 -0800 (PST)
X-Gm-Message-State: APjAAAU/jZhHpH/icjg2K7MTDxP68iTYm8LJQ/cR3NQvN42Tzcu1urgy
 PL3i4/YTG0B4KOJQIUgRerhQleR9bH0jV7QNsvdh9w==
X-Google-Smtp-Source: APXvYqw5H814IruOE6KiflSk63yk0XpLxWMumnCT4d6g3D3LEBouwjR0Z0rqMrV+mGI06upNb53KEAiOR8SV+YPRVK8=
X-Received: by 2002:a5d:6252:: with SMTP id m18mr7652954wrv.199.1551575511385; 
 Sat, 02 Mar 2019 17:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20190228183220.15626-1-sudeep.holla@arm.com>
 <20190228183220.15626-4-sudeep.holla@arm.com>
In-Reply-To: <20190228183220.15626-4-sudeep.holla@arm.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 2 Mar 2019 17:11:40 -0800
X-Gmail-Original-Message-ID: <CALCETrVOJV0uBX3CbpmuwSGQa98Fabq3-GoRbGMb79m_OoJkmQ@mail.gmail.com>
Message-ID: <CALCETrVOJV0uBX3CbpmuwSGQa98Fabq3-GoRbGMb79m_OoJkmQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
To: Sudeep Holla <sudeep.holla@arm.com>
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
Cc: Haibo Xu <haibo.xu@arm.com>, Steve Capper <Steve.Capper@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jeff Dike <jdike@addtoit.com>,
 X86 ML <x86@kernel.org>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Andy Lutomirski <luto@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Bin Lu <bin.lu@arm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 28, 2019 at 10:32 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Now that we have a new hook ptrace_syscall_enter that can be called from
> syscall entry code and it handles PTRACE_SYSEMU in generic code, we
> can do some cleanup using the same in syscall_trace_enter.
>
> Further the extra logic to find single stepping PTRACE_SYSEMU_SINGLESTEP
> in syscall_slow_exit_work seems unnecessary. Let's remove the same.

I wasn't cc'd on the whole series, so I can't easily review this.  Do
you have a test case to make sure that emulation still works?  Are
there adequate tests in tools/testing/selftests/x86?  Do they still
pass after this patch?

--Andy
