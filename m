Return-Path: <linuxppc-dev+bounces-23115-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611B4C43327
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 13:31:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpnHn5clkz2yFc;
	Mon, 29 Jun 2026 23:31:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782739909;
	cv=none; b=RI5ODOWuKxBD19+8x2aJPqABNANNu/foxGxb6CEx16I3qvGF6EXAlp0SJN0TORF0vwVgHVpYveO1eH2J8R10vObdAEeP3Pt18gQobAHPhZFXnxNAMPb/I/nRxL8l20QrkttLH3hRkNmtLmEHh5RWJ8qZir47+76HsgLOWYkJfuhyiKDBo7nL5k+rkdlmkV5k46KM0vklJLMTYSzH+mU315ekP8OrAVf94lVwmMDJqGRUYnq7gz0WbDLjpssVsONM/ATnuA9wgAuQGqxJLXM7LDQ3nvGgfv8CkuiyQXdbz5yj5K1LHTVVwKEFifDVVd2UL3Spp0gXdQRjLAMAwhhaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782739909; c=relaxed/relaxed;
	bh=FQYItTj83ndavw6UQp5BwjnG14vM48N1/0OH1HWTN7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiWf137hJWYF30TX9izQLpqu89hzXBCQbn2MOG5atvKMZpX8epkRDuP2QInGHHByxbwtf3R5co7syi2/+52+O/uGCUrjvTJHXDhKAyz1xIjLJHzTqUUWBL6NuucdNH8ZcmH7839Ulwfi92Th7a1V6KZcjIuuloIsiIEc6GHZ4vaX1bv5MXTcqiCT6g4uP3DFhRDfMjoQ7kkKxsh0T6GP9C0rpv+u6vfzSHsjh2kqNJ8crZ42AFo0X8nG/J+owxacJqJYi5vhlqozK+82ulDUY11cDPepqqOHv0wBcmHSGX62xRmjrNLSx9eWv7jdunQouwuirtNb/A1uJJYC/gkR1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rKePMkdb; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oiwGIM/J; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YrAesAEk; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FJneIzCs; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rKePMkdb;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oiwGIM/J;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=YrAesAEk;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FJneIzCs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpnHl1Jysz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 23:31:47 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 21AA6730A6;
	Mon, 29 Jun 2026 13:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782739899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQYItTj83ndavw6UQp5BwjnG14vM48N1/0OH1HWTN7Q=;
	b=rKePMkdbK7MzqhjcfNU7hpM0TQNJw+u2RAmgudH9P8aIonOtwCY+yqDfO9GqO0Rsfi0zyd
	ugH72Ql/XOnYX3Sf83YVFpd25LJIYJLiuFcVfrgWSZSV9aij9wx3haosU2/ez779R+y1PX
	u6KjiVb875dz7d60fisSi0C4RAhgsd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782739899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQYItTj83ndavw6UQp5BwjnG14vM48N1/0OH1HWTN7Q=;
	b=oiwGIM/JVZWt+Q9AJXDSsYOFP864LJc60Tzi6tTxI0SMvLnMvhSqjAFF4nFZDrnXBgOFsk
	w5AQZ38vznFZk9Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YrAesAEk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FJneIzCs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782739898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQYItTj83ndavw6UQp5BwjnG14vM48N1/0OH1HWTN7Q=;
	b=YrAesAEk9xoCdxAophmd/SBQ4lC0ZKfwxBgTGwcdGURWZQsd/qc+Jw7Lo82xYJoyttVSyM
	JmEDQt/UrhZ2fgt+we0Loc3K8rx2QThh3fl12Uvf7pSSzFff4PrbwIVHkmDRnMSCUQDcjk
	mGupoan9/FyxAhZdT+DDAZvfKjtBz3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782739898;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQYItTj83ndavw6UQp5BwjnG14vM48N1/0OH1HWTN7Q=;
	b=FJneIzCsnVHpZKTosmSoILPRB41ri4XD2/4LVfufXp5fCawsGc0yUxj7bJ/qOro42f/VtH
	350b9cfv9XPKPeDQ==
Date: Mon, 29 Jun 2026 15:31:36 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, sshegde@linux.ibm.com, mkchauras@linux.ibm.com,
	kees@kernel.org, mark.rutland@arm.com, ryan.roberts@arm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akJzuEJRLniHk4Fi@kunlun.suse.cz>
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
X-Spamd-Bar: +++++++++++++++
X-Rspamd-Queue-Id: 21AA6730A6
X-Rspamd-Action: add header
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [15.07 / 50.00];
	SPAM_FLAG(5.00)[];
	NEURAL_SPAM_LONG(3.50)[1.000];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_SPAM_SHORT(2.88)[0.961];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b306:2000::2:from];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[kunlun.suse.cz:mid,kunlun.suse.cz:helo,suse.de:email,suse.de:dkim];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,arm.com,lists.ozlabs.org,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,kunlun.suse.cz:mid,kunlun.suse.cz:helo]
X-Spam: Yes

Hello,

there is yet another bug identified.

When the initial syscall number is -1 the new condition bypasses setting
the ENOSYS below in if (unlikely(r0 >= NR_syscalls)) and returns 0.

perl -MPOSIX -e '$!=0; my $r = syscall(-1, 0); print "ret=$r errno=".($!+0)." ($!)\n"'

Normally the result is

ret=-1 errno=38 (Function not implemented)

but with this patch the result is

ret=0 errno=0 ()

fixup below.

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
	unsigned long r0_initial = r0;
>  	add_random_kstack_offset();
>  	r0 = syscall_enter_from_user_mode(regs, r0);
>  
> +	/* Seccomp or ptrace may have set return value, skip syscall */
> +	if (unlikely(r0 == -1L)
				&& (r0_initial != -1L))
> +		return regs->gpr[3];
> +
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {
>  			/* Unsupported scv vector */

Thanks

Michal

