Return-Path: <linuxppc-dev+bounces-24952-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBBDC54F4D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 16:30:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8gtP1t72z2xyh;
	Wed, 29 Jul 2026 02:30:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785256221;
	cv=none; b=IndKzKpVPOvsv5v089/9qvPUM5q2tPM2+Hve3dguhQNCgbywA+hPRP3Uu3Bul1EPXRoSlD9UUXKmKSO6CPtbcBEfy+rnijSVcXimRQVuxB+mVfUSFpzY7PjQyj1eY2Jz6/HZ1ygFizs9tA4ZfFwUACtP2kNIAQoEg9G+/9tImejdf+64icjyTSnIJNUwk9HoNRJ8HOtZDwP9ysejxDhU5LwbQykFVDFdels+78W79Nn82kxkaNW2RDkzjEuK+NkiAcgEafp6pTmCJ7Gn7boIuPMi2gPspO7XSre5HqyzD8oHAdPxmZPADuf+5BMHYymUJCnYq4uudUaimoEuYiyx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785256221; c=relaxed/relaxed;
	bh=ZRrvQlVT7FmO287SeIYP1YQhHkkVKP6roatDKiO6GyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6jiUjNw0ao/gNRC1EExH5hyvoYG4qLpfFkvkKJ1fTqvYhdb26Hl/5G0rfQCQTMR/qVc8stHcJk2DM7pFxC0O08FuRTr7gPFxIadkzMKbU9848J1ch9B11LpdRwCd1RwqvRvVUuD8BIwHngduFvOSY8BCgQfQZExwTnVo10KZNnVgioJAqPIrL3luW1HvvsH4TnYA21DEROWdoaAokMUTLobMuLC4nRcxrS/LLVXt/dfhAWLvUh/bF9c/WYPeRz9X6OhpfVxqbPOnKaxtwbFhaCNLfAdmyp10G8zmw9jDJSwW3b4jfvu8gRmK7B0CtAicNMACMq5G6cg4KCoxpg4GQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibmNsonp; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=jrcz=fw=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ibmNsonp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=jrcz=fw=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8gtN1wq5z2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 02:30:20 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C8FEF60A5E;
	Tue, 28 Jul 2026 16:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB151F000E9;
	Tue, 28 Jul 2026 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785256217;
	bh=ZRrvQlVT7FmO287SeIYP1YQhHkkVKP6roatDKiO6GyA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=ibmNsonpYVENQQUKm3dF5kH495nHeYgVnxg7o/a0EfI760/FMQfH+ALQe4c9JufAb
	 J/+i5ZQiw3PiuniV9Wi8kmrhTncgH/lABr+1GswuWxxqnQ99Pr/utiHraBpa0O2Dlr
	 C+tyEpmR30lpQMiNt/6zu4XFE2jF/P7nWBcaVUEYDS/l9/RIIPqQHKqmgrvoRV31nU
	 Hpr7q0jthp0aOZJQrjiw1mRyKVXlbR7DOUiDMALvYK68PgIEHXD/Ud0WaVonywsV/2
	 F0UbYnBmdRpksy4l+L22H3scO+lwduz2r2OjQWDq6Obamq/NCEGaXM41JVxClQgNn9
	 CUGiIG/bnEhUg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3B87CCE133F; Tue, 28 Jul 2026 09:30:17 -0700 (PDT)
Date: Tue, 28 Jul 2026 09:30:17 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Jirka Hladky <jhladky@redhat.com>, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	npiggin@gmail.com, bigeasy@linutronix.de, will@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
Message-ID: <5e9a0e85-22ac-491d-b6d2-a4814c57b367@paulmck-laptop>
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
 <39449915-04f2-4259-a6d9-1a2c1fcf9a63@paulmck-laptop>
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
In-Reply-To: <39449915-04f2-4259-a6d9-1a2c1fcf9a63@paulmck-laptop>

