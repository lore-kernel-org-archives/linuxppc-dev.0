Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 78B73B6F7E
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Jul 2011 19:32:48 +1000 (EST)
Message-ID: <4E27F223.4060602@windriver.com>
Date: Thu, 21 Jul 2011 17:32:19 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>, "Walsh, Benjamin"
	<benjamin.walsh@windriver.com>
Subject: Re: [v3 PATCH 1/1] booke/kprobe: make program exception to use one
	dedicated exception stack
References: <1310383915-30543-1-git-send-email-tiejun.chen@windriver.com>	<CC4F4DC6-0682-4FC6-8D89-CE9AFEA7AD85@kernel.crashing.org>
	<4E1FCFEF.7070702@windriver.com>
In-Reply-To: <4E1FCFEF.7070702@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tiejun.chen wrote:
> Kumar Gala wrote:
>> On Jul 11, 2011, at 6:31 AM, Tiejun Chen wrote:
>>
>>> When kprobe these operations such as store-and-update-word for SP(r1),
>>>
>>> stwu r1, -A(r1)
>>>
>>> The program exception is triggered, and PPC always allocate an exception frame
>>> as shown as the follows:
>>>
>>> old r1 ----------
>>>         ...
>>>         nip
>>>         gpr[2] ~ gpr[31]
>>>         gpr[1] <--------- old r1 is stored.
>>>         gpr[0]
>>>       -------- <--------- pr_regs @offset 16 bytes
>>>       padding
>>>       STACK_FRAME_REGS_MARKER
>>>       LR
>>>       back chain
>>> new r1 ----------
>>> Then emulate_step() will emulate this instruction, 'stwu'. Actually its
>>> equivalent to:
>>> 1> Update pr_regs->gpr[1] = mem[old r1 + (-A)]
>>> 2> stw [old r1], mem[old r1 + (-A)]
>>>
>>> Please notice the stack based on new r1 may be covered with mem[old r1
>>> +(-A)] when addr[old r1 + (-A)] < addr[old r1 + sizeof(an exception frame0].
>>> So the above 2# operation will overwirte something to break this exception
>>> frame then unexpected kernel problem will be issued.
>>>
>>> So looks we have to implement independed interrupt stack for PPC program
>>> exception when CONFIG_BOOKE is enabled. Here we can use
>>> EXC_LEVEL_EXCEPTION_PROLOG to replace original NORMAL_EXCEPTION_PROLOG
>>> for program exception if CONFIG_BOOKE. Then its always safe for kprobe
>>> with independed exc stack from one pre-allocated and dedicated thread_info.
>>> Actually this is just waht we did for critical/machine check exceptions
>>> on PPC.
>>>
>>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>>> ---
>> I'm still very confused why we need a unique stack frame for kprobe/program exceptions on book-e devices.
> 
> Its a bug at least for Book-E. And if you'd like to check another topic thread,
> "[BUG?]3.0-rc4+ftrace+kprobe: set kprobe at instruction 'stwu' lead to system
> crash/freeze", you can know this story completely :)
> 
> This bug should not be reproduced on PPC64 with the exception prolog/endlog
> dedicated to PPC64. But I have no enough time to check other PPC32 & !BOOKE so
> I'm not sure if we should extend this modification.
> 
>> Can you explain this further.
> 
> I can show one of those issued examples.
> 
> Here we kprobe the entry point of show_interrupts().
> 
> (gdb) disassemble show_interrupts
> Dump of assembler code for function show_interrupts:
>    0xc0004ff4 <+0>:	stwu    r1,-48(r1)
>    0xc0004ff8 <+4>:	mflr    r0
> 
> I add some printk() inside pre_handler() to show pt_regs->gpr[1] and pt_regs->nip.
> ------
> ......
> Planted kprobe at c0004ff4
> pre_handler: p->addr = 0xc0004ff4, nip = 0xc0004ff4, msr = 0x29000
> gpr[1] = de767e50.
> nip = c0004ff4.
> 
> When hit this instruction, emulate_step() would emulate this instruction as follows:
> ------
> #1> current pr_regs->gpr[1] = 0xde767e50 - 48 = 0xde767e20;
> #2> stw (previous pr_regs->gpr[1]), @(current pr_regs->gpr[1])
> 	==> stw (0xde767e50), 0xde767e20
> 
> But after this kprobe process something would be rewrite incorrectly:
> ------
> ......
> post_handler: p->addr = 0xc0004ff4, msr = 0x29000
> gpr[1] = de767e20.
> nip = de767e54.
> 	^
> 	If everything is good nip should equal to (0xc0004ff4 + 0x4). But looks its
> reset with (0xde767e50 + 0x4) via the above #2 operation. So why?
> 
> As I understand kprobe use 'trap' to enter the program exception. At now PR = 0
> so the kernel allocate an exception frame as normal.
> 
>         ---------------- old r1[0xde767e50]
> 	 1  pt_regs->result
> 	 2  pt_regs->dsisr
> 	 3  pt_regs->dar
> 	 4  pt_regs->trap
> 	 5  pt_regs->mq
> 	 6  pt_regs->ccr
> 	 7  pt_regs->xer
> 	 8  pt_regs->link
> 	 9  pt_regs->ctr
> 	 10 pt_regs->orig_gpr3
> 	 11 pt_regs->msr
>          12 pt_regs->nip  <-- @ 0xde767e50 - 12 x 4 = 0xde767e20
> 		......
> 	----------------- new r1[0xde767e50 - INT_FRAME_SIZE]
> 
> I think you can understand why pt_regs->nip is broken :) So the root cause is an
> exception frame and the kprobed function stack frame are always overlap. And
> then someone member inside an exception frame may be corrupted by that emulated
> stw operation.
> 
> So I think we have to use one unique stack frame to avoid this when enable
> CONFIG_KPROBES. Especially for Book-E we can refer easily machine
> check/critical/debug exception implementation to do this like my patch.
> 

More questions or suggestions?

Tiejun

> Tiejun
> 
>> - k
