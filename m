Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711071546j5ea4a01dj9fd237b52ad059db@mail.gmail.com>
Date: Wed, 7 Nov 2007 18:46:10 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: mpc5200, sysctl table check failed
In-Reply-To: <9e4733910711071304l46cb948fk8a1fba27acdd6dac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711071224v7bf643bahba0fd23eb2d16ee1@mail.gmail.com>
	<fa686aa40711071233x7f892d20g41449cd1e8a34dd4@mail.gmail.com>
	<9e4733910711071239v6e646590s906f22cb7a9564bb@mail.gmail.com>
	<fa686aa40711071242kd6c3012lf36c0ea22149c9ba@mail.gmail.com>
	<9e4733910711071259n29609954j78d4a3d2050bc267@mail.gmail.com>
	<9e4733910711071304l46cb948fk8a1fba27acdd6dac@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I think whatever is broken in my FEC code is exposing a different bug
in some timeout code that is not normally run. Something to do with
the swap thread being unable to get to the swap device maybe?

Can anyone tell me where this Oops is coming from? It is the same oops
as the previous one, but the stacks are different.

I am getting it after a random number of retries of:
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying
nfs: server 192.168.1.4 not responding, still trying

Using current git head.

Unable to handle kernel paging request for data at address 0x0000001b
Faulting instruction address: 0xc0027288
Oops: Kernel access of bad area, sig: 11 [#1]
pcm030
Modules linked in:
NIP: c0027288 LR: c0027284 CTR: c00274c4
REGS: c031bd80 TRAP: 0300   Not tainted  (2.6.24-rc2-efika-g34082a7d-dirty)
MSR: 00001032 <ME,IR,DR>  CR: 28000028  XER: 00000000
DAR: 0000001b, DSISR: 20000000
TASK = c02fa570[0] 'swapper' THREAD: c031a000
GPR00: 03ffffff c031be30 c02fa570 c032e9a8 0000001b 00000001 c0320000 c0320000
GPR08: c02febd8 c032e9a8 00004000 00000000 248e3746 ffefffff 03ffe000 ffffffff
GPR16: 00000001 00000000 007ffc00 00000000 00000000 03ff8838 00000000 00000004
GPR24: 00000000 00000000 c032341c c0320000 c031a000 00000001 c032e9a0 0000001b
NIP [c0027288] cascade+0x74/0x9c
LR [c0027284] cascade+0x70/0x9c
Call Trace:
[c031be30] [c0018c94] __update_rq_clock+0x20/0x124 (unreliable)
[c031be60] [c002753c] run_timer_softirq+0x78/0x1b4
[c031be90] [c00234cc] __do_softirq+0x64/0xd4
[c031beb0] [c0006144] do_softirq+0x40/0x58
[c031bec0] [c0023378] irq_exit+0x38/0x48
[c031bed0] [c000d178] timer_interrupt+0x164/0x180
[c031bee0] [c000fe64] ret_from_except+0x0/0x14
--- Exception: 901 at cpu_idle+0x88/0xd0
    LR = cpu_idle+0x88/0xd0
[c031bfa0] [c0009038] cpu_idle+0xcc/0xd0 (unreliable)
[c031bfb0] [c024aa30] rest_init+0x50/0x60
[c031bfc0] [c02d19c4] start_kernel+0x298/0x2ac
[c031bff0] [00003438] 0x3438
Instruction dump:
80810008 83e40000 4800002c 80040014 5400003c 7c00f278 3160ffff 7d2b0110
0f090000 7fc3f378 4bfffecd 7fe4fb78 <83ff0000> 38010008 7f840000 409effd0
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 180 seconds..


-- 
Jon Smirl
jonsmirl@gmail.com
