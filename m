Message-ID: <38431925.2B0111C2@netx4.com>
Date: Mon, 29 Nov 1999 19:24:05 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: "Robin O'Leary" <ppc@ro.nu>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 860T cold boot
References: <19991129234653.A1270@mail.ro.nu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Robin O'Leary wrote:


> Using the (rather unreliable) SDS SingleStep development kit and BDM
> cable, I can address all the CPU memory-mapped registers, set up the SIU,
> load zImages into RAM or flash and make them run.  I can write simple
> programs that waggle I/O ports and generally test that the hardware is
> present and correct.  But when I try to run a zImage it all goes wrong.
> The debugger doesn't seem able to insert working breakpoints after the
> first ``rfi'' so I can't tell exactly what's the matter,


The trouble is Linux+MMU+BDM doesn't work.  Once the MMU is
enabled by the rfi, BDM debuggers don't understand the world
and keep poking around and breaking things.

When trying to run Linux, you must use a BDM debugger that allows
you to disable all debugging hooks.  All you can do is download
the kernel, disable all debugging, and then push the 'go' button.
Or, use a kernel-aware BDM debugger for Linux, which doesn't
exist.....yet.


> 
> I currently set up 25 registers plus the UPM table with values derived
> initially from Motorola's hopeless mcuinit tool, later much tinkered with
> by reference to the 860UM/AD manual.  I'm sure that's all I should need to
> get it going.


There are lots of 8xx internal registers that have to be
set properly depending upon your hardware configuration.  If
you didn't sit down with a hardware engineer to derive your
DRAM timing, I doubt the UPM tables are correct.  You also
need to set several multifunction pin configurations depending
upon the external bus connections and external devices.

Since you were able to get something downloaded and running
at least that far, some of the hardware configuration is
correct.  The worst case bus timing occurs when you start up
an Ethernet port which performs burst mode DMA while the PPC
core has copyback caches enabled.  That's when you are going
to start looking for software bugs, but the real problem is
DRAM timing or other hardware configuration problems.


> ....If anybody has a working set of initialisation
> instructions that they could share, or even just a register dump of how
> their boot-loader leaves things set, I should be most grateful.

That is a place to start, but these values have to be properly
set for your hardware design.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
