Message-ID: <3C20CDF7.B8EABF01@aquilagroup.com>
Date: Wed, 19 Dec 2001 10:27:19 -0700
From: Jeff Studer <jstuder@aquilagroup.com>
MIME-Version: 1.0
To: Peter Desnoyers <pdesnoyers@chinook.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCI QSPAN2 resource conflicts
References: <3C1F9452.AB979826@aquilagroup.com> <3C1F8DE8.9FA7CECE@chinook.com> <3C1FBADD.FF66E2A7@aquilagroup.com> <3C20B5E2.4C3AA604@chinook.com> <3C20BAE5.3180684F@chinook.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Basically, my problem is setting up resources, or at least for our PCI
card, thats the case.  I can't get past resource allocation for it.

My current understanding is that we pick a safe base address to use to
access PCI I/O and Memory space.  We also set up the amount of PCI I/O and
Memory space we want to be able to access.  We set this address up in the
Slave0 -- in our case, we only get Slave0 -- and this size, and do the same
with the chipselect for the Slave0 image.  We then use these same values to
set up the PCI system's bus resources.  How much space is recommended?  I
picked 0xf4000000 and 64Mbs of PCI I/O / Memory space.

I also modified the inb/outb/inw/outw/inl/outl to set the QSpan2 Slave0 for
I/O space access, and readb/writeb/readw/writew/readl/writel to set Slave0
for PCI Memory access, as our board can't use Slave1 at all.

As far as setting up the device resources, I'm not entirely clear on what I
should do, if anything, in this regard.  I wasn't sure if the rest of
Linux's PCI system would do that, given the bus resources settings I made.

I did try using the probe_addresses() and map_pci_addrs() functions from
arch/ppc/mbxboot/pci.c, but I don't clearly understand what the address
mapping function is trying to do.

Am I making things overly complicated, or overly simplified?

Peter Desnoyers wrote:

> I'm forgetting - the values in the registers are actual PCI I/O and
> memory addresses, so there's no issue if they overlap.  (the physical
> addresses mapped to them on the CPU side can't overlap, though) And when
> I was talking about target image programming in the QSpan, I should have
> been referring to the bus addresses, not the physical addresses.

Me, too.  Is there a standardized algorithm to do this?

>
> However, I still get the feeling that there's something badly wrong with
> the way you've got your base registers mapped on the two devices, plus
> your device is just plain turned off.

Thanks again for taking the time to help me.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
