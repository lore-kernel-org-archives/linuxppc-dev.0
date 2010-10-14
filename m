Return-Path: <tao_rick@yahoo.com>
Received: from nm20-vm0.bullet.mail.ac4.yahoo.com
	(nm20-vm0.bullet.mail.ac4.yahoo.com [98.139.53.214])
	by ozlabs.org (Postfix) with SMTP id 8111F1007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 07:45:12 +1100 (EST)
Message-ID: <174398.42321.qm@web50405.mail.re2.yahoo.com>
Date: Thu, 14 Oct 2010 13:45:09 -0700 (PDT)
From: Rick Tao <tao_rick@yahoo.com>
Subject: Possible kernel stack overflow due to fast interrupts
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi, all,

I am looking at the kernel source of 2.6.32. It appears to me that kernel stack can be easily getting overflowed in case of fast interrupts. Here is my observation, any comments? Thanks,

Let's assume task A triggers the fast interrupts, and task B was running when the fast interrupt occur. 

In the context of task B (according to entry_32.S)
0. Assume task B's ksp = X
1. the interrupt causes exception, allocate exception frame space from
   the task B'stack (ksp = X - INT_FRAME_SIZE).
2. interrupt handler is invoked
3. ret_from_except, and resume_kernel is invoked
4. then preempt_schedule_irq is called, which in trun, __schedule() and 
   context_switch is called. Assume it switches to task A. 
   In this step,
     task B's stack is pushed another INT_FRAME_SIZE to save its context,
     so task B's ksp = X - 2 * INT_FRAME_SIZE now.

In the context of task A
a. NIP would point to the instruction after switch_to(). 
b. MSR_EE is enabled in the call trace (finish_task_switch -->finish_lock_switch-->spin_unlock_irq)
c. do something that would trigger an interrupt later on (such as timer)
d. call schedule() for context switch to task B.
   In this step, 
     task B's stack is popped INT_FRAME_SIZE size for context restore.  
   Note that task B's ksp = X - INT_FRAME_SIZE

In the context of task B again
a1. similar to step "a" above
b1. similar to step "b" above 
c1. interrupt occurs, go to step "1" above, and repeat!!!

As you can see, task B's kernel stack space is reduced by INT_FRAME_SIZE
on each loop. It will eventually overflow.

Thanks for your input.

Rick





      
