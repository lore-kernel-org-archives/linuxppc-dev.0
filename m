Return-Path: <linuxppc-dev+bounces-24951-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097D6C531F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 16:22:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8ghm24wnz2xyh;
	Wed, 29 Jul 2026 02:22:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785255720;
	cv=none; b=TXOcmPvoIjJx9NyCnbGZSJfJeDBIbFgDmNa+CY3324S68q5VbnDJ30uwBpeeR/MxUO4V814IdUbOC+M/w7bst9A25KCQRtEVAqFY7UvEXh1w89jIs2LOG78TyN425Ri+KtgDVflmvi8zS9qN+K+NjYjmryrqHaQ4QYEeMxLW3V/8J9eDt/JxIk89Yw9Piw7VuGgaAgJZNySBdCHPG9mLA/leuXrU9k6jARs0KnIJhJ6eQBf38Q4jxTrkhSxFSXBUYOiXeuBf91E5zO5jNM5tXkwLel9ioi6XLKnYg7DO+8RP3QrkMZSp6GzyMOB74yIrEsr1BXkM9+GbA46PSL211A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785255720; c=relaxed/relaxed;
	bh=ZuXqXUCeMXh1eFLuuoLpFfDDPdjHU+CC2srwMejL7dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IabpmhZLTUg8m8auF+Z36Pq7lFq+o3Z1Ecb7eVpWRfXmqqNrGE9Wt5nQEH2ZDdho0tKMNhrw7K1gwerJcbE9dgVv2T1NwgE2n68zkQzFhZtDrHu2V+5Gk9u3NlxkzpHwAG2zgiWqSn9+ZMCrlq0sCY4xu3wyAie8EWfDG2AUsJkmiwfnLBufwg2XejLLkdEkJVGh44Y2q/LexECsi5EC3DfQZ/C+JHB0zEvgUuth7nOGGFj+T0pJ6WUKJLPRAk2tBhQHX5ystpaEsFJQTsESUjrXKYdTeyk/KqDHsTSddevPv9DdSzH6hUQJFfr0+flO2Tsp5LEp1N2+sqyS5S5KJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ci6KYTDK; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=jrcz=fw=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ci6KYTDK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=jrcz=fw=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8ghl1LWQz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 02:21:59 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CEA87600FC;
	Tue, 28 Jul 2026 16:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824DD1F000E9;
	Tue, 28 Jul 2026 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785255715;
	bh=ZuXqXUCeMXh1eFLuuoLpFfDDPdjHU+CC2srwMejL7dI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ci6KYTDK79cbkpafi3S/Cq5sqLCzZiE9i2gF139c2ydxq17w6uI00uq5zpLBRog2I
	 fIOCeSAoqm84+t0cf/cWOqeXRGXq4uNa+pfl9HkQ/whrsu4sJTn4fDZ4gvwDkXpdQn
	 ZsZy/eFuEpd4hU+h5da/L7WqUWFJ3yjoOtFFvqNdft1LL047d4+19aWAdjq7+mPmeE
	 FFaurUaB/Q1bOmLt2fj6uvq1/OUfdfqrre8j1ejhsAuSue7dHuz3rZ0YOrLwYFT4eP
	 RYYjVWYRnAIA//REILxT3YC7cgn+cLKJDWRG3yVd+dfTSor747mviCZebhRL4FNB65
	 GqDrMbcfqZ/rw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 30B1FCE133F; Tue, 28 Jul 2026 09:21:55 -0700 (PDT)
Date: Tue, 28 Jul 2026 09:21:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jirka Hladky <jhladky@redhat.com>, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
Message-ID: <39449915-04f2-4259-a6d9-1a2c1fcf9a63@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250210184334.567383-1-sshegde@linux.ibm.com>
 <20250210184334.567383-2-sshegde@linux.ibm.com>
 <CAE4VaGBwMp3Ke1+Bt11-v6CCE0h=mPm8k_Cf8DazFSQNT9Mz8g@mail.gmail.com>
 <c0f51eda-21c4-4e9d-95e9-75b2740c3f43@linux.ibm.com>
 <500d8e8c-088c-4e6d-ab53-868ade6b0eda@paulmck-laptop>
 <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <f81777c3-e341-4ec5-8d61-b333d7170b3f@kernel.org>
 <82752e9b-ed94-4253-ac5f-83cd3c91d569@linux.ibm.com>
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
In-Reply-To: <82752e9b-ed94-4253-ac5f-83cd3c91d569@linux.ibm.com>

