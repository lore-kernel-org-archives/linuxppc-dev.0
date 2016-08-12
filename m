Return-Path: <dave.hansen@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s9qZW6Vm5zDr1m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 02:09:06 +1000 (AEST)
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
To: Holger Brunck <holger.brunck@keymile.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
 <57ADE7E6.9030900@linux.intel.com>
 <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
Cc: "mingo@kernel.org" <mingo@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <57ADF4A0.5040807@linux.intel.com>
Date: Fri, 12 Aug 2016 09:09:04 -0700
MIME-Version: 1.0
In-Reply-To: <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/12/2016 08:47 AM, Holger Brunck wrote:
> On 12/08/16 17:14, Dave Hansen wrote:
>> On 08/12/2016 07:50 AM, Holger Brunck wrote:
>>> When I try to debug our multithreaded userspace application with gdb I  get
>>> stuck when trying to single step code.
>>
>> Can you clarify "stuck"?  Like the instructions don't advance?  Have you
>> been able to find a root cause for this?
> 
> the behaviour is slightly different on the kernel versions. So my setup is a
> remote debug session via gdbserver.
> 
> After connecting to the gdbserver I set a break point and start to run my
> program. When hitting the breakpoint I try to single step. With stuck I mean
> that the connection to the gdbserver is broken and I can't control my debug
> session anymore while the application is not continuing.

Could you try debugging locally with gdb?  It would be nice to take all
the stuff involved with remote debugging out of the picture.

Have you tried turning on a bunch of kernel debugging (SLAB/SLUB
debugging, pagealloc debug, lockdep, etc...)?  If something is getting
corrupted, those tend to catch it.

> On Kernel 4.2 I got additionally the following dump in my serial terminal:
> 
> ------------[ cut here ]------------
> WARNING: at
> /opt/keymile/ws_root/git_repositories/prod/keyne/plat/kernel/gpl/kernel/sched/core.c:1975
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.2.0-00003-g0478a57 #10
> task: c04213d0 ti: c0434000 task.ti: c0434000
> NIP: c003c4ac LR: c005d7f0 CTR: c005d7c8
> REGS: c0435ce0 TRAP: 0700   Not tainted  (4.2.0-00003-g0478a57)
> MSR: 00021032 <ME,IR,DR,RI>  CR: 22044228  XER: 20000000
> 
> GPR00: c005dfd8 c0435d90 c04213d0 cfba7a70 c042624c 00000000 00000001 00000000
> GPR08: 00000001 00000001 00000007 ffffffff 42044228 eec349c0 00000000 00000000
> GPR16: 0fe75f34 c0434000 0000000a c005d7c8 00000001 0000000a c0430000 c042624c
> GPR24: 7ffc66b5 7ffc66b5 00000001 c0434000 0000000a c0426240 cfb81e90 c04261e0
> NIP [c003c4ac] wake_up_process+0x10/0x20
> LR [c005d7f0] hrtimer_wakeup+0x28/0x44
> Call Trace:
> [c0435d90] [c0426240] 0xc0426240 (unreliable)
> [c0435da0] [c005dfd8] __hrtimer_run_queues.constprop.7+0x114/0x214
> [c0435df0] [c005e334] hrtimer_interrupt+0xb8/0x29c
> [c0435e40] [c0009c80] __timer_interrupt+0xb8/0x1c4
> [c0435e60] [c000a03c] timer_interrupt+0x8c/0xb8
> [c0435e90] [c000ece4] ret_from_except+0x0/0x14
> --- interrupt: 901 at arch_cpu_idle+0x24/0x6c
>     LR = arch_cpu_idle+0x24/0x6c
> [c0435f50] [c0434000] 0xc0434000 (unreliable)
> [c0435f60] [c0044cc0] cpu_startup_entry+0x138/0x1cc
> [c0435fb0] [c03fdde0] start_kernel+0x32c/0x340
> [c0435ff0] [00003438] 0x3438
> 
> 
> This trace is missing when I try the same with latest kernel 4.7. But the
> behaviour is similar. The board is still reachable via telnet but I need to kill
> the gdbserver session manually to get control over the initial serial terminal
> again. When I move the mentioned line of code everything works fine.

I think that warning was just a false positive.  It got removed:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=119d6f6a3be8b

Is the process still alive at the point that the remote debugger stops
responding?  What is it doing at that point?
