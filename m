Message-ID: <B895EFF5AF34724880036BDB5B5B814813561D@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'James Don'" <JDon@spacebridge.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: advice please: virtex pro 2
Date: Wed, 7 May 2003 10:11:19 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James:

We have brought up a custom Virtex-II Pro board and
now have ELDK running on it.  I can answer some
of your questions, but not all, as I am the software
guy.

1.) Is it just as "easy" as an MPC860 or MPC8260 based platform?

Since there is a 405 core in there, it really is a PowerPC.  Once
you get the PowerPC running, it's very familiar.

One big caveat is that the PPC is surrounded by the programmable
logic -- in particular, *all* I/Os.  Your UART, Ethernet MAC,
interrupt controller, memory controller etc. are *all* programmable
logic.  This turns out to be a good thing because you have the
flexibility to, say, change MACs without needing to use a soldering
iron.

The peripherals are (in my opinion) stable.  You can drop a peripheral
into your design and feel confident that it will work.

There is a learning curve -- since you really are building the chip
and the software, not just the software.  Xilinx has what they call
an Embedded Development Kit (EDK) which is a very nice GUI for building
your hardware design.  It runs on Windows and Solaris, but unfortunately
not, to my knowledge, on Linux.  You do need to learn the syntax of
their hardware-specification and software-specification files.  You
need to get used to running the place-and-route tool each time you
change your hardware design, and you need to accept that you will
now need to think about whether all your logic is meeting timing, etc.

The EDK GUI (XPS, Xilinx Platform Studio) is great for building a
hardware design.  Personally, I don't like it as much for building
software.  They assume that you have one and only one C program; maybe
true for small software systems but not generally true.  Second, they
use Xygwin (like Cygwin) as a Unix-on-Windows portability layer.  It's
OK, as a dumbed-down bash prompt, but it is slow, and also lacks a Perl,
a native gcc, etc.  Third, the automatically-generated makefiles created
by XPS lack any dependencies for header files, and also rebuild all
.c's whenever any is touched.  Again, OK for small projects, but not
OK when you have a hundred source files.

Fortunately, you don't need to build your software in XPS.  The
cross GCC (powerpc-eabi-gcc) is available from the Xygwin shell.
You can create your own makefiles & make your software build
sophisticated.

Also, once the hardware design is created -- meaning that a bit
file has been generated for the FPGA, and header files have been
generated telling you the addresses all the peripherals are at,
etc. -- you have a hardware platform.  You can then build software
for that platform elsewhere -- e.g. I use XPS to build the
bit file & headers, but then I use any of (1) Xygwin & makefiles
(2) Green Hills on Window$ (3) ELDK's ppc_4xx-gcc on my Linux box
to generate code for that hardware platform.  There are no special
Virtex-II Pro compiler flags -- you can use any compiler that
creates 405-compatible object code.

So, in a shorter answer to your question, once your hardware
design has stabilized and you have your bit file in the FPGA's PROM,
it really does look like a fully hardwired PowerPC chip.

2.) Is there any big caveats I should now about for debugging bring up?

My experience is that, if anything, it was *easier* to bring up the
Virtex-II Pro.  Xilinx has a debugger called XMD (Xilinx Microprocessor
Debugger) which, by itself, is a minimally featured command-line
tool.  You can print registers, etc.  On top of that, separately,
is a GUI laid on top of powerpc-eabi-gdb.  If you want a point-and-click
debugger, you can use that.  (Note:  their graphical gdb seems
not to proceed with executables not created by Xilinx tools.
But the lower-level XMD doesn't care, since it's not operating
at the symbolic level.)

But for me the primary interest is using XMD -- this is a program
on the PC which communicates with the PPC debug port.  You can use
XMD to download and run ELF files over the JTAG cable (pretty
snappy with parallel-III, faster with parallel-IV).  You can use
it to dump memory as well.

3.) Does anybody know about vxworks 'support' for this as well?

I haven't used VxWorks at all, but a customer of ours has.  And
I do know that XPS includes explicit support for building a VxWorks
BSP, within the GUI.  (Contrast to Linux, for which I build the
hardware system in XPS, then do the software elsewhere.)

What I do not know is how the licensing works.  VxWorks, of course,
is not free.

4.) Is debugging support with BDI, vision ICE, etc there yet for this
board? Is it just good old JTAG or something different?

I rarely if ever use a visionICE, and have never used a BDI, on this
or any other platform.  So I can't speak to that.  However as described
above you do have XMD over the JTAG port.

5.) Is this chip even mature yet?

To my knowledge, yes.  IBM does have some 405 errata but they are
well-documented.  If there are maturity issues, I'm not aware of
them.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
