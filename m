Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE39F606A32A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URGWjLaz
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTTlD2rgzz2xmk;
	Wed, 18 Nov 2026 02:52:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794930760;
	cv=none; b=ZuGdqVH2ZqhvrDdCHBu0HRn1uOFN6Vs8nExkK5GzLOchiRDNGOrQipHcANI0MY1JGBlQq56MXLNtvFjL/0PRLQmSACGujCKC4fKs7XIuz8y42cZxMvm+uY17mymoV2vxHYKl0k8YcMiKWiqBQH98mEJz1jh/hCB8IMjy0EYPO9H7/Nczn8efXzdzgbp5EmukYC+WjwwHiJW+/mUXVTghIAammq79wDFQpkl6wNVbX+thTwLeKs+r1ze4RmiDlzDnq0WB5/zUtWBOcQFIxr6vqT2R7Qy8POxvaU/UqbvxgMOddXtmJ0gqdBHbxINkqHrOVNmtYiOFlcPGskhtJ0DnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794930760; c=relaxed/relaxed;
	bh=rWQ3LCKx81yVb4ZPYmvkuNFKtOFNJfTl68Lxuk3875w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hB2xOmkgJLOpZk1KncFYY2vZij4dJc4CFoHKGJXs4rgfRusJl0FjQiDnbatWejP1n9RHde1jB/mfgfv09WvmgzjF15ypKvv8H/DMK5hOksGO6pHzPmH+nRHjSoWtKeMAkFEUz4OuyRHf/Jlrd1F/njaFR7PW7jl2IjXvd6q3+SyuxOIAUAQArLEwMpdxA8V4jIGni79r0VDV9B0Sz8gRjtHguVDpMX9jAxXFVthCxvu0T9FzFeOhJ/a6wxXXHocwaI+fz0tgqfA2k4t6aScZITiPlB+wgkCtzWZ/TBI3x17ifRi+XBimM4MfEZZCrPotouMs6zxoDhdx7+UhUDshAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URGWjLaz; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=URGWjLaz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTTlC2Xpnz2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 02:52:39 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 71DC04099F;
	Tue, 17 Nov 2026 15:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7A01F000C7;
	Tue, 17 Nov 2026 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794930757;
	bh=rWQ3LCKx81yVb4ZPYmvkuNFKtOFNJfTl68Lxuk3875w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=URGWjLazzCNyXLQoIZq8i+Ieeqm5wCpQGJa3a+x8rIKCdnXEJkzUl48TG7es5hN1t
	 aP23+qbwX5cDttOoJpIdRG2DNigYRritwoUMwYe5KGFybBNRKJT2cKLlO6S2VHwCX5
	 nTq11yf1pXMzhm3FpbRLshfnXfHG+9AUmH7xVqNnVZ3Sda/vcLAuqVhRPy1kCVnLNq
	 hWS+pU8vcqeNP/Jb3fhA2XXC1mHLAylbRZb8a+8164OusWf81YmV756sceh5ysQ1X1
	 yHPP7ilExlBiJ1uEbvfmlw5YbLkfvdHAmr3phQzeESesk8U2rDraLjNjIe++54oCc+
	 XRu+Xb4FIPsRw==
Message-ID: <07b9bd2b-19da-4e3c-9b01-552364a82269@kernel.org>
Date: Tue, 17 Nov 2026 16:52:31 +0100
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/4] powerpc/64: Leave lockdep hardirq context around
 replayed interrupts
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, stable@vger.kernel.org
References: <cover.1794924821.git.ritesh.list@gmail.com>
 <cfdac7c3508cf0eb1cbf063e7f6331dccb128796.1794924821.git.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <cfdac7c3508cf0eb1cbf063e7f6331dccb128796.1794924821.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 17/11/2026 à 15:25, Ritesh Harjani (IBM) a écrit :
