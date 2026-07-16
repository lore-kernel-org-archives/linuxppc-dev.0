Return-Path: <linuxppc-dev+bounces-24321-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA4CC44511
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2026 16:34:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h1JXb5rdWz3brH;
	Fri, 17 Jul 2026 02:34:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784219663;
	cv=none; b=E8607Z6O6kb9Zy2LRZ0sgvYNmPzVQB/IjLIbc6VRsJBA5+csId+vWYciz1L7SocqTFxKO3LdjsfWMdhH89eK8pnQSYlHF2PSQivaw/QD9/MK/8doCNl5DWCZWhWjLWXLLZOmVQg31/O5mJBTX1IhydCHTbeFZQQ1atnpiVcwMDeJkHYH4+ww4kRR9u72UgKbdeHgto7VGH7LFdmyJhviSqo/EE3dm3qnJ6sN+jgv2VdmLJl6aqvbRbcFJ1LfY7JKLDijN9KfuGyZQxMj1XEhwsuafTGwfVPffwWCxKBEaePV4lRNtsfopSscpGhuKYrsIuFHtCr/5k1T2YKrRZfa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784219663; c=relaxed/relaxed;
	bh=hRIlkUFNXSnVjl7nU+5tayy/Q9Hmh7cE9CUYAHl6yoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CQyICDBks2268RKceAW8UQpiSQ56ZiXtU1ZBKj2F7inQggMTK21bPyytisgR+67AsPOu9P6m7wn+YgIEkn3NtS2TpqGPdpLKhTvOUasXVtmwsaeE6eR8qL5vf/x/xImgGxMUV7X3j0139MqD3i4Zz+jvtCFNCHGRwHWhYO4HZtJqXr2fYy4bK4FaUUZlicTHgkwgngqxmSafm8OtTGyToPvB+aF1LoX47crdgclcC/2WInKe99xGFP65xBST7QqEl599Wi6RWvHDwbBm29aSWzzo6GhElz6tnNX2hBydFseRvjq0gymlHm0flLTDv8ynpGRRIjr515oFVDnUWCIevg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=T9Gua9OZ; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ag72+Rsg; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=T9Gua9OZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ag72+Rsg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=john.ogness@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h1JXY1hxMz3br2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2026 02:34:21 +1000 (AEST)
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784219654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hRIlkUFNXSnVjl7nU+5tayy/Q9Hmh7cE9CUYAHl6yoU=;
	b=T9Gua9OZZYS3jIf2+UWaoK9o0KgnknLUNYZjXTizXrKaJ1WlBGIvL1pro3nTM2BH1H4pvJ
	eqnUq1BFMgoUssbmK5Y6szfQ67xK2PPrvv+UBhzSXOaGqGsl2rSw7KVo0AeqH5P/fRLc5E
	0ctxEpKQd4F1+fOKZWe3s+eeaGJDUO6Ooqp4RdK1rkHZC5Je96URx7QHPKqH35wK9O07sI
	Cz61oTrL71Jw17vEQJwa37H/W/RW5FR7vedKNn80XcS1Dop9Rgcns4yTw/5PNc9XtKkZyo
	qcEUZLUxnoAhVPMK1yQk7f2bftEllybJ5uNLY0EOdMSlugUFUmp+SdW7SedOWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784219654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hRIlkUFNXSnVjl7nU+5tayy/Q9Hmh7cE9CUYAHl6yoU=;
	b=ag72+Rsg+CTxnC0Xc6VdHmqDhZS8KPz3VORx9pohNemeldpQz8j3jZCDorYby2oXR/Ojqp
	SIhDRpwP7BELVwAQ==
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, sshegde@linux.ibm.com, mchauras@linux.ibm.com,
 mkchauras@gmail.com, ruanjinjie@huawei.com, thuth@redhat.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] powerpc/970: fix nap return address corruption on async
 interrupt exit
In-Reply-To: <20260707172430.790040-1-mkchauras@gmail.com>
References: <20260707172430.790040-1-mkchauras@gmail.com>
Date: Thu, 16 Jul 2026 18:40:13 +0206
Message-ID: <87fr1iq4fu.fsf@jogness.linutronix.de>
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

On 2026-07-07, "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com> wrote:
> On PowerMac G5 (PPC970, CONFIG_PPC_970_NAP) the system panics shortly
> after boot with symptoms including instruction fetch faults, kernel data
> access faults, and stack corruption, predominantly on SMP and always
> somewhere inside softirq processing.
>
> The PPC970 idle path works by setting _TLF_NAPPING in the current
> thread's local flags before entering the MSR_POW nap loop.  When any
> async interrupt wakes the CPU, nap_adjust_return() is expected to detect
> _TLF_NAPPING, clear it, and rewrite regs->NIP to power4_idle_nap_return
> so that the interrupt returns cleanly to the caller of power4_idle_nap()
> rather than back into the nap spin loop.
>
> DEFINE_INTERRUPT_HANDLER_ASYNC generates the following sequence:
>
>     irq_enter_rcu();
>     ____func(regs);           /* timer_interrupt / do_IRQ body */
>     irq_exit_rcu();           /* softirqs run here, irqs re-enabled */
>     arch_interrupt_async_exit_prepare(regs); /* nap_adjust_return was here */
>     irqentry_exit(regs, state);
>
> irq_exit_rcu() calls invoke_softirq() -> do_softirq_own_stack(), which
> runs softirqs with hardware interrupts re-enabled.  A nested async
> interrupt can therefore arrive while _TLF_NAPPING is still set.  That
> nested interrupt reaches nap_adjust_return() in its own
> arch_interrupt_async_exit_prepare() call, finds _TLF_NAPPING set, and
> redirects *its own* regs->NIP to power4_idle_nap_return.  Returning via
> that blr with an unrelated LR on the softirq stack jumps to a garbage
> address, causing the observed crashes.
>
> The comment that previously lived in arch_interrupt_async_exit_prepare()
> even described this exact hazard ("must come before irq_exit()"), but
> nap_adjust_return() was placed after irq_exit_rcu() in the macro, so
> the protection was never effective.
>
> Fix this by calling nap_adjust_return() inside DEFINE_INTERRUPT_HANDLER_ASYNC
> immediately before irq_exit_rcu(), ensuring _TLF_NAPPING is cleared and
> regs->NIP is adjusted before any code that can re-enable interrupts or
> invoke softirqs runs.  Move the explanatory comment into
> nap_adjust_return() itself and remove it from arch_interrupt_async_exit_prepare().
>
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Closes: https://lore.kernel.org/all/87wlvazrdy.fsf@igel.home/
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Tested-by: John Ogness <john.ogness@linutronix.de>

Would be nice to see this in 7.2-rc4

