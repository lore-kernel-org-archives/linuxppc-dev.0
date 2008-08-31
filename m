Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 57DA3DDE98
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Aug 2008 18:28:52 +1000 (EST)
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200808291348.27652.david.jander@protonic.nl>
References: <200808251131.02071.david.jander@protonic.nl>
	<1219703291.13162.106.camel@pasglop>
	<1219871079.28869.149.camel@spokane1.rchland.ibm.com>
	<200808291348.27652.david.jander@protonic.nl>
Content-Type: text/plain
Date: Sun, 31 Aug 2008 18:28:43 +1000
Message-Id: <1220171323.13162.395.camel@pasglop>
Mime-Version: 1.0
Cc: munroesj@us.ibm.com, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

O> > It would be useful of somebody interested in getting things things
> > > into glibc did the necessary FSF copyright assignment stuff and worked
> > > toward integrating them.
> >
> > Ben makes a very good point!
> 
> Sounds reasonable... but I am still wondering about what you mean 
> with "things"?

Typo. I meant "these things", that is, variants of various libc
functions optimized for a given processor type.

> AFAICS there is almost nothing there (besides the memcpy() routine from Gunnar 
> von Boehn, which is apparently still far from optimal). And I was asking for 
> someone to correct me here ;-)

No idea, as we said, it's mostly up to users of the processors (or to a
certain extent, manufacturers, hint hint hint) to do that work.

> > There is also a framework for adding and maintaining optimizations of
> > this type:
> > 
> > http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html
> 
> I had already stumbled across this one, but it seems to focus on G3 or newer 
> processors (power4). There is no optimal memcpy() for G2/PPC603/e300.

It focuses on what the people doing it have access to, are paid to work
on, or other material constraints. It's up to others from the community
to fill the gaps.

> >[...]
> > So it does no good to complain here. If you have core you want to
> > contribute, Get your FSF CR assignment and join #glibc on freenode IRC.
> 
> I am not complaining. I was only wondering if it is just me or there really is 
> very little that has been done (for either uClibc, glibc, or whatever for 
> powerpc) to improve performance of (linux-) applications on "lower"-power 
> platforms (G2 core), AFAICS there is a LOT that can be gained by simple 
> tweaks.

Well, possibly, then you are welcome to work on those tweaks and if they
indeed improve things, submit patches to glibc :-) I'm sure Steve and
Ryan will be happy to help with the submission process.

> > And we will help you.
> 
> Thanks, now that I know which is the "correct" way to contribute, I only need 
> to come up with a good set of optimization, worthy of inclusion in glibc.

You don't have to do it all at once. A  simple tweak of one function
such as memcpy, if it's measurably improving performances without
notable regressions could be a first step, and then tweak after tweak...

It's a common mistake to try to do too much "out of tree" and then
struggle and give up when it's time to merge that stuff because there
are too many areas that won't necessarily be acceptable "as is".

One little bit at a time is generally a better approach.

> OTOH, maybe it is easier and simpler to start with a collection of functions 
> in a shared-library, that may be suited for preloading via LD_PRELOAD 
> or /etc/ld_preload...
> 
> Maybe once this collection is more stable (in terms of that heavy tweaking has 
> stopped) one could try the pilgrimage towards glibc inclusion....

I believe that's the wrong approach as it leads to never-merged out-of
tree code.

> The problem is: I have very little experience with powerpc assembly and only 
> very limited time to dedicate to this and I am looking for others who have 

Cheers,
Ben.
