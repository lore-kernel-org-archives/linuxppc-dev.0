Subject: Re: address translation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ppc339@vtnet.ca
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200305160002.57463.ppc339@vtnet.ca>
References: <200305150729.36436.ppc339@vtnet.ca>
	 <1053007531.2561.38.camel@gaston>  <200305160002.57463.ppc339@vtnet.ca>
Content-Type: text/plain
Message-Id: <1053075615.2561.76.camel@gaston>
Mime-Version: 1.0
Date: 16 May 2003 11:00:15 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-05-16 at 06:02, Trevor Woerner wrote:

> But when it comes time to access the ATA registers I've hit a brick
> wall. The default PCMCIA code keeps wanting to setup IO ranges at 0x1f0
> and 0x3f6. So I've sliced out most of the configuration code from
> ide-cs.c and have tried to "manually" set the ports start at 0xf000000
> (0xf000000 + _IO_BASE = 0xf7000000). I don't think I've been too
> successful. For one, the size of an io port is 'unsigned short' which
> won't fit, so I changed that to 'unsigned int'.

What you can do is to setup different iops. Starting with 2.4.21,
the IDE layer let you change the accessor functions for a given
hwif. If you want to stick to an older kernel, you can tweak
the definition for IDE_INB etc...

Regarding address mappings, what you need is:

 - Provide a virtual mapping for f7000000. That is ioremap it
basically. The resulting virtual address will be called
ide_virt

 - Feed the IDE layer with a set of ports that start at

ide_virt - _IO_BASE

That way, when the IDE layer tries to do an inb() for example,
it will do an access to port + _IO_BASE, which will turn into
an access to port_offset + ide_virt - _IO_BASE + _IO_BASE,
that is port_offset + ide_virt, which is what you want.

> >From a cursory look at the ide.c code, it appears the kernel wants to
> access the ATA registers one byte at a time. Unfortunately, because my
> device is wired directly, I have to access it 16 bits at a time. So it
> looks like I'm going to have to hack the ide.c code (or something like
> it) to combine adjacent registers together before reading/writing.

Well. This is another issue. You basically need to redefine the
accessors IDE_INB/W etc... (or use custome iops in the hwif structure
for 2.4.21 and later kernels). Typically, you will do a 16 bits
access keeping only half of the read word for reads, or writing to
half of the 16 bits word for writes. There is nothing like accessing
2 registers at a time, registers will appear to be 16 bits each if
your bus is properly wired, it's just that IDE registers other than
the data register only contain 8 bits of useful data.

Also be careful that your HW engineers properly wired the ATA bus,
so that you don't have to byteswap the data. If this is done properly,
you will have to byteswap the control but not the data. That is
the "byte" access will work on the MSB of the 16 bits word while the
word accessors will do no byteswap. If you don't do that, then you'll
have problem with insw/outsw etc...

> Is it just me, or did the hard drive controllers of the 68k era
> (drivers/ide/legacy/macide.c) have memory-mapped registers? I was
> looking at their code today and it seems similar to what I'm looking
> for (i think).
>
> I can't help notice that in _2_4_devel, ide-cs.c has been moved to
> drivers/ide/legacy. What is the intent here, what are we supposed to
> use for cs cards?

We do mmio on powermac too. On pre 2.4.21, we did pointer tricks like
described above, on 2.4.21 and later, you can fill the hwif to use
different access functions for registers.

(look drivers/ide/ppc/pmac.c)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
