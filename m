Date: Sat, 23 Sep 2000 14:38:39 -0700
From: Matt Porter <mporter@mvista.com>
To: Dan Malek <dan@mvista.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, paulus@linuxcare.com.au,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Message-ID: <20000923143839.A16562@cx258813-a.chnd1.az.home.com>
References: <Pine.LNX.4.10.10009221356470.377-100000@cassiopeia.home> <39CBA90A.58092A25@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <39CBA90A.58092A25@mvista.com>; from dan@mvista.com on Fri, Sep 22, 2000 at 02:46:34PM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 22, 2000 at 02:46:34PM -0400, Dan Malek wrote:
>
> Geert Uytterhoeven wrote:
>
> > But you suggested the use of the MMU to map all I/O spaces from all bridges
> > into one merged and consecutive universal I/O space.
>
> Well, Paul is suggesting that, I don't really care and I think it
> is a detail that doesn't matter.  I prefer the approach:
>
> 	addr_to_use = tell_me_where()
> 	inb(addr_to_use)
>
> but I guess I am wrong on this :-).  Everyone seems to like hacking
> addresses either in the PCI resources structures or within the macros
> rather than doing it as a one time operation in some well contained
> platform specific function.  I already know I can't use a simple
> mapping/arithmetic solution on a platform I have, so I am going to
> pay a high penalty for people using in/out on PCI I/O space.  Fortunately,
> I can use drivers for devices that have PCI memory, although I will
> have to modify them, and most of the drivers will be new and unique.

Paul's major concern is to not disturb the legacy drivers because of
the unknown level of effort to "move that mountain" of developers
to enhance them with a new I/O access scheme like you're suggesting.

I would honestly like to see something like the above.  I said that
if we have to stick with the legacy inb usage then the MMU handled
fixup would be preferred.

> > ... but not in user space, because you still need the correct _physical_
> > address when mmap'ing /dev/mem.
>
> Right, and I don't really think we should be promoting that kind of
> access at the user level.  To do so you either need some more complex
> method of finding this physical address, and I don't know the outcome
> of some of these discussions that took place a while ago, or you should
> write a driver to just do it (open the device and mmap that descriptor).

Absolutely, if people want to mmap /dev/mem they'll have to do the
hard work of getting the correct physical address on their own.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
