Return-Path: <linuxppc-dev+bounces-24725-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B6DC531CB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 11:52:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5TyR0Qwvz2xs1;
	Thu, 23 Jul 2026 21:52:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784807566;
	cv=none; b=FHN0PjJft36+ttqpvcUDwR2t4zxn2MYMkUolapHhXFSW5L73Ck11wLHBn/BOYTb9CF6zsnX7PZc+OoZ5tQzXE9BiRDZD6+ooMsrt15HF/dHVQvvaJPeuxcSqy/fU7pgTYvGvrg2G9huJOLEjUK04TjTakB4CzeLNT4qvOAZ3OqoWpQJGqShm4296NVNo8IK77zZ3c2tanCUBG9RS1fYXgUkSn9sBAVCJkTnQRSS1XcxsQamDndssAg88gHLl9Y3IgOEfJ9UcksVGwY1MFr2+21CjsmTTNd2p4cwjSD3Sov4E4fjBrrbmiV69P445w8sVqlkbsH+TkxsWW7Y9/h3x4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784807566; c=relaxed/relaxed;
	bh=QmXY88KWedCv3LgNMTTpRBbPejN5wfvGcvmWOTilvG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=omxgou7tItAIv69WOm6uO2xkagSzvAZOQwD4xwbhh4P3elZXgofx9edXl7/zoCEJM5KMJmBP2nuPMcgyLk2pWcZuqAW3cCBn4vQH22h2+cLD32uVY1DFnpFYrXeUJfvy4khGABgNZNu1919kaPlqsy3j4Bprq9jlhAUPBSE4fSyjCTQ+l4oLoxyC0GC3LBU8pBoxPtdrlHgSDY+FvVRRZkPYlyNwGFjuIysYJ75r6NjgbkzNMjSiWYlSiD8PNeUhTu4nm6Faj7azFc0yKZBLgEMwFSxv2recUPA2nBa+64Uv6+KcNLVVfFmXxihvKXC4vSu/wXYpb58yvElrV9RlGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pLbeLY7f; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Fa5fKgOi; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pLbeLY7f;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Fa5fKgOi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5TyP1mrFz2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 21:52:45 +1000 (AEST)
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784807559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmXY88KWedCv3LgNMTTpRBbPejN5wfvGcvmWOTilvG0=;
	b=pLbeLY7ftasf5v/3N2fbp3kzHhWikfUL5UjHjg9X6G4idARRQQZJ0xrcQW0Nz4oGBssk3W
	i0nK5LT8UCrHDHsPi6VHpJ32yglb0SkcTnegqxDuMcnOGjEHCo4Bn38CbFqiDYZz1V+wGz
	t5ANMX5z4Onf077mmoZFJ6EBjUkw0Ez3e5S4qZnksV0JzStN+uLZlgmRKw1j6DcjDpYuc4
	CNH6cC04ygsGkIbhsmYeKlx3U4H2b8yTPN1YfSYLtxs8OBudfSwXDvsnw+IvflG7e0Ar21
	/4oxOyuokuGuea4wv3qwU1OYQwP83VUdL9q0XMgCtYDWfmuXrdytzCa9mvRv2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784807559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QmXY88KWedCv3LgNMTTpRBbPejN5wfvGcvmWOTilvG0=;
	b=Fa5fKgOi4cavQvrj3OSEmlriU+6oB43AauIJos28z7uDpB9DAqg0tELJjqZk+KP0szNuE/
	IYCbP9/o/B0jJhBg==
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, sshegde@linux.ibm.com, mchauras@linux.ibm.com,
 mkchauras@gmail.com, ruanjinjie@huawei.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] powerpc/970: fix nap return address corruption on async
 interrupt exit
In-Reply-To: <87fr1iq4fu.fsf@jogness.linutronix.de>
References: <20260707172430.790040-1-mkchauras@gmail.com>
 <87fr1iq4fu.fsf@jogness.linutronix.de>
Date: Thu, 23 Jul 2026 13:58:39 +0206
Message-ID: <87h5lpq5x4.fsf@jogness.linutronix.de>
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
Content-Type: text/plain

On 2026-07-16, John Ogness <john.ogness@linutronix.de> wrote:
> On 2026-07-07, "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:
>> On PowerMac G5 (PPC970, CONFIG_PPC_970_NAP) the system panics shortly
>> after boot with symptoms including instruction fetch faults, kernel data
>> access faults, and stack corruption, predominantly on SMP and always
>> somewhere inside softirq processing.
>>
>> The PPC970 idle path works by setting _TLF_NAPPING in the current
>> thread's local flags before entering the MSR_POW nap loop.  When any
>> async interrupt wakes the CPU, nap_adjust_return() is expected to detect
>> _TLF_NAPPING, clear it, and rewrite regs->NIP to power4_idle_nap_return
>> so that the interrupt returns cleanly to the caller of power4_idle_nap()
>> rather than back into the nap spin loop.
>>
>> DEFINE_INTERRUPT_HANDLER_ASYNC generates the following sequence:
>>
>>     irq_enter_rcu();
>>     ____func(regs);           /* timer_interrupt / do_IRQ body */
>>     irq_exit_rcu();           /* softirqs run here, irqs re-enabled */
>>     arch_interrupt_async_exit_prepare(regs); /* nap_adjust_return was here */
>>     irqentry_exit(regs, state);
>>
>> irq_exit_rcu() calls invoke_softirq() -> do_softirq_own_stack(), which
>> runs softirqs with hardware interrupts re-enabled.  A nested async
>> interrupt can therefore arrive while _TLF_NAPPING is still set.  That
>> nested interrupt reaches nap_adjust_return() in its own
>> arch_interrupt_async_exit_prepare() call, finds _TLF_NAPPING set, and
>> redirects *its own* regs->NIP to power4_idle_nap_return.  Returning via
>> that blr with an unrelated LR on the softirq stack jumps to a garbage
>> address, causing the observed crashes.
>>
>> The comment that previously lived in arch_interrupt_async_exit_prepare()
>> even described this exact hazard ("must come before irq_exit()"), but
>> nap_adjust_return() was placed after irq_exit_rcu() in the macro, so
>> the protection was never effective.
>>
>> Fix this by calling nap_adjust_return() inside DEFINE_INTERRUPT_HANDLER_ASYNC
>> immediately before irq_exit_rcu(), ensuring _TLF_NAPPING is cleared and
>> regs->NIP is adjusted before any code that can re-enable interrupts or
>> invoke softirqs runs.  Move the explanatory comment into
>> nap_adjust_return() itself and remove it from arch_interrupt_async_exit_prepare().
>>
>> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
>> Closes: https://lore.kernel.org/all/87wlvazrdy.fsf@igel.home/
>> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
>> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
>
> Tested-by: John Ogness <john.ogness@linutronix.de>

Is there a reason this is not being queued for 7.2? Without this fix,
PPC970 machines cannot boot 7.2.

John Ogness

