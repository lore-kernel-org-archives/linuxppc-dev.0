Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-02.nyroc.rr.com (ms-smtp-02.nyroc.rr.com [24.24.2.56])
	by ozlabs.org (Postfix) with ESMTP id F0C83679EA
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 09:44:47 +1000 (EST)
Date: Mon, 17 Apr 2006 19:44:34 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <20060417220238.GD3945@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0604171936040.24264@gandalf.stny.rr.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
	<4440855A.7040203@yahoo.com.au>
	<Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
	<20060417220238.GD3945@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	benedict.gaster@superh.com, bjornw@axis.com, Ingo Molnar <mingo@elte.hu>,
	Christoph Lameter <clameter@sgi.com>,
	Nick Piggin <nickpiggin@yahoo.com.au>, grundler@parisc-linux.org,
	starvik@axis.com, Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>, tony.luck@intel.com,
	LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
	Marc Gauthier <marc@tensilica.com>, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 17 Apr 2006, Ravikiran G Thirumalai wrote:

> On Mon, Apr 17, 2006 at 09:55:02AM -0700, Christoph Lameter wrote:
> > On Sat, 15 Apr 2006, Nick Piggin wrote:
> >
> > > If I'm following you correctly, this adds another dependent load
> > > to a per-CPU data access, and from memory that isn't node-affine.
> >
> > I am also concerned about that. Kiran has a patch to avoid allocpercpu
> > having to go through one level of indirection that I guess would no
> > longer work with this scheme.
>
> The alloc_percpu reimplementation would work regardless of changes to
> static per-cpu areas.  But, any extra indirection as was proposed initially
> is bad IMHO.
>

Don't worry, that idea has been shot down more than once ;-)

> >
> > > If so, I think people with SMP and NUMA kernels would care more
> > > about performance and scalability than the few k of memory this
> > > saves.
> >
> > Right.
>
> Me too :)
>

Understood, but I'm going to start looking in the way Rusty and Arnd
suggested with the vmalloc approach. This would allow for saving of
memory and dynamic allocation of module memory making it more robust. And
all this without that evil extra indirection!

So lets put my original patches where they belong, in the bit grave and
continue on. I lived, I learned and I've been shown the Way (thanks to
all BTW).

So now we can focus on a better solution.

Cheers,

-- Steve
