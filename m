From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jure Menart <jure@kom.org>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: kernel course no. 1
Date: Mon, 3 Sep 2001 21:34:28 +0200
Message-Id: <20010903193428.1773@smtp.wanadoo.fr>
In-Reply-To: <20010903192322.A1346@hannanges.teden-mladih.com>
References: <20010903192322.A1346@hannanges.teden-mladih.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>well, I have two LEDs on my board for 'very hardware debug' (I know it's VERY
>cheap, but it's very useful too ;-), so I try to turn one LED on before the
>jump ('rfi' call) and another at the beginning of 'start_here' procedure. As
>you can guess - first LED turned on but second didn't.
>
>Any idea? Could be something wrong with my cross-compiler? Initialization of
>MMU? Stack?
>I'm pretty much down on this :-(

Beware, when doing such debugging, that the IOs you use for your LED are
actually mapped in virtual memory space before accessing them.

The head.S entry does approximately this:

 - first it calls early_init(). It does so before touching the MMU
or changing anything to the CPU setup, it's still running at whatever
address it was loaded, early_init() handles interaction with the
firmware, like grabbing the OF device-tree on OF based machines.

 - then, it turns off the MMU, sanitize it (clear_bats & flush_tlbs),
prepares a fixed mapping (via BATs on desktop CPUs) of the first
16Mb of RAM at KERNELBASE (0xc0000000). The MMU is prepared but not
yet turned ON.

 - it copies itself down to 0 physical (it's final location). MMU is
off, so it shouldn't take an exception, which is what we want currently.

 - it turns back ON the MMU with the temporary mapping setup above.
At this point, only mappings setup with BATs exist in the MMU, that
is the first 16Mb of RAM mapped at KERNELBASE, and eventually, the
framebuffer via the special "display BAT" hack. Your IOs are not reachable
here, unless you have hacked some mapping for them earlier.

 - With that MMU setup, it enters start_here. That function will setup
the initial stack pointer, setup the remaining CPU features, and calls
machine_init (arch/ppc/kernel/setup.c) and MMU_init (arch/ppc/mm/init.c).
Those must take care of not touching memory above the 16Mb mapped by
the BAT and have no access to any IO but the eventually mapped
framebuffer.

 - Finally, upon exit from MMU setup, is goes back unmapped, setup the
MMU with whatever MMU_init decided, and jumps to start_kernel with
the MMU back on.

So unless you have done some io_block_mapping calls or ioremap calls
inside MMU_init for your board, your LEDs will not be available neither
at start_kernel time. You have to ioremap them before use. You may have
been able to use them while running with MMU on as the entire physical
space is then available, but beware, it is also cacheable which can be
a real problem when dealing with IOs.

Hope this helps,

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
