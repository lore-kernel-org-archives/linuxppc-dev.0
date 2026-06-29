Return-Path: <linuxppc-dev+bounces-23122-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE028C43327
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 17:07:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpt4Z3YDYz2yS4;
	Tue, 30 Jun 2026 03:07:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782752846;
	cv=none; b=oSw2Uje70geVoW1xqlghh6YYuWULKlsWM/86k5Zh6UXCRi1cZ1wBLDJ248zBDrFzk4iQHITgzZDbLrO/i+6kVpHEMMGpMdoRE8/gsuiIusLAQ15P32psF0qbAZJNHWk6Ntn6c0pP6yHhiFYMw3sJEgmTjRwBAXpRRsK0bQh6Jx3M+3FAGyKoccAtcpkZbwIoAubWmG/fBlMqTmC77N3rlqHxO/490sU99qiwQUWb39ONcID4xfdnxSfnD4LW/sa40Bya1CC6oLxLho+TJtMUGRWBeITIvpCYWLioKnhtFRuLwH8Zq4TNhCodwOHllE8j5AXLxwZoWYTkXUCt13HQlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782752846; c=relaxed/relaxed;
	bh=yrAz5+rNmNvKUf9HWj/fZkOgkYiZdk9fD174+I6A7o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZD6oUJbCLSv9asCnLMa6H7qup8rTJ6HH8/3RmhsM3mJdanmRzQg5vUg6C3WPt/MbMohfxk0g3A1Lqu0Fj86WYsLoLdZ7jo2ncBG1QY6iKie9tMJStln7GVmYQqQbMy2osS7Yp0PjtUXF4tiyB7jC2LN0GBJMRJeLP5Nk7z0KlWeSPAf8WD2ijTniDM221w3DX1uatyGmmvKLLrs7Ogpn9Wh0LDSMlCSpUOq7IFFMycZzy9YE+NYl0vOaY/ee9QXuxrrvw0/HaPrcqmM+b+NQi7PnWYYMQIoZ7HD2wRMjQZ5d/XGkhkSjLXEsOeS557WFaR6JIfKN1BeXRSpqbB0Yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpt4Y5Dxhz2yH4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 03:07:25 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4957B75D88;
	Mon, 29 Jun 2026 17:07:22 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Date: Mon, 29 Jun 2026 19:07:21 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, sshegde@linux.ibm.com, mkchauras@linux.ibm.com,
	kees@kernel.org, mark.rutland@arm.com, ryan.roberts@arm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akKmSblIh_xNcHHp@kunlun.suse.cz>
References: <20260624171520.772408-1-mkchauras@gmail.com>
 <akJzuEJRLniHk4Fi@kunlun.suse.cz>
 <akKkdd7i6oZ2o5A5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
In-Reply-To: <akKkdd7i6oZ2o5A5@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.00 / 50.00];
	REPLY(-4.00)[];
	RDNS_NONE(2.00)[]
X-Rspamd-Queue-Id: 4957B75D88
X-Rspamd-Action: no action

On Mon, Jun 29, 2026 at 10:32:47PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Mon, Jun 29, 2026 at 03:31:36PM +0200, Michal Suchánek wrote:
> > Hello,
> > 
> > there is yet another bug identified.
> > 
> > When the initial syscall number is -1 the new condition bypasses setting
> > the ENOSYS below in if (unlikely(r0 >= NR_syscalls)) and returns 0.
> > 
> > perl -MPOSIX -e '$!=0; my $r = syscall(-1, 0); print "ret=$r errno=".($!+0)." ($!)\n"'
> > 
> > Normally the result is
> > 
> > ret=-1 errno=38 (Function not implemented)
> > 
> > but with this patch the result is
> > 
> > ret=0 errno=0 ()
> > 
> > fixup below.
> > 
> > On Wed, Jun 24, 2026 at 10:45:20PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > After enabling GENERIC_ENTRY on PowerPC, seccomp filters using
> > > SCMP_ACT_ERRNO without an explicit errnoRet value return ENOSYS
> > > (Function not implemented) instead of the expected EPERM (Operation
> > > not permitted).
> > > 
> > > The issue occurs in system_call_exception() when syscall_enter_from_user_mode()
> > > returns -1 to indicate the syscall should be skipped (e.g., blocked by seccomp).
> > > The current code treats this -1 as a syscall number and compares it against
> > > NR_syscalls. Since -1 (when cast to unsigned long) is greater than NR_syscalls,
> > > the code incorrectly returns -ENOSYS, overwriting the errno that seccomp
> > > already set via syscall_set_return_value().
> > > 
> > > The generic entry code in syscall_trace_enter() calls __secure_computing(),
> > > which sets the appropriate errno in regs->gpr[3] and returns -1 to signal
> > > that the syscall should be skipped. However, the PowerPC syscall handler
> > > was not checking for this -1 return value before validating the syscall
> > > number.
> > > 
> > > Fix this by explicitly checking if syscall_enter_from_user_mode() returns
> > > -1 and returning the value already set in regs->gpr[3] (the errno from
> > > seccomp) before performing the syscall number validation.
> > > 
> > > This aligns PowerPC's behavior with other architectures using GENERIC_ENTRY
> > > and restores correct seccomp errno handling.
> > > 
> > > Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> > > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > > ---
> > >  arch/powerpc/kernel/syscall.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> > > index a9da2af6efa8..5b58c8d396c8 100644
> > > --- a/arch/powerpc/kernel/syscall.c
> > > +++ b/arch/powerpc/kernel/syscall.c
> > > @@ -22,6 +22,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
> > 	unsigned long r0_initial = r0;
> > >  	add_random_kstack_offset();
> > >  	r0 = syscall_enter_from_user_mode(regs, r0);
> > >  
> > > +	/* Seccomp or ptrace may have set return value, skip syscall */
> > > +	if (unlikely(r0 == -1L)
> > 				&& (r0_initial != -1L))
> > > +		return regs->gpr[3];
> > > +
> > >  	if (unlikely(r0 >= NR_syscalls)) {
> > >  		if (unlikely(trap_is_unsupported_scv(regs))) {
> > >  			/* Unsupported scv vector */
> > 
> > Thanks
> > 
> > Michal
> 
> What do you think about this diff?
> This seems much cleaner.
> 
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index a9da2af6efa8..a6c89052e8c5 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -20,8 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>         syscall_fn f;
>  
>         add_random_kstack_offset();
> -       r0 = syscall_enter_from_user_mode(regs, r0);
> -
>         if (unlikely(r0 >= NR_syscalls)) {
>                 if (unlikely(trap_is_unsupported_scv(regs))) {
>                         /* Unsupported scv vector */
> @@ -30,6 +28,11 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>                 }
>                 return -ENOSYS;
>         }
> +       r0 = syscall_enter_from_user_mode(regs, r0);
> +
> +       /* Seccomp or ptrace may have set return value, skip syscall */
> +       if (unlikely(r0 == -1L))
> +               return syscall_get_error(current, regs);
>  

This will skip the check for NR_syscalls for whatever is returned from
syscall_enter_from_user_mode other than -1. To me it is not clear if
invalid syscall can be generated by one of the modifications done in
syscall_enter_from_user_mode.

Thanks

Michal

