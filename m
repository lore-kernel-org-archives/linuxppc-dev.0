Return-Path: <linuxppc-dev+bounces-24189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0681C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 07:29:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzrXc3LNrz2y71;
	Tue, 14 Jul 2026 17:29:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784014160;
	cv=none; b=RS/Jg8eoQRgiLsqHDD+e3z0Hvhb+eC+K02OpItwbK7z8JlVBu86JQdeLdPJrz/5XGqjpyM+6TWU0i8bv7XU9WCYwUb3UiCohQGo+Bqlg67Speqc+T4KIu4plSCbEsr0w6HkZWVamolnn7Cm3eNmwgbZypmsvsh/sS4JP3VDGXeafCnlVY2EkAKe8wnrMXY7WBvDGVmZJQ3oLMJL4VC5yj8BZGCKnkLNB9/pMFkTRc8weozhmOa0kwukYJtzVyEY3ld1tTm9JsYpO11Tgazc68NexOsSC+OAzFnDGnUIteHA4A4ijD7UxdvjQzHazCm2b1BosB6laE7fT57MT08ZgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784014160; c=relaxed/relaxed;
	bh=7oQy++gQVcbJeCZVwlXy7MNx94CpG6jaAajm+FSFAIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3BIzYU3j5e9s/d35g2MVq6V9lmNJsbLq4TkoAHevZcfX8Nw5aatHiUUimM9BqmOLu/PZZMbRb+DIsVCvapDjCjudzi4dalrXCoeeKf7jEJjQLYZXOp2BsvpHgQ/2TShOz+qNDyTppBpmb1tuXNxDGXRrDTm5yoxDEVRhBnnVsJB92n2bQPH6hUXNLdimZ854DKoXiThL+UUcfifoAVcMlDYhG04XljdoE95bKXR6jMVJBrAsCigRgH4TsAw1uqSe5gFa9DmJXpPqXwp717Pt11xImbv9/lo0hulvllh4Sr43ODJZ5J239q8zd3vui/+wbfgQrBmYTywM/EezlNqZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzrXb5Xlmz2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 17:29:19 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0B5C77D39;
	Tue, 14 Jul 2026 07:29:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Date: Tue, 14 Jul 2026 09:29:13 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Radu Rendec <radu@rendec.net>
Subject: Re: [patch 4/4] entry, treewide: Make
 syscall_enter_from_user_mode[_work]() indicate syscall execution
Message-ID: <alXlSUcT2TWOlM7r@kunlun.suse.cz>
References: <20260712134433.549076055@kernel.org>
 <20260712141346.772209074@kernel.org>
 <alSlg72c8xmjaj48@kunlun.suse.cz>
 <871pd6r0ou.ffs@fw13>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871pd6r0ou.ffs@fw13>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: D0B5C77D39
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[]

On Tue, Jul 14, 2026 at 12:20:49AM +0200, Thomas Gleixner wrote:
> On Mon, Jul 13 2026 at 10:44, Michal Suchánek wrote:
> > On Sun, Jul 12, 2026 at 11:25:32PM +0200, Thomas Gleixner wrote:
> >> The return values of syscall_enter_from_user_mode[_work]() are
> >> non-intuitive. Both functions return the syscall number which should be
> >> invoked by the architecture specific syscall entry code. The returned
> >> number can be:
> >> 
> >>   - the unmodified syscall number which was handed in by the caller
> >> 
> >>   - a modified syscall number (ptrace, seccomp, trace/probe/bpf)
> >> 
> >> That has an additional twist. If the return value is -1L then the caller is
> >> not allowed to modify the return value as that indicates that the modifying
> >> entity requests to abort the syscall and set the return value already. That
> >> can obviously not be differentiated from a syscall which handed in -1 as
> >> syscall number.
> >> 
> >> The most trivial way to deal with that is:
> >> 
> >>     set_return_value(regs, -ENOSYS);
> >>     nr = syscall_enter_from_user_mode(regs, nr);
> >>     if (valid(nr))
> >>     	handle_syscall(regs, nr);
> >> 
> >> That's what LOONGARCH, RISCV, and X86 do. But PowerPC and S390 do not
> >> preset the return value, so when user space hands in -1 and there is
> >> nothing setting the return value in the entry work code, then the syscall
> >> is skipped but the return value is whatever random data has been in the
> >> return value register.
> >
> > The reason why PowerPC and S390 do not preset the return value is that
> > the return value uses the same register as the syscall number. There are
> > apparently other architectures on which the return value overlaps with
> > the arguments which also do not preset the return value for that reason.
> > If they would use the generic entry the same problem would arise.
> 
> That's an implementation choice of PPC/S390 as I explained before, which
> could trivially be solved by having an explicit pt_regs->return_val
> member,
> 
> >> Change the return values of syscall_enter_from_user_mode[_work]() to
> >> boolean and return false, when either ptrace or seccomp request to skip the
> >
> > There is a difference between seccomp and ptrace.
> >
> > When seccomp indicates to skip the syscall it has also set the syscall
> > return value.
> >
> > However, when the syscall number is -1 and the return value is not
> > preset that does not indicate anything.
> 
> I agree it's an invalid syscall, but the current generic entry code made
> the rightful assumption that returning -1L as the syscall number either
> results in -ENOSYS or in the value which was set by one of the entry
> mechanisms as that code originated from the x86 implementation.

You know, the world is not x86. For 20+ years that is not true.

> 
> It's not the fault of that code that PPC and S390 converted their stuff
> over without paying attention to that detail.

So this is not generic entry but rather x86-like entry do I get it
correct?

> 
> > The return value can still hold garbage. ptrace does not have the
> > ability to indicate that a syscall is to be skipped, at least on the
> > entry trace. It needs to be skipped based on the syscall number being
> > invalid.
> 
> That's what I explained you before and you told me I'm all wrong.
> 
> But that's moot as this latest version does not care anymore. The
> architectures whixh preset the return value are correct under all
> circumstances and PPC/S390 can keep their own world view.

So do I get it that you do not care about breaking userspace then?

Thanks

Michal

