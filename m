Message-ID: <39CBA90A.58092A25@mvista.com>
Date: Fri, 22 Sep 2000 14:46:34 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: paulus@linuxcare.com.au,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.LNX.4.10.10009221356470.377-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> But you suggested the use of the MMU to map all I/O spaces from all bridges
> into one merged and consecutive universal I/O space.

Well, Paul is suggesting that, I don't really care and I think it
is a detail that doesn't matter.  I prefer the approach:

	addr_to_use = tell_me_where()
	inb(addr_to_use)

but I guess I am wrong on this :-).  Everyone seems to like hacking
addresses either in the PCI resources structures or within the macros
rather than doing it as a one time operation in some well contained
platform specific function.  I already know I can't use a simple
mapping/arithmetic solution on a platform I have, so I am going to
pay a high penalty for people using in/out on PCI I/O space.  Fortunately,
I can use drivers for devices that have PCI memory, although I will
have to modify them, and most of the drivers will be new and unique.

> ... but not in user space, because you still need the correct _physical_
> address when mmap'ing /dev/mem.

Right, and I don't really think we should be promoting that kind of
access at the user level.  To do so you either need some more complex
method of finding this physical address, and I don't know the outcome
of some of these discussions that took place a while ago, or you should
write a driver to just do it (open the device and mmap that descriptor).


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
