Return-Path: <linuxppc-dev+bounces-26430-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93739C61DFD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 05:36:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZWgH6W2lz2xyl;
	Wed, 02 Sep 2026 15:36:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788327387;
	cv=none; b=VQH4Wun+zcj6Mmvtf6BPhzscHwY4ynFZGt2ErJNLqDIIjlHhN4AV4qZfJkT3LT5MHv6YBFhiH9JoodFsbh/7R8CWk4auhfwx63dLNlc8SVgMiu+/SxwOsln+SHVFQg+8a+N5X46NsEroIO8lEhjTZ+GQ+YcFEaoKQfSKax7gotdnMbO2tG1cpeFZVqHDfKbXOoZKG8ogwmLmW+rrMBVQ/5gF3mMIFGrGy1CvXG4hOI+AGG83eAtB6r4Nv9wjKVGmss42j/EIVFtn390/0jTyZOajDdCKWpVwWTq7po1oNQO65cZExMWz4lEbodqHpZjAlX7CCHaMrIhptdTJMwfh+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788327387; c=relaxed/relaxed;
	bh=jyzYoXCRm/+tjQ+fROHfpYCMy4+lHSWupjhgvEHZkcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aP15kvqDtOSLGihXDUgNAMNwhr5hJpXfyhRSVwhxnqrnx6oHQbBHMOOezxK83Tsa9nbLeHRqztQ0HkTGaRRi+4muzPab3CXKHXMsWeVhf2vNQ6C/zc34jaedb8v31rZcewpsgrybhpMKJfHTT4hRq1JWq1wMkZbAXvtHiiOspWYtDl/d+i7TnHkoSEPmxWP0yHQHJVA1bpBYXMYrcw2+64wOQC3A3BLusdlAALfDA6Lr9FX4lmJFp9E9IFzsD3/PfTawqMA06N3mIMYHIoCX5SQqMYXUUZ3N7MBFAXowKtVLwkwPF0J+VnlGAeBb4iXyHH3G+zFHAMw0IbXxuNFqug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHZCCKpu; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHZCCKpu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZWgG6YCmz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 15:36:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0262360229;
	Wed,  2 Sep 2026 05:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F5F1F000E9;
	Wed,  2 Sep 2026 05:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327383;
	bh=jyzYoXCRm/+tjQ+fROHfpYCMy4+lHSWupjhgvEHZkcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nHZCCKpuW66tiUxQ1gIcOIpxpVnZrKV+h5ZBhsjzp1xgyZXNHcoHK8tGhCWmuX0GO
	 R7sus+SR6/Vz89lpmbKDNygNkKfZDdrUNNkCPJQoQMIiKR9eftMQ8VJF+CTSDKxwR6
	 Lydg9lzZ2LWwqYQ4PNdhQxgzeNFPOHbCuJdnd8O7gbWkyNhvAOtXMQFqEbRYczJUsM
	 2+8v6lV6OTFMmTyR8KX1xkRJG3a6wBoysLRpxlJqSbAzSlMEEa53CUFwY1PAa0JrOU
	 EcUYw8aH2Ns5akkNKgM6mTvuYZrtIr2TQVEKaMfqTQfQphz4IsFWV7C/ZshVUj71c5
	 8PQADmTkyfjAg==
Message-ID: <cd25ffa5-5efc-42f1-b145-0c1c6539b4c4@kernel.org>
Date: Wed, 2 Sep 2026 07:36:17 +0200
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
Subject: Re: [PATCH] powerpc/entry: Fix double accounting of user time on
 interrupt entry
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Ritesh Harjani <ritesh.list@gmail.com>
References: <20260902050628.2553909-1-aboorvad@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260902050628.2553909-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/09/2026 à 07:06, Aboorva Devarajan a écrit :
> Since the switch to generic entry, an interrupt taken from user mode
> accounts user time twice: once in arch_interrupt_enter_prepare() and
> again in arch_enter_from_user_mode(), which irqentry_enter() invokes
> for the same interrupt:
> 
>    arch_interrupt_enter_prepare()
>        account_cpu_user_entry()
>    irqentry_enter()
>      arch_enter_from_user_mode()
>        account_cpu_user_entry()
> 
> account_cpu_user_entry() accumulates the time spent in user mode
> since the last return to user space, so the second call charges the
> same interval again.

One of them was added by commit 09a9d3a8499d ("powerpc: introduce 
arch_enter_from_user_mode"), the other one by commit 893082ac769b 
("powerpc: Prepare for IRQ entry exit"). Would be good to mention it and 
explain how it went wrong.


> 
> With CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y this roughly doubles the
> reported user time of any workload that takes interrupts. On a
> pseries LPAR, ps/top show ~200% CPU for a single-threaded CPU-bound
> loop, and time(1) reports user time about twice the elapsed time.
> 
> Remove the accounting from arch_interrupt_enter_prepare() and rely on
> arch_enter_from_user_mode(), which runs for both syscalls and
> interrupts. The duplicate account_stolen_time() call is removed the
> same way.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")

Not sure it is the correct commit. Should probably be one of the ones 
that introduced the wrong call.

> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
> Verified on a pseries LPAR (CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y),
> 7.3.0-rc1, single-threaded CPU-bound loop:
> 
> Before:
> 
>    $ python3 -c 'while True: pass' &
>    $ sleep 3; ps -p $! -o pid,etime,time,pcpu
>        PID     ELAPSED     TIME %CPU
>       4980       00:03 00:00:06  210
> 
> After:
> 
>    $ python3 -c 'while True: pass' &
>    $ sleep 3; ps -p $! -o pid,etime,time,pcpu
>        PID     ELAPSED     TIME %CPU
>       4951       00:03 00:00:03  105
> 
>   arch/powerpc/include/asm/entry-common.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index c5adb5006361..984294e62568 100644
> --- a/arch/powerpc/include/asm/entry-common.h
> +++ b/arch/powerpc/include/asm/entry-common.h
> @@ -222,8 +222,6 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
>   
>   	if (user_mode(regs)) {
>   		kuap_lock();
> -		account_cpu_user_entry();
> -		account_stolen_time();
>   	} else {
>   		kuap_save_and_lock(regs);
>   		/*
> @@ -426,6 +424,10 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
>   #endif
>   	kuap_assert_locked();
>   	booke_restore_dbcr0();
> +	/*
> +	 * User and stolen time is accounted here for every entry from
> +	 * user mode. The interrupt prepare hooks must not account again.
> +	 */

Don't polute the code with such a comment. This is to be explained in 
the commit message. First a comment shall tell what code does, not what 
it doesn't do. And the comment has no added value, when you see 
account_cpu_user_entry() is called you already know that.

Here you feel the need to add such comment, but if you had implemented 
this function yourself and done it right at the first time, would you 
have felt the need for this comment ?

Have a look at https://docs.kernel.org/process/coding-style.html#commenting

>   	account_cpu_user_entry();
>   	account_stolen_time();
>   
> 
> base-commit: fb442a6673ff1046bf67754957d95880fdb394b5