On Tue, Jul 28, 2026 at 09:21:55AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 28, 2026 at 10:57:57AM +0530, Shrikanth Hegde wrote:
> > Hi Paul, Christophe,
> > 
> > On 7/27/26 11:59 PM, Christophe Leroy (CS GROUP) wrote:
> > > Hi Shrikanth,
> > > 
> > 
> > > 
> > > That's right with CONFIG_PREEMPT_DYNAMIC=y
> > > 
> > > With CONFIG_PREEMT_DYNAMIC=n:
> > > - CONFIG_PREEMPT (full) implies CONFIG_PREEMPT_RCU
> > > - CONFIG_PREEMPT_LAZY (lazy) doesn't imply CONFIG_PREEMPT_RCU
> > > 
> > > because of kernel/rcu/Kconfig,
> > > 
> > > config PREEMPT_RCU
> > >      bool
> > >      default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
> > >      select TREE_RCU
> > > 
> > > Christophe
> > > 
> > > 
> > 
> > Right.
> > 
> > Looks like __rcu_read_unlock can set need_resched bit if it find irq were disabled
> > and rcu_read_unlock_special.s is set. I don't have much clue about it.
> > So, after seeing __rcu_read_unlock for PREEMPT_RCU I have these concerns now.
> 
> This is because irq-disabled regions of code act as RCU readers.
> For non-preemptible RCU (even in CONFIG_PREEMPT_LAZY=y kernels), this
> comes for free.  In contrast, preemptible RCU must explicitly (and,
> as you noticed, rather painfully) handle the irq-disabled case:
> 
> 	rcu_read_lock();
> 	do_something();
> 	local_irq_disable();
> 	do_something_else();
> 	rcu_read_unlock();
> 	do_yet_another_thing();
> 	local_irq_enable();
> 
> Here, the RCU reader extends all the way from the rcu_read_lock() to
> the final local_irq_enable().  And this is why RCU checks for IRQs being
> disabled in __rcu_read_unlock().
> 
> > In current upstream, lazy is a preemption mode with preempt_enable being a preemptible point,
> > 
> > 1. If PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n, then PREEMPT_RCU=n. That seems wrong. It is supposed to
> >    do the preemption checks, since preempt_count is actual count with lazy preemption.
> 
> Sorry, but no, not wrong at all.  This is the way that it is supposed
> to be.  In this configuration, RCU readers explicitly disable preemption.
> This gets us minimal RCU overhead on architectures such as x86 and arm64
> that have prohibited CONFIG_PREEMPT_NONE and CONFIG_PREEMPT_VOLUNTARY.
> Not zero overhead, but minimal overhead given the constraints imposed by
> CONFIG_PREEMPT_LAZY.  This also prevents preemption of RCU readers, which
> is extremely important on datacenter servers that have good and sufficient
> quantities of memory, but which are not well-endowed with memory.

Now, if you would like to be able to manually choose between non-preemptible
and preemptible RCU when when PREEMPT_LAZY=y, *that* we could discuss.

But it looks like you are looking for low overhead, and thus wanting to
avoid preemptible RCU.

							Thanx, Paul

> > 2. PREEMPT_LAZY=y and PREEMPT_DYNAMIC=n and PREEMPT_LAZY=y and PREEMPT_DYNAMIC=y are supposed
> >    to be similar w.r.t to performance.
> 
> RCU never made that promise.  ;-)
> 
> With PREMPT_DYNAMIC=y, RCU has no choice but to be preemptible, at
> least unless and until someone decides to make RCU's preemptibility be
> changeable at runtime (which I do not recommend).  And we really do need
> non-preemptible RCU for server workloads.
> 
> So it is not just that RCU never made that promise, it is that RCU cannot
> reasonably make that promise.
> 
> >                                        Promise of PREEMPT_DYNAMIC was the ability to
> >    switch at runtime based on the user workload and his/her preference.
> >    But with  PREEMPT_LAZY=y and PREEMPT_DYNAMIC=y, there is additional cost due to PREEMPT_RCU.
> >    lazy being the middle ground w.r.t for decent performance, either PREEMPT_RCU should either kick in
> >    for both cases or bail out for both.
> 
> Absolutely not!!!  Please see above.
> 
> > Before 7.0
> > 3. the same concerns would be true to PREEMPT_VOLUNTARY and PREEMPT_NONE with PREEMPT_DYNAMIC=y.
> >    Those model never wanted a preemption, but PREEMPT_RCU could have forced a need_resched to be
> >    set. Which is also likely wrong. No?
> 
> You lost me on this one.  Please give me an explicit sequence of events
> that would cause things to go wrong in this case.
> 
> 							Thanx, Paul

