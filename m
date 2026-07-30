Return-Path: <linuxppc-dev+bounces-25130-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46DAC55162
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 17:27:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9x2t2nD8z2ygG;
	Fri, 31 Jul 2026 03:27:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785432422;
	cv=none; b=bdEXHWcwo+ORfluoSDlpBJo2CdHZr4lg0fBl6lj+DBG18fnQGnYpCbYDAuQ6ZNyjBcyTp7i90hsoeFCsfB7gsUMZSSMlhMFln2moL5UAWY+YPCoosVicAnYgFhXxWWzGbHL9m5V//wVv/NxBG0t5QsIdymEG1JUUWI0cQ2WnOJu5AuU4FJ8CICo71zeIpcncLKizUfB3I858ivri9L66L4jaQO0yyD+CknpuJQ2XIcZzlnPTqjUijCjLwO7db+4R1RDzkPcrguui0aMO12JV8cWSY6yKzJflL4var2GIWdcZAmF3ykCoCORkWafFF6HoAkH9CBqFKVC1CwYXs+cbag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785432422; c=relaxed/relaxed;
	bh=DLIhxqXV9WGmdforKyzCgNUWEKMrdFciDZgAYfqkZvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLZCYcULGvE5xJvTl/gN2LjJ4SHXHZ9034HZN00AXkvCz1UmzUZD1Exeah/bDGZQkaZkuyp+C6FBvGUE/irHq0mRCICXa/t9eD/8ypmVtdRPXWW5Ovgs3RzWTA3K0zDUhdM0SmoGVtHfJ9M2EdFqmvpxLIQ5zUGNAFQGLjVtx2tB+y2McW0HSXaXveYE8HdOzsbaWmDOEnREpp7+GgZaZHzHwQP2/rI5Kd4fDnkSknROomaa3/q7LAxR+IDjtZ+Nqi8aDdu2tdUyTRKsjxXCy7yD9toI1grP9RdViL1Dy1fqlehAbQQgSa0yJeq2wNHO3cCq23pF9tmzfMuAYqNbzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXibzAd+; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=scs2=fy=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXibzAd+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=scs2=fy=paulmck-thinkpad-p17-gen-1.home=paulmck@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9x2s2Sp5z2yMy
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 03:27:01 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D58C2600AD;
	Thu, 30 Jul 2026 17:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1F11F000E9;
	Thu, 30 Jul 2026 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785432418;
	bh=DLIhxqXV9WGmdforKyzCgNUWEKMrdFciDZgAYfqkZvs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=BXibzAd+tM0/2AREluVDESrLjjYg5W++1XAWeJ9Y2j0IIKl2ZBLUCZXpaGhTlws71
	 z46bk42Q36aUS5dO5zrsYECbrMazXMn4zEgrjmQhupwqby7YGzlAisMtzM5m4zIQPi
	 L4SzfsiLgluGOmFPOjHWWd82DNjjjxyaL3vaLQfTu2DhFdBoUf+DsL0r3d2R7kpVRv
	 gqY62i7ouW3AShuC5Za+DtOwwiX4jO/XqOgd0vMjaPoCkVJ14pnCENNmNI4ao/Rc5X
	 mbhu5fTD711Wig84Tm6RfEOjs0+7IHHiAYxUHFpLJ0pQ8mgGJNs2Z1JdSyhDGGvVv9
	 gmx6cMUSmVTnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 45E0ACE0B67; Thu, 30 Jul 2026 10:26:58 -0700 (PDT)
Date: Thu, 30 Jul 2026 10:26:58 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Jirka Hladky <jhladky@redhat.com>, maddy@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu,
	mpe@ellerman.id.au, npiggin@gmail.com, bigeasy@linutronix.de,
	will@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] powerpc: enable dynamic preemption
