Date: Sat, 2 Jan 1999 19:47:53 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: Jeff Rugen <jrugen@primenet.com>
cc: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: fbcon + X Server + Cirrus/Powerstack
In-Reply-To: <Pine.BSI.3.96.981228111730.13388A-100000@usr05.primenet.com>
Message-ID: <Pine.LNX.4.04.9901021921540.9212-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 
> It seems Troy Benjegerdes had a problem with getting the matrox (?)
> framebuffer to work with something as well, but I don't remember if that was
> as a module or if it was with the X server (my tweaked clgenfb doesn't work
> as a module, and I'm thinking it may be related to the physical address
> above, but I haven't experimented as a module recently).

ioremap is broken, at least on PReP. It works during the kernel boot-up
sequence, but not after (when you try to load a module)

> 
> Could the problem be that ioremap doesn't return the same address as passed
> into it?  It seems I remember seeing a comment or some documentation that
> indicated it was supposed to...

Not on PReP.. It's sorta confusing because the kernel is mapped at
*virtual* address 0xC0000000 and the PCI memory space is mapped at
*physical* address 0xC0000000.

--------------------------------------------------------------------------
| Troy Benjegerdes    |       troy@microux.com     |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
