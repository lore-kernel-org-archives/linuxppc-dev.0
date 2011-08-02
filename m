Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4EA97B71C0
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Aug 2011 20:47:56 +1000 (EST)
Message-ID: <4E37D5D9.7070001@embedded-sol.com>
Date: Tue, 02 Aug 2011 13:47:53 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: GPIO IRQ on P1022
References: <4E35309E.4000202@embedded-sol.com>
	<4E355FB7.3030904@freescale.com>
In-Reply-To: <4E355FB7.3030904@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 07/31/2011 04:59 PM, Tabi Timur-B04825 wrote:
> Felix Radensky wrote:
>>       What happens when I load my driver is single execution of interrupt
>> handler
>>       followed by system freeze. Even if I call disable_irq() in interrupt
>> handler the
>>       system still freezes.
> I don't know anything about the GPIO layer, but I think you're going to
> need to debug this a little more.  Where exactly is the freeze?  Are you
> sure the interrupt handler is being called only once?  Perhaps you're not
> clearing the interrupt status and your handler is being called repeatedly?
>

I'm trying to debug this problem, without much luck so far.
I've enabled hard and soft lock-up detection and various
locking debugging options in kernel configuration but nothing
shows up. I've also tried KGDB over serial line, and was able
to hit the breakpoint in mpc8xxx_gpio code, but was unable
to step through the code, gdb just freezes.

I'm getting the following after system locks up:

nfs: server 10.0.0.10 not responding, still trying
NETDEV WATCHDOG: eth0 (fsl-gianfar): transmit queue 0 timed out
------------[ cut here ]------------
WARNING: at net/sched/sch_generic.c:255
Modules linked in: gsat hal
NIP: c01a5e9c LR: c01a5e9c CTR: c01576bc
REGS: dfff1e90 TRAP: 0700   Not tainted  (3.0.0)
MSR: 00029000 <EE,ME,CE>  CR: 24044082  XER: 20000000
TASK = c02df3b8[0] 'swapper' THREAD: c02ee000
GPR00: c01a5e9c dfff1f40 c02df3b8 00000046 00003d04 ffffffff c01546e4 
00003d04
GPR08: c02e0000 c02ed710 00003d04 00000002 84044042 7dcac9f0 00000000 
00000000
GPR16: 1ff8c184 1ffa95e0 c0284070 c02f9dc0 c02fabec c02fa9ec c02fa7ec 
c02fa5ec
GPR24: 00200200 dfff1f68 c02e0000 dfff0000 c034c138 c02e0000 df011000 
00000000
NIP [c01a5e9c] dev_watchdog+0x298/0x2a8
LR [c01a5e9c] dev_watchdog+0x298/0x2a8
Call Trace:
[dfff1f40] [c01a5e9c] dev_watchdog+0x298/0x2a8 (unreliable)
[dfff1f60] [c00434e8] run_timer_softirq+0x1a4/0x1e0
[dfff1fb0] [c003cf20] __do_softirq+0x9c/0x114
[dfff1ff0] [c000c8a0] call_do_softirq+0x14/0x24
[c02efe90] [c00049ec] do_softirq+0x74/0x80
[c02efeb0] [c003d174] irq_exit+0x98/0x9c
[c02efec0] [c0009944] timer_interrupt+0xb4/0x118
[c02efed0] [c000e018] ret_from_except+0x0/0x18
--- Exception: 901 at cpu_idle+0x98/0xd8
     LR = cpu_idle+0x98/0xd8
[c02eff90] [c0008238] cpu_idle+0x50/0xd8 (unreliable)
[c02effb0] [c00022e4] rest_init+0x64/0x78
[c02effc0] [c02bb86c] start_kernel+0x244/0x2c0
[c02efff0] [c00003a0] skpinv+0x2b8/0x2f4
Instruction dump:
38000001 7c0903a6 4bfffe40 7fc3f378 4bfe7045 7fe6fb78 7c651b78 3c60c02a
7fc4f378 38639ac4 4cc63182 4be921dd <0fe00000> 38000001 981c0001 4bffff9c
---[ end trace 5d45e0fe33774f9c ]---


What else can be done to find the problem. ?

Thanks a lot in advance.

Felix.
