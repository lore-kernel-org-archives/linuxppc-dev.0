Message-ID: <5993-72182@sneakemail.com>
Date: Tue, 02 Mar 2004 16:14:23 -0800
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel hangs in early_init
References: <20040302235632.341E4C0655@atlas.denx.de>
In-Reply-To: <20040302235632.341E4C0655@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wd-at-denx.de |PPC Linux Embedded| wrote:
> In message <4522-80798@sneakemail.com> you wrote:
>
>>Good point, I missed that. However, that particular FAQ doesn't seem
>>to apply. I'm using 2.4.24+ (>2.4.5), the CFG_IMMR value doesn't seem
>>to apply (PPC405GPr, not a MPC8xx system) and I double-checked that
>>the bd_t structure matches. Besides, it's nowhere neer trying to access
>>any of the arguments yet.
>
>
> I think it does access arguments. Linux  will  need  parameters  like
> clock frequencies, memory sizes etc. Passing wrong paramteters is one
> of the most frequent causes of that particular failure mode.

I know it will access the arguments *eventually*, but it is not
there yet.

head_4xx.S:_start calls initial_mmu to set up a preliminary map,
then turns on the MMU, branching to "start_here". start_here
calls early_init, which immediately calls reloc_offset in misc.S,
but stops there. In all this, I don't yet see any reference to
the arguments until *after* early_init returns. Then the args
are passed to machine_init.

Since it hangs *before* any reference to the passed in arguments,
I don't believe the problem lies there.

I've homed in on the hang being during a bl to reloc_offset
by using an o'scope and some spin loops, so I'm pretty sure
where it's going.

>
>>The stack at the time is still where U-Boot left it, near the end of
>>the 128Meg memory. Is this something I should address (pardon the pun)?
>
>
> I don't think so.

I think it's something related to a stack, even if it's not
that particular stack. Can someone explain this bit of code
to me? I'm not a PPC ASM hotshot.

(from head_4xx.S)

	/* ptr to current */
	lis	r2,init_task_union@h
	ori	r2,r2,init_task_union@l

	/* ptr to phys current thread */
	tophys(r4,r2)
	addi	r4,r4,THREAD	/* init task's THREAD */
	mtspr	SPRG3,r4
	li	r3,0
	mtspr	SPRG2,r3	/* 0 => r1 has kernel sp */

	/* stack */
	addi	r1,r2,TASK_UNION_SIZE
	li	r0,0
	stwu	r0,-STACK_FRAME_OVERHEAD(r1)

	bl	early_init	/* We have to do this with MMU on */

--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
