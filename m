To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compile gdbserver for powerpc 
In-Reply-To: Message from Lucinda Schafer <lucsch@adaptivemicro.com>
   of "Tue, 20 Jun 2000 10:35:21 EST." <A109131318C4D1119AC20060088DECE330F451@amwmail.adaptivemicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Mime-Version: 1.0
Date: Wed, 21 Jun 2000 11:49:51 +1000
Message-ID: <5804.961552191@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 20 Jun 2000 10:35:21 -0500, Lucinda Schafer <lucsch@adaptivemicro.com>
writes:
>>From Graham Stoney's "Linux for PowerPC Embedded Systems HOWTO/FAQ", Section
...
>18.3 Kernel
>It is not currently possible to use gdb for kenel debugging.

Whoops. This should probably change. I use gdb for kernel debugging on
the (8xx) 2.[34].x kernels (its *very* handy!). You need to enable
CONFIG_KGDB first though, and if you don't want to use the default serial
port (via SMC1?? for 8xx) you need to do a bit of hacking. Here's how:

1. make sure either CONFIG_SERIAL_CONSOLE, or CONFIG_KGDB, itself is undefined
   when 8xx_io/uart.c is compiled

2. ensure the call to kgdb_map_scc() is not done in arch/ppc/kernel/setup.c;
   replace it with a call to your own serial port init routine, if required.

3. write three functions (usually in your serial driver, and inside #ifdef
   CONFIG_SERIAL_CONSOLE, inside #ifdef CONFIG_KGDB):

	extern void putDebugChar(char kgdb_char);
	extern char getDebugChar(void);
	extern void kgdb_interruptible(int yes);

   the first two are fairly obvious - busy-wait put and get character to
   the chosen serial port. the third enables (yes==1) or disables (yes==0)
   *serial* interrupts (not all interrupts - at least I don't think so).

   e.g.	#ifdef CONFIG_SERIAL_CONSOLE
	... (serial console stuff) ...
	#ifdef CONFIG_KGDB
	void
	putDebugChar(char c)
	{
	...
	#endif /* CONFIG_KGDB */
	#endif /* CONFIG_SERIAL_CONSOLE */

1 and 2 are for the 8xx kernel - there will be similar steps for other
platforms (i.e. making sure the code for the default kgdb serial "driver" is
not compiled in, obviously so there is not a clash with the ones you write).

One thing to remember: if you enable CONFIG_KGDB, setup_arch() in
arch/ppc/kernel/setup.c will execute a breakpoint() and for the kernel
to proceed past that point, you must start gdb on your host in "remote"
mode (on the appropriate serial port with the appropriate speed) and
perform a gdb "continue" command (this caused me some concern when it
was added a few months ago, I thought my kernel was dead :-)

Hope this helps. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
