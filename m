Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz1tq6QWPzDsM4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 15:17:07 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8M5DpI3116113
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 01:17:04 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2d4pnj90t7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 01:17:04 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <kamalesh@linux.vnet.ibm.com>;
 Fri, 22 Sep 2017 15:17:01 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v8M5Gx9b42270850
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 15:16:59 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v8M5Gn7i018157
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 15:16:49 +1000
Subject: Re: [PATCH] powerpc/livepatch: Fix livepatch stack access
To: "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
References: <1505902791-26383-1-git-send-email-kamalesh@linux.vnet.ibm.com>
 <87d16kcqsz.fsf@concordia.ellerman.id.au>
 <CAKTCnznFX=HkB9jUEKCHb=gbZxuupHpRrbwuM93cN=jAU5Wyhg@mail.gmail.com>
 <20170921165559.ki4dnggjv7t25dah@naverao1-tp.localdomain>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Fri, 22 Sep 2017 10:46:54 +0530
MIME-Version: 1.0
In-Reply-To: <20170921165559.ki4dnggjv7t25dah@naverao1-tp.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <2c388462-22ce-45cf-5a83-e31ccef3fe61@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 21 September 2017 10:25 PM, Naveen N . Rao wrote:
> On 2017/09/21 09:00PM, Balbir Singh wrote:
>> On Thu, Sep 21, 2017 at 8:02 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> writes:
>>>
>>>> While running stress test with livepatch module loaded, kernel
>>>> bug was triggered.
>>>>
>>>> cpu 0x5: Vector: 400 (Instruction Access) at [c0000000eb9d3b60]
>>>>     pc: c0000000eb9d3e30
>>>>     lr: c0000000eb9d3e30
>>>>     sp: c0000000eb9d3de0
>>>>    msr: 800000001280b033
>>>>   current = 0xc0000000dbd38700
>>>>   paca    = 0xc00000000fe01400   softe: 0        irq_happened: 0x01
>>>>     pid   = 8618, comm = make
>>>> Linux version 4.13.0+ (root@ubuntu) (gcc version 6.3.0 20170406 (Ubuntu 6.3.0-12ubuntu2)) #1 SMP Wed Sep 13 03:49:27 EDT 2017
>>>>
>>>> 5:mon> t
>>>> [c0000000eb9d3de0] c0000000eb9d3e30 (unreliable)
>>>> [c0000000eb9d3e30] c000000000008ab4 hardware_interrupt_common+0x114/0x120
>>>>  --- Exception: 501 (Hardware Interrupt) at c000000000053040 livepatch_handler+0x4c/0x74
>>>> [c0000000eb9d4120] 0000000057ac6e9d (unreliable)
>>>> [d0000000089d9f78] 2e0965747962382e
>>>> SP (965747962342e09) is in userspace
>>>>
>>>> When an interrupt is served in between the livepatch_handler execution,
>>>> there are chances of the livepatch_stack/task task getting corrupted.
>>>
>>> Ouch. That's pretty broken by me.
>>>
>>
>> I was worried more about preemption as I said in the review comment earlier,
>> this is new. It looks like we restored the wrong r1 on returning from
>> the interrupt
>> context? It would be nice to see any pt_regs changes due to the interrupt.
>> Did the interrupt handling code called something that needed live-patching?
>
> The problem is just that the livepatch stack grows up, rather than down.
> So, when this stack is used during interrupt handling, we'll clobber
> part of this stack.
>
> There aren't any pt_regs changes due to this afaics. Just the livepatch
> stack being over-written.
>
>>
>>>> Fix the corruption by using r11 register for livepatch stack manipulation,
>>>> instead of shuffling task stack and livepatch stack into r1 register.
>>>> Using r11 register also avoids disabling/enabling irq's while setting
>>>> up the livepatch stack.
>>>
>>> I'm trying to think if there's some reason I didn't use r11. But I can't
>>> remember anything specific. I suspect I just didn't check the ABI
>>
>> We can't use r11, this is ftrace with regs, we've restore registers before
>> calling livepatch_handler, I don't think we can clobber r11, but I might
>> be sleep deprived and missing something
>
> r11 is volatile and meant for usage in function linkage. With
> -mprofile-kernel, we've just entered the new function and haven't
> touched r11 yet. So, it appears to me that we can definetely use/clobber
> it, along with r0 and r12.
>

Misread the question from Balbir. livepatch_handler is called in mcount
context, which is very early in the function execution. r11 might
have live values used by the calling function, those are restored by
ftrace code but the called/calling function cannot rely on it, after
a function call as pointed out by Naveen.

In non-ftrace context, r11 is also used/clobbered between function calls 
to load the stub address.

-- 
cheers,
Kamalesh.
