Date: Sat, 11 Aug 2001 19:43:20 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP and generic PCI resource assignment
In-Reply-To: <20010810143423.B28326@austin.ibm.com>
Message-ID: <Pine.LNX.4.05.10108111942220.11186-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 10 Aug 2001, Hollis Blanchard wrote:
> On Fri, Aug 10, 2001 at 10:38:04AM +0200, Geert Uytterhoeven wrote:
> > There are (or were, read as in `were the last time I
> > tried it, a few months ago) still some problems, though. One of them is that
> > the hardcoded ISA motherboard resources (i8259 and legacy stuff) are
> > requested before PCI resources are done, and that the PCI bus parent
> > resources were not requested and thus don't appear in the full resource
> > tree.
>
> There is still that problem with VGA console, which does a
> request_resource(&ioport_resource,...) after the PCI host bridge has been
> found, but well before the PCI code has reserved all of *its* resources. So
> reserving 0-ffffffff IO fails because VGA already grabbed a tiny chunk at
> 0x3d0 or so.
>
> Even regardless of order, VGA console is requesting directly from
> ioport_resource, which probably should be changed (Paul suggested
> request_region instead)...

Yes, using request_region() is the correct fix.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
