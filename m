From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15924.24396.105367.383171@argo.ozlabs.ibm.com>
Date: Mon, 27 Jan 2003 09:21:00 +1100
To: Steven Scholz <steven.scholz@imc-berlin.de>,
	Dan Malek <dan@embeddededge.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] m8xx_setup.c and PCMCIA
In-Reply-To: <3E3157BF.7060804@embeddededge.com>
References: <3E30F363.1020501@imc-berlin.de>
	<3E3157BF.7060804@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> > I reckon that (almost) all MPC8xx boards that use PCMCIA CS have to call
> > io_block_mapping() with _IO_BASE anyway....
>
> Well, _almost_ isn't good enough :-)
>
> I hope some of the more PCMCIA literate folks speak up here, because I
> think placing IO_BASE into the mix, and certainly io_block_mapping it
> is quite wrong.  It may be necessary for your board, but it certainly
> isn't something that is going to work on many others.  All you need is
> an 860 with a Tundra PCI bridge and all of these patches will fail to work.
> The pcmcia register mapping for you board should take these things
> into consideration when that mapping and register configuration is
> done, it's not something that should be part of global set up.

I'm not really here, I'm on vacation, but anyway...

The PCMCIA layer is one of those places where we can't easily get in
and change its assumptions about how I/O is mapped.  The reason is
that it will assign some range of I/O addresses to a card and then
expect to be able to access the card using those addresses.

In more detail, when a card is plugged in, the PCMCIA layer will read
its attribute memory to find out what it is and what memory and I/O
resources it has.  For example, suppose it is a modem card that
presents a serial port (16550-style) interface.  Its attribute memory
will say that it needs 8 bytes of I/O.  The PCMCIA layer will look for
8 bytes of unused I/O space.  Suppose it finds 8 bytes free at 0x400.
It will then write that value (0x400) into the appropriate spot in the
card's attribute memory, and expect to be able to do inb(0x400) to
access the card.

Which is, on the face of it, perfectly reasonable.  It put the card at
I/O address 0x400 and it expects to be able to access the card at I/O
address 0x400.  It creates difficulties for us, of course, because it
is assuming a single space of I/O port addresses with no translations.

What it boils down to is that we have little choice (unless you want
to rewrite the pcmcia layer :) but to make inb/outb etc. do what the
pcmcia layer is expecting.  That's the reason for the _IO_BASE mapping
hacks.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
