Return-Path: <linuxppc-dev+bounces-23000-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F961CD4F26
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 05:54:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmlHB2hyjz2yYf;
	Fri, 26 Jun 2026 15:54:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782453254;
	cv=none; b=mSMOjJEcLzghWw7HKbuQihaDaa2/VKRpLUUIuLno6NyXVU81R39vJrYzF88JhSZnADBMNRGTFLDz0aYWIhBYKPsd8240gWt+2cwZzjN+qTSvyUFDdkhgFYz/Nge+nOYyR4yfjqWmuXHYSvVoAf8ebFL+bEDKuwny8sYOHOHKGUzRdfv3vXHvaN5AAFwtEyI3bH7ODac+0rkLjrsoTr6OEWFitk2GJxoXYtjdXBmwxcYOr2XdkKGYqQMCSfXcMuQ1CfnWwy8safUWbnse33teW67ftsi6mVWqiKlo/reJoqFHvvudo0Yb6ZgcyBapQk7recbG4b6mRCXLjX960YLzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782453254; c=relaxed/relaxed;
	bh=tHJX+/j6dKMpSwR1pPR5+WZRefWjtKKPN5BWHqL2m04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgVFsKZaDV+ndUq6hqf1I/xntrLlInct/B2jE5kFr8OenBPoUuHiIv03BR5uqkW9WNXqsQ6Lxo4J5LWzfP3iSqafUmpGOBAHNkVz4USXUIo9h2yscGw4URHU+fp4zsfSoZg7/9fe70RedZ3NyikexAlMOE/8BYnkxNlltmC098N6F2Qf2eJg7e/sY5RjVKak5jT5ob/1SvqaI3X7Z4Yl5aLyc8RqNq0dOyOFiJBquFE6o6gbds/K7rhJDLcoK/yKJBv2yhp+FPn4jr5dIDNjs4RAMyw+p3JED/hNFVAbvGvgMrPqV+EYfKCEZhfsmxQGDWTwSspLMnyp3iwLgoF/7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RWaKDtRh; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cK7I7wxo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RWaKDtRh; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cK7I7wxo; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RWaKDtRh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cK7I7wxo;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RWaKDtRh;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cK7I7wxo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmlH860G9z2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2026 15:54:12 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A29A75BA2;
	Fri, 26 Jun 2026 05:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782453249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHJX+/j6dKMpSwR1pPR5+WZRefWjtKKPN5BWHqL2m04=;
	b=RWaKDtRhFipsb/IW9aOHcqkFQyQZNjobycHlu6Rvb3y9cjJWoHkE8c491kuoJq8Piuulnl
	oYH53dz3rMY2CyyclHx10OXZJgs79L9kzn76loWbM2LiGlLDZuBNSCJucNzf6AlpgQYxN1
	0Pmg0t/6baxU/FrCYl8w9EulMwPm77s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782453249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHJX+/j6dKMpSwR1pPR5+WZRefWjtKKPN5BWHqL2m04=;
	b=cK7I7wxosCY2Int1G05vwrQsWbcLuiwSUyWXaXsPpLEeLrx8gNqu3OmNeZfvZdpK5WcS81
	GZqOIWo4aLK0P0BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RWaKDtRh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cK7I7wxo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782453249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHJX+/j6dKMpSwR1pPR5+WZRefWjtKKPN5BWHqL2m04=;
	b=RWaKDtRhFipsb/IW9aOHcqkFQyQZNjobycHlu6Rvb3y9cjJWoHkE8c491kuoJq8Piuulnl
	oYH53dz3rMY2CyyclHx10OXZJgs79L9kzn76loWbM2LiGlLDZuBNSCJucNzf6AlpgQYxN1
	0Pmg0t/6baxU/FrCYl8w9EulMwPm77s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782453249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHJX+/j6dKMpSwR1pPR5+WZRefWjtKKPN5BWHqL2m04=;
	b=cK7I7wxosCY2Int1G05vwrQsWbcLuiwSUyWXaXsPpLEeLrx8gNqu3OmNeZfvZdpK5WcS81
	GZqOIWo4aLK0P0BA==
Date: Fri, 26 Jun 2026 07:54:08 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, sshegde@linux.ibm.com, mkchauras@linux.ibm.com,
	kees@kernel.org, mark.rutland@arm.com, ryan.roberts@arm.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <aj4UAGaPdaI1wEED@kunlun.suse.cz>
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [2.49 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	RDNS_NONE(2.00)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[kunlun.suse.cz];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[kunlun.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,arm.com,lists.ozlabs.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b306:2000::2:from];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Spamd-Bar: ++
X-Rspamd-Queue-Id: 2A29A75BA2

Hello,

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
>  	add_random_kstack_offset();
>  	r0 = syscall_enter_from_user_mode(regs, r0);
>  
> +	/* Seccomp or ptrace may have set return value, skip syscall */
> +	if (unlikely(r0 == -1L))
> +		return regs->gpr[3];

this should use syscall_get_error instead of accessing the register
value directly. The error is represented differently in the scv and
non-scv case, and for non-scv case this will return wrong value.

Thanks

Michal

> +
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {
>  			/* Unsupported scv vector */
> -- 
> 2.54.0
> 

