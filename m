Date: Tue, 8 Feb 2000 17:51:33 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Retrace
In-Reply-To: <20000208155637.001939@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.05.10002081749540.27293-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Feb 2000, Benjamin Herrenschmidt wrote:
> On Tue, Feb 8, 2000, Gabriel Paubert <paubert@iram.es> wrote:
> >On x86 you have /dev/port which is disabled on PPC. I once or twice
> >suggested (but was greeted with a deafening silence) that we could
> >resurrect it and add an mmap method so that privileged programs may access
> >I/O ports with:
> >
> >	io_fd= open("/dev/port", O_RDWR);
> >	iobase=mmap(0, device_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> >			io_fd, device_base);
> >
> >
> >> Unfortunately, with weird host bridges like Apple Uni-N (that has 3
> >> busses with 3 different io bases but the same bus number), it's almost
> >> impossible to get it correct, or eventually by parsing /proc/device-tree.
> >
> >Not a problem if device_base is unique, you have to check that
> >device_base+device_size fits within one area. It must be unique at one
> >point to distinguish them from the processor perspective.
>
> device_base may not be unique. Actually, that depends what is device_base
> and how it's retreived. But for example, reading the BARs can give you
> identical io base for devices on different sub-bridges, the distinction
> beeing done by the iobase of the bridge itself.

The BAR values in PCI config space may be the same, but the BAR values in
struct pci_dev can be made different by the machine-specific fixup code.

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
