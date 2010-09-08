Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 3F5ADB70D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 09:21:27 +1000 (EST)
Date: Wed, 8 Sep 2010 16:21:24 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linuxppc-dev@lists.ozlabs.org
Subject: CONFIG_PROVE_LOCKING broken on 83xx (and all of powerpc?)
Message-ID: <20100908232124.GB30291@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: peterz@infradead.org, mingo@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everyone,

I'm running Linux on a Freescale MPC8349EA board (PowerPC 6xx processor). When
I enable the CONFIG_PROVE_LOCKING option, the kernel fails to boot. If I
toggle that option (and ONLY that option) off, the kernel boots normally.

The lockup happens very, very early during boot. Much too early to even have
console messages coming out on the serial port. Therefore, I've hooked up a
JTAG debugger and gained as much information as I can.

I would guess that something in lockdep_init() is breaking things, based on
the backtrace provided. It is called in machine_init(), which is part of the
backtrace. I think some part of lockdep is overwriting the flat device tree.
The __log_buf output supports this claim. I am booting the two kernels with
*exactly* the same device tree.

(gdb) target remote bdi2k:2001
Remote debugging using bdi2k:2001
0x0ffbf760 in ?? ()
(gdb) cont
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0xc031e0ec in memblock_reserve (base=8355840, size=0) at /home/iws/devel/linux-2.6/mm/memblock.c:270
270             BUG_ON(0 == size);
(gdb) info stack
#0  0xc031e0ec in memblock_reserve (base=8355840, size=0) at /home/iws/devel/linux-2.6/mm/memblock.c:270
#1  0xc0315f04 in early_init_devtree (params=<value optimized out>) at /home/iws/devel/linux-2.6/arch/powerpc/kernel/prom.c:537
#2  0xc031691c in machine_init (dt_ptr=8355840) at /home/iws/devel/linux-2.6/arch/powerpc/kernel/setup_32.c:127
#3  0xc0003410 in start_here () at /home/iws/devel/linux-2.6/arch/powerpc/kernel/head_32.S:982
Backtrace stopped: previous frame inner to this frame (corrupt stack?)
(gdb) print __log_buf 
$3 = "<3>[    0.000000] Invalid tag 0 in flat device tree!\n<3>[    0.000000] Invalid tag 0 in flat device tree!\n<3>[    0.000000] Invalid tag 0 in flat device tree!\n", '\0' <repeats 130912 times>


I am happy to provide more information if it will help. I'm not especially
good at working the debugger. I can't get it to stop at machine_init() and let
me step through the code.

I tried this feature when it first became available on powerpc, and it
did not work then. At that time, I didn't have the resources to
investigate further. I don't think a git bisect will help in this case.

Thanks,
Ira
