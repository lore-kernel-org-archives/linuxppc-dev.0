Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 64A00DDDFA
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 12:21:50 +1100 (EST)
Date: Mon, 3 Dec 2007 18:23:29 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/5] PowerPC 74xx: Katana Qp device tree
Message-ID: <20071204012329.GA18903@mag.az.mvista.com>
References: <20071129152836.GB13751@ru.mvista.com>
	<1196715170.13230.228.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196715170.13230.228.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 07:52:50AM +1100, Benjamin Herrenschmidt wrote:
> > 	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	model = "Katana-Qp"; /* Default */
> > +	compatible = "emerson,Katana-Qp";
> > +	coherency-off;
> > +
> 
> What do that mean (coherency-off) ?
> 
> Somebody is trying again to use a 74xx with non cache coherent DMA ?

Hi Ben.

I suspect Andrei got that from the prpmc2800 dts which I made so I'll
jump in.  (BTW, this is the same debate we have every year or two. :)

By looking at the dts, that board has an mv64460 which has a couple
issues when it comes to coherency (depending on the rev of the chip).

One is about not being able to use DCBST instructions with coherency on
and the other is about limiting the length of one of the traces (which
at least one board manufacturer that I know of refuses to implement).
The first one is supposed to be fixed by rev A1 of the part and the second
is supposed to be fixed by rev B0 of the part.  I don't know what rev(s)
are on the board(s) Andrei is using.  If its B0 or later, in theory, the
part should work with coherency on.

Andrei, have you tested with coherency on?

--

As far as the prpmc2800 (mv64360)...

[I don't know what an NDA let's me say or not so I'll just give
summaries of the errata.  If you or another reader has signed the NDA
you/they can look them up.]

I don't recall all of the details anymore but these are the errata I saw
by quickly scanning the 64360's list.

- "FEr CPU-#1":

Basically the CPU could read a stale cache line.  Supposed to be fixed
in rev A2 & B0 but I haven't verified.

- "FEr MPSC-#1":

The MPSC can't access a coherent memory region.
This is pretty much a show stopper for the prpmc2800.

There are no plans to fix that erratum.

- "FEr PCI-#4" (Detailed by Application Note AN-84):

[This isn't strictly a coherency issue but having coherency enabled
exacerbates the problem.]  Basically, the bridge can let the cpu read
a pci device's registers before all of the data the PCI devices has
written has actually made it to memory.  This and the fact that the
device's write data may be stuck in the PCI Slave Write Buffer
(which isn't checked for coherency), the cpu can get stale data.

There are no plans to fix that erratum.

- "FEr PCI-#5" (Detailed by Application Note AN-85):

With certain PCI devices and with coherency enabled, some combinations
of PCI transactions can cause a deadlock.  There is a workaround
documented but I've tried it and it didn't work for me (but I can't be
sure that was the erratum I was bumping into).

There are no plans to fix that erratum.
--

So, the answer depends on what part & what rev of the part you have
(e.g., the pegasos doesn't use the MPSC and apparently has the other
issues worked around so it can turn on coherency but the prpmc2800
doesn't so it needs coherency off).

BTW, I haven't forgotten the inherent bug you described when coherency
is off (/me too lazy to find link to the email) but AFAIK I've never run
into it.  However, if I turn on coherency and stress the PCI bus, it
hangs (I can't even look at memory thru a bdi).

Mark
