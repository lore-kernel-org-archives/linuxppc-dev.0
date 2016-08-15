Return-Path: <prvs=003553880f=holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCdMc4KfjzDr3S
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 00:35:55 +1000 (AEST)
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
To: Dave Hansen <dave.hansen@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
 <57ADE7E6.9030900@linux.intel.com>
 <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
 <57ADF4A0.5040807@linux.intel.com>
CC: "mingo@kernel.org" <mingo@kernel.org>
From: Holger Brunck <holger.brunck@keymile.com>
Message-ID: <41e00d07-d7ce-0198-acce-ac25db8c9df3@keymile.com>
Date: Mon, 15 Aug 2016 16:35:47 +0200
MIME-Version: 1.0
In-Reply-To: <57ADF4A0.5040807@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/08/16 18:09, Dave Hansen wrote:
> On 08/12/2016 08:47 AM, Holger Brunck wrote:
>> On 12/08/16 17:14, Dave Hansen wrote:
>>> On 08/12/2016 07:50 AM, Holger Brunck wrote:
>>>> When I try to debug our multithreaded userspace application with gdb I  get
>>>> stuck when trying to single step code.
>>>
>>> Can you clarify "stuck"?  Like the instructions don't advance?  Have you
>>> been able to find a root cause for this?
>>
>> the behaviour is slightly different on the kernel versions. So my setup is a
>> remote debug session via gdbserver.
>>
>> After connecting to the gdbserver I set a break point and start to run my
>> program. When hitting the breakpoint I try to single step. With stuck I mean
>> that the connection to the gdbserver is broken and I can't control my debug
>> session anymore while the application is not continuing.
> 
> Could you try debugging locally with gdb?  It would be nice to take all
> the stuff involved with remote debugging out of the picture.
> 

I tried this but unfortunately the error only occurs while remote debugging.
Locally with gdb everything works fine. BTW we double-checked with a 85xx ppc
target which is also 32-bit and it ends up with the same behaviour.

I was also investigating where I have to move the line in the struct task_struct
and it turns out to be like this (diff to 4.7 kernel):

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 253538f..4868874 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1655,7 +1655,9 @@ struct task_struct {
        struct signal_struct *signal;
        struct sighand_struct *sighand;

+       // struct thread_struct thread;   // until here everything is fine
        sigset_t blocked, real_blocked;
+       struct thread_struct thread;      // from here it's broken
        sigset_t saved_sigmask; /* restored if set_restore_sigmask() was used */
        struct sigpending pending;

@@ -1919,7 +1921,6 @@ struct task_struct {
        struct task_struct *oom_reaper_list;
 #endif
 /* CPU-specific state of this task */
-       struct thread_struct thread;
 /*

So it's in the area where some signal information are stored, which makes sense
because this is highly used in case of gdb debugging.

> Have you tried turning on a bunch of kernel debugging (SLAB/SLUB
> debugging, pagealloc debug, lockdep, etc...)?  If something is getting
> corrupted, those tend to catch it.
>

I switched on some memory debugging features but didn't get suspicious output.
To make the situation even more weird after enabling FTRACE in the kernel to
trace some signal code the error disappeared.

> 
> Is the process still alive at the point that the remote debugger stops
> responding?  What is it doing at that point?
> 

the process is still alive. The state of the process, it's threads and the
gdbserver is like this:

Bad case after a single step:
 73    73 TS       -   0  19   0  0.3 S    sigsuspend     gdbserver
 74    74 TS       -   0  19   0  0.0 tl+  ptrace_stop    infra_pbec83xx_
 74    77 IDL      0   -  19   0  0.0 tl+  ptrace_stop    TR_Task
 74    78 IDL      0   -  19   0  0.0 tl+  ptrace_stop    TR_Timeout
 74    79 TS       -   0  19   0  0.0 tl+  poll_schedule_ timed_msg
 74    80 IDL      0   -  19   0  0.0 tl+  ptrace_stop    stimuli
 74    81 TS       -  -5  24   0  0.0 t<l+ ptrace_stop    timer0Dflt
 74    82 TS       - -19  38   0  0.0 t<l+ futex_wait_que timerUpd0
 74    83 TS       - -19  38   0  0.0 t<l+ timerfd_read   timerClk
 74    84 TS       - -19  38   0  0.0 t<l+ ptrace_stop    b/beatWDogRefr

Good case after a single step:
 76    76 TS       -   0  19   0  4.0 S    poll_schedule_ gdbserver
 77    77 TS       -   0  19   0  0.0 tl   ptrace_stop    infra_pbec83xx_
 77    84 IDL      0   -  19   0  0.0 tl   ptrace_stop    TR_Task
 77    85 IDL      0   -  19   0  0.0 tl   ptrace_stop    TR_Timeout
 77    86 TS       -   0  19   0  0.0 tl   ptrace_stop    timed_msg
 77    87 IDL      0   -  19   0  0.0 tl   ptrace_stop    stimuli
 77    88 TS       -  -5  24   0  0.0 t<l  ptrace_stop    timer0Dflt
 77    89 TS       - -19  38   0  0.0 t<l  ptrace_stop    timerUpd0
 77    90 TS       - -19  38   0  0.0 t<l  ptrace_stop    timerClk
 77    91 TS       - -19  38   0  0.0 t<l  ptrace_stop    b/beatWDogRefr

So in the error case only some threads are at ptrace_stop, while all of them
should be after a single step with the gdb. So it's somewhere in the signal
handling between kernel and gdbserver.

Best regards
Holger Brunck