On Tue, Jul 28, 2026 at 10:57:57AM +0530, Shrikanth Hegde wrote:
> Hi Paul, Christophe,
> 
> On 7/27/26 11:59 PM, Christophe Leroy (CS GROUP) wrote:
> > Hi Shrikanth,
> > 
> 
> > 
> > That's right with CONFIG_PREEMPT_DYNAMIC=y
> > 
> > With CONFIG_PREEMT_DYNAMIC=n:
> > - CONFIG_PREEMPT (full) implies CONFIG_PREEMPT_RCU
> > - CONFIG_PREEMPT_LAZY (lazy) doesn't imply CONFIG_PREEMPT_RCU
> > 
> > because of kernel/rcu/Kconfig,
> > 
> > config PREEMPT_RCU
> >      bool
> >      default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> >      select TREE_RCU
> > 
> > Christophe
> > 
> > 
> 
> Right.
> 
> Looks like __rcu_read_unlock can set need_resched bit if it find irq were disabled
> and rcu_read_unlock_special.s is set. I don't have much clue about it.
> So, after seeing __rcu_read_unlock for PREEMPT_RCU I have these concerns now.

This is because irq-disabled regions of code act as RCU readers.
For non-preemptible RCU (even in CONFIG_PREEMPT_LAZY=y kernels), this
comes for free.  In contrast, preemptible RCU must explicitly (and,
as you noticed, rather painfully) handle the irq-disabled case:

	rcu_read_lock();
	do_something();
	local_irq_disable();
	do_something_else();
	rcu_read_unlock();
	do_yet_another_thing();
	local_irq_enable();

Here, the RCU reader extends all the way from the rcu_read_lock() to
the final local_irq_enable().  And this is why RCU checks for IRQs being
disabled in __rcu_read_unlock().

> In current upstream, lazy is a preemption mode with preempt_enable being a preemptible point,
> 
> 1. If PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n, then PREEMPT_RCU=n. That seems wrong. It is supposed to
>    do the preemption checks, since preempt_count is actual count with lazy preemption.

Sorry, but no, not wrong at all.  This is the way that it is supposed
to be.  In this configuration, RCU readers explicitly disable preemption.
This gets us minimal RCU overhead on architectures such as x86 and arm64
that have prohibited CONFIG_PREEMPT_NONE and CONFIG_PREEMPT_VOLUNTARY.
Not zero overhead, but minimal overhead given the constraints imposed by
CONFIG_PREEMPT_LAZY.  This also prevents preemption of RCU readers, which
is extremely important on datacenter servers that have good and sufficient
quantities of memory, but which are not well-endowed with memory.

> 2. PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n and PREEMPT_LAZY=y and PREEMPT_DYNAMIC=y are supposed
>    to be similar w.r.t to performance.

RCU never made that promise.  ;-)

With PREMPT_DYNAMIC=y, RCU has no choice but to be preemptible, at
least unless and until someone decides to make RCU's preemptibility be
changeable at runtime (which I do not recommend).  And we really do need
non-preemptible RCU for server workloads.

So it is not just that RCU never made that promise, it is that RCU cannot
reasonably make that promise.

>                                        Promise of PREEMPT_DYNAMIC was the ability to
>    switch at runtime based on the user workload and his/her preference.
>    But with  PREEMPT_LAZY=y and PREEMPT_DYNAMIC=y, there is additional cost due to PREEMPT_RCU.
>    lazy being the middle ground w.r.t for decent performance, either PREEMPT_RCU should either kick in
>    for both cases or bail out for both.

Absolutely not!!!  Please see above.

> Before 7.0
> 3. the same concerns would be true to PREEMPT_VOLUNTARY and PREEMPT_NONE with PREEMPT_DYNAMIC=y.
>    Those model never wanted a preemption, but PREEMPT_RCU could have forced a need_resched to be
>    set. Which is also likely wrong. No?

You lost me on this one.  Please give me an explicit sequence of events
that would cause things to go wrong in this case.

							Thanx, Paul