> With PROVE_LOCKING, boot warns once and lockdep turns itself off:
>    DEBUG_LOCKS_WARN_ON(lockdep_hardirq_context())
>    WARNING: kernel/locking/lockdep.c:4448 at lockdep_hardirqs_on_prepare+0x22c/0x2d4, CPU#0: swapper/0/0
>    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.4.0-rc2-00027-g074831f06e18-dirty #123 PREEMPT
>    NIP:  c0000000002b2f2c LR: c0000000002b2f28 CTR: c000000002426f90
>    REGS: c000000004f075c0 TRAP: 0700   Not tainted  (7.4.0-rc2-00027-g074831f06e18-dirty)
>    MSR:  8000000002021033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 48022221  XER: 20040000
>    NIP [c0000000002b2f2c] lockdep_hardirqs_on_prepare+0x22c/0x2d4
>    LR [c0000000002b2f28] lockdep_hardirqs_on_prepare+0x228/0x2d4
>    Call Trace:
>      lockdep_hardirqs_on_prepare+0x228/0x2d4 (unreliable)
>      trace_hardirqs_on+0x98/0x11c
>      irqentry_exit+0x64c/0x1064
>      timer_interrupt+0x274/0x6bc
>      __replay_soft_interrupts+0x158/0x380
>      arch_local_irq_restore+0x1cc/0x244
>      console_flush_one_record+0x438/0x654
>      console_unlock+0xb8/0x1e0
>      vprintk_emit+0x300/0x56c
>      vprintk+0x20/0x34
>      _printk+0x40/0x54
>      lockdep_init+0xdc/0x104
>      start_kernel+0xa24/0xc68
>      start_here_common+0x1c/0x20
> 
> Since commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") a
> replayed handler always returns via irqentry_exit(), which traces hardirqs
> on while the replay is still inside irq_enter():
>    arch_local_irq_restore()
>      irq_enter()                        hardirq_context = 1
>      __replay_soft_interrupts()
>        timer_interrupt(&regs)
>          irq_enter_rcu()                hardirq_context = 2
>          irq_exit_rcu()                 hardirq_context = 1
>          irqentry_exit()
>            trace_hardirqs_on()          hardirq_context != 0 -> WARN
>        next_interrupt()
>          lockdep_hardirq_exit()         too late
> 
> Leave the hardirq context before each replayed handler instead of
> after it:
>    arch_local_irq_restore()
>      irq_enter()                        hardirq_context = 1
>      __replay_soft_interrupts()
>        lockdep_hardirq_exit()           hardirq_context = 0 // fix
>        timer_interrupt(&regs)
>          irq_enter_rcu()                hardirq_context = 1
>          irq_exit_rcu()                 hardirq_context = 0
>          irqentry_exit()
>            trace_hardirqs_on()          ok
>        next_interrupt()
>          trace_hardirqs_off()
>          lockdep_hardirq_enter()        hardirq_context = 1
>      irq_exit()                         hardirq_context = 0
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>   arch/powerpc/kernel/irq_64.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
> index d5c48d1b0a31..b189e796eb34 100644
> --- a/arch/powerpc/kernel/irq_64.c
> +++ b/arch/powerpc/kernel/irq_64.c
> @@ -75,12 +75,6 @@ static inline void next_interrupt(struct pt_regs *regs)
>   		WARN_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
>   	}
> 
> -	/*
> -	 * We are responding to the next interrupt, so interrupt-off
> -	 * latencies should be reset here.
> -	 */
> -	lockdep_hardirq_exit();
> -	trace_hardirqs_on();
>   	trace_hardirqs_off();
>   	lockdep_hardirq_enter();
>   }
> @@ -137,18 +131,21 @@ static __no_kcsan void __replay_soft_interrupts(void)
>   	if (IS_ENABLED(CONFIG_PPC_BOOK3S) &&
>   	    irq_happened_test_and_clear(PACA_IRQ_HMI)) {
>   		regs.trap = INTERRUPT_HMI;
> +		lockdep_hardirq_exit();

Can we include that in irq_happened_test_and_clear() instead of 
duplicating it 5 times ?

>   		handle_hmi_exception(&regs);
>   		next_interrupt(&regs);
>   	}
> 
>   	if (irq_happened_test_and_clear(PACA_IRQ_DEC)) {
>   		regs.trap = INTERRUPT_DECREMENTER;
> +		lockdep_hardirq_exit();
>   		timer_interrupt(&regs);
>   		next_interrupt(&regs);
>   	}
> 
>   	if (irq_happened_test_and_clear(PACA_IRQ_EE)) {
>   		regs.trap = INTERRUPT_EXTERNAL;
> +		lockdep_hardirq_exit();
>   		do_IRQ(&regs);
>   		next_interrupt(&regs);
>   	}
> @@ -156,6 +153,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
>   	if (IS_ENABLED(CONFIG_PPC_DOORBELL) &&
>   	    irq_happened_test_and_clear(PACA_IRQ_DBELL)) {
>   		regs.trap = INTERRUPT_DOORBELL;
> +		lockdep_hardirq_exit();
>   		doorbell_exception(&regs);
>   		next_interrupt(&regs);
>   	}
> @@ -164,6 +162,7 @@ static __no_kcsan void __replay_soft_interrupts(void)
>   	if (IS_ENABLED(CONFIG_PPC_BOOK3S) &&
>   	    irq_happened_test_and_clear(PACA_IRQ_PMI)) {
>   		regs.trap = INTERRUPT_PERFMON;
> +		lockdep_hardirq_exit();
>   		performance_monitor_exception(&regs);
>   		next_interrupt(&regs);
>   	}
> --
> 2.39.5
> 


