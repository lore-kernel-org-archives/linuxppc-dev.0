Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 49305DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 13:49:47 +1100 (EST)
Subject: Re: performance: memcpy vs. __copy_tofrom_user
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <48F40077.5060003@genesi-usa.com>
References: <48ECC611.3030309@mikroswiat.pl>
	<20081008154212.GA21723@secretlab.ca>
	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>
	<48EDD905.6070609@mikroswiat.pl>
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>
	<48EE2553.30903@genesi-usa.com> <1223764226.8157.182.camel@pasglop>
	<48F15B7D.3060608@genesi-usa.com>
	<20081013152028.GA18639@ld0162-tx32.am.freescale.net>
	<1223931027.8157.272.camel@pasglop> <48F3B7A2.3010004@freescale.com>
	<48F40077.5060003@genesi-usa.com>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 13:39:19 +1100
Message-Id: <1223951959.8157.318.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Dominik Bozek <domino@mikroswiat.pl>,
	Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> There should definitely be a nice API for an in-kernel AltiVec context
> save/restore. When preemption happens doesn't it do some equivalent of
> the userspace context switch? Why can't the preemption system take care
> of it?
> 
> At worst case you make the worst case latency bigger, but at best case
> you gain performance across the board.

Do you ? Can you prove this assertion with numbers ?

> One thing which is worrying me is that now that Ben has thrown down the
> gauntlet (note, I'm not going to be coding a line, but I know a man who
> can :) how on earth do we benchmark the differences here?

Precisely :-)

So again, let's start by having somebody pick up something that you
believe is worth altivec-ifying, eat the preempt_disable/enable for now,
and if we see that indeed, it's worth the pain, then we can look into
adding a way to context switch altivec in a kernel thread upon explicit
request or something like that.

As to how to benchmark the difference ? Well, I would suggest first a
couple of very simple things that give a good indication, and from
there, if it looks promising, we can torture more and see whether we can
find regressions etc..

For example, I personally use kernel compile times (with make -jN on
SMP), I find it a good overall exercise, but if you feel like a network
benchmark might be better at advertising your improvements, then go for
that too, though expect us to also do some other tests to verify they
didn't regress.

Cheers,
Ben.
