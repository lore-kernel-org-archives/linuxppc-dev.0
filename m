Date: Wed, 20 Sep 2000 14:15:38 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matt Porter <mporter@mvista.com>
cc: Paul Mackerras <paulus@linuxcare.com.au>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <20000919231220.A10511@cx258813-a.chnd1.az.home.com>
Message-ID: <Pine.LNX.4.10.10009201408560.389-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 19 Sep 2000, Matt Porter wrote:
> On Wed, Sep 20, 2000 at 09:58:07AM +1100, Paul Mackerras wrote:
> > Matt Porter writes:
> > > On Tue, Sep 19, 2000 at 02:59:02PM +1100, Paul Mackerras wrote:
> > One solution that has been proposed is to set the base I/O port number
> > in the pci_dev structure to be actually the virtual address where you
> > can access that I/O port.  I don't like that solution because it means
> > that drivers for legacy PC-style devices can't do inb/outb to the
> > usual well-known port numbers and find the device they expect.  For
> > example, inb(0x3f8) won't access the first serial port (this is on
> > machines such as prep and some chrp which have a lot of PC-style
> > devices).

Another option would be to use a translation table. If you limit I/O space to
64 kB (like on PC), you waste only 256 kB of memory (assuming a table with
32-bit pointers). With a multi-level tree or a smarter pointer scheme, you can
limit the waste even more. Since I/O accesses are intrinsically slow, the
overhead is minimal.

I agree this solution is not optimal, though.

> Ick...agree here.  Of course, the serial driver could be changed to
> do other than inb/outb's for other archs and be passed the memory
> mapped address of the ports.

These days serial.c does support MMIO on PCI devices. In fact it supports
everything that looks even remotely like a NS16550 (hence it should be renamed
16550.c), both in I/O and in memory space.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
