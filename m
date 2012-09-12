Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 520862C0080
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 18:38:33 +1000 (EST)
Message-ID: <505049FE.8060204@windriver.com>
Date: Wed, 12 Sep 2012 16:38:22 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [v3][PATCH 2/3] ppc/kprobe: complete kprobe and migrate exception
 frame
References: <1347330053-27039-1-git-send-email-tiejun.chen@windriver.com>
 <1347330053-27039-2-git-send-email-tiejun.chen@windriver.com>
 <1347342718.2603.38.camel@pasglop>
In-Reply-To: <1347342718.2603.38.camel@pasglop>
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

On 09/11/2012 01:51 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2012-09-11 at 10:20 +0800, Tiejun Chen wrote:
>> We can't emulate stwu since that may corrupt current exception stack.
>> So we will have to do real store operation in the exception return code.
>>
>> Firstly we'll allocate a trampoline exception frame below the kprobed
>> function stack and copy the current exception frame to the trampoline.
>> Then we can do this real store operation to implement 'stwu', and reroute
>> the trampoline frame to r1 to complete this exception migration.
>
> Ok, so not quite there yet :-)
>
> See below:
>
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>>   arch/powerpc/kernel/entry_32.S |   45 ++++++++++++++++++++++++++++++++++------
>>   arch/powerpc/kernel/entry_64.S |   32 ++++++++++++++++++++++++++++
>>   2 files changed, 71 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
>> index ead5016..6cfe12f 100644
>> --- a/arch/powerpc/kernel/entry_32.S
>> +++ b/arch/powerpc/kernel/entry_32.S
>> @@ -831,19 +831,54 @@ restore_user:
>>   	bnel-	load_dbcr0
>>   #endif
>>
>> -#ifdef CONFIG_PREEMPT
>>   	b	restore
>>
>>   /* N.B. the only way to get here is from the beq following ret_from_except. */
>>   resume_kernel:
>> +	/* check current_thread_info, _TIF_EMULATE_STACK_STORE */
>> +	CURRENT_THREAD_INFO(r9, r1)
>> +	lwz	r0,TI_FLAGS(r9)
>> +	andis.	r0,r0,_TIF_EMULATE_STACK_STORE@h
>> +	beq+	1f
>
> So you used r0 to load the TI_FLAGS and immediately clobbered it in
> andis. forcing you to re-load them later down. Instead, put them in r8
>
> 	lwz	r8,TI_FLAGS(r9)
> 	andis.	r0,r8,_TIF_*
> 	beq+	*
>
>> +	addi	r8,r1,INT_FRAME_SIZE	/* Get the kprobed function entry */
>
> Then you put your entry in r8 ....

I'll update this for 32b and 64b sections.

>
>> +	lwz	r3,GPR1(r1)
>> +	subi	r3,r3,INT_FRAME_SIZE	/* dst: Allocate a trampoline exception frame */
>> +	mr	r4,r1			/* src:  current exception frame */
>> +	li	r5,INT_FRAME_SIZE	/* size: INT_FRAME_SIZE */
>> +	mr	r1,r3			/* Reroute the trampoline frame to r1 */
>> +	bl	memcpy			/* Copy from the original to the trampoline */
>
> Which you just clobbered... oops :-)
>
> So you need to store that old r1 somewhere fist then retrieve it
> after the memcpy call. That or open-code the memcpy to avoid all
> the clobbering problems.

Maybe we can use copy_and_flush() since looks copy_and_flush() only clobber r0, 
r6 and LR explicitly.

I'll resync these comments for v4.

Tiejun
