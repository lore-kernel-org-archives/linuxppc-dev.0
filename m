Content-Type: text/plain;
  charset="iso-8859-1"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: address translation
Date: Fri, 16 May 2003 00:02:57 -0400
References: <200305150729.36436.ppc339@vtnet.ca> <1053007531.2561.38.camel@gaston>
In-Reply-To: <1053007531.2561.38.camel@gaston>
MIME-Version: 1.0
Message-Id: <200305160002.57463.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On May 15, 2003 10:05 am, Benjamin Herrenschmidt wrote:
> On Thu, 2003-05-15 at 13:29, Trevor Woerner wrote:
> > I want to setup a mapping so that when anything tries to read/write
> > the 16 bytes at 0x1f0 - 0x1ff the actual physical memory that gets
> > accessed is 0xf7000000 - 0xf700000f.
>
> I would say you are taking the problem backward.

Yea, that sounds like me :-)

> Tell us more about what you are doing. Looks like you have some IDE
> mapped at 0xf7000000+. You need to tell IDE to use those. What kind
> of PPC CPU is this ?

I've got a PPC405gp-based device that has an on-board CompactFlash slot
into which CF cards can be inserted. But to save money there is no
PCMCIA controller, and the device is simply wired directly to 2 address
regions: 0xf7100000 for the attribute memory (which mostly holds config
information and the Card Information Structure (CIS) tuples) and
0xf7000000 which is where the card's ATA registers will show up (once a
card is inserted). If only it had been wired to 0xf70001f0...

The spec says these are supposed to be little endian, but I only get
meaningful data when I use big endian access (most devices on this
board appear to have been swapped in this way, e.g. RTC).

They want to be able to swap cards in and out, so I started with the
PCMCIA stuff. I've got the card detect interrupt working so inserting a
card will cause the ds.c, cs.c and all that other stuff to start
chugging along. I also twisted the cistpl.c code so it can successfully
read and parse the CIS structure.

But when it comes time to access the ATA registers I've hit a brick
wall. The default PCMCIA code keeps wanting to setup IO ranges at 0x1f0
and 0x3f6. So I've sliced out most of the configuration code from
ide-cs.c and have tried to "manually" set the ports start at 0xf000000
(0xf000000 + _IO_BASE = 0xf7000000). I don't think I've been too
successful. For one, the size of an io port is 'unsigned short' which
won't fit, so I changed that to 'unsigned int'.

This isn't a pci device, unfortunately, just straight memory-mapped. All
of the PCMCIA code expects this to be accessed using 2 IO windows with
ioremap()ping and so on. But because of the lack of wires I can only
access the device in "common-memory" mode (which the PCMCIA code isn't
setup to handle).

> IDE by default uses inx/outx accesses, which are
> relative to _IO_BASE. So you just need to pass IDE some addresses
> that when offsetted with _IO_BASE will fall in an ioremap'ed mapping
> of 0xf7000000

Ha! I spent most of the morning tracking this one down. I couldn't
figure out why, when I asked for 0xf700000, I kept getting illegal
accesses in the 0xdf000000 range (my _IO_BASE is set to 0xe8000000). So
now that I lie and ask for 0x0f000000 instead, the kernel stops
panicing :-)

> There is no MMU trick involved

Perhaps you can see why I was hopeful there was.

>From a cursory look at the ide.c code, it appears the kernel wants to
access the ATA registers one byte at a time. Unfortunately, because my
device is wired directly, I have to access it 16 bits at a time. So it
looks like I'm going to have to hack the ide.c code (or something like
it) to combine adjacent registers together before reading/writing.

Is it just me, or did the hard drive controllers of the 68k era
(drivers/ide/legacy/macide.c) have memory-mapped registers? I was
looking at their code today and it seems similar to what I'm looking
for (i think).

I can't help notice that in _2_4_devel, ide-cs.c has been moved to
drivers/ide/legacy. What is the intent here, what are we supposed to
use for cs cards?

> Ben.

p.s. are you coming to OLS again this year?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
