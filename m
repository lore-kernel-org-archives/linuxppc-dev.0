Date: Thu, 25 May 2000 14:13:13 +0200 (CEST)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: Neil Russell <caret@c-side.com>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Floating Point problems with Linux on the EST SBC8260
In-Reply-To: <20000524201743.A8680@lx.c-side.com>
Message-ID: <Pine.BSF.4.21.0005251319150.9249-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 24 May 2000, Neil Russell wrote:


> We have an FPGA that implements part of the ISA spec, enough to do
> programmed I/O to an IDE device.  The FPGA has its own chip select and uses
> the UPM for timing.  It doesn't work correctly yet because what the 8260
> documentation says and what the 8260 does are different.  When it works,
> it will be slow, but we probably don't care - we are not building a
> file server.

You tell me your HW designers can't operate a logic analyzer?
Be nice. My guess is that they are experiencing some transmission
line failures. It is also hard to reach the /TA line timing
requirements with FPGA. Logical errors are simple to correct.
Reflected waves or responstime errors not quite so. BTW, when you
already have a full FPGA installed then why waste a UPM? A full
local bus decoder does not take that much FPGA space.
And if you do share a /CSn line and only decodes the LS address
bits, then the gates reqirement can be cut in half. This is not
even that hard to do. We do it already in both Altera and Xilinx.

> I'm not sure that we care enough to redesign the logic to make it fast,
> but I do care that it doesn't slow everything else down, so at some point
> I plan to look to using some form of DMA; perhaps the SDMA that the CPM
> provides.  It will probably still be slow, but he CPU will no longer be
> held up.
>
> Got any better ideas?  (no PCI, no expensive chips...).

HW FIFOs are always nice to have, even with HDD caches.
Concatenating 16 bit IDE PIO stobes into 32/64 bit PowerPC burst
transfers are likewise not to be foresaken. But this works best for
large datatransfers or else the overhead from "data ready"
interrupts will be expensive. Or one could hook the "data ready"
line up against an IDMA_REQ line instead.

Actually, I am about to implemet this kind of interface for the
MPC860. I have just recived a go from our management on designing
our own scalable MBX860 board. Which means it will be awhile
before I get around to the IDE interface. But to keep power
drain low I will probabely use the second PCMCIA port for it
by means of Xilinx Coolrunner and an AVR for autoconfiguration.
Then I could (but will not) expand this into a full ISA bus.

BTW, VxWorks can not easily handle more than 32 MBytes of local RAM
as the eabi specification (as a result of the PowerPC architecure)
rules for 26 bit (signed) relative addressing. Hence, I will design
in exactly 32 MBytes of soldered low power SDRAM on UPMA and assign
UPMB to a DIMM socket. How does PPC/Linux handle this addressing
problem?

One more - if anyone has the specification for Sony Memorystick
I would be interested. I am pretty certain that this flashstick
has a serial interface on it. Most probabely SPI since Sony use
SPI extensively in the Playstation among others. This would suite
a PowerQUICC just fine, thus avoiding those ATA flash disks
completely. As you should be aware of by now, I am absolutely
no fan of ATA from a HW point of view. And since struggling
with the ATA device drivers in VxWorks, neither from a SW point
of view. Thank you for your attention. But I will nevertheless
design ATA interfaces for the interested parties.

--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.and.so.forth
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
