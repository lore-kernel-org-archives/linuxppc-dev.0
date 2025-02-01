Return-Path: <linuxppc-dev+bounces-5760-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209D9C0218F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Feb 2025 01:42:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YlFrS1M7Sz2yVb;
	Sat,  1 Feb 2025 12:42:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738374168;
	cv=none; b=UjC88y2SUgiytaVKJCoOUpy3LII1TZJS89xt5xdZY479Dlw48EEwgkI3E3r2aCXIzzRgsts2OpLBlWpiQLkmb3JuxHmYYiQatlwBRq9OmM4i4Rhq1pXG1MG4suXkdJr/aMI8V7nb9ykZHC5KeEu38apAG06TP+l3h26OCH7r6zEc6XN5h3SK9DcuxuGgybeo1rZluFprbZk+70sRNc94kURpu+Fz7N6tiqBIzEJTorYx3D2vzL5YLkhRrMVJW0SgW99TqmquAulouZSfRLZmSuSPEq1ffrRND6kc+nSUePc50o7AT+00/7pWhyfrMJwaWnzhfcJ9qly3hSY8rMuiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738374168; c=relaxed/relaxed;
	bh=PjLs3jHJ6gre5zEKgFB96jUHS1/DMoYPTnwMihnfenY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbCYQD83mKEFh/HFnB7tk2Zvzw0AeETnTDL4OQKQX6Ra6rA33puvSQDzzFD21uQNm1DiYys4naHeTRbtJdNmIUachXQ0BNSMFlcYUoICrv0yylST1RSfD3e4LfAWpKQ0in6tMCQ5nCNvfOYG59o/v16xLA9P/1ieFqULhXZ6iS8wTvenY6ECiCCKm37/eJN/WODROvKMfuQXINCIQGvwoCgIuYjyhbo6Oa7nqOAgcY9woHFKe/MeLVZliMSILW6LdNAOEhrpq1VAsuid6hnRp+12yjh9zvWHbLavFzv3KYSHeiULiT54qL7mDqem1G28Ydk4P7hJ6DZ8Ms4JUO/chw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=rMDfqEQT; dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=rMDfqEQT;
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YlFrQ6QbRz2yNn
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2025 12:42:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1738374157;
	bh=PjLs3jHJ6gre5zEKgFB96jUHS1/DMoYPTnwMihnfenY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMDfqEQTbWHoowk5Km8DJ1nLExKt2RpaU6RXYwyOXPkofXLC9yA8oQH/K60e143tw
	 L5db6Yg6DU5EZjTJj97tRxRql2WAj4K0fv0N7aeyLNWtgzbBdH/zg4BZGGdFpbdOi3
	 QLg+HmZcaoy+neKPz3cX9ux/Uj2qnhXsP8gpzvTU2RiaPrSf3VOl+ofHXYAro8lNT4
	 r2cBuPN8pFKebfheD8GCeCHGRJiX0lC0gkq2YDg5VnWUE5SoQ2YIKrIpg7yRSh2AZS
	 il0rrStx9polMTxM9fYVi4Ig3YGse7iHSWM+dbmvyu1b0zq/9atlZ8aOVhtjuOxTrT
	 iKIaUu6ncOBsQ==
Received: by gandalf.ozlabs.org (Postfix, from userid 1003)
	id 4YlFrF4RNSz4wy9; Sat,  1 Feb 2025 12:42:37 +1100 (AEDT)
Date: Sat, 1 Feb 2025 12:22:51 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/5] Microwatt updates
Message-ID: <Z513a_fdrtUgE0gE@thinks.paulus.ozlabs.org>
References: <Z5lfDb8wsLlmSLBZ@thinks.paulus.ozlabs.org>
 <20250131161343.GY20626@gate.crashing.org>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131161343.GY20626@gate.crashing.org>

On Fri, Jan 31, 2025 at 10:13:43AM -0600, Segher Boessenkool wrote:
> Hi!
> 
> On Wed, Jan 29, 2025 at 09:49:49AM +1100, Paul Mackerras wrote:
> > This patch series updates the kernel support for the Microwatt
> > soft-core and its implementation on FPGA systems, particularly the
> > Digilent Arty A7-100 FPGA development board.
> > 
> > Microwatt now supports almost all of the features of the SFFS (Scalar
> > Fixed-poin and Floating-point Subset) compliancy subset of Power ISA
> > version 3.1C, including prefixed instructions and the fixed-point hash
> > (ROP mitigation) instructions.  It is also now SMP-capable, and a
> > dual-core system will fit on the Arty A7-100 board.
> 
> Congratulations!

Thanks!

> > Microwatt does not have broadcast TLB invalidations in SMP systems;
> 
> So it isn't *really* SMP.  Compare 603 vs. 604.  With enough software

Actually, the term "SMP" is about latency to memory, indicating that
all CPUs have access to memory with similar latency.  It doesn't say
anything about coherency, either of memory caches or TLBs.  So yes,
Microwatt is SMP.

And for the record, the instruction and data caches are coherent,
which is what matters to user-space.  Stuff to do with the TLB is not
visible to user-space.  And the ISA explicitly says "TLBs are
non-coherent caches of the HTABs and Radix Trees" (Book III section
6.10.1).

> (OS) trickery you can make some things work, but :-)  (There have been
> many 603 multiprocessor systems as well, to draw the analogy further
> than wanted :-) )

603 was a looong time ago, I don't recall the details.

Regarding broadcast TLBIEs, the protocols and mechanisms for doing
that are known to be complex and slow in the IBM Power processors (ask
Derek Williams about that :).  Anton found that in fact doing only
local TLBIEs and using IPIs gave *better* performance on IBM Power
systems than using hardware broadcast TLBIEs in many cases (the reason
being that software knows which other CPUs might have a given TLB
entry, often quite a small set, whereas hardware doesn't, and has to
send the invalidation to every CPU and wait for a response from every
CPU).  Add to that, that most other SMP-capable CPU architectures
don't do broadcast TLB invalidations, Intel x86 for example.

> > the kernel already has code to deal with this.  One of the patches in
> > this series provides a config option to allow platforms to select
> > unconditionally the behaviour where cross-CPU TLB invalidations are
> > handled using inter-processor interrupts.
> 
> Are there plans to broadcast the (SMP cache invalidation) messages?

Cache (i.e. instruction and data cache) - yes, they *are* coherent.
More precisely, the D caches are write-through, and all I and D caches
snoop writes to memory (including DMA writes) and invalidate any cache
lines being written to.

> Will uwatt support some real bus protocol, for example?

"Real" meaning using tri-state bus drivers, like we did in the 90s? :)

> Again, congrats on this great milestone!  Does this floating point
> support do square roots as well (aka "gpopt"; does it do "gfxopt" for
> that matter, fsel?)  fsqrt is kinda tricky to get to work fully
> correctly :-)

Yes, fsqrt and fsel are implemented in hardware, and are accurate to
the last bit.  Also, the FPU handles denormalized values in hardware
(both input and output) and implements all exception handling as per
the ISA, including the trap-enabled overflow cases.  Feel free to run
whatever tests you like and report bugs.  But we're getting a bit
off-topic from the kernel patches. :)

Paul.

