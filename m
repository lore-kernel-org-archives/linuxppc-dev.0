Date: Sat, 11 Mar 2000 16:39:53 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Kostas Gewrgiou <gewrgiou@imbc.gr>,
        Michel Danzer <michdaen@iiic.ethz.ch>, linuxppc-dev@lists.linuxppc.org
Subject: Re: patch to get latest XFree 4.0 snapshot (xf3918) to work on pp
 cwith r128
In-Reply-To: <Pine.LNX.3.96.1000310113001.26527B-100000@deepspace.mklinux.org>
Message-ID: <Pine.HPX.4.10.10003111633140.22162-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Fri, 10 Mar 2000, David A. Gatwood wrote:

> > What do you mean with x100 ? Is it a series of PMAC models ? sync and
> > eieio perform an address-only bus broadcast that should be terminated by
> > the host bridge but never to the PCI bus so they can't crash HW. Is the
> > host bridge/memory controller really that buggy ?
>
> NuBus, not PCI.  There's no bridge involved.  If the value in whichever
> register, when shifted appropriately, results in a value within the NuBus
> range, the address-only transaction causes problems, specifically the
> system just locks up solid.  Only happens with certain cards.

Ok, bad HW design, some of the so called address-only transactions do not
even use the address bits. They just use the address phase of the bus
protocol.

> > And isync is not irrelevant on any processor since a) it flushes the
> > instruction queue and b) it ensures that the effect of all previous
> > instructions on machine state is taken into account before the next
> > instruction executes (that's important if you change context by changing
> > segment registers or modify some MSR bits).
>
> My reference manual is in another city, so I can't look this up, but I'm
> pretty sure isync is either a no-op or is mapped onto another instruction
> for the 601.

Wrong, and I had a 601 manual in front of me when I wrote this. You might
have confused it with icbi which is a no-op on 601, but isync definitely
is not.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
