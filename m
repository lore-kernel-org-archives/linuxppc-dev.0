Date: Thu, 6 Jun 2002 17:57:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: LMbench results for large page patch
Message-ID: <20020606075732.GY2630@zax>
References: <20020605070832.GF2630@zax> <20020606042939.GU2630@zax> <3CFF0F88.5020600@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CFF0F88.5020600@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 06, 2002 at 03:30:16AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> > ....There are a couple of things largepte still does better
> >on, main memory latency (expected) and exec proc (unexpected).  The
> >difference is small though.
>
> The exec proc does lots of VM updates and TLB management.  The pinned
> TLBs on the 4xx require additional management overhead to ensure they
> aren't flushed when it is viewed as quicker to just flush the TLB.
> The exec proc tests don't accomplish any useful work once the system
> resources are allocated, so you are continually turning over the TLB and
> any additional managemant will appear in this overhead.

Ah yes, that makes sense.  In particular _tlbia() will be much slower
with pinned TLBs than without.

> >	largepte still does as well or better than nopintlb in
> >essentially every case.
>
> Which is expected....now if we could just extend this to applications, we
> would really have something :-)

So are you ok with the notion of merging the large page stuff and
abolishing CONFIG_PIN_TLB, once I've made iopa() and mapin_ram() less
ugly than they are in that first cut?

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
