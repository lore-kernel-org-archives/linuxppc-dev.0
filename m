From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <jeffrey.d.kowing1@jsc.nasa.gov>,
	Hollis Blanchard <hollis@austin.ibm.com>
Cc: <jeffrey.d.kowing1@jsc.nasa.gov>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: io.h and I/O port access from user space
Date: Tue, 5 Feb 2002 23:34:46 +0100
Message-Id: <20020205223446.15657@smtp.wanadoo.fr>
In-Reply-To: <15456.23060.255087.831957@igor.jsc.nasa.gov>
References: <15456.23060.255087.831957@igor.jsc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>
>Well, since you ask and at the risk of further demonstrating my
>ignorance:
>
>Yes, I have ISA slots - well, actually, I have a PC/104 stack.
>
>Specifically, I've got an inhouse 603ev/MPC106 board on a PC/104 form
>factor running a linuxppc 2.4.x kernel.  I've been using an Adastra
>NSP-104 PC/104 module as my network interface card.  That card,
>besides its ethernet chip, also has a Super I/O PC87338 chip that
>controls two serial ports (i.e. SCC1 and SCC2).  Naturally, I just had
>to use those two serial ports, and, of course, it doesn't have nice
>little jumpers to set IRQ and IO base addresses.  Instead, it wants to
>be configured using Plug-n-Play which I obviously know nothing about.
>Anyways, I thought, hey, I'll investigate by using this nifty
>isapnptools package.  Silly me.
>
>But beyond my specific problem, I guess it got me to wondering in
>general about the proper way to write user space programs using
>inb/outb (and in my wildest fantasies of submiting a patch for
>isapnptools).

The best way here is to use the mmap facility of /proc/bus/pci to
mmap the IO space of the bus into your userland space, and then
write your own accessors.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
