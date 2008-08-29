Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 3D20FDE078
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 21:49:06 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: munroesj@us.ibm.com
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Fri, 29 Aug 2008 13:48:26 +0200
References: <200808251131.02071.david.jander@protonic.nl>
	<1219703291.13162.106.camel@pasglop>
	<1219871079.28869.149.camel@spokane1.rchland.ibm.com>
In-Reply-To: <1219871079.28869.149.camel@spokane1.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200808291348.27652.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 27 August 2008 23:04:39 Steven Munroe wrote:
> On Tue, 2008-08-26 at 08:28 +1000, Benjamin Herrenschmidt wrote:
> > On Mon, 2008-08-25 at 15:06 +0200, David Jander wrote:
> > > Hi Matt,
> > >
> > > On Monday 25 August 2008 13:00:10 Matt Sealey wrote:
> > > > The focus has definitely been on VMX but that's not to say lower
> > > > power processors were forgotten :)
> > >
> > > lower-power (pun intended) is coming strong these days, as
> > > energy-efficiency is getteing more important every day. And the MPC5121
> > > is a brand-new embedded processor, that will pop-up in quite a lot
> > > devices around you most probably ;-)
> >
> > It would be useful of somebody interested in getting things things
> > into glibc did the necessary FSF copyright assignment stuff and worked
> > toward integrating them.
>
> Ben makes a very good point!

Sounds reasonable... but I am still wondering about what you mean 
with "things"?
AFAICS there is almost nothing there (besides the memcpy() routine from Gunnar 
von Boehn, which is apparently still far from optimal). And I was asking for 
someone to correct me here ;-)

> There is also a framework for adding and maintaining optimizations of
> this type:
> 
> http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html

I had already stumbled across this one, but it seems to focus on G3 or newer 
processors (power4). There is no optimal memcpy() for G2/PPC603/e300.

>[...]
> So it does no good to complain here. If you have core you want to
> contribute, Get your FSF CR assignment and join #glibc on freenode IRC.

I am not complaining. I was only wondering if it is just me or there really is 
very little that has been done (for either uClibc, glibc, or whatever for 
powerpc) to improve performance of (linux-) applications on "lower"-power 
platforms (G2 core), AFAICS there is a LOT that can be gained by simple 
tweaks.

> And we will help you.

Thanks, now that I know which is the "correct" way to contribute, I only need 
to come up with a good set of optimization, worthy of inclusion in glibc.
OTOH, maybe it is easier and simpler to start with a collection of functions 
in a shared-library, that may be suited for preloading via LD_PRELOAD 
or /etc/ld_preload...

Maybe once this collection is more stable (in terms of that heavy tweaking has 
stopped) one could try the pilgrimage towards glibc inclusion....

The problem is: I have very little experience with powerpc assembly and only 
very limited time to dedicate to this and I am looking for others who have 

Greetings,

-- 
David Jander
