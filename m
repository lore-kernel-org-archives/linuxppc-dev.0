Return-Path: <linuxppc-dev+bounces-25278-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2ADC55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 15:27:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDLCX1Qs0z2yMn;
	Tue, 04 Aug 2026 01:27:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785770872;
	cv=none; b=oAETEBDN5Cmx04hP5iawLLP5NIfqcGC+k8PkX4VU9r6dFksiNmWV3cWW73ZMGeGzWEZjRHxq+Usd/Uf0G5sqxUMtQd8j0LX/0qevXjIUlnfw9FyghnjnXlDD9zSxmk+xfeoQN7twTP97Rv8xSJXh3V0oH34hbAYSqDBqeIOvWhtQyTSmCTDaci9a7sdvtEDTXrkpK51As1FxcDgkyy4VWAqUrJMdhYarAC1exg8xJu0shzPHmCrAbUiZr5QegzYbCVYBi/R2cd+Ak4TE4T1K/cp8d/wlmt6dCpaPYIyNROcXQRjwEn3jeQygvr4sGirQFA45DgG4pbggdJynGfbSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785770872; c=relaxed/relaxed;
	bh=pNCUJNxQD9q2mw3S9MHwNVAQbjwYHSj63XXhWt5IJ/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJNtOZ+elv3yc37UvtgaEi41hARN4zVO+5NYKLI395kGiHDqLd4EmYGIOjHJK75EgGXj3BCsNX9vLoDWhS454623sWGGBx4hK98ZV00ZS0i5Aas7ZGWLppr8sERLw6tLVowE8hYixDUe7J5rGUl6bG2zCNsPIFRqaCaGiwgL1+5hjFIJEGrJozAFgCxGalR2xOLN+asXS/w/DYz1toi7N5vMUuOF7tUNvgXX+3WjPqW2VaXPLVUbCStqJcbVj4yIVLUTwM3wt6nkTqDm2ztF6KeQMaLkrgbQ0DKOPRRjRkyAG5myWIcWKP1KJJQgN4K/sL3V6JNoldieoVR1qbpOAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asb217m5; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=el+k=f4=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=asb217m5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=el+k=f4=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDLCW1kBbz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 01:27:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E28F460A78;
	Mon,  3 Aug 2026 15:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972BD1F000E9;
	Mon,  3 Aug 2026 15:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770867;
	bh=pNCUJNxQD9q2mw3S9MHwNVAQbjwYHSj63XXhWt5IJ/w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=asb217m595qu5tNIOl+Jxevuae6T8tIA+ORxUrCY13lPy1cCarTOe5F2u4s4bkhPi
	 JoICTm6n0MTGm6Ia7RaNLLgSvsMun742RXGsfkSQzVTCKM22GOG+zQYyFZtkstlVgN
	 wMeGt2MrjmwE67jyfGBMgEpaTgC4DzMZn6aKy8hi7lZmk9JbTCYCc21/odgODsZdfL
	 Mz8nmo/THjsHkxHCv32kwPakxbUBtOK9mTh2c9rngeXdgL+EnUMEpBxzIqVc8iRLsI
	 fGYdGS6T69pJcls9Ailj/zzwwNWFDIcnk5V+ssV7DGLjGgNNBH10dnITElkr2UWW2A
	 j3qY0CVm4rWdQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5F1FCCE19B2; Mon,  3 Aug 2026 08:27:47 -0700 (PDT)
Date: Mon, 3 Aug 2026 08:27:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Jirka Hladky <jhladky@redhat.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, npiggin@gmail.com, bigeasy@linutronix.de,
	will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
Message-ID: <a98d7587-d9de-47c3-aa2e-0c9d9df0acf5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
 <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
 <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>
 <972db4f1-406b-477b-895e-59ffc643e384@kernel.org>
 <CAE4VaGD0Ekz+5s26iTW=UV4PuBkUm9AzorBgAVGJBjttH7sMWQ@mail.gmail.com>
 <4be922b5-7dc2-48c1-938c-de02245bc5e2@linux.ibm.com>
 <CAE4VaGDQ0Ysdfhqc-eF9Oby-QkZxiL-TvS-WkJ_KKEVrRvTc7Q@mail.gmail.com>
 <1eab63fc-b70d-41ef-b720-8ae77d8e56d8@linux.ibm.com>
 <c85a1f0a-d702-4470-b2d5-c308805acebb@paulmck-laptop>
 <3b524463-91de-4034-9478-7dbb5848262b@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b524463-91de-4034-9478-7dbb5848262b@linux.ibm.com>

On Mon, Aug 03, 2026 at 10:21:26AM +0530, Shrikanth Hegde wrote:
> 
> Hi Paul,
> 
> > > I tried moving to PACA plus splitting 64 bit into need_resched and preempt
> > > count. But it doesn;t move the needle. But it maybe worth pursuing,
> > > since it could help preemption modes. It needs more work and needs numbers
> > > across benchmark.
> > > 
> > > > Thanks for trying. Paul questioned whether barriers are actually
> > > > needed for preempt_count, or whether software interrupt disabling
> > > > would suffice (his words: "I can see why the preempt_count()
> > > > operations need to be interrupt-safe, but I don't see why you would
> > > > need barriers"). Any thoughts on whether that's feasible for
> > > > powerpc?
> > > 
> > > Barrier are likely not the concern as it is mostly nop.
> > > Also, soft disabling interrupts needs to arch specific hooks to setup
> > > before preempt_disable and replay interrupts after preempt_enable.
> > > I don't think it would benefit since interrupt disabling during this likely
> > > shouldn't happen. Maybe I don't understand how that could work.
> > 
> > For some reason, I remembered powerpc software-disabling interrupts,
> > but when I go look now, there is no such thing.  Maybe powerpc used to
> > but no longer does.  Or maybe I am just hallucinating.  ;-)
> > 
> > 							Thanx, Paul
> 
> It is there still,
> 
> static inline unsigned long arch_local_irq_save(void)
> {
>         return irq_soft_mask_or_return(IRQS_DISABLED);
> }
> Sets the softmask bit, and any interrupt that arrives,
> gets added to a list and that will be replayed in arch_local_irq_restore.
> 
> That will protect against the race of irq vs preempt count in
> __preempt_count_dec_and_test. In the PACA based PoC i have i tried to use it,
> but it doesn't make a difference, since this particular test accounts mainly
> preempt count overhead itself, which cannot be escaped in dynamic preemption.
> 
> So, I think this is the tax we got to live with for dynamic preemption on RISC archs.
> But good thing is, its effect is limited to a very few microbenchmarks.

OK, I guess I just didn't look hard enough.  ;-)

And glad that the blast radius is limited.

							Thanx, Paul

