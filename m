From: David Jander <david.jander@protonic.nl>
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Memory map with "holes"...
Date: Tue, 12 Aug 2003 17:00:11 +0200
Cc: linuxppc-embedded@lists.linuxppc.org
References: <20030812141332.496E2C59E4@atlas.denx.de>
In-Reply-To: <20030812141332.496E2C59E4@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308121700.11708.david.jander@protonic.nl>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tuesday 12 August 2003 16:13, Wolfgang Denk wrote:
> In message <200308121432.09782.david.jander@protonic.nl> you wrote:
> > We are designing a board based on the MPC852T (MPC866 serivate), and
> > I want to make sure there is the possibility to mount different-size
> > SDRAM chips on it, so I just connect the two bank-select pins to some
> > higher address lines, leaving some out in between, in order to acomodate
> > for bigger chips in the future. The bottom line is that I will get the
> > memory map split up into 4 segments with vast holes between each segment
> > that are undefined. What do I need to keep in mind regarding linux
> > about this? I suppose it isn't an issue, but I want to be sure I don't
>
> This is not an issue, as Linux does not care about  the  organization
> of  your  memory.  It  just  expects some amount of contiguous memory
> stating at address 0.

AFAIK this is exactly what I do _not_ get.
I wanted to connect the bank select lines BA0 and BA1 of the SDRAM chips to A6
and A5 respectively, and use only one CS (Chip-Select).

> > get any trouble later. Any experience with memory holes? I suppose the
> > boot-loader should tell the kernel about the memory-map, in a way just
> > like lilo on an x86 machine, am I right? Does this work the same way on
>
> No. There will not be any "holes". It is up  to  your  bootloader  to
> program  the  memory controller of the MPC8xx such that there is just
> one contiguous piece of memory. See U-Boot for example code how to do
> that (including auto-sizing routines and all the rest).

I saw different examples (tqm8xx.c for instance), but the only thing they seem
to do is program the memory controller in a way that all CS's map the whole
RAM on a contiguous block.
What I pretend to do is something like this:
Memory mapped on CS0:
Region                  What
--------------------------------
0x00000000-0x007fffff   RAM
0x00800000-0x01ffffff   invalid
0x02000000-0x027fffff   RAM
0x02800000-0x03ffffff   invalid
0x04000000-0x047fffff   RAM
0x04800000-0x05ffffff   invalid
0x06000000-0x067fffff   RAM

So it would not be possible to use the memory controller to make a contiguous
block out of this. But maybe the kernel could be told to declare the ranges
marked as "invalid" to be, well, invalid. With a MMU this should not matter,
only the kernel must know what to do.

For example I found in /arch/ppc/init.c, in the function set_phys_avail(),
this piece of code:

phys_avail.regions[0].address = PPC_MEMSTART;
phys_avail.regions[0].size = total_memory;
phys_avail.n_regions = 1;

This looks fairly easy to modify, but I wonder why nobody seems to use more
than one region in linux-ppc??
What's the policy? To not use this?
Am I the only one who wants something like this?
Should I start implementing this myself on u-boot and linux-ppc ('cause I
believe in this case you'd have to give linux a map from the boot-loader), or
should I better restrict my design to contiguous blocks of RAM only (this
would make me waste 4 CS lines, and unnecessarily complex hardware)?

Sincerely,

--
David Jander
Protonic Holland.
tel.: +31 (0) 229 212928
fax.: +31 (0) 229 210930
Factorij 36 / 1628 AL Zwaag

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
