Date: Sun, 27 Aug 2000 23:26:53 +0200 (MET DST)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@netx4.com>
cc: Ronald Wahl <rwa@peppercon.de>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: allocating uncachable memory
In-Reply-To: <39A96FFA.EF350293@embeddededge.com>
Message-ID: <Pine.GSO.4.10.10008272258170.29427-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

> Coming up with a function name and actually implementing it are two
> very different things......ioremap() should do the right thing.

If you mark the page(s) as reserved it should already do the right thing
on most architectures. The only problem is ioremap doesn't take an array
of pages.
Another possibility is __vmalloc(), that already has a protection
argument and you only need a virt_to_xxx() to get the address of the
allocated pages.

> > Sure?
>
> Yes I am sure.  Bursting data over the bus is hell of a lot faster,
> especially in this case where the PCI bridge can combine these into
> a PCI burst transfer as well.

This mostly useful for stuff like framebuffers, where you have only one or
two copy functions, where the required complexity is concentrated.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
