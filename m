Return-Path: <prvs=0032113f0d=holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9q5s6ZM0zDr1m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Aug 2016 01:47:45 +1000 (AEST)
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
To: Dave Hansen <dave.hansen@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
 <57ADE7E6.9030900@linux.intel.com>
CC: "mingo@kernel.org" <mingo@kernel.org>
From: Holger Brunck <holger.brunck@keymile.com>
Message-ID: <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
Date: Fri, 12 Aug 2016 17:47:37 +0200
MIME-Version: 1.0
In-Reply-To: <57ADE7E6.9030900@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for the quick answer!

On 12/08/16 17:14, Dave Hansen wrote:
> On 08/12/2016 07:50 AM, Holger Brunck wrote:
>> When I try to debug our multithreaded userspace application with gdb I  get
>> stuck when trying to single step code.
> 
> Can you clarify "stuck"?  Like the instructions don't advance?  Have you
> been able to find a root cause for this?
> 

the behaviour is slightly different on the kernel versions. So my setup is a
remote debug session via gdbserver.

After connecting to the gdbserver I set a break point and start to run my
program. When hitting the breakpoint I try to single step. With stuck I mean
that the connection to the gdbserver is broken and I can't control my debug
session anymore while the application is not continuing.

On Kernel 4.2 I got additionally the following dump in my serial terminal:

------------[ cut here ]------------
WARNING: at
/opt/keymile/ws_root/git_repositories/prod/keyne/plat/kernel/gpl/kernel/sched/core.c:1975
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.2.0-00003-g0478a57 #10
task: c04213d0 ti: c0434000 task.ti: c0434000
NIP: c003c4ac LR: c005d7f0 CTR: c005d7c8
REGS: c0435ce0 TRAP: 0700   Not tainted  (4.2.0-00003-g0478a57)
MSR: 00021032 <ME,IR,DR,RI>  CR: 22044228  XER: 20000000

GPR00: c005dfd8 c0435d90 c04213d0 cfba7a70 c042624c 00000000 00000001 00000000
GPR08: 00000001 00000001 00000007 ffffffff 42044228 eec349c0 00000000 00000000
GPR16: 0fe75f34 c0434000 0000000a c005d7c8 00000001 0000000a c0430000 c042624c
GPR24: 7ffc66b5 7ffc66b5 00000001 c0434000 0000000a c0426240 cfb81e90 c04261e0
NIP [c003c4ac] wake_up_process+0x10/0x20
LR [c005d7f0] hrtimer_wakeup+0x28/0x44
Call Trace:
[c0435d90] [c0426240] 0xc0426240 (unreliable)
[c0435da0] [c005dfd8] __hrtimer_run_queues.constprop.7+0x114/0x214
[c0435df0] [c005e334] hrtimer_interrupt+0xb8/0x29c
[c0435e40] [c0009c80] __timer_interrupt+0xb8/0x1c4
[c0435e60] [c000a03c] timer_interrupt+0x8c/0xb8
[c0435e90] [c000ece4] ret_from_except+0x0/0x14
--- interrupt: 901 at arch_cpu_idle+0x24/0x6c
    LR = arch_cpu_idle+0x24/0x6c
[c0435f50] [c0434000] 0xc0434000 (unreliable)
[c0435f60] [c0044cc0] cpu_startup_entry+0x138/0x1cc
[c0435fb0] [c03fdde0] start_kernel+0x32c/0x340
[c0435ff0] [00003438] 0x3438


This trace is missing when I try the same with latest kernel 4.7. But the
behaviour is similar. The board is still reachable via telnet but I need to kill
the gdbserver session manually to get control over the initial serial terminal
again. When I move the mentioned line of code everything works fine.

>> Does anyone have an idea why the change in sched.h break my debug
>> usecase? Anyone out here who is debugging ppc83xx targets flawlessly
>> with a recent kernel?
> 
> Thanks for going to the trouble of bisecting this, btw!
> 
> I'd _suspect_ something very specific to your platform since this
> doesn't appear to affect even other ppc variants.
> 

yeah I also think  this. I did the same test on  an embedded ARM target and it
works fine, so it seems to be somehow related to ppc 83xx which is a 32-bit
target. And what we also need is multithreading and/or c++ code. I did check
with some simple code and single stepping works fine.

It might also be that your code change simply exposes an error in the gdb/g++
environment.

> I wonder if making it cross a page boundary from some other structure
> causes this, or moving it relative to something else.  Could you try
> moving it to a few more places, or padding it by, say PAGE_SIZE on
> either side makes a difference?
> 

yes I can do some more tests at the beginning of the next week. Moving this
definition within the structure is a good idea.

> Is there some assembly involved in your single-stepping, or some other
> code that assumes relative offsets between two pieces of 'task_struct'?
> 

no. At least not in the code we have written. Not sure what the related g++
libraries are doing.

Regards
Holger
