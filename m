Date: Fri, 19 Oct 2001 08:13:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: arch/ppc/kernel clutter
Message-ID: <20011019081353.C7765@cpe-24-221-152-185.az.sprintbbd.net>
References: <15312.6740.808012.183783@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15312.6740.808012.183783@cargo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Oct 19, 2001 at 10:19:32PM +1000, Paul Mackerras wrote:

> I feel that arch/ppc/kernel in the linuxppc_2_4_devel tree is getting
> more than a bit cluttered.  I propose that we make a new
> arch/ppc/platforms directory and move the platform-specific files into
> there - i.e. all of *_setup.c, *_pic.c, *_pci.c, and maybe some
> others.  What would be left in arch/ppc/kernel is the more generic
> stuff, i.e. things relating to the different base processors, the
> different types of interrupt controllers or PCI host bridges, the
> generic stuff that interfaces to the rest of the kernel (e.g. setup.c)
> and so on.

I think we should go and look at what MIPS is doing.  They've got
something like:
arch/mips/<chipset>/
                    common/pci.c, irq.c
		    board_name/setup.c, other board specific stuffs.
I think doing something like this, but inside of arch/ppc/platforms
would make sense.

> My idea is that adding support for a new board would not normally
> require changes in arch/ppc/kernel unless the new board has a new type
> of interrupt controller, PCI host bridge, etc.

Sounds good.

> Another thing I would like to do is to generalize the drivers for the
> various on-chip peripherals a bit more.  The platform code would then
> specify in some way "this platform has an XYZZY on-chip ethernet
> controller with registers at 0xabcdef00, using interrupt 123, with
> quirks A, D and F".  (This sort of thing is what the OF device tree
> was designed for and does very well, BTW.)

How about we put the totally platform specific stuff, like say 8xx
microcode updating into arch/ppc/platforms/cpm8xx/drivers/ or something
like that, and move the enet/serial drivers out.  But yes, the 8xx/8260
enet/serial drivers need some work.  The ppc405 enet driver is a bit
better about some of these things.

With the ppc405 enet driver we can detect things like the PHY, but other
infos are still a compile-time option.  Some of these might be
detectible, but I think in the case where you don't have any control
over the firmware, and it's either buggy or it's lacking in features,
it's a toss up if you want to figure stuff out at compile time with a
config option or hardcode stuff either in the driver or wrapper based on
best-guessing.

> The configuration scripts could force CONFIG_XYZZY on when this
> platform is selected and that would compile in the xyzzy driver.
> The xyzzy driver initialization would get called during boot and would
> look up whether the platform has any XYZZY's, and if so, what
> addresses and interrupts to use.  So the XYZZY code doesn't need to
> know anything about which platforms have an XYZZY at all.

Erm, I don't think you can get rid of asking things about CONFIG_XYZZY
tho.  I _think_ depending on how you build the drivers it's sometimes
possible to have the same HW either have 2 XYZZYs or an XYZZY and a
ZYXXY.  But the drivers can certainly be cleaned up a bit to probe
around in some cases instead of big ugly #ifdef tables.

> This could extend to things like interrupt controllers and PCI host
> bridges as well as regular I/O devices, too.

Eh?  I'm pretty sure all of the bridge stuff is pretty well extracted.
Pass it your board values (which are unchanging constants) and it just
works.  There are a couple of funny issues which could be handled a bit
better (Sandpoint X2 vs Sandpoint X3) but by and large the I/O device
drivers are the ones with some glaring uglies in it (which I have been
thinking about..)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
