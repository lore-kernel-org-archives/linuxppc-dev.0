Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id B8918DDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 16:32:44 +1100 (EST)
Date: Mon, 3 Dec 2007 22:34:27 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
Message-ID: <20071204053427.GB27063@mag.az.mvista.com>
References: <20071129152836.GB13751@ru.mvista.com>
	<1196715170.13230.228.camel@pasglop>
	<20071204012329.GA18903@mag.az.mvista.com>
	<1196734483.13230.256.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196734483.13230.256.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 01:14:43PM +1100, Benjamin Herrenschmidt wrote:
> 
>  .../... (snip scary bunch of errata)
> 
> > - "FEr PCI-#4" (Detailed by Application Note AN-84):
> > 
> > [This isn't strictly a coherency issue but having coherency enabled
> > exacerbates the problem.]  Basically, the bridge can let the cpu read
> > a pci device's registers before all of the data the PCI devices has
> > written has actually made it to memory.  This and the fact that the
> > device's write data may be stuck in the PCI Slave Write Buffer
> > (which isn't checked for coherency), the cpu can get stale data.
> > 
> > There are no plans to fix that erratum.
> 
> So if I understand correctly, there's no plan to fix a major PCI spec
> violation which prevent any kind of reliable implementation whatsoever ?

That's just for that particular part (e.g., 64360).  Newer parts like
the 64460 have it fixed.

> > So, the answer depends on what part & what rev of the part you have
> > (e.g., the pegasos doesn't use the MPSC and apparently has the other
> > issues worked around so it can turn on coherency but the prpmc2800
> > doesn't so it needs coherency off).
> > 
> > BTW, I haven't forgotten the inherent bug you described when coherency
> > is off (/me too lazy to find link to the email) but AFAIK I've never run
> > into it.  However, if I turn on coherency and stress the PCI bus, it
> > hangs (I can't even look at memory thru a bdi).
> 
> Well, as it is today, the "classic" MMU code cannot deal with !coherent.
> The entire linear mapping is always mapped cacheable with BATs, so stuff
> may be brought into the cache at any time, potentially polluting DMA
> data.
>
> Dealing with that would be hard. It might be possible by using G on the
> entire linear mapping like we do on 4xx (yuck), and/or by not using
> D-BATs (the kernel will blow up in various areas without I-BATs).

Hrm, I didn't realize it was in such bad shape.  I'll have to take a
closer look.

Mark
