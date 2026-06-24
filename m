Return-Path: <linuxppc-dev+bounces-22964-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAC6CDB47F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:44:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glq7M34Z9z2xwL;
	Thu, 25 Jun 2026 03:44:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782323055;
	cv=none; b=JE1yd3YyPYoVbyUBwtP2H6ulf4eVfbOhdeldETZmiMxSsCM0jEsESuwHmanZGk5RKHsNIWDIrpMnDIsWt5OF+iTPOcesYZLebu3i0QAgEMT1Lf85L19YnQAKZq5nGhJZwnCLnrlNZWlHFumG0wX37f0SCe3BysU70KPEHI+KGEbCtg5c4Ijbm17xGDnDH7jm/Ec+adah8ifOozK7w/uN2HMwSKsivY/ZZlrcPP6CBN0XYpjhgmTzH/ltkQtxvGEUr3c6KY8+WlGbG62YidpXfM9ooaQuenk7u2dmrrm19ksR3gLI/rB5Cn1TvTqJ+0orCPvtUmOuZx20vZY7aAyJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782323055; c=relaxed/relaxed;
	bh=Ftf6Cq+TeoEfMJbZKCvjkjFrgBlmmaoTuiEBwRaU3NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1i4BMPxsH9y4qwLw3CDOPkR+dQn3wLCB2ZFtQ3V2mq8r6hb6ZRMDtRiN1WHeMPF1ZknhP0ArulvMJXhMqG9OZBBT1hbiRJBBrZOP5BJZBF5CbW+1Oz8vVzMxkWZooguICIHRUxjKZJlIZUPJNJcTob/LURPB38haRazyAE0xW/OuC6cWEADkJP6o/V4vBmujEE/z2z88N7Ykp3lAZ0/XZSvHajv7xLQr4hhT/XYS3jA+A6ubtzuZuYQoW2NdSsAgsYbNcI1rNwEHxbnxMM31fO92WvGbkXBhKav+LjLfmqWrBj3f0yCOxycTqWO7h9HG79sHxO2Q/MajO9FoHEL1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XlVdGCyx; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0Ky3Tq8v; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cYpPQfA9; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xcUg5teN; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XlVdGCyx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0Ky3Tq8v;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=cYpPQfA9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xcUg5teN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glq7K1wxZz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2026 03:44:12 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C9166DBAA;
	Wed, 24 Jun 2026 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782323049; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftf6Cq+TeoEfMJbZKCvjkjFrgBlmmaoTuiEBwRaU3NY=;
	b=XlVdGCyxDPIohzZiucH0EPeqwmtM3wiwb1povF/9D6sWmJoep4Yc99n0XWBbLH/2dI2qEb
	P51vPdHrMnAUdi9KtOLCo0URN/sGIa44Eitp/fC2u5mRbwET7/GEurMBwOEv+dYOBgoxks
	7SsLHmjR4g/xqQ2cO+7h7Qb4v4y3nmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782323049;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftf6Cq+TeoEfMJbZKCvjkjFrgBlmmaoTuiEBwRaU3NY=;
	b=0Ky3Tq8vNMV9f2BlGQ/97An1FqFDlAGhM18iKq96LQZCohBDuWxuPLUECWE4x6jpicHVaw
	txaVOLDAZmiQJBBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cYpPQfA9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xcUg5teN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782323048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftf6Cq+TeoEfMJbZKCvjkjFrgBlmmaoTuiEBwRaU3NY=;
	b=cYpPQfA96PA1mDfUsAi0R/IFAvbwHvSitp0eICs623v2p6P5FjYNg6q4S0KEfWpStKYDtc
	gyEj3u/uND4Jqq1YoISs5Fh22r4szt7TPdxyQ6uQmK64KiDABgNBbLJs6bKgrHAQ5ml9DA
	L3x7+sg3tlHv1pVn6atNO4coOPk4qC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782323048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ftf6Cq+TeoEfMJbZKCvjkjFrgBlmmaoTuiEBwRaU3NY=;
	b=xcUg5teN2oHQkwDJ0GXIrRMRqI2aPETl4r/mJqj5u4Xb1AftO/xnjeNiBvaWwm7ulyXYz3
	uTntGJBwkOf9SpDQ==
Date: Wed, 24 Jun 2026 19:44:07 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, sshegde@linux.ibm.com, mkchauras@linux.ibm.com,
	kees@kernel.org, mark.rutland@arm.com, ryan.roberts@arm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <ajwXZ6watUr_igyX@kunlun.suse.cz>
References: <20260624171520.772408-1-mkchauras@gmail.com>
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
In-Reply-To: <20260624171520.772408-1-mkchauras@gmail.com>
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: 6C9166DBAA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.49 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,arm.com,lists.ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kunlun.suse.cz:mid,kunlun.suse.cz:helo,suse.de:email,suse.de:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b306:2000::2:from]

On Wed, Jun 24, 2026 at 10:45:20PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> After enabling GENERIC_ENTRY on PowerPC, seccomp filters using
> SCMP_ACT_ERRNO without an explicit errnoRet value return ENOSYS
> (Function not implemented) instead of the expected EPERM (Operation
> not permitted).
> 
> The issue occurs in system_call_exception() when syscall_enter_from_user_mode()
> returns -1 to indicate the syscall should be skipped (e.g., blocked by seccomp).
> The current code treats this -1 as a syscall number and compares it against
> NR_syscalls. Since -1 (when cast to unsigned long) is greater than NR_syscalls,
> the code incorrectly returns -ENOSYS, overwriting the errno that seccomp
> already set via syscall_set_return_value().
> 
> The generic entry code in syscall_trace_enter() calls __secure_computing(),
> which sets the appropriate errno in regs->gpr[3] and returns -1 to signal
> that the syscall should be skipped. However, the PowerPC syscall handler
> was not checking for this -1 return value before validating the syscall
> number.
> 
> Fix this by explicitly checking if syscall_enter_from_user_mode() returns
> -1 and returning the value already set in regs->gpr[3] (the errno from
> seccomp) before performing the syscall number validation.
> 
> This aligns PowerPC's behavior with other architectures using GENERIC_ENTRY
> and restores correct seccomp errno handling.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reported-by: Michal Suchánek <msuchanek@suse.de>

Tested-by: Michal Suchánek <msuchanek@suse.de>

Thanks

Michal

> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  arch/powerpc/kernel/syscall.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index a9da2af6efa8..5b58c8d396c8 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -22,6 +22,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>  	add_random_kstack_offset();
>  	r0 = syscall_enter_from_user_mode(regs, r0);
>  
> +	/* Seccomp or ptrace may have set return value, skip syscall */
> +	if (unlikely(r0 == -1L))
> +		return regs->gpr[3];
> +
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {
>  			/* Unsupported scv vector */
> -- 
> 2.54.0
> 

