Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Paul Mackerras <paulus@samba.org>,
	Dan Malek <dan@embeddededge.com>, Amit Shah <amitshah@gmx.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040512080024.GA26628@iram.es>
References: <c7nb0l$5e3$1@sea.gmane.org>
	 <16544.4592.978105.177882@cargo.ozlabs.ibm.com>
	 <3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com>
	 <16544.16999.648530.393071@cargo.ozlabs.ibm.com>
	 <517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com>
	 <16545.27647.651552.393992@cargo.ozlabs.ibm.com>
	 <20040512080024.GA26628@iram.es>
Content-Type: text/plain
Message-Id: <1084357578.1933.28.camel@gaston>
Mime-Version: 1.0
Date: Wed, 12 May 2004 20:26:19 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> Are you sure? Since the cache lines are in the other processor memory,
> they will be flushed to RAM when they are fetched by the processor,
> provided that you can force the coherence bit on instruction fetches
> (this is possible IIRC).

Coherency of the data cache lines is one thing... getting the icbi
broadcast is another. Normal coherency will not help if you don't get
the icache of the other CPU to snoop your icbi and invalidate the trash
it has in its icache.

> As I said, I believe the real problem is multithreaded applications.

Which isn't a simple problem...

> >
> > > My experience has been that MPC750s work in a SMP environment
> > > on a 60x bus.  Maybe I was just lucky?  The way I read the manual,
> > > they should work with a proper memory controller.
> >
> > I think that the sorts of problems I am talking about wouldn't show up
> > very often.  Generally I think that these problems would just cause
> > the system to be a bit flaky rather than stop it from working at all.
>
> I agree.
>
> > If you didn't have L2 caches that would make the problems show up less
> > frequently, too.
>
> I'm not so sure. Instruction fetches look into L2 caches. The main issue
> are:
> 1) are the instruction fetches marked coherent?
> 2) do you run multithreaded applications?
>
> If you answer yes and no, then I don't see any showstopper.
>
> 	Regards,
> 	Gabriel
>
>
> >
> > Regards,
> > Paul.
> >
>
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
