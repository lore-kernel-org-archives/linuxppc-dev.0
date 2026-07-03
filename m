Return-Path: <linuxppc-dev+bounces-23498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED382C43458
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Jul 2026 11:25:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gsBJB2zT8z2xwL;
	Fri, 03 Jul 2026 21:25:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783077930;
	cv=none; b=WBAC8ACTy6MBQi7gNp2a/avxGgNgm15t5EBtL2Z9ulKJ3fUJRjOpA0NaIRI/TST45apU5yxRumqHxm+mRanf/gybR2uwgB/7d02Wo/BCksmkQVyqm+UbSj51yxDHWoNc0qfsYcR1lDOdWUT0Jo6s9892q77EZ0bczyjQQOa9xlOJrfbgJqzTKXve13NA7RXU0Z/EyIZrFyAJ3A0tYYfMqmBppQWmDVKPJQaIzr45gLdc8UXRxMM6WsSVZ8NYReQlnj95gz6j6oOT3AtI6Xjvxh8XQ6gDothSuXY/S74aQ7ZRof+T4geuFuSeITRehiQRPGoSDtfz3nX1gqByt6bmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783077930; c=relaxed/relaxed;
	bh=TzUo2iurZpqXwNVxx2UMOaZ69dfsfnAButwGG38BzDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKq+QC1Phcx3Q46eQZswBs5lfhVSbM2U0v/EsNTP60UeRzwpiQWuChxTkJzAhTuQYCPXVH41k0lLGPn9UZlssaCPOKXAOksQzLGb18qq7jlwBNxulqepV0kaajm/PTi27eETSkX4TQyloH1UyoJaBZfmrcxaN7tI5DL7I8SpB3u0x0lgaEqQkxwfHL9e2x1OYKRvRfSI0l4jZGYYkG3TmemUwRzGIpdjaE/E0QTwPfyELDKsBCnbDCy5QyRdvZwnPtNPvbnqKYAgCKLPJGz17JCwyM1kutd0my6Adfko77TMOSXxMCNV2mzFy5AxXDUplGxiLm1Qzjz9obsSvMaaaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gsBJ94xSnz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jul 2026 21:25:29 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AEE26758B0;
	Fri,  3 Jul 2026 11:25:26 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Date: Fri, 3 Jul 2026 13:25:25 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
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
Message-ID: <akecJWAJP-e5CYP_@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz>
 <BA7CD91D-C0E5-47A1-B49C-BC6AF6604182@zytor.com>
 <87h5mhnjsr.ffs@fw13>
 <yt9dwlvca8rn.fsf@linux.ibm.com>
 <87ldbsmnie.ffs@fw13>
 <yt9d5x2w5r84.fsf@linux.ibm.com>
 <20260703105718.GO751831@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260703105718.GO751831@noisy.programming.kicks-ass.net>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[];
	TAGGED_RCPT(0.00)[kernel]
X-Rspamd-Queue-Id: AEE26758B0
X-Rspamd-Action: no action

On Fri, Jul 03, 2026 at 12:57:18PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 03, 2026 at 11:59:07AM +0200, Sven Schnelle wrote:
> > Thomas Gleixner <tglx@kernel.org> writes:
> > 
> > > On Fri, Jul 03 2026 at 08:26, Sven Schnelle wrote:
> > >> Thomas Gleixner <tglx@kernel.org> writes:
> > >>> It's less than obvious and I have no objections to clean that up and
> > >>> make it more intuitive, but I still fail to see what Michal is actually
> > >>> trying to solve and what the magic flag is for. If s390 requires it,
> > >>> then that's an s390 problem, but definitely x86 does not.
> > >>
> > >> The difference between x86 and s390 is that on s390, regs->gprs[2] is
> > >> used for both the syscall number and the syscall return value.
> > >> That was a design mistake early in the begin about 25 years ago, but
> > >> it's ABI now, so it cannot be changed.
> > >
> > > Cute.
> > >
> > >> When seccomp decides to skip a syscall, it write a return value into
> > >> regs->gprs[2]. When syscall_enter_from_user_mode_work() returns, it
> > >> returns this number. If it's negative all is good - the 'if (likely(nr <
> > >> NR_syscalls))' conditiion would just catch it and skip the syscall.
> > >>
> > >> But if it's a positive number, the code cannot distinguish whether
> > >> that's a return value or a syscall number.
> > >>
> > >> So I introduced PIF_SYSCALL_RET_SET when converting s390 to generic
> > >> entry. This flag tells the syscall code that a return value was set in
> > >> ptregs and the syscall should be skipped.
> > >
> > > You also could have added a 'syscall_ret' member to pt_regs, operate
> > > on that for the return values (seccomp, syscall...) and swap it into
> > > gprs[2] right before returning to user space.
> > 
> > That would likely also work, but I found it easier to read and
> > understand to have an additional flag with a descriptive name than having
> > yet another 'somehow-related-to-gpr2' member in ptregs.
> 
> I find this very odd; I would think that having both syscall-nr and
> syscall-ret in separate (virtual) registers for most of the normal cycle
> would be most obvious and less surprising -- given that this is what all
> other architectures do.
> 
> Entry either grabs a copy of gpr2 and preserves it in orig_gpr2 as the
> syscall nr, or as Thomas suggests, you keep syscall_ret and copy that
> into gpr2 on return to userspace (and ptrace and signal and whatever
> other surface bits are affected).
> 
> Either way around you then have separate values for the entire range of
> at least the C part of the kernel syscall handling -- just like every
> other arch. How is munging things in a single value and a flag easier?

The same could be asked of syscall_enter_from_user_mode. I find it very
odd. Why does it conflate the syscall number with its return value?

It never uses the syscall number passed in except when returning it
unchanged. When it pokes the registers it reads the syscall number from
them.

If the caller of syscall_enter_from_user_mode only read the syscall
number from the registers when syscall_enter_from_user_mode returns and
indicates the syscall should be still executed this whole shenigan would
be avoided.

Thanks

Michal

