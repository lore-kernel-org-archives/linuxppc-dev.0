Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45D0AB7C0F
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Sep 2009 17:07:18 +1000 (EST)
Subject: Re: [PATCH] powerpc/8xx: fix regression introduced by cache
	coherency rewrite
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rex Feany <RFeany@mrv.com>
In-Reply-To: <20090929012106.GA22798@compile2.chatsunix.int.mrv.com>
References: <20090924004552.GA11737@compile2.chatsunix.int.mrv.com>
	<1253774659.7103.405.camel@pasglop>
	<20090924233346.GA445@compile2.chatsunix.int.mrv.com>
	<1253836376.7103.469.camel@pasglop>
	<20090925013528.GA2584@compile2.chatsunix.int.mrv.com>
	<1253843480.7103.492.camel@pasglop>
	<20090929012106.GA22798@compile2.chatsunix.int.mrv.com>
Content-Type: text/plain
Date: Tue, 29 Sep 2009 17:07:11 +1000
Message-Id: <1254208031.5771.6.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-09-28 at 18:21 -0700, Rex Feany wrote:
> > It's going to be hard for me to get that "right" since I don't really
> > know what's going on with the core here, but I suppose if we get it
> > moving along with extra tlb invalidations, that should be "good enough"
> > until somebody who really knows what's going on comes up with possibly
> > a better fix.
> 
> I've tried sticking tlbil_va() in those places, nothing seems to help.
> In some cases userspace is slow, in other cases userspace is faster and
> unstable: sometimes commands hang, sometimes I am able to ctrl-c and
> and kill it, sometimes I get other strange crashes or falures (so far no
> kernel oopses though).

And you are positive that with 2.6.31 and your other patch, it works
both fast and stable ? This is strange... the code should be mostly
identical. I'll have a second look and see if I can get you a patch that
reproduce -exactly- the behaviour of 2.6.31 plus your patch.

Cheers,
Ben.
