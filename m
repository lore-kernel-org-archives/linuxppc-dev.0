Date: Fri, 10 Aug 2001 12:51:34 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PReP and generic PCI resource assignment
In-Reply-To: <20010810095659.6588@smtp.adsl.oleane.com>
Message-ID: <Pine.LNX.4.05.10108101249010.2083-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 10 Aug 2001, Benjamin Herrenschmidt wrote:
> >You should initialize the parent pointers in the PCI bus structure with
> >pointers to resources containing the correct region.
> >
> >I once hardcoded the parents for the LongTrail, but that code is gone. Now it
> >tries to set up the parents from information in the OF device, which works
> >more or less. There are (or were, read as in `were the last time I tried
> it, a
> >few months ago) still some problems, though. One of them is that the
> hardcoded
> >ISA motherboard resources (i8259 and legacy stuff) are requested before PCI
> >resources are done, and that the PCI bus parent resources were not requested
> >and thus don't appear in the full resource tree.
>
> Parent pointer should be set properly nowadays on bk _2_4_devel at least.

Are the parent resources registered using request_resource() yet?

Furthermore legacy resources should be requested after that, so they are
requested from the correct region, and no overlaps will occur. I had some
(fortunately harmless, it still worked) conflicts, because the PCI resource
tree and the normal I/O resources where in two separate resource trees.

> However, the generic PCI code still wants to add that PCIBIOS_MIN_MEM
> value when assigning resources, I bet we should probably #define that
> to 0 on PPC.

Yes, that should be OK, iff all PIC buses have valid parent resources.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
