Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyZlF5HTjzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 21:54:00 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8LBpFg8011753
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 07:53:58 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d48cyftbr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 07:53:58 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Thu, 21 Sep 2017 21:53:55 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8LBrrC941418858
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 21:53:53 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8LBrkt7008794
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 21:53:46 +1000
Subject: Re: [PATCH] powerpc/livepatch: Fix livepatch stack access
To: Balbir Singh <bsingharora@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
References: <1505902791-26383-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <87d16kcqsz.fsf@concordia.ellerman.id.au>
 <CAKTCnznFX=HkB9jUEKCHb=gbZxuupHpRrbwuM93cN=jAU5Wyhg@mail.gmail.com>
Cc: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 17:23:50 +0530
MIME-Version: 1.0
In-Reply-To: <CAKTCnznFX=HkB9jUEKCHb=gbZxuupHpRrbwuM93cN=jAU5Wyhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f28375ec-078a-43d6-fbd1-4ee10572e38a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 21 September 2017 04:30 PM, Balbir Singh wrote:
> On Thu, Sep 21, 2017 at 8:02 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:
>>
>>> While running stress test with livepatch module loaded, kernel
>>> bug was triggered.
>>>
>>> cpu 0x5: Vector: 400 (Instruction Access) at [c0000000eb9d3b60]
>>>     pc: c0000000eb9d3e30
>>>     lr: c0000000eb9d3e30
>>>     sp: c0000000eb9d3de0
>>>    msr: 800000001280b033
>>>   current = 0xc0000000dbd38700
>>>   paca    = 0xc00000000fe01400   softe: 0        irq_happened: 0x01
>>>     pid   = 8618, comm = make
>>> Linux version 4.13.0+ (root@ubuntu) (gcc version 6.3.0 20170406 (Ubuntu 6.3.0-12ubuntu2)) #1 SMP Wed Sep 13 03:49:27 EDT 2017
>>>
>>> 5:mon> t
>>> [c0000000eb9d3de0] c0000000eb9d3e30 (unreliable)
>>> [c0000000eb9d3e30] c000000000008ab4 hardware_interrupt_common+0x114/0x120
>>>  --- Exception: 501 (Hardware Interrupt) at c000000000053040 livepatch_handler+0x4c/0x74
>>> [c0000000eb9d4120] 0000000057ac6e9d (unreliable)
>>> [d0000000089d9f78] 2e0965747962382e
>>> SP (965747962342e09) is in userspace
>>>
>>> When an interrupt is served in between the livepatch_handler execution,
>>> there are chances of the livepatch_stack/task task getting corrupted.
>>
>> Ouch. That's pretty broken by me.
>>
>
> I was worried more about preemption as I said in the review comment earlier,
> this is new. It looks like we restored the wrong r1 on returning from
> the interrupt
> context?

Yes, consider the example in the mail thread. Where the r0 is temporary 
used to hold the stack pointer value before loading r1 with the 
livepatch_sp (current->thread_info + 24). An interrupt occurs while the 
livepatch stack is being setup to store or restore the LR/TOC value of 
the calling function.

do_IRQ -> call_do_irq's first instruction mflr r0, over-writes the stack 
value with LR value. Consecutive instruction referring to r1 in 
call_do_irq are actually referring to the livepatch_sp instead of task 
stack. On the return to livepatch_handler, stack is restored from r0 
value (which has been over-written with LR value in call_do_irq). Any 
access therefore made to the stack is to a wrong address.

> It would be nice to see any pt_regs changes due to the interrupt.
> Did the interrupt handling code called something that needed live-patching?
>

AFAIK, the livepatch_sp value for softirq_ctx/hardirq_ctx are 
initialized, as it's part of thread_info. Am I missing something here.


>
>>> Fix the corruption by using r11 register for livepatch stack manipulation,
>>> instead of shuffling task stack and livepatch stack into r1 register.
>>> Using r11 register also avoids disabling/enabling irq's while setting
>>> up the livepatch stack.
>>

The r11 is restored before calling the livepatch_handler by ftrace_caller:

         /* Load CTR with the possibly modified NIP */
         mtctr   r15

         /* Restore gprs */
         REST_GPR(0,r1)
         REST_10GPRS(2,r1)
         REST_10GPRS(12,r1)
         REST_10GPRS(22,r1)

         [...]

#ifdef CONFIG_LIVEPATCH
         /*
          * Based on the cmpd or cmpdi above, if the NIP was altered and 
we're
          * not on a kprobe/jprobe, then handle livepatch.
          */
         bne-    livepatch_handler
#endif


-- 
cheers,
Kamalesh.
