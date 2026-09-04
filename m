Return-Path: <linuxppc-dev+bounces-26520-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82A9C79F80
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:09:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmJ60qXNz2y2b;
	Fri, 04 Sep 2026 16:09:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788502150;
	cv=none; b=AeDVSMY571U+WVoAMo7aaJJw1MqgKEe3OcdKLaS9sGNoimSNtTE7XoX7tEotB6wq2F1KmU/kRcYtYmEnNaO3+v/0T8V0pFDXuD4PKuxMFGmvLzRyvmZmAsvbdo5yis2t56MV3suRpOluTRIes9NG/NjVQr40OxDsvSMVC7XHAjCpOL4xpXTpNpcO22Ai88iPh8jgs9mKlPOCJETGGlGrHqF4nGSjCj/KmDcUzhKjga54rxm7x0yoWkamWdlqNlOsM7kYRjHjZ3Wn9KptcjG5GImGDdzC0acCgZrxkIF8MSUJXGcV5BJtcJn0T1Cpo0b2YJJWCQpqyDtG/9SEDpGjOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788502150; c=relaxed/relaxed;
	bh=ykfieVvZNqtUa+4jWvCQTTFA2b6xsuqBfoeLrAe0uqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LKpwHgoSjYeE6P/DXC/wgVwi3i2Wg7uKLVquRD3H5aq+Bop6rlxXP0GC6OqUy38lI0FKXVp2LSQSZnWjcNwyfj6TwnkpCKJUlzan0xoZY4rGr3dzSrlT6bWlWZ5tjmQRj8LvYPuoHXAMiDnmazGuHyp8tYrucSOEhdGAu8OhyLPTqoA5Cz8nwVDmzGfRZD4ClKyVg7ClUQKYIIivuwJ7I++dCz75DsUxH/M0mc/x4+qNab5iuiGtjQnl4xkUbNqK6xv5bDU+bt05FjJp7ahEu3CyDQ8FS+Oy5nU7uLtOS3H4jQvyIvm/pvwGmxDPib7kGA0rhGfx9DOoXONPsJly+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1fXFY/S; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P1fXFY/S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbmJ46rP2z2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 16:09:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 69FA243999;
	Fri,  4 Sep 2026 06:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF8F1F00A3E;
	Fri,  4 Sep 2026 06:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502145;
	bh=ykfieVvZNqtUa+4jWvCQTTFA2b6xsuqBfoeLrAe0uqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=P1fXFY/Say3wJWn/3DLEhCoWyCe4uU/Z6AO/b3p409SgNVUl9xYp6kruuLVDZ3F0K
	 pN9jh74KW6FRGbnzMu9loZiTKh/oudilsJKCVmVzBB/EkJTWNPaB7HREAc73/0jLNP
	 qMS/KiggcALQ3y6RKrap4Nt+w791sW748pityCX7BIKok98/HvOzMrSU0APumOMxdW
	 hTLwYQMyH18P+qFsvS8gwEJyAce8fFmqKwybrqhEOYJ16BrxzYuxRT6oNmuVAanRR3
	 +7wRHhVUGXmw+woevJ4N6pjl27QYzthF8hMiFqiWP8Aeg2Tj0xcgB0oL4cZW7GKq/I
	 S4sKdnz/d6gtw==
Message-ID: <5c42b080-cdcb-43c8-9bf9-15f79339f0da@kernel.org>
Date: Fri, 4 Sep 2026 08:09:00 +0200
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
Subject: Re: [PATCH v2] powerpc/entry: Fix double accounting of user time on
 interrupt entry
To: Aboorva Devarajan <aboorvad@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Ritesh Harjani <ritesh.list@gmail.com>,
 "Nysal Jan K . A ." <nysal@linux.ibm.com>
References: <20260904025831.3439809-1-aboorvad@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260904025831.3439809-1-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/09/2026 à 04:58, Aboorva Devarajan a écrit :
> Since the switch to generic entry, an interrupt from user mode
> accounts user time twice: once in arch_interrupt_enter_prepare()
> and again in arch_enter_from_user_mode(), which irqentry_enter()
> invokes for the same interrupt:
> 
> 	arch_interrupt_enter_prepare()
> 	  account_cpu_user_entry()		/* first */
> 	irqentry_enter()
> 	  arch_enter_from_user_mode()
> 	    account_cpu_user_entry()		/* second */
> 
> The second call charges the same interval again, because
> account_cpu_user_entry() accumulates the time spent in user mode
> since the last return to user space.
> 
> The two calls come from the GENERIC_ENTRY preparation series,
> where each step was a no-op on its own. Commit 09a9d3a8499d
> ("powerpc: introduce arch_enter_from_user_mode") added the hook
> with the user-time accounting in it, but nothing called it yet.
> Commit 893082ac769b ("powerpc: Prepare for IRQ entry exit")
> copied interrupt_enter_prepare() verbatim into entry-common.h as
> arch_interrupt_enter_prepare(); that copy was equally unused, as
> handlers still called interrupt_enter_prepare().
> 
> Commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> made both live. On the syscall side it did the full conversion:
> system_call_exception() now accounts once through the hook via
> syscall_enter_from_user_mode(), rather than calling
> account_cpu_user_entry() directly. On the interrupt side it
> switched the handler macros to arch_interrupt_enter_prepare()
> followed by irqentry_enter(), which also runs the hook, but the
> accounting in arch_interrupt_enter_prepare() was not removed to
> match. The double accounting starts with that commit.
> 
> With CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y this roughly doubles the
> reported user time of any workload that takes interrupts. The
> other accounting modes compile account_cpu_user_entry() to an
> empty stub, so they are not affected.
> 
> Remove the accounting from arch_interrupt_enter_prepare() and rely
> on arch_enter_from_user_mode(), which already runs for both
> syscalls and interrupts. The duplicate account_stolen_time() call
> is removed the same way.
> 
> On a pseries LPAR a busy loop reports 6s user time in 3s elapsed
> (~210% CPU) before the fix, and 3s (~105% CPU) after it:
> 
>    $ python3 -c 'while True: pass' &
>    $ sleep 3; ps -p $! -o etime,time,pcpu
> 
>              ELAPSED     TIME  %CPU
>    Before      00:03 00:00:06   210
>    After       00:03 00:00:03   105
> 
> A 50% load reports ~70% usr / 30% idle before the fix, and
> ~49% usr / 51% idle after it:
> 
>    $ taskset -c 6 stress-ng --cpu 1 --cpu-load 50 &
>    $ mpstat -P 6 1
> 
>              CPU    %usr   %idle
>    Before      6   69.74   30.26
>    After       6   48.51   50.50
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

 > ---> Changes in v2:
>   - Explain which commits introduced each accounting call and how
>     they overlapped in commit message.
>   - Drop the code comment.
> 
> v1: https://lore.kernel.org/linuxppc-dev/20260902050628.2553909-1-aboorvad@linux.ibm.com/
> 
>   arch/powerpc/include/asm/entry-common.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
> index c5adb5006361..000fa925e26a 100644
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
> 
> base-commit: fb442a6673ff1046bf67754957d95880fdb394b5


