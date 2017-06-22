Return-Path: <kda@linux-powerpc.org>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtYvH08jmzDr1S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 18:01:46 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id e7so5350566pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 01:01:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAO7m3AnPKavoBjmHJwuQ1y5ctyNk08eYB35M00ZiGgOwN4udvQ@mail.gmail.com>
References: <CAO7m3AnPKavoBjmHJwuQ1y5ctyNk08eYB35M00ZiGgOwN4udvQ@mail.gmail.com>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Thu, 22 Jun 2017 11:01:43 +0300
Message-ID: <CAOJe8K1BmGxLhCR=ZpayFRj4B+36sXoUMx3Qavpv8E6wpOUcUw@mail.gmail.com>
Subject: Re: Network TX Stall on 440EP Processor
To: Thomas Besemer <thomas.besemer@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/21/17, Thomas Besemer <thomas.besemer@gmail.com> wrote:
> I'm working on a project that is derived from the Yosemite
> PPC 440EP board.  It's a legacy project that was running the
> 2.6.24 Kernel, and network traffic was stalling due to transmission
> halting without an understandable error (in this error condition, the
> various
> status registers of network interface showed no issues), other
> than TX stalling due to Buffer Descriptor Ring becoming full.
>
> In order to see if the problem has been resolved, the Kernel
> has been updated to 4.9.13, compiled with gcc version 5.4.0
> (Buildroot 2017.02.2).  Although the frequency of the
> problem is decreased, it still does show up.
>
> The test case is the Linux Target running idle, no application
> code.  From a Linux host on a directly connected network, 30
> flood pings are started.  After a period of several minutes to
> perhaps hours, the transmit aspect of the network controller
> ceases to transmit packets (Buffer Descriptor ring becomes full).
> RX still works.  In the 2.6.24 Kernel, the problem happens
> within seconds, so it has improved with the new Kernel.
>
> Below is the output from the Kernel when this happens.
>
> Has anybody seen this problem before?  I can't find any
> errata on it, nor can I find any reports of it.
>
> The orginal problem is rooted in the Embedded Application
> running, and after a period of time of heavy network
> traffic, the TX side of network stalls.  The flood ping
> test is used simply to force the problem to happen.

The only thing that you can do is to carefully look at the ring management code.

Looks like that it's not enough to call the emac_reset_work to
properly reset the tx queue on your device.
>
> [ 3127.143572] NETDEV WATCHDOG: eth0 (emac): transmit queue 0 timed out
> [ 3127.150172] ------------[ cut here ]------------
> [ 3127.154778] WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:316
> dev_watchdog+0x23c/0x244
> [ 3127.162965] Modules linked in:
> [ 3127.166013] CPU: 0 PID: 0 Comm: swapper Not tainted 4.9.13 #9
> [ 3127.171707] task: c0e67300 task.stack: c0f00000
> [ 3127.176192] NIP: c068e734 LR: c068e734 CTR: c04672f4
> [ 3127.181107] REGS: c0f01c90 TRAP: 0700   Not tainted  (4.9.13)
> [ 3127.186793] MSR: 00029000 <CE,EE,ME>[ 3127.190241]   CR: 28122222  XER:
> 00000000
> [ 3127.194210]
> GPR00: c068e734 c0f01d40 c0e67300 00000038 d1006301 000000df c04683e4
> 000000df
> GPR08: 000000df c0eff4b0 c0eff4b0 00000004 24122424 00b960f0 00000000
> c0e80000
> GPR16: 000ac8c1 c07b8618 c098bddc c0e69000 0000000a c0ee0000 c0e73f20
> c0f00000
> GPR24: c100e4e8 c0ee0000 c0e77d60 c3128000 c068e4f8 c0e80000 00000000
> c3128000
> NIP [c068e734] dev_watchdog+0x23c/0x244
> [ 3127.227680] LR [c068e734] dev_watchdog+0x23c/0x244
> [ 3127.232427] Call Trace:
> [ 3127.234857] [c0f01d40] [c068e734] dev_watchdog+0x23c/0x244 (unreliable)
> [ 3127.241447] [c0f01d60] [c00805e8] call_timer_fn+0x40/0x118
> [ 3127.246889] [c0f01d80] [c00808e8] expire_timers.isra.13+0xbc/0x114
> [ 3127.253032] [c0f01db0] [c0080a94] run_timer_softirq+0x90/0xf0
> [ 3127.258753] [c0f01e00] [c07b31b4] __do_softirq+0x114/0x2b0
> [ 3127.264202] [c0f01e60] [c002a158] irq_exit+0xe8/0xec
> [ 3127.269144] [c0f01e70] [c0008c98] timer_interrupt+0x34/0x4c
> [ 3127.274684] [c0f01e80] [c000ec94] ret_from_except+0x0/0x18
> [ 3127.280151] --- interrupt: 901 at cpm_idle+0x3c/0x70
> [ 3127.280151]     LR = arch_cpu_idle+0x30/0x68
> [ 3127.289300] [c0f01f40] [c0f058e4] cpu_idle_force_poll+0x0/0x4
> (unreliable)
> [ 3127.296146] [c0f01f50] [c00073e4] arch_cpu_idle+0x30/0x68
> [ 3127.301509] [c0f01f60] [c005bce8] cpu_startup_entry+0x184/0x1bc
> [ 3127.307392] [c0f01fb0] [c0a76a1c] start_kernel+0x3d4/0x3e8
> [ 3127.312843] [c0f01ff0] [c00000b4] _start+0xb4/0xf8
> [ 3127.317599] Instruction dump:
> [ 3127.320557] 811f0284 4bffff78 39200001 7fe3fb78 99281966 4bfd9cd5
> 7c651b78 3c60c0a1
> [ 3127.328359] 7fc6f378 7fe4fb78 3863357c 48125319 <0fe00000> 4bffffb8
> 7c0802a6 90010004
> [ 3127.336327] ---[ end trace c31dfe4772ff0e8f ]---
>
