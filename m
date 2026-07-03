Return-Path: <linuxppc-dev+bounces-23495-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8143DC43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 10:58:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gs9hT1qdcz2xd2;
	Fri, 03 Jul 2026 20:58:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783076281;
	cv=none; b=kE5nDOLhmw+Rj9pWGH2evhirfZrSMmF6XKBh774w6Xixkka+9zmw4cSYB0KpAQnyoXk99TKm9ZLbpueom3xK2B6N0p1yPiuOoO7dAvczm1O3G712bBCmzjPK07R9iEL6Nx9xKD9O6rB6SN2P6+z59eqAmYPY4YfrviN4U3Ux96i96royDpnXg642EZ8yzb11W/cQX/RBjhSubKoiJkxvMhSLJENDA4gZAkf6mPg+r2Cd+PQHEMTOajZjWH0+V6ltzZSzC9DWpqgOl1vRoknuKgGsq1suw9YWcHNF8BqnxhKex3t8xKiL1Kw0GFZDNZ0kmCgXIzg6V+ScbxgtGGe93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783076281; c=relaxed/relaxed;
	bh=z9mfhe8NL5p/8FnxdJEUK4N0owxOfETS9bDtYqAhEkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1e33wZZLXjCg1BmojKrtLjp3ijXP79w0Z7GvzvNBKI/m9miA/0LA8vLi/vzbkzFkCT7FQJ4JcFqZVT39p8jEdzbTboKz9c3onZvaMBrCkGDNwQPA5f9P6LgSb8H0Ca3njtcsZs0KU5RECNGL95v39vSevmCPCmxdnR7tKTQQmYk9Y7FkkbArtLEdXVY9uZrS0gS9TmZGL0Ww/uAjLgNsgrw+32ZkINvDeSqDBupZ1kGphrLATBwYHMcuUyXvVGBTxIX0dQIc1Es6GtfUxG5f8RW5Vyl7r+rrB57ypFCDPvjD0BlAC/O1/XDTecqMWXBU/N+FIFLpv/Ofsyo3WR+aw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=m8iiOBj9; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=m8iiOBj9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gs9hM3NjYz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 20:57:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z9mfhe8NL5p/8FnxdJEUK4N0owxOfETS9bDtYqAhEkY=; b=m8iiOBj9h+vogWkfy1Cne5Qkvv
	rZ158rJbURZ9yw3QpqOT4NqpPFzMnxZg+4eUX3xqtzNTT7MXwtCo7fTZvtLEzyvgbM3WQzmM6uTmA
	fyH+gCWqn0r5WOQUm2gUCOWz3zmvr2fGMZVU5VQqlUQMKmX2dldYOi9SaBfvk1ZMqRvDE2vQjoEV5
	aQK5s98fiZZh79Dzjqt+p8BEwfsnr4UgGmDUrd30tzwpr0WaU759DWCAcBzBuay9OD3rDaY58EYaj
	6QIZcBfJjwyEjtSpP75/J7O3osN1paoow9q7momriwcMe+vS0b83x4BnSwtjZaRQUaA0GvgJQBDW+
	00qcBIcA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wfbaC-00000004jKJ-3HEk;
	Fri, 03 Jul 2026 10:57:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 95062300220; Fri, 03 Jul 2026 12:57:18 +0200 (CEST)
Date: Fri, 3 Jul 2026 12:57:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Zong Li <zong.li@sifive.com>, Nam Cao <namcao@linutronix.de>,
	Deepak Gupta <debug@rivosinc.com>,
	Lukas Gerlach <lukas.gerlach@cispa.de>,
	Rui Qi <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
Message-ID: <20260703105718.GO751831@noisy.programming.kicks-ass.net>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
 <87h5mhnjsr.ffs@fw13>
 <yt9dwlvca8rn.fsf@linux.ibm.com>
 <87ldbsmnie.ffs@fw13>
 <yt9d5x2w5r84.fsf@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9d5x2w5r84.fsf@linux.ibm.com>

On Fri, Jul 03, 2026 at 11:59:07AM +0200, Sven Schnelle wrote:
> Thomas Gleixner <tglx@kernel.org> writes:
> 
> > On Fri, Jul 03 2026 at 08:26, Sven Schnelle wrote:
> >> Thomas Gleixner <tglx@kernel.org> writes:
> >>> It's less than obvious and I have no objections to clean that up and
> >>> make it more intuitive, but I still fail to see what Michal is actually
> >>> trying to solve and what the magic flag is for. If s390 requires it,
> >>> then that's an s390 problem, but definitely x86 does not.
> >>
> >> The difference between x86 and s390 is that on s390, regs->gprs[2] is
> >> used for both the syscall number and the syscall return value.
> >> That was a design mistake early in the begin about 25 years ago, but
> >> it's ABI now, so it cannot be changed.
> >
> > Cute.
> >
> >> When seccomp decides to skip a syscall, it write a return value into
> >> regs->gprs[2]. When syscall_enter_from_user_mode_work() returns, it
> >> returns this number. If it's negative all is good - the 'if (likely(nr <
> >> NR_syscalls))' conditiion would just catch it and skip the syscall.
> >>
> >> But if it's a positive number, the code cannot distinguish whether
> >> that's a return value or a syscall number.
> >>
> >> So I introduced PIF_SYSCALL_RET_SET when converting s390 to generic
> >> entry. This flag tells the syscall code that a return value was set in
> >> ptregs and the syscall should be skipped.
> >
> > You also could have added a 'syscall_ret' member to pt_regs, operate
> > on that for the return values (seccomp, syscall...) and swap it into
> > gprs[2] right before returning to user space.
> 
> That would likely also work, but I found it easier to read and
> understand to have an additional flag with a descriptive name than having
> yet another 'somehow-related-to-gpr2' member in ptregs.

I find this very odd; I would think that having both syscall-nr and
syscall-ret in separate (virtual) registers for most of the normal cycle
would be most obvious and less surprising -- given that this is what all
other architectures do.

Entry either grabs a copy of gpr2 and preserves it in orig_gpr2 as the
syscall nr, or as Thomas suggests, you keep syscall_ret and copy that
into gpr2 on return to userspace (and ptrace and signal and whatever
other surface bits are affected).

Either way around you then have separate values for the entire range of
at least the C part of the kernel syscall handling -- just like every
other arch. How is munging things in a single value and a flag easier?

