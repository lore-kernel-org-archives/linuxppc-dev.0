Return-Path: <prvs=0037b07ebe=holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDsx02pdgzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 01:05:40 +1000 (AEST)
Subject: Re: debug problems on ppc 83xx target due to changed struct
 task_struct
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
References: <dc38afe9-6b78-f3f5-666b-986939e40fc6@keymile.com>
 <57ADE7E6.9030900@linux.intel.com>
 <4e16aad4-80d3-ffcc-d183-681b48d4751b@keymile.com>
 <57ADF4A0.5040807@linux.intel.com>
 <41e00d07-d7ce-0198-acce-ac25db8c9df3@keymile.com>
 <57B1EBAE.6030503@linux.intel.com>
 <1471385632.19495.24.camel@kernel.crashing.org>
CC: "mingo@kernel.org" <mingo@kernel.org>
From: Holger Brunck <holger.brunck@keymile.com>
Message-ID: <b78d9e5d-fc2e-3676-a47e-ed5ca7a836e6@keymile.com>
Date: Wed, 17 Aug 2016 17:05:34 +0200
MIME-Version: 1.0
In-Reply-To: <1471385632.19495.24.camel@kernel.crashing.org>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/08/16 00:13, Benjamin Herrenschmidt wrote:
> On Mon, 2016-08-15 at 09:19 -0700, Dave Hansen wrote:
>>  
>> Wow, thanks for all the debugging here!
> 
> Yup, thanks, that's really odd... I wonder if one of those
> structures is accessed beyond it's boundary, either the sigset
> or the thread struct, causing corruption of neighbouring fields
> in task struct...
> 
> Can you try adding a little canary on both sides (make it not-so-little 
> maybe a few words) which you initialize to a known pattern and check
> every now and then ?
> 

I added a dummy char buffer like this:

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1655,7 +1655,11 @@ struct task_struct {
        struct signal_struct *signal;
        struct sighand_struct *sighand;

+        // struct thread_struct thread;      // does work
        sigset_t blocked, real_blocked;
+
+        struct thread_struct thread;      // does work if dummy has 5 bytes
+        char dummy[5];                    // if we use 4 bytes it's broken
        sigset_t saved_sigmask; /* restored if set_restore_sigmask() was used */
        struct sigpending pending;

@@ -1919,7 +1923,6 @@ struct task_struct {
        struct task_struct *oom_reaper_list;
 #endif
 /* CPU-specific state of this task */
-       struct thread_struct thread;
 /*
  * WARNING: on x86, 'thread_struct' contains a variable-sized
  * structure.  It *MUST* be at the end of 'task_struct'.

If I use 4 bytes the error is present if I add 5 bytes it runs fine. For both
cases I added a printout into the sched_debug.c code to the general scheduler
statistics and the content of the buffer is always zero and does not change. So
at least no one is writing non-zero to the buffer. Where gets the task_struct
initialized? Then I could double check with different values.

Just to let you know in rare case I get a kernel crash (my_trace are some
printouts in arch/powerpc/signal_32.c and arch/powerpc/kernel/signal.c) :

my_trace: handle_signal32
my_trace: save_user_regs
my_trace: copy_fpr_to_user
my_trace: sys_sigreturn
my_trace: restore_user_regs
my_trace: copy_fpr_from_user
my_trace: do_signal: no signal to deliver
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc01dd2a4
Oops: Kernel access of bad area, sig: 11 [#1]
PREEMPT mpc83xx-km-platform
Modules linked in:
CPU: 0 PID: 65 Comm: TR_Task Not tainted 4.7.0-00271-g76ef984-dirty #77
task: cfbab5f0 ti: cfb94000 task.ti: cfb94000
NIP: c01dd2a4 LR: c003d0fc CTR: c003ddc0
REGS: cfb95bf0 TRAP: 0300   Not tainted  (4.7.0-00271-g76ef984-dirty)
MSR: 00001032 <ME,IR,DR,RI>  CR: 84022282  XER: 20000000
DAR: 00000000 DSISR: 20000000
GPR00: c003df58 cfb95ca0 cfbab5f0 cfbab138 cfb7f708 00000000 00000001 00000000
GPR08: 00000000 cfb9ea18 00000000 13d50b30 84022282 1006ac08 00000000 0fff0018
GPR16: 0fcc02a8 b7d3b4c0 10068c70 10068c70 0fe1a91c 0fcc22f8 00000000 cfb94000
GPR24: 00000000 ffffffff cfb94000 c044ea40 cfbab130 cfbab138 cfb7f6e0 cfbab130
NIP [c01dd2a4] rb_erase+0x1d0/0x3e4
LR [c003d0fc] set_next_entity+0x7c/0xc8
Call Trace:
[cfb95ca0] [84022282] 0x84022282 (unreliable)
[cfb95cc0] [c003df58] pick_next_task_fair+0x198/0x1e8
[cfb95cf0] [c03666f4] __schedule+0xd8/0x4d8
[cfb95d40] [c0366b30] schedule+0x3c/0xac
[cfb95d60] [c006f96c] futex_wait_queue_me+0xd4/0x164
[cfb95d80] [c007098c] futex_wait+0xfc/0x268
[cfb95e50] [c0072500] do_futex+0x138/0xb34
[cfb95ee0] [c0072f60] SyS_futex+0x64/0x1d0
[cfb95f40] [c000e788] ret_from_syscall+0x0/0x38
--- interrupt: c01 at 0xfca0db4
    LR = 0xfca0d90
Instruction dump:
912a0000 81490000 71470001 418200d4 5548003b 418200b0 7d274b78 7d094378
81490004 7f8a3840 409eff60 81490008 <810a0000> 71060001 40820040 80ea0004
---[ end trace e7b4a1ae0909a358 ]---

note: TR_Task[65] exited with preempt_count 2

So I also see a race condition in rare cases when I trigger the error, while
most of the time the kernel continues and the threads are in a state which are
confusing the gdbserver. All these test are done with a simple C program which
runs three threads in a while loop.

Best regards
Holger Brunck
