Message-ID: <39CAD7BC.7AF0E42D@mvista.com>
Date: Thu, 21 Sep 2000 23:53:32 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: paulus@linuxcare.com.au,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.LNX.4.10.10009211544591.375-100000@cassiopeia.home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven wrote:

> And how to access PCI I/O space from user space? There the MMU doesn't help,

Sure.  I do it all of the time.  I have an 860 with a Tundra PCI
bridge (any system but x86 will do this too).  I just open /dev/mem,
and map the physical address of the device on the bus.  In this
case the Tundra maps physical 0x80000000 to the PCI/ISA I/O space,
and 0xc0000000 to PCI memory.  I even have an ISA bridge downstream
that I access ISA boards in the user application.  Piece of cake.

In the user application I get some virtual address like 0x34010000
or whatever, and that is mapped through the MMU to the 0x80000000
physical address.  You can do this on any processor but the x86.
The virtual address is likely to be different every time, but I
don't care...


> since the user application (usually XFree86) just look at the BARs from
> /proc/bus/pci/...

Well, there lies the challenge.  I _know_ where I am going, so I
can just hard code the addresses.  This is the reason I keep asking
for the one single thing that I think is going to make the biggest
difference.  We need a mechanism that will tell you how to find these
devices (like give you a virtual address pointer).

Reading BARs through config register access of bridges doesn't
provide enough information that allow you to do in/out, or read/write,
or whatever you want to do.  We need a platform specific method of
containing this information, mapping it, and providing it to portable
drivers.

> This is very similar to what many people already suggested on linux-kernel
> years ago: inb() and friends should take an additional argument pci_dev *.

Yeah, but it is easier to talk about here.  I discovered it is easier
to do something in the machine dependent part of the tree and let Linus
see it work than try to convince him it is a good thing before you
start :-).  Hmmm...sounds like me :-).

I don't have good enough filters for linux-kernel any more.  Too much
noise out there.

> For kernel space. This doesn't work for user space, unless you mmap
> /dev/pci_{io,mem}_space, which don't exist at the moment.

I'm not sure it's a good thing to mmap from user space like this,
although I do it quite a bit because it is easier than writing a driver.
There were discussions not long ago about some interfaces that would
work properly.  You would identify a device by more than just an
address, I believe the PCI bus/dev/function was discussed.

> Microchannel is something different.

I was just kidding :-).


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
