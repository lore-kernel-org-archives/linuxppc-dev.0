From: Gabriel Paubert <paubert@iram.es>
Date: Wed, 12 May 2004 13:53:30 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	Dan Malek <dan@embeddededge.com>, Amit Shah <amitshah@gmx.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
Message-ID: <20040512115330.GA30295@iram.es>
References: <c7nb0l$5e3$1@sea.gmane.org> <16544.4592.978105.177882@cargo.ozlabs.ibm.com> <3B3163BD-A2F0-11D8-95B9-003065F9B7DC@embeddededge.com> <16544.16999.648530.393071@cargo.ozlabs.ibm.com> <517E783F-A362-11D8-942E-003065F9B7DC@embeddededge.com> <16545.27647.651552.393992@cargo.ozlabs.ibm.com> <20040512080024.GA26628@iram.es> <1084357578.1933.28.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084357578.1933.28.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 12, 2004 at 08:26:19PM +1000, Benjamin Herrenschmidt wrote:
>
> >
> > Are you sure? Since the cache lines are in the other processor memory,
> > they will be flushed to RAM when they are fetched by the processor,
> > provided that you can force the coherence bit on instruction fetches
> > (this is possible IIRC).
>
> Coherency of the data cache lines is one thing... getting the icbi
> broadcast is another. Normal coherency will not help if you don't get
> the icache of the other CPU to snoop your icbi and invalidate the trash
> it has in its icache.
>
> > As I said, I believe the real problem is multithreaded applications.
>
> Which isn't a simple problem...

Indeed, it is actually not solvable in a reasonable way, disabling
the icache being far too unreasonable ;-)

But my point was that Paul's example, one process being rescheduled
on another processor, is actually quite solvable (provided it is the
sole owner of the MM context). You don't lose much by flushing the
icache on a MEI system compared with the hardware overhead of all
the invalidations and flushing that will take place because of the
process switch.

	Regards,
	Gabriel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
