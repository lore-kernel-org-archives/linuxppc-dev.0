To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kgdb/Sandpoint -- patch & help needed 
In-Reply-To: Message from Alex Shnitman <alexsh@hectic.net>
   of "Mon, 18 Sep 2000 17:16:27 +0300." <20000918171627.B4328@hectic.net>
Mime-Version: 1.0
Content-Type: text/plain
Date: Tue, 19 Sep 2000 14:39:17 +1100
Message-ID: <7803.969334757@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 18 Sep 2000 17:16:27 +0300, Alex Shnitman <alexsh@hectic.net> writes:
>... However, with this patch the kernel
>hangs right after saying "Now booting the kernel". I don't even see
>how these changes could affect the boot process so early.

Aha! I was caught by this. When you enable CONFIG_KGDB, a breakpoint is
executed in setup_arch() which is just about the first thing the kernel
does.

The sequence is (very!) roughly (and for the 8xx embedded platform):

_start()
	identify_machine()
	MMU_init()
	start_kernel()
		lock_kernel()
		setup_arch()
			set_debug_traps()	| ifdef CONFIG_KGDB
			breakpoint()		|
			...
		parse_options()
		trap_init()
		init_IRQ()
		...

Solution? Simply start gdb on your host machine and do the following:

	set remotebaud BBBBBB	(if required)

	target remote /dev/...	(serial port on host connected to
				 target kgdb serial port)
	continue

and your kernel will fire up again (I kicked myself when I realised what
was going on). Cheers!
								Murray...


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
