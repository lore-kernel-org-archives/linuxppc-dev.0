Message-ID: <39CBBBA9.38DB93DF@mvista.com>
Date: Fri, 22 Sep 2000 13:06:01 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, paulus@linuxcare.com.au,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.LNX.4.10.10009221356470.377-100000@cassiopeia.home> <39CBA90A.58092A25@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek wrote:
>
> Geert Uytterhoeven wrote:
>
> > But you suggested the use of the MMU to map all I/O spaces from all bridges
> > into one merged and consecutive universal I/O space.
>
> Well, Paul is suggesting that, I don't really care and I think it
> is a detail that doesn't matter.  I prefer the approach:
>
>         addr_to_use = tell_me_where()
>         inb(addr_to_use)
>
> but I guess I am wrong on this :-).  Everyone seems to like hacking
> addresses either in the PCI resources structures or within the macros
> rather than doing it as a one time operation in some well contained
> platform specific function.  I already know I can't use a simple

I've been staying out of this discussion because I didn't want to just add
noise.  But what the heck...  I think that the flexibility of the
tell_me_where() approach is very appealing.  It allows for arbitrary future
designs of hardware topologies, including complex fabrics.  (OK, so I don't
know of any planned fabric designs for PowerPC, just other architectures.)

I do know that the IBM 405 processors have split PCI I/O space into two
non-contigous blocks in the physical address map.  My current implementation
only allows access to the first block.  Adding the second block is going
to be a bit "painful" (extra code complexity, etc) for me.


> mapping/arithmetic solution on a platform I have, so I am going to
> pay a high penalty for people using in/out on PCI I/O space.  Fortunately,
> I can use drivers for devices that have PCI memory, although I will
> have to modify them, and most of the drivers will be new and unique.

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
