Date: Mon, 29 Nov 1999 23:46:54 +0000
From: "Robin O'Leary" <ppc@ro.nu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 860T cold boot
Message-ID: <19991129234653.A1270@mail.ro.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have been following the linuxppc-embedded discussions for some
time while pottering with an i-Mac and the Bright Star ipEngine, in
preparation for our new 860T-based hardware to be designed and built.
It had been so easy to use both these systems, I was unprepared for the
ordeal involved in getting the 860T hardware going without the assistance
of a boot-loader.

Using the (rather unreliable) SDS SingleStep development kit and BDM
cable, I can address all the CPU memory-mapped registers, set up the SIU,
load zImages into RAM or flash and make them run.  I can write simple
programs that waggle I/O ports and generally test that the hardware is
present and correct.  But when I try to run a zImage it all goes wrong.
The debugger doesn't seem able to insert working breakpoints after the
first ``rfi'' so I can't tell exactly what's the matter, but inevitably
it crashes with some sort of exception, usually with PC=0x1100 (TLB miss
exception) where there is no code.  I've tried booting from RAM and flash,
with code, RAM and registers at various addresses, with various kernels.
I'm sure that the basics are correct and as nobody else seems to be
talking about problems with this low-level stuff, either you're all
using proprietary boot loaders or I'm missing something obvious (or it's
a hardware problem:-).

I currently set up 25 registers plus the UPM table with values derived
initially from Motorola's hopeless mcuinit tool, later much tinkered with
by reference to the 860UM/AD manual.  I'm sure that's all I should need to
get it going.  Am I right?  If anybody has a working set of initialisation
instructions that they could share, or even just a register dump of how
their boot-loader leaves things set, I should be most grateful.

Robin O'Leary.
-- 
email: roleary@equiinet.com  Equiinet Ltd., Innovation Centre, Singleton Park,
Tel.:  +44 1792 540008       Swansea  SA2 8PP, Wales, U.K.  51.6101N 3.9831W

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
