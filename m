Message-ID: <39B7F7A7.1B36ACBD@adc.com>
Date: Thu, 07 Sep 2000 15:16:39 -0500
From: Darin Smith <darin_smith@adc.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: io write not working
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,

I hope someone here can give me a clue as to what is going on.

I have a networking driver that I have spent a lot of time porting from
a 2.0.30 kernel to 2.2.14.

This works:
I have a transmit buffer in kernel space (0xc0xxxxxx) and I give this
address to the device across the PCI bus by writing
cpu_to_le32(virt_to_bus(bufaddr)) to the appropriate register.  When I
queue up data in the buffer it transmits just fine, and a fully
functional 2.0.30-based machine reads a ping and sends one back.

This doesn't work: (receive)
The controller receives the packet from the PHY interface, and does its
work, then generates a "receive done" interrupt, which indicates to my
driver that it should pick up the data from the receive buffer.  The
receive buffer also resides in kernel (host) space around the address
(0xcc40xxxx).  The base address of this buffer is handed to the
controller across the PCI bus just as above at initialization time.  The
controller increments the location within the buffer, and returns the
address through a register that I read, doing
bus_to_virt(le32_to_cpu(rxbufaddr)).  Only my buffer does not contain
any data (just has the test pattern I wrote to it on init).  Thus trash
gets sent up to the protocol layer and the packet gets dropped.  Let's
say my buffer starts at 0xcc4098d4, when I send this to the device and
read back (without swapping or converting on the read back) I get
0xd498408c...which is LE for 0x8c4098d4...seems right...after dropping
data in there, the chip passes me 0xd498408c which after my
bus_to_virt(le32_to_cpu()) becomes 0xcc4098d4 ... looks correct.  In
fact, if I ping it long enough, I can watch the buffer (circular queue)
wrap around precisely where it should, the free buffer queue has all the
seemingly "right" addresses, etc.

So it seems obvious that from PCI space, the controller is able to
*read* from 0x8xxxxxxx addresses, but cannot *write* to them.

Here is some more configuration info for you:
Machine is basically prep, with a few customizations.
Registers exist at phys 0xc1000000, virt 0xf1000000 (due to BAT
mapping)  ... I stuggled with that at first but eventually figured it
out.

BAT setup looks like:
setbat(0, 0x80000000, 0x80000000, 0x10000000, IO_PAGE);
setbat(1, 0xf0000000, 0xc0000000, 0x08000000, IO_PAGE);
setbat(3, 0xF8000000, 0xF8000000, 0x08000000, (_PAGE_NO_CACHE | _PAGE_RW
| _PAGE_COHERENT));

Nothing fancy.

This should be governed by BAT0, and IO_PAGE defines _PAGE_RW.

On initialization I set and checked PCI_COMMAND_IO and
PCI_COMMAND_MEMORY ... according to the docs, you only need to set
PCI_COMMAND_MEMORY, but I've tried it both ways.

We have a logic analyzer, but hardware has to build a cable set for me
before I can use it.

Maybe somebody out there sees something obvious that I'm doing / not
doing?

Any help is greatly appreciated.

--
Regards,

Darin W. Smith

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
