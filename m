Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4DD7A2C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2012 16:13:07 +1000 (EST)
Message-ID: <505810EC.6060907@windriver.com>
Date: Tue, 18 Sep 2012 14:13:00 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [v5][PATCH 2/3] powerpc/kprobe: complete kprobe and migrate
 exception frame
References: <1347875671-15838-1-git-send-email-tiejun.chen@windriver.com>
 <1347875671-15838-2-git-send-email-tiejun.chen@windriver.com>
 <1347944755.2386.43.camel@pasglop> <1347944998.2386.44.camel@pasglop>
In-Reply-To: <1347944998.2386.44.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/18/2012 01:09 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2012-09-18 at 15:05 +1000, Benjamin Herrenschmidt wrote:
>> On Mon, 2012-09-17 at 17:54 +0800, Tiejun Chen wrote:
>>> -#ifdef CONFIG_PREEMPT
>>>   	b	restore
>>>
>>>   /* N.B. the only way to get here is from the beq following ret_from_except. */
>>>   resume_kernel:
>>> -	/* check current_thread_info->preempt_count */
>>> +	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
>>>   	CURRENT_THREAD_INFO(r9, r1)
>>> +	lwz	r8,TI_FLAGS(r9)
>>> +	andis.	r8,r8,_TIF_EMULATE_STACK_STORE@h
>>> +	beq+	1f
>>> +
>>> +	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
>>> +
>>> +	lwz	r3,GPR1(r1)
>>> +	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame */
>>> +	mr	r4,r1			/* src:  current exception frame */
>>> +	li	r5,INT_FRAME_SIZE	/* size: INT_FRAME_SIZE */
>>> +	li	r6,0			/* start offset: 0 */
>>> +	mr	r1,r3			/* Reroute the trampoline frame to r1 */
>>> +
>>> +	/* Copy from the original to the trampoline. */
>>> +	li	r6,0
>>
>> You just did that li r6,0 2 lines above :-) I'll fix it up manually
>> while applying.
>
> In fact the srwi can be dropped completely, we can just load r5 with the
> divided value. Committed, will push later today, please test.

I retest to kprobe do_fork() and show_interrupts() with/without enabling 
CONFIG_PREEMPT, separately, looks still work.

For 32-bit:
------------
+       /* Copy from the original to the trampoline. */
+       lwz     r3,GPR1(r1)
+       subi    r3,r3,INT_FRAME_SIZE    /* dst: Allocate a trampoline exception 
frame */
+       mr      r4,r1                   /* src:  current exception frame */
+       li      r5,INT_FRAME_SIZE/4     /* size: INT_FRAME_SIZE */
+       li      r6,0                    /* start offset: 0 */
+       mr      r1,r3                   /* Reroute the trampoline frame to r1 */
+       mtctr   r5
+2:     lwzx    r0,r6,r4
+       stwx    r0,r6,r3
+       addi    r6,r6,4
+       bdnz    2b

And for 64-bit:
---------------
+       /* Copy from the original to the trampoline. */
+       lwz     r3,GPR1(r1)
+       subi    r3,r3,INT_FRAME_SIZE    /* dst: Allocate a trampoline exception 
frame */
+       mr      r4,r1                   /* src:  current exception frame */
+       li      r5,INT_FRAME_SIZE/8     /* size: INT_FRAME_SIZE */
+       li      r6,0                    /* start offset: 0 */
+       mr      r1,r3                   /* Reroute the trampoline frame to r1 */
+       mtctr   r5
+2:     ldx     r0,r6,r4
+       stdx    r0,r6,r3
+       addi    r6,r6,8
+       bdnz    2b

Thanks
Tiejun