Message-ID: <a1bb8e93-47b5-4f23-91fc-54d1492eca15@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAE4VaGDGS8wkZj4SF5XVC3-1yDmvJxjUjThTPqVw3kxg56ssQA@mail.gmail.com>
 <e013e88a-6137-4de8-9dfd-925b707f2e01@linux.ibm.com>
 <CAE4VaGAJ9mT8-V=GRPYj8h0RXuNf6S5icrmqeOOFDnkpPMQjaw@mail.gmail.com>
 <a1e04751-eab5-465b-8238-c9f4cd40e472@linux.ibm.com>
 <CAE4VaGCaN6uBBGqbGAsxudSxMC0JdXYn2vpuDJZPFR3xxJgMYA@mail.gmail.com>
 <29a407ab-268e-4443-96dc-8f5f933cb63c@linux.ibm.com>
 <CAE4VaGDzVa3+MKUbwH4LFj_mHZ721fd=7cWEd+G5=eVNWLePsg@mail.gmail.com>
 <529b8d9f-54a0-4ec2-9886-83cd528e5e04@paulmck-laptop>
 <CAE4VaGDJxcu_zgDyrSW=j9WzLEpNsQ9A9Rza-F5PLZq03kJYew@mail.gmail.com>
 <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>
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
In-Reply-To: <57d9de4a-65aa-44cf-9024-de4e5bdd1971@linux.ibm.com>

On Thu, Jul 30, 2026 at 10:40:38PM +0530, Shrikanth Hegde wrote:
> Hi Jirka, Paul,
> 
> 
> +cc will
> 
> On 7/30/26 8:38 PM, Jirka Hladky wrote:
> > On Thu, Jul 30, 2026 at 4:53 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > But is this really a fundamental RISC cost?  For example, does arm64
> > > see the same performance issues?
> > 
> > We tested arm64 (Ampere Altra Max) with the same controlled
> > experiment -- two 6.18 kernels, both voluntary, differing only in
> > PREEMPT_DYNAMIC:
> > 
> > Arch     PREEMPT_DYNAMIC   kill bogo-ops/sec   Delta
> > -------  ---------------   -----------------   -----
> > ppc64le  off               108,836
> > ppc64le  on                 68,197             -37.3%
> > aarch64  off                 5,538
> > aarch64  on                  5,082              -8.2%
> > 
> > arm64 sees -8.2% vs ppc64le's -37.3%. So arm64 is affected but
> > much less severely.
> 
> Ouch!. But that's good to know.
> 
> > 
> > > In particular, I can see why the preempt_count() operations need to be
> > > interrupt-safe, but I don't see why you would need barriers.  And
> > > doesn't powerpc still use software interrupt disabling?  If so, why
> > > not use that to simply software-disable interrupts around the
> > > preempt_count() operations?
> 
> Barrier are in core implementation, not in arch specific.
> 
> #ifdef CONFIG_PREEMPT_COUNT
> #define preempt_disable() \
> do { \
>         preempt_count_inc(); \
>         barrier(); \
> } while (0)
> 
> 
> #ifdef CONFIG_PREEMPTION
> #define preempt_enable() \
> do { \
>         barrier(); \
>         if (unlikely(preempt_count_dec_and_test())) \
>                 __preempt_schedule(); \
> } while (0)

But barrier() is just "__asm__ __volatile__("": : :"memory")", which
does not emit any instructions.  Or is this doing more machine-register
flushing/restoring than one might expect?

> > > What am I missing here?
> > 
> > That's a good question -- I don't know enough about the powerpc
> > preempt_count implementation to answer this. Shrikanth, could you
> > comment on whether removing the barriers or using software interrupt
> > disabling around preempt_count is feasible?
> > 
> > Thank you
> > Jirka
> > 
> 
> PowerPC currently uses asm-generic implementation which is probably sub-optimal
> w.r.t to check of need_resched.
> 
> When i see ARM's implementation, i see there is trick of splitting it into two.
> 
>         union {
>                 u64             preempt_count;  /* 0 => preemptible, <0 => bug */
>                 struct {
> #ifdef CONFIG_CPU_BIG_ENDIAN
>                         u32     need_resched;
>                         u32     count;
> #else
>                         u32     count;
>                         u32     need_resched;
> #endif
>                 } preempt;
>         };
> 
> 
> Seeing Will's changelog is on similar direction.
> 
> 396244692232 arm64: preempt: Provide our own implementation of asm/preempt.h
> "The asm-generic/preempt.h implementation doesn't make use of the
> PREEMPT_NEED_RESCHED flag, since this can interact badly with load/store
> architectures which rely on the preempt_count word being unchanged across
> an interrupt.
> 
> However, since we're a 64-bit architecture and the preempt count is
> only 32 bits wide, we can simply pack it next to the resched flag and
> load the whole thing in one go, so that a dec-and-test operation doesn't
> need to load twice. "
> 
> I am speculating this might help solve for ppc64 too. But i don't have a system
> to try this right now, will get back once i do

Looking forward to seeing what you come up with!

							Thanx, Paul

