Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.0.14.2.20020222070057.01f28df8@falcon.si.com>
Date: Fri, 22 Feb 2002 08:09:16 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: RE: custom mpc8240 student project (long)
In-Reply-To: <20020222084929.O34054-100000@invalid.ed.ntnu.no>
References: <C08678384BE7D311B4D70004ACA371050B7632E4@amer22.avnet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[snip]

> > #1, you don't write any C code; you get the BSDL files from the
> > part vendors, and the board's netlist from the board vendor.
>
>What I would like to know is wether this BSDL file can be used
>to reversengineer the functionality of the internal TRAP logic.

No.  BSDL stands for Boundary Scan Description Language (well, I'm guessing
on the "DL", but that is probably right).  Note the first term "boundary"
as in "the boundary of the chip".  That is important.  The BSDL file is
always (?) disclosed, not covered by a NDA.  The original purpose for JTAG
was board test.  With JTAG and BSDL, the tester can, for instance, set all
the pins in a net to inputs except for one, wiggle the target net high and
low with the one driven pin, and observe that all the pins in the net
wiggle properly.  This tests the soldering and traces on the boards.

What you are asking for is the information covering the separate ring that
goes through the innards (registers) of the CPU.

>We really don't want to do boundary scan in the true meaning of
>the words, but rather we want to do what BDM4GDB does for us on
>the XPC8xx series CPUs - control the core. I do HW, not really SW.
>This is all about control - the manufactures should not be allowed
>to place a NDA on this information. Redirecting customers to 3'd
>party vendors of debug equipment effectively means customer
>filtration. "If your are to small to afford the contiousely
>astronomical cost of 3'd party tools, then you're also too
>small for us." Need I remind you that the same melody can
>be applied to GCC and LinuxPPC vs. 3'd party too...?

I suspect that it's about sanity preservation, not control.  Releasing this
extremely complex information (which can vary from chip rev to chip rev) to
John Q Public is going to generate a LOT of technical support calls that
they are currently avoiding by carefully selecting who they release the
information to.

By the way, the 3rd party tool costs are NOT astronomical.  Entry level is
$50 for a BDM4GDB, $150 for a Macraiger Wiggler.  That is roughly the same
as the cost of the CPU you are trying to debug.  That's pretty reasonable
in my book.  With the BDI-2000 or Corolis accel card you are paying a LOT
more for the HARDWARE ACCELERATION.  The software, which is the part
covered by the NDA, you can download from Macraigor for _FREE_ so
quicherbitchin:
   http://www.ocdemon.net/Merchant2/merchant.mv?Screen=CTGY&Store_Code=MTS&Category_Code=FS

Now, back to the "boundary" in BSDL.  You CAN program flash with only the
BSDL information.  It isn't easy, but it CAN and HAS been done (by several
people on this list, as a matter of fact).  If you want to start an Open
Source project doing this, you can start TODAY.  Hey, you could become as
rich and famous as Wolfgang :-).

> > #3, socketed flash tends to wear out -- we've had a lot of
> > frustration with metal fatigue on the flash pins and/or socket
> > pins.  When you use JTAG, you aren't wearing out your flash
> > pins by popping them in & out of sockets, in & out of the flash
> > programmer, dropping them, etc.
>
>Zero Force Sockets? But really, reprogramming a flash is not the
>right way to do debugging. One needs the good, old EPROM emulator.

JTAG programming flash is cheaper and easier if you are comparing equal
systems (parallel port dongles).  All of the information necessary to
program flash via JTAG _is_ publicly available.  If you are willing to
spend the money to build a SRAM dongle, you will find a Macraiger Wiggler
costs about the same with no assembly required, so where's the beef?

>It is really not that hard to make - works much the same way as the
>JTAG dongle above, but parallel in both ends. Use either some dual
>port SRAM - or - (larger) single sided SRAM plus bus mastering
>capabilities between the MCU and the CPU (PowerPC.) The bus
>mastering is not used for anything else than throwing the CPU
>off the bus so that the MCU can update/patch the SRAM.
>
>The easiest and most flexible solution is the dual ported SRAM
>version, the cheapest is the single sided SRAM + bus mastering.
>But GDB server stubs has to reside in the (DP)SRAM too. Reverse
>channel communication can also be done through the same (DP)SRAM.

Couple of reality checks:
                 JTAG            SRAM
                 ----            ----
Pins            5               32 (possible 32x4)
Size            10 pin header   32 pin DIP, no wait TSOP,
                                   no wait BGA, no wait...
                                   (DIP footprint by 1++ inches long)
Speed           don't care      full bus speed (66MHz)
Support logic   1 logic buffer  CPLD and buffers
Future          works           Obsolescence is a continual problem
Cost            $15 in parts    $$$
Software        roughly the same both ways

>The open source community could really use such an beast, given
>the current NDA state of JTAG. The dual ported SRAM version is
>even CPU independant - EPROM/Flash chips looks the same regardless
>of platform. Hmmm. Anyone want to do the GDB server part if I do
>the hardware?

Do it, be rich and famous, but my professional opinion is that using JTAG
to program flash is going to be a much easier path to the same end goal.

gvb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
