Return-Path: <kiran@scalex86.org>
Received: from serv01.siteground.net (ns1.siteground.net [207.218.208.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9C94C679F0
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2006 08:01:42 +1000 (EST)
Date: Mon, 17 Apr 2006 15:02:38 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Message-ID: <20060417220238.GD3945@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain>
	<4440855A.7040203@yahoo.com.au>
	<Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0604170953390.29732@schroedinger.engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	benedict.gaster@superh.com, bjornw@axis.com, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>, grundler@parisc-linux.org,
	Steven Rostedt <rostedt@goodmis.org>, starvik@axis.com,
	Linus Torvalds <torvalds@osdl.org>,
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

On Mon, Apr 17, 2006 at 09:55:02AM -0700, Christoph Lameter wrote:
> On Sat, 15 Apr 2006, Nick Piggin wrote:
> 
> > If I'm following you correctly, this adds another dependent load
> > to a per-CPU data access, and from memory that isn't node-affine.
> 
> I am also concerned about that. Kiran has a patch to avoid allocpercpu
> having to go through one level of indirection that I guess would no 
> longer work with this scheme.

The alloc_percpu reimplementation would work regardless of changes to
static per-cpu areas.  But, any extra indirection as was proposed initially
is bad IMHO. 

>  
> > If so, I think people with SMP and NUMA kernels would care more
> > about performance and scalability than the few k of memory this
> > saves.
> 
> Right.

Me too :)

Kiran
