Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8lf61P31zDq9n
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 17:08:13 +1000 (AEST)
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 18 May 2016 12:38:11 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 612CAE0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 12:41:20 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4I788jS14942292
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 12:38:08 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4I784Ww011890
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 12:38:07 +0530
Message-ID: <573C14CC.20307@linux.vnet.ibm.com>
Date: Wed, 18 May 2016 12:37:56 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: ego@linux.vnet.ibm.com
CC: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [PATCH v2 2/9] powerpc/kvm: make hypervisor state restore a
 function
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1462263878-25237-3-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160518062542.GB3939@in.ibm.com>
In-Reply-To: <20160518062542.GB3939@in.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gautham,

On 05/18/2016 11:55 AM, Gautham R Shenoy wrote:
> Hi Shreyas,
> 
> On Tue, May 03, 2016 at 01:54:31PM +0530, Shreyas B. Prabhu wrote:
>> In the current code, when the thread wakes up in reset vector, some
>> of the state restore code and check for whether a thread needs to
>> branch to kvm is duplicated. Reorder the code such that this
>> duplication is avoided.
>>
>> At a higher level this is what the change looks like-
> 
> I have manually verified that the code flow in the new patch is has
> the same effect as whatever we were doing earlier. There a couple of
> comments inline.
> 
Thanks for the review!

>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>> index 7716ceb..7ebfbb0 100644
>> --- a/arch/powerpc/kernel/exceptions-64s.S
>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>> @@ -107,25 +107,8 @@ BEGIN_FTR_SECTION
>>  	beq	9f
>>
>>  	cmpwi	cr3,r13,2
>> +	bl	power7_restore_hyp_resource
>>
>> -	/*
>> -	 * Check if last bit of HSPGR0 is set. This indicates whether we are
>> -	 * waking up from winkle.
>> -	 */
>> -	GET_PACA(r13)
>> -	clrldi	r5,r13,63
>> -	clrrdi	r13,r13,1
>> -	cmpwi	cr4,r5,1
>> -	mtspr	SPRN_HSPRG0,r13
>> -
>> -	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
>> -	cmpwi   cr2,r0,PNV_THREAD_NAP
>> -	bgt     cr2,8f				/* Either sleep or Winkle */
>> -
>> -	/* Waking up from nap should not cause hypervisor state loss */
>> -	bgt	cr3,.
>> -
>> -	/* Waking up from nap */
>>  	li	r0,PNV_THREAD_RUNNING
>>  	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
>>
>> @@ -143,13 +126,9 @@ BEGIN_FTR_SECTION
>>
>>  	/* Return SRR1 from power7_nap() */
>>  	mfspr	r3,SPRN_SRR1
>> -	beq	cr3,2f
>> -	b	power7_wakeup_noloss
>> -2:	b	power7_wakeup_loss
>> -
>> -	/* Fast Sleep wakeup on PowerNV */
>> -8:	GET_PACA(r13)
> 
> In the old code, we do a GET_PACA(r13) before invoking the
> power7_wakeup_tb_loss. In the new code we don't. Can you explain
> this omission ?

GET_PACA(13) is the called in the beginning of
power7_restore_hyp_resource. So r13 contains pointer to PACA when
power7_wakeup_tb_loss invoked later in the same function.
> 
> 
> [..snip..]
> 
>> @@ -420,33 +451,9 @@ common_exit:
>>
>>  hypervisor_state_restored:
>>
>> -	li	r5,PNV_THREAD_RUNNING
>> -	stb     r5,PACA_THREAD_IDLE_STATE(r13)
>> -
>>  	mtspr	SPRN_SRR1,r16
>> -#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>> -	li      r0,KVM_HWTHREAD_IN_KERNEL
>> -	stb     r0,HSTATE_HWTHREAD_STATE(r13)
>> -	/* Order setting hwthread_state vs. testing hwthread_req */
>> -	sync
>> -	lbz     r0,HSTATE_HWTHREAD_REQ(r13)
>> -	cmpwi   r0,0
>> -	beq     6f
>> -	b       kvm_start_guest
>> -6:
>> -#endif
>> -
>> -	REST_NVGPRS(r1)
>> -	REST_GPR(2, r1)
>> -	ld	r3,_CCR(r1)
>> -	ld	r4,_MSR(r1)
>> -	ld	r5,_NIP(r1)
>> -	addi	r1,r1,INT_FRAME_SIZE
>> -	mtcr	r3
>> -	mfspr	r3,SPRN_SRR1		/* Return SRR1 */
>> -	mtspr	SPRN_SRR1,r4
>> -	mtspr	SPRN_SRR0,r5
>> -	rfid
>> +	mtlr	r17
>> +	blr
> 
> 
> Perhaps you could add a comment against this blr to indicate that we
> go back to the reset vector right after the call to
> power7_restore_hyp_resource. 

Ok. I'll do that.
> 
>>
>>  fastsleep_workaround_at_exit:
>>  	li	r3,1
>> -- 
>> 2.4.11
>>
