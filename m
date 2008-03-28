Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id AFCCCDE0B1
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 09:24:35 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.macqel.be (Postfix) with ESMTP id 4C2AE150E3F
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 23:24:33 +0100 (CET)
Received: from mail.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 93LSTykHiMvO for <linuxppc-dev@ozlabs.org>;
	Fri, 28 Mar 2008 23:24:31 +0100 (CET)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by mail.macqel.be (Postfix) with ESMTP id 31B4B150E3A
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 23:24:31 +0100 (CET)
Date: Fri, 28 Mar 2008 23:24:30 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: linuxppc-dev@ozlabs.org
Subject: badness in gfar_timeout
Message-ID: <20080328222430.GA14018@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everybody,

When connected to a 10Mbit/Half hub, my mpc8540 board quickly falls in an
endless "NETDEV WATCHDOG: eth0: transmit timed out" loop.  This has not
yet happened here when connected to a 100Mbit/Full switch.  Problem
seems to be twofold, because the gfar_timeout does not fix the problem, but
causes another one with a 'badness' message.  I am not familiar with
that, so does someone have a fix for either the timeout either the badness
problem. or at least an explanation for the 'badness' problem.

When that happens, network becomes and remains broken, but other processes
keep working.

Below is a short excerpt of the endless kernel log.

Philippe

------------[ cut here ]------------
Badness at c0041604 [verbose debug info unavailable]
NIP: c0041604 LR: c0193b5c CTR: c0194894
REGS: c035fd00 TRAP: 0700   Not tainted  (2.6.25-rc6)
MSR: 00029000 <EE,ME>  CR: 24002028  XER: 00000000
TASK = c0340490[0] 'swapper' THREAD: c035e000
GPR00: 00000001 c035fdb0 c0340490 00000029 cf86c000 00000001 000010e0 000000c3
GPR08: cf86c360 c035e000 d101a000 fffffffa 00001670 00000000 0fff1500 ffffffff
GPR16: 00800000 00000000 007fff00 007ffec0 00200200 c0373cc8 c0373ac8 c03738c8
GPR24: c03736c8 c035e000 c035fe28 c0340000 d101a000 00029000 00000029 cf86c360
NIP [c0041604] free_irq+0x28/0x124
LR [c0193b5c] stop_gfar+0xdc/0xe0
Call Trace:
[c035fdb0] [c0340000] 0xc0340000 (unreliable)
[c035fdd0] [c0193b5c] stop_gfar+0xdc/0xe0
[c035fdf0] [c01948ec] gfar_timeout+0x58/0x64
[c035fe00] [c0204c98] dev_watchdog+0x110/0x118
[c035fe20] [c0024b44] run_timer_softirq+0x15c/0x1c0
[c035fe70] [c0020390] __do_softirq+0x74/0xe0
[c035fe90] [c0004510] do_softirq+0x54/0x58
[c035fea0] [c0020240] irq_exit+0x48/0x58
[c035feb0] [c000b010] timer_interrupt+0xa8/0x10c
[c035fed0] [c000e37c] ret_from_except+0x0/0x18
[c035ff90] [c0007854] cpu_idle+0xbc/0xcc
[c035ffb0] [c0284050] 0xc0284050
[c035ffc0] [c03209c8] start_kernel+0x224/0x2a4
[c035fff0] [c00003a0] skpinv+0x2d0/0x30c
Instruction dump:
90030000 4e800020 9421ffe0 7c0802a6 bfa10014 54290024 90010024 7c7e1b78
8009000c 5400012e 7c0000d0 54000ffe <0f000000> 2b8301ff 419d0074 546b1838
NETDEV WATCHDOG: eth0: transmit timed out
------------[ cut here ]------------
Badness at c0041604 [verbose debug info unavailable]
NIP: c0041604 LR: c0193b5c CTR: c0194894
REGS: c035fd00 TRAP: 0700   Not tainted  (2.6.25-rc6)
MSR: 00029000 <EE,ME>  CR: 24002028  XER: 00000000
TASK = c0340490[0] 'swapper' THREAD: c035e000
GPR00: 00000001 c035fdb0 c0340490 00000029 cf86c000 00000001 000010e0 000000c3
GPR08: cf86c360 c035e000 d101a000 fffffffa 00001710 00000000 0fff1500 ffffffff
GPR16: 00800000 00000000 007fff00 007ffec0 00200200 c0373cc8 c0373ac8 c03738c8
GPR24: c03736c8 c035e000 c035fe28 c0340000 d101a000 00029000 00000029 cf86c360
NIP [c0041604] free_irq+0x28/0x124
LR [c0193b5c] stop_gfar+0xdc/0xe0
Call Trace:
[c035fdb0] [c0340000] 0xc0340000 (unreliable)
[c035fdd0] [c0193b5c] stop_gfar+0xdc/0xe0
[c035fdf0] [c01948ec] gfar_timeout+0x58/0x64
[c035fe00] [c0204c98] dev_watchdog+0x110/0x118
[c035fe20] [c0024b44] run_timer_softirq+0x15c/0x1c0
[c035fe70] [c0020390] __do_softirq+0x74/0xe0
[c035fe90] [c0004510] do_softirq+0x54/0x58
[c035fea0] [c0020240] irq_exit+0x48/0x58
[c035feb0] [c000b010] timer_interrupt+0xa8/0x10c
[c035fed0] [c000e37c] ret_from_except+0x0/0x18
[c035ff90] [c0007854] cpu_idle+0xbc/0xcc
[c035ffb0] [c0284050] 0xc0284050
[c035ffc0] [c03209c8] start_kernel+0x224/0x2a4
[c035fff0] [c00003a0] skpinv+0x2d0/0x30c
Instruction dump:
90030000 4e800020 9421ffe0 7c0802a6 bfa10014 54290024 90010024 7c7e1b78
8009000c 5400012e 7c0000d0 54000ffe <0f000000> 2b8301ff 419d0074 546b1838
INIT:NETDEV WATCHDOG: eth0: transmit timed out
------------[ cut here ]------------
