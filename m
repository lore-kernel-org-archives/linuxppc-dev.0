Date: Wed, 25 Aug 1999 20:43:39 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Tony Mantler <eek@escape.ca>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Performa 5200
In-Reply-To: <v04003a00b3e9f623e46f@[216.81.27.143]>
Message-ID: <Pine.LNX.3.96.990825202634.30523A-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 25 Aug 1999, Tony Mantler wrote:

> [...]
> >all the x100 machines have address maps that depends on the population of
> >the RAM slots. Also, some of them have a DRAM-based frame buffer working
> >at a fixed physical address which can be either 0 or 1Mb.
> >BootX will load the kernel in the first contiguous region in memory it
> >can find, but that means that we have to copy the exception vectors to 0,
> >adjust them so they call correctly the kernel routines in the real base
> >of the kernel (which will not be 0 on some machines), and we'll have
> >virt_to_phys and co be non-constant. I read an interesting suggestion
> >some time ago of reserving a register during kernel compile with gcc and
> >using this register to store the real base of the kernel. Modules will
> >not be compatible, but that's not a real issue for now.
> >I don't know how the APUS code works, but I heard it is similar.
> 
> Yeek. Sounds like a messed up version of RBV (IIsi). On that particular
> machine (iirc), the start of real useable ram, where the kernel is located,
> is remapped down to 0x0, and the framebuffer is mapped way up into (I
> think) slot $9 regular space to mimic the configuration of the slightly
> more sane macs.

Not quite.  It moves from 0 to something like 0x10000, but there may be
more zeroes than that.  That's the PDM's.  If you're asking about the
52/53/62/6300's, though, they use a Valkyrie just like the 5400.  They
have nothing in common with the 6100.  They don't even have DMA support.


> >>I'm starting to think that I should carve out a new machine class in the
> >>config options (#ifdef CONFIG_WUSSY_68K_PMAC?) ;)
> >
> >Or simply CONFIG_NUBUS_PMAC... BootX will tell you if you are running on
> >one of those and will tell you if it's a PDM based (x100), performa or
> >powerbook (5300/1400). It will also give you the gestalt machineID and
> >the phys. memory map table. If you need more infos, tell me, but I
> >beleive most of the other infos will have to be hard coded.

It's a bad idea to have any of these three in the same class.  They don't
act a thing alike.  The NuBus PowerBooks and Performas are KIND of close,
in that neither has DMA, but their IDE works with different offsets
between registers, their interrupt handling is almost completely
different, the video is different... it's substantial enough to make it
far better to define them as separate classes.  Otherwise, all those
pieces of code will be riddled with switch statements for a huge list of
gestalts (16 different numbers for the PDMs alone).

If you want to maintain some sense of naming consistency with MkLinux
(which is a good idea), we use:

POWERMAC_CLASS_PCI       - almost everything
POWERMAC_CLASS_PDM       - 6/7/81xx, AWS 6/7/81xx
POWERMAC_CLASS_POWERBOOK - NuBus PowerBooks
POWERMAC_CLASS_PERFORMA  - NuBus Performas
POWERMAC_CLASS_LEGACY    - 68k PowerMacs w/ upgrade cards

Note that the last two are not quite working yet.  We were close on the
performas, and the 68k PowerMacs aren't quite as close, but at least some
of them start booting now with the right config.


Later,
David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
