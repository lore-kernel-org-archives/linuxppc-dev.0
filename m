Date: Fri, 22 Feb 2002 10:32:26 +0100 (CET)
From: Geir Frode Raanes <geirfrs@invalid.ed.ntnu.no>
To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: custom mpc8240 student project (long)
In-Reply-To: <C08678384BE7D311B4D70004ACA371050B7632E4@amer22.avnet.com>
Message-ID: <20020222084929.O34054-100000@invalid.ed.ntnu.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 21 Feb 2002, Kerl, John wrote:

>
> I don't want to scare anyone off ... JTAG *is* slow, painful,
> and fraught with hazards -- *if* you try to write your own
> software to bit-bang the JTAG pins over, say, a parallel port.

Now, the parallel port is as we all know parallel.
JTAG is, as we all know, synchronous serial.

To interface the former to the latter, one would normally
place a shift register with clock control inbetween. But
the clock control can be complex enough to justify replacing the
shift register and clock control with a single microcontroller
with a SPI port. The SPI port basically constitutes of a shift
register with clock control which we can misuse as such.
An AVR AT90S4433 would suffice. It also offer an HW UART if
serial communication is preferable to the parallel port.

One needs one full 8 bit port free to read an external octal
latch/register or FIFO, which other side will be hooked up to
the parallel port. Basically two chips and perhaps some glue.

Preferabely use an 9 bit wide FIFO like the 9x64 word deep
74HC7030. The 9'th bit can be connected to an control
line of the parallel port to distinguish between control
and data in the FIFO. The other end of the 9'th bit can
then be routed to an interrupt pin on the microcontroller
to avoid SW polling.

> #2, the bit rate out the parallel port is abysmal.  Another
> poster on this list cited 40 KB in 12 minutes; our experience

Legacy parallel port perform @ 100 KByte/s. This is about
the saturation level of the microcontroller too. It is also
as fast than the SPI port will go, wich tops out below Fosc/4
or 8MHz/4 = 2MBit/s = 256 KByte/s. But datapushing at 100 KB/s
leaves a headroom of ~64 instructions per byte. Tight.

> #1, you don't write any C code; you get the BSDL files from the
> part vendors, and the board's netlist from the board vendor.

What I would like to know is wether this BSDL file can be used
to reversengineer the functionality of the internal TRAP logic.
We really don't want to do boundary scan in the true meaning of
the words, but rather we want to do what BDM4GDB does for us on
the XPC8xx series CPUs - control the core. I do HW, not really SW.

This is all about control - the manufactures should not be allowed
to place a NDA on this information. Redirecting customers to 3'd
party vendors of debug equipment effectively means customer
filtration. "If your are to small to afford the contiousely
astronomical cost of 3'd party tools, then you're also too
small for us." Need I remind you that the same melody can
be applied to GCC and LinuxPPC vs. 3'd party too...?

> #3, socketed flash tends to wear out -- we've had a lot of
> frustration with metal fatigue on the flash pins and/or socket
> pins.  When you use JTAG, you aren't wearing out your flash
> pins by popping them in & out of sockets, in & out of the flash
> programmer, dropping them, etc.

Zero Force Sockets? But really, reprogramming a flash is not the
right way to do debugging. One needs the good, old EPROM emulator.

It is really not that hard to make - works much the same way as the
JTAG dongle above, but parallel in both ends. Use either some dual
port SRAM - or - (larger) single sided SRAM plus bus mastering
capabilities between the MCU and the CPU (PowerPC.) The bus
mastering is not used for anything else than throwing the CPU
off the bus so that the MCU can update/patch the SRAM.

The easiest and most flexible solution is the dual ported SRAM
version, the cheapest is the single sided SRAM + bus mastering.
But GDB server stubs has to reside in the (DP)SRAM too. Reverse
channel communication can also be done through the same (DP)SRAM.

The open source community could really use such an beast, given
the current NDA state of JTAG. The dual ported SRAM version is
even CPU independant - EPROM/Flash chips looks the same regardless
of platform. Hmmm. Anyone want to do the GDB server part if I do
the hardware?


--
  ******************************************************
  Never ever underestimate the power of human stupidity.
  -Robert Anson Heinlein

		GeirFRS@invalid.ed.ntnu.no
  ******************************************************


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
