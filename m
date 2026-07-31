Return-Path: <linuxppc-dev+bounces-25185-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F629C5516D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 18:11:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBYzp2cmHz2ygh;
	Sat, 01 Aug 2026 04:11:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785521494;
	cv=none; b=ObSSPKu2n1n4rZvDm4AXROTjiUvBbWDM7OigYOS201d9+OdTkuy0mXBxuYb1gYoY/qnU4kcI5nlvKBywLq9HdB9bEqFzKPCubIAbT7xW76mFgsx8dl1UG1YQvC/mETv9jHSf4D4L69BLBr3/sxvnc/iQYfV4jFsRVSVA7AvItO7LkXQP6YpVdSOClLqgkS9Tql2Y12FDogj82SqGB3g8NER0SxuX/Jl1CBLgvnf0BYRA391ov24DsGCZCdL85CrLwxs5ceL9/Wq8xfXs1mmzqEJgbUqoT8rxEtZF+KmstUAv/wWykQw4TPV3LYcnTVAeA0HDn9QzK6l9I3zxEJUahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785521494; c=relaxed/relaxed;
	bh=ybedOK6rGeUsvJIvx8YU1Y9NOV7LOxSrZpdSzwMxpkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h1l5xhbTz+/gldyX0GqAAHcrPBik/ahsw7omqDm2WrL6S0chGNsifMewnrOkvTYqHcE8R2xEYKSi7q3LwoMSMkDG6BlseizwB7tFBDuoOnlqFN1p6yoUwxFswZLK5UoKJuTdqapfAbVRkyUhOKkeGTeoYKCYLwM+UkdF8AnwbhYr81Z5t1Gc5bxTxLWEic0kxpE5pLcXnk81syyisoELoT5zXI3TdMi6i1qrRJHbVo3w6eUXHeq0bdQOlSoOcrobdRxN5L9/ZWLDL/e/8v0E8ZNwrABKKfLm8iw6Dm2tnDvAS9T9FQDUXxP9yn1RhW8Nv59rdBWN0yFbB9r7cn/4QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Selyc80T; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=tn6v=fz=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Selyc80T;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=tn6v=fz=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBYzn2MyYz2ySg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 04:11:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7C26460A6C;
	Fri, 31 Jul 2026 18:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307AC1F00AC4;
	Fri, 31 Jul 2026 18:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785521490;
	bh=ybedOK6rGeUsvJIvx8YU1Y9NOV7LOxSrZpdSzwMxpkQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Selyc80ToAFTBobCteBiLufuuV7cLvBpvAsV+PxJhVbKcUbjpAgCbxu2iHqnq2DHr
	 33gbXD7Cj90+xv7/tbBpEO1RCKcZWfFMxQMNLyvZKgnZDJ2NmbNEYLLuzuw6hdsTKb
	 NxEowxQsd6+rF8yeLqkqb9zv6fMJpLlFAgYq1skWf9yAjlyurhTF6k/9lBYE+ODd6X
	 DgymKLksCSvn6wmFQxJi8GMP3vUYhd4G0fgxhACQ2O/FuzmY3qk6+bEFkTiGUNzJjA
	 ZFZQsD+RubR1agmvE1qOtzSIUNwYt1pAGZYfoSn8PnpjeB0DG3xf6QZx5QDvqwsrPZ
	 jktuIx8TPY3kg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D74BFCE11BE; Fri, 31 Jul 2026 11:11:29 -0700 (PDT)
Date: Fri, 31 Jul 2026 11:11:29 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Jirka Hladky <jhladky@redhat.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au, npiggin@gmail.com, bigeasy@linutronix.de,
	will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
Message-ID: <c85a1f0a-d702-4470-b2d5-c308805acebb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
 <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
 <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
 <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>
 <972db4f1-406b-477b-895e-59ffc643e384@kernel.org>
 <CAE4VaGD0Ekz+5s26iTW=UV4PuBkUm9AzorBgAVGJBjttH7sMWQ@mail.gmail.com>
 <4be922b5-7dc2-48c1-938c-de02245bc5e2@linux.ibm.com>
 <CAE4VaGDQ0Ysdfhqc-eF9Oby-QkZxiL-TvS-WkJ_KKEVrRvTc7Q@mail.gmail.com>
 <1eab63fc-b70d-41ef-b720-8ae77d8e56d8@linux.ibm.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1eab63fc-b70d-41ef-b720-8ae77d8e56d8@linux.ibm.com>

On Fri, Jul 31, 2026 at 11:27:06PM +0530, Shrikanth Hegde wrote:
> Hi Jirka.
> 
> On 7/31/26 7:20 PM, Jirka Hladky wrote:
> > On Fri, Jul 31, 2026 at 10:03 AM Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> > > Coming into numbers, I did notice later, arm64 numbers are almost 20x less.
> > > But if we compare the time taken for each operations, it tells a
> > > different story.
> 
> > 
> > The bottom line: PREEMPT_DYNAMIC/preempt_count overhead is present
> > on both RISC architectures but its visibility depends heavily on the
> > workload profile and hardware topology.
> > 
> > > PS: I tried porting some of those changes in arm64 to powerpc to
> > > split preempt count into two. but i don;t see much improvement
> > > there.
> 
> I tried moving to PACA plus splitting 64 bit into need_resched and preempt
> count. But it doesn;t move the needle. But it maybe worth pursuing,
> since it could help preemption modes. It needs more work and needs numbers
> across benchmark.
> 
> > Thanks for trying. Paul questioned whether barriers are actually
> > needed for preempt_count, or whether software interrupt disabling
> > would suffice (his words: "I can see why the preempt_count()
> > operations need to be interrupt-safe, but I don't see why you would
> > need barriers"). Any thoughts on whether that's feasible for
> > powerpc?
> 
> Barrier are likely not the concern as it is mostly nop.
> Also, soft disabling interrupts needs to arch specific hooks to setup
> before preempt_disable and replay interrupts after preempt_enable.
> I don't think it would benefit since interrupt disabling during this likely
> shouldn't happen. Maybe I don't understand how that could work.

For some reason, I remembered powerpc software-disabling interrupts,
but when I go look now, there is no such thing.  Maybe powerpc used to
but no longer does.  Or maybe I am just hallucinating.  ;-)

							Thanx, Paul

