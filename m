Return-Path: <linuxppc-dev+bounces-23227-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C745FC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 17:19:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqVJL28bpz2yR5;
	Wed, 01 Jul 2026 03:19:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782839986;
	cv=none; b=TZ3PALupiYoWpmPIMXkQfyK4J2S1gaThGCYyVvjZ0AwdhxdVpHmfNtZ+bYwkvgETQUGRGFbphIYVXm524VKD7UuWp/0+157AJqrG1M4n/Nni+p4VWJ7Nb8NhxHv94u/Q1X0tC+BkYMvkRi/6MkZGzd9JrIIq+g+8DTDFACIP2eJopaRna/S4tGj7o5hHFYVx0JMbr7gGG8KPMLqk8YMcPWkctx8kY5uYByj0gUjftepCgeJlQv5wF0umOFywPy0yYMH0WMVu6Rz+obzBCCE+hDfWPG+QkgkFPOajSMlydx/mYJ+ObE6R6QIHqNOav1NhQXOE9nRRNHnwlxOSo96mBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782839986; c=relaxed/relaxed;
	bh=w4CIyJxvF1PC0s+b0aLNqrr76NOdy1GPgmiN/EM27To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLVtAbjDFJ/osc/gJRb6Bh9nxPfgetCneTU8yI25pjC3zpKEkpxk9npY0M+RxYNLlrD33QvoAo+gSmZX5NUedrNJnTIhPWyW4TfmU1PCUyyIlu1iLKDjUts6wZuPsmXXoyqlAkzvCNuc44t108QJkzw2qzfLHi3QgM/oFHpN3Yy3w8XpfldQAsEd/qF5Mf0CyPXEYVtW+Z6MnRr8+ZkeU+PS10znOo55QJF0n/SUPHTJsZbTv+CV5RAA1dduFKRKbSZ2xGiifIhVXMIT+6Gvo+wjUX4PCFqkpwoEzNFZ0CFWnl3bScZ/z2GHHMnZxOusiJPdAiqONEYsVivcvDd/CA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de; envelope-from=msuchanek@suse.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 100081 seconds by postgrey-1.37 at boromir; Wed, 01 Jul 2026 03:19:45 AEST
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqVJK31NZz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 03:19:45 +1000 (AEST)
Received: from kunlun.suse.cz (unknown [IPv6:2a07:de40:b306:2000::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 252FC71BA2;
	Tue, 30 Jun 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Date: Tue, 30 Jun 2026 19:19:40 +0200
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, mkchauras@linux.ibm.com, sshegde@linux.ibm.com,
	ryan.roberts@arm.com, ruanjinjie@huawei.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
Message-ID: <akP6rOF-fH7dIlUR@kunlun.suse.cz>
References: <20260629182946.419552-1-mkchauras@gmail.com>
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
In-Reply-To: <20260629182946.419552-1-mkchauras@gmail.com>
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
X-Rspamd-Queue-Id: 252FC71BA2
X-Rspamd-Action: no action

On Mon, Jun 29, 2026 at 11:59:46PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> After enabling GENERIC_ENTRY on PowerPC, seccomp filters using
> SCMP_ACT_ERRNO without an explicit errnoRet value return ENOSYS
> (Function not implemented) instead of the expected EPERM (Operation
> not permitted).
> 
> The issue occurs in system_call_exception() when syscall_enter_from_user_mode()
> returns -1 to indicate the syscall should be skipped (e.g., blocked by seccomp).
> The current code treats this -1 as a syscall number and compares it against
> NR_syscalls. Since -1 is greater than NR_syscalls,
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
> Also Move the syscall_enter_from_user_mode() call and the seccomp/ptrace
> skip check to after the NR_syscalls bounds check.
> 
> When syscall -1 was passed, the r0 == -1L check would trigger before
> the NR_syscalls check, causing syscall_get_error() to return 0 instead
> of -ENOSYS. This resulted in a silent success (ret=0, errno=0) instead
> of the expected ENOSYS error.
> 
> By moving syscall_enter_from_user_mode() after the bounds check, an
> initial syscall number of -1 is correctly rejected with -ENOSYS first.
> The seccomp/ptrace skip path still works correctly for valid syscall
> numbers that get overridden to -1 by seccomp or ptrace.
> 
> This aligns PowerPC's behavior with other architectures using GENERIC_ENTRY
> and restores correct seccomp errno handling.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reported-by: Michal Suchánek <msuchanek@suse.de>

Tested-by: Michal Suchánek <msuchanek@suse.de>

Reviewed-by: Michal Suchánek <msuchanek@suse.de>

Thanks

Michal

> Closes: https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
> 
> v1 -> v2:
>  - Fix issues in the previous fix (Michal)
> v1: https://lore.kernel.org/all/20260624171520.772408-1-mkchauras@gmail.com
> 
>  arch/powerpc/kernel/syscall.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index a9da2af6efa8..36d73933a311 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -20,7 +20,6 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>  	syscall_fn f;
>  
>  	add_random_kstack_offset();
> -	r0 = syscall_enter_from_user_mode(regs, r0);
>  
>  	if (unlikely(r0 >= NR_syscalls)) {
>  		if (unlikely(trap_is_unsupported_scv(regs))) {
> @@ -31,6 +30,12 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>  		return -ENOSYS;
>  	}
>  
> +	r0 = syscall_enter_from_user_mode(regs, r0);
> +
> +	/* Seccomp or ptrace may have set return value, skip syscall */
> +	if (unlikely(r0 == -1L))
> +		return syscall_get_error(current, regs);
> +
>  	/* May be faster to do array_index_nospec? */
>  	barrier_nospec();
>  
> -- 
> 2.54.0
> 

