Message-Id: <v01530500b7aa4cb483fb@[199.170.89.98]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 23 Aug 2001 01:15:04 -0500
To: linuxppc-dev@lists.linuxppc.org
From: trag@io.com (Jeff Walther)
Subject: Hacking the Apple x500, x600 ROMs
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm not much of a software guy, but thought someone might find this useful.
If someone is interested in modifying the contents of the Apple ROM, but
was wondering how to get their hacked version back on the Apple
motherboard, here is the chip to use.

The Hyundai HY29F800BG Flash Memory can be substituted for the Apple ROM
chips on the x500 and x600 machines.   The only hardware modification
needed is to put a 100 ohm (higher R will probably work fine) resistor
between pins 23 and 44 on each Flash chip.  Pin 44 is an unused pin on the
Apple ROM, but is the Reset pin on the Flash Memory and it must be tied
high for the Flash to operate.  Pin 23 is the 5V supply.

The Apple ROM is typically a Sharp or Samsung Mask ROM and can be read as a
Macronix 27C8100.

The x500, x600 and x600 enhanced (Kansas) all use a different version of
the ROM, 341S0168 - 341S0171, 341S0280 - 341S0283 and 341S0380 - 341S0383
respectively.

Interestingly, I've found that the later ROMs (8/9600 and Kansas) will work
fine in the older x500 motherboards and clones.  In fact installing the
Kansas ROM in the older boards eliminates the Speculative Processing/G3
incompatibilities.

Also interesting is that some PM7200 boards use the same ROMs as the x500
machines.  The Power Computing Catalyst based clones were based on the 7200
and had their ROMs on a DIMM.  If that DIMM is compatible with the ROM slot
in the x500 machines, it may be possible to install modified ROM chips on
one of the Power Computing DIMMs and then install the ROM DIMM in the ROM
slot of the target x500/x600 machine.  One would still need to solder the
chips to the DIMM, but one would avoid soldering on the actual motherboard.

Some compatibility tables list the Atmel AT49F8192 as a substitute for the
HY29F800.  However, I tried the Atmel chip and it doesn't work in this
application.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
