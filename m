Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Thu, 14 Aug 2003 13:28:50 +0200
Message-Id: <200308141128.h7EBSnQ06089@mailgate5.cinetic.de>
MIME-Version: 1.0
From: "Christian Meyer" <Christian.Meyer@cs.tum.edu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC7410 doesn't work with linux-2.4.20-denx
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

I'm currently trying to get linux running on an embedded board:
	* MPC7410 Rev.1.4
	* PowerQUICC (MPC 8260)
	* RAM: 128 MB
	* Flash: 64 MB
	* Kernel: 2.4.20-denx

For some reason, it doesn't boot properly. It says "Now booting Linux",
after that something triggers a hard reset. For the last 2 weeks I tried
to debug (using the hardware debugger BDI2000) the kernel and more or
less found out where the problem might be located.

start_here() (arch/ppc/kernel/head.S) calls call_setup_cpu()
(arch/ppc/kernel/misc.S), machine_init() (arch/ppc/kernel/setup.c),
MMU_init() (arch/ppc/mm/init.c) and load_up_mmu()
(arch/ppc/kernel/head.S). call_setup_cpu() and machine_init() seem to
be fine; MMU_init() calls MMU_init_hw() and mapin_ram(). As far as I
can tell, that's the point where the board initiates a hard reset. I
don't know why it does that and I also don't know any solution to solve
that problem. It seems like either the MMU isn't correctly initialized
or there's a problem with the L2 cache. Motorola says, that the MPC7410
is compatible to the MPC75x; regarding my current problem it looks like
that there's a difference somewhere.

Maybe you know a solution for the problem or have an idea how to find
out what's wrong.

Thanks in advance,
--
Christian Meyer

Technische Universität München
E-Mail: Christian.Meyer@cs.tum.edu
UIN: 72107443
AIM: chrisime
Jabber: chrisime@charente.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
