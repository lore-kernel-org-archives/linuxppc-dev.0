Date: Fri, 29 Sep 2000 17:11:37 -0700
From: Matt Porter <mporter@mvista.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <bh40@calva.net>, Michel Lanners <mlan@cpu.lu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
Message-ID: <20000929171137.A31137@cx258813-a.chnd1.az.home.com>
References: <19340823125112.7591@mailhost.mipsys.com> <Pine.LNX.4.10.10009291319510.383-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.10009291319510.383-100000@cassiopeia.home>; from geert@linux-m68k.org on Fri, Sep 29, 2000 at 01:37:45PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 29, 2000 at 01:37:45PM +0200, Geert Uytterhoeven wrote:
>
> On Thu, 28 Sep 2000, Benjamin Herrenschmidt wrote:
> > >> I'm not sure it would help. It would probably allow a kind of "mapping on
> > >> demand" of the IO region on memory mapped IOs platforms, but unless we
> > >> add another parameter to ioportremap telling it the pci_dev (or at least
> > >> the bus number), we can't "guess" on which IO bus the device is and which
> > >> physical base we must use.
> > >
> > >But we can find out the IO bus by looking in which region the physical
> > address
> > >is located, right? Or do we have the same region on different IO busses?
> > >That would be really weird! Different IO busses should decode different
> > >regions.
> >
> > That mean that you intend to feed a physical address to ioportremap and
> > not an IO address ? Hrm... that mean we need to have the physical address
> > in the device IO resources instead of the content of the IO BAR. Well,
> > how should this work for legacy devices, then ? By assuming addresses
> > below 64k are legacy IO (hard coded) addresses ? I don't like it too much.
>
> No, I meant I/O addresses. Each PCI bus should decode different I/O addresses,
> just like it decodes different memory addresses.
>
> Say the first bus decodes I/O 0x0000-0x0fff, the second one decodes
> 0x1000-0x1fff, and so on. If the different busses have different physical
> addresses, you have to use the region decoding from my previous mail. Hence
> ioportremap() would move the burden (and overhead) of the region decoding from
> inb() and friends to one single place: ioportremap().

No, each PCI host bridge segment contains an independent address space
and may well have addresses that are identical numerically to addresses
on other host bridge segments (I hate that "host" terminology).  The
host bridges are what map these to sane unique values on the processor
bus.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
