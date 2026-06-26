Return-Path: <linuxppc-dev+bounces-23026-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B0BC43327
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2026 14:31:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmymW03Kdz2yYf;
	Sat, 27 Jun 2026 00:31:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782484314;
	cv=none; b=J3573gmPzlgCTcXzgfcOVSPxI1mmNs4tVKvpoOnrLhWrVVo893TR/MItj33Kgl0AydHw2bdSqlgFFCEQDfb0J9bRBWOYEPlxVdxECKyi4SnP9DbsgEmpK1pVsG2Q46Q61i9vMPS3uFjpCpZBpGOrTn7NlNlttqPWuZVmozz0Acm/qaRPr6ch9C1P/Rny+Q+CnutcwKWaMsnMLW9jlajCOpCp4miSSXQ9mNOKmJtWFxv3gPi80gCB2p5fwX9hbAvqRs8tmTJ0wYGFH7u6OPwE5Vaf12OAWZHzyUihV5oukuf/RPdHaMj2JmcECsG6jGl2+LfybeuW+KocdeC3Hc1J1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782484314; c=relaxed/relaxed;
	bh=i0wu8Q+145AvrvTbKuoqi8x8L/c1FZs+98nHo/LrncA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UoGQ4Vf+6GvVqT7zwOrixR5DHVmO76ujObOgaw3YryQ+WpGzh/fitFVdx/C2YBQgbCdc6dc5uvr3LStpTbU7UTcAPEC4onE2zu0DFfLyMAN6UmKEB/bciNer5MdGYGICbm5EZEpLcGORL53s0a8BNvVEWu8fPC+chvRugAvJExLWwv/WIuWj6QLhwzKGRpyvnl7AURL++Ry5UVGySbBMOcp0bZTl/cNv+Y5VSPHNmPpZmaU6cx15gaSk31NDgJ82t/gu9k6SW9su6nfbC+/W8+2UNB43frPjAp9rMwNzqnf6wHv8dudozJP+Vpv55F1arNVq74e3H/VJJ/yHWWxGbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fn1SIcXU; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fn1SIcXU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmymV1c65z2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jun 2026 00:31:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EBF894148B;
	Fri, 26 Jun 2026 14:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD02A1F000E9;
	Fri, 26 Jun 2026 14:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782484311;
	bh=i0wu8Q+145AvrvTbKuoqi8x8L/c1FZs+98nHo/LrncA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Fn1SIcXUvaCc2WIKpXFJng++cv0dJioTlTBlat5BSRME4QAgFkka7Jc04AA17TrCa
	 qI1TkECYX0juNllZKBq9kan+sZgIilcFAmgp+4D7cdZ8UZoENHSShJT2+55Y+EV+3J
	 LVLELPV5GgszkctmNXzPFgxsylZD8+wsGeoxCxZeJTHlD3Adh4EYvAf8oHv3Rxzoed
	 YgSwBX7k9dVjKANDZ+63FdSZAbOmI8gDnulKcLtInVHU5UjafDrKCRVPGE/0tVy+Bu
	 EYvLQyV5yW34+CD521wlj194xfqlxaWrdvv6LE/Ynb3iB2ZpDb2S6y9FW3+RqXwLHJ
	 BNU/XEj/izWBw==
Message-ID: <17eecc4d-ae7b-4c32-9edc-d3b8e131549c@kernel.org>
Date: Fri, 26 Jun 2026 16:31:47 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc/syscall: Fix seccomp errno handling with
 GENERIC_ENTRY
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 sshegde@linux.ibm.com, mkchauras@linux.ibm.com, kees@kernel.org,
 mark.rutland@arm.com, ryan.roberts@arm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
References: <20260624171520.772408-1-mkchauras@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260624171520.772408-1-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 24/06/2026 à 19:15, Mukesh Kumar Chaurasiya (IBM) a écrit :
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

Closes: https://lore.kernel.org/all/ajpp-_XnbF3UTM_E@kunlun.suse.cz/

> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>   arch/powerpc/kernel/syscall.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
> index a9da2af6efa8..5b58c8d396c8 100644
> --- a/arch/powerpc/kernel/syscall.c
> +++ b/arch/powerpc/kernel/syscall.c
> @@ -22,6 +22,10 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
>   	add_random_kstack_offset();
>   	r0 = syscall_enter_from_user_mode(regs, r0);
>   
> +	/* Seccomp or ptrace may have set return value, skip syscall */
> +	if (unlikely(r0 == -1L))

Is it really needed to add the L after 1 ?

> +		return regs->gpr[3];
> +
>   	if (unlikely(r0 >= NR_syscalls)) {
>   		if (unlikely(trap_is_unsupported_scv(regs))) {
>   			/* Unsupported scv vector */


