Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id D6242DDE28
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 16:43:29 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: benh@kernel.crashing.org
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Mon, 1 Sep 2008 08:42:10 +0200
References: <200808251131.02071.david.jander@protonic.nl>
	<200808291348.27652.david.jander@protonic.nl>
	<1220171323.13162.395.camel@pasglop>
In-Reply-To: <1220171323.13162.395.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809010842.10960.david.jander@protonic.nl>
Cc: munroesj@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 31 August 2008 10:28:43 Benjamin Herrenschmidt wrote:
> O> > It would be useful of somebody interested in getting things things
>
> > > > into glibc did the necessary FSF copyright assignment stuff and
> > > > worked toward integrating them.
> > >
> > > Ben makes a very good point!
> >
> > Sounds reasonable... but I am still wondering about what you mean
> > with "things"?
>
> Typo. I meant "these things", that is, variants of various libc
> functions optimized for a given processor type.

Ok, we'd have to _make_ those "things" first then ;-)

> > AFAICS there is almost nothing there (besides the memcpy() routine from
> > Gunnar von Boehn, which is apparently still far from optimal). And I was
> > asking for someone to correct me here ;-)
>
> No idea, as we said, it's mostly up to users of the processors (or to a
> certain extent, manufacturers, hint hint hint) to do that work.

Ok, I get the point.

> > > There is also a framework for adding and maintaining optimizations of
> > > this type:
> > >
> > > http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html
> >
> > I had already stumbled across this one, but it seems to focus on G3 or
> > newer processors (power4). There is no optimal memcpy() for
> > G2/PPC603/e300.
>
> It focuses on what the people doing it have access to, are paid to work
> on, or other material constraints. It's up to others from the community
> to fill the gaps.

That's all I need to know ;-)

> > >[...]
> > > So it does no good to complain here. If you have core you want to
> > > contribute, Get your FSF CR assignment and join #glibc on freenode IRC.
> >
> > I am not complaining. I was only wondering if it is just me or there
> > really is very little that has been done (for either uClibc, glibc, or
> > whatever for powerpc) to improve performance of (linux-) applications on
> > "lower"-power platforms (G2 core), AFAICS there is a LOT that can be
> > gained by simple tweaks.
>
> Well, possibly, then you are welcome to work on those tweaks and if they
> indeed improve things, submit patches to glibc :-) I'm sure Steve and
> Ryan will be happy to help with the submission process.

Sounds encouraging. I'll try my best (in the limited amount of time I have).

>[...]
> You don't have to do it all at once. A  simple tweak of one function
> such as memcpy, if it's measurably improving performances without
> notable regressions could be a first step, and then tweak after tweak...
>
> It's a common mistake to try to do too much "out of tree" and then
> struggle and give up when it's time to merge that stuff because there
> are too many areas that won't necessarily be acceptable "as is".
>
> One little bit at a time is generally a better approach.

Ok, I take your advice.

> > OTOH, maybe it is easier and simpler to start with a collection of
> > functions in a shared-library, that may be suited for preloading via
> > LD_PRELOAD or /etc/ld_preload...
> >
> > Maybe once this collection is more stable (in terms of that heavy
> > tweaking has stopped) one could try the pilgrimage towards glibc
> > inclusion....
>
> I believe that's the wrong approach as it leads to never-merged out-of
> tree code.

Hmm... you mean, it'll be easier to keep patching (improving) things once they 
are already in glibc? Interesting.

Thanks a lot for your comments.

Best regards,

-- 
David Jander
