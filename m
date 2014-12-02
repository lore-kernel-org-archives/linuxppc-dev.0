Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 590CF1A018F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 20:01:53 +1100 (AEDT)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BA98C1402B2
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 20:01:50 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 2 Dec 2014 14:31:45 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 12463E0045
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2014 14:32:11 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB291rxl29425918
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2014 14:31:54 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB291dhW028997
 for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2014 14:31:39 +0530
Message-ID: <547D7FF2.3010901@linux.vnet.ibm.com>
Date: Tue, 02 Dec 2014 14:31:38 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/book3s: Fix flush_tlb cpu_spec hook to take a generic
 argument.
References: <20141128223838.B21E51401B1@ozlabs.org>
In-Reply-To: <20141128223838.B21E51401B1@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/29/2014 04:08 AM, Michael Ellerman wrote:
> On Tue, 2014-23-09 at 03:53:54 UTC, Mahesh Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> The flush_tlb hook in cpu_spec was introduced as a generic function hook
>> to invalidate TLBs. But the current implementation of flush_tlb hook
>> takes IS (invalidation selector) as an argument which is architecture
>> dependent. Hence, It is not right to have a generic routine where caller
>> has to pass non-generic argument.
>>
>> This patch fixes this and makes flush_tlb hook as high level API.
>>
>> The old code used to call flush_tlb hook with IS=0 (single page) resulting
>> partial invalidation of TLBs which is not right. This fix now makes
>> sure that whole TLB is invalidated to be able to successfully recover from
>> TLB and ERAT errors.
> 
> Which old code? You mean the MCE code I think. That's a bug fix, so it should
> be a separate patch.

Yes. MCE code. Since this patch re-factors the code that takes IS as
direct argument, having a separate fix patch does not make any sense and
would get overwritten by this patch anyway.

> 
>> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
>> index daa5af9..ae3e74f 100644
>> --- a/arch/powerpc/include/asm/cputable.h
>> +++ b/arch/powerpc/include/asm/cputable.h
>> @@ -100,7 +100,7 @@ struct cpu_spec {
>>  	/*
>>  	 * Processor specific routine to flush tlbs.
>>  	 */
>> -	void		(*flush_tlb)(unsigned long inval_selector);
>> +	void		(*flush_tlb)(unsigned int action);
>>  
>>  };
>>  
>> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
>> index d765144..068ac8b 100644
>> --- a/arch/powerpc/include/asm/mmu-hash64.h
>> +++ b/arch/powerpc/include/asm/mmu-hash64.h
>> @@ -112,6 +112,11 @@
>>  #define TLBIEL_INVAL_SET_SHIFT	12
>>  
>>  #define POWER7_TLB_SETS		128	/* # sets in POWER7 TLB */
>> +#define POWER8_TLB_SETS		512	/* # sets in POWER8 TLB */
>> +
>> +/* TLB flush actions. Used as argument to cpu_spec.flush_tlb() hook */
>> +#define FLUSH_TLB_ALL		0	/* invalidate all TLBs */
>> +#define FLUSH_TLB_LPID		1	/* invalidate TLBs for current LPID */
> 
> Now that these are generic actions then they should go in cputable.h with the
> flush hook.

Sure, I will move them.

> 
>> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
>> index 4673353..9c9b741 100644
>> --- a/arch/powerpc/kernel/cpu_setup_power.S
>> +++ b/arch/powerpc/kernel/cpu_setup_power.S
>> @@ -137,15 +137,11 @@ __init_HFSCR:
>>  /*
>>   * Clear the TLB using the specified IS form of tlbiel instruction
>>   * (invalidate by congruence class). P7 has 128 CCs., P8 has 512.
>> - *
>> - * r3 = IS field
>>   */
>>  __init_tlb_power7:
>> -	li	r3,0xc00	/* IS field = 0b11 */
>> -_GLOBAL(__flush_tlb_power7)
>>  	li	r6,128
>>  	mtctr	r6
>> -	mr	r7,r3		/* IS field */
>> +	li	r7,0xc00	/* IS field = 0b11 */
>>  	ptesync
>>  2:	tlbiel	r7
>>  	addi	r7,r7,0x1000
> 
> So the current version is:
> 
> _GLOBAL(__flush_tlb_power7)
> 	li	r6,128
> 	mtctr	r6
> 	mr	r7,r3		/* IS field */
> 	ptesync
> 2:	tlbiel	r7
> 	addi	r7,r7,0x1000
> 	bdnz	2b
> 	ptesync
> 1:	blr
> 
> ie. a loop preceeded and followed by ptesync.
> 
> Your new version is:
> 
>> +static void _flush_tlb(uint32_t tlb_set, unsigned long inval_selector)
>> +{
>> +	unsigned long i, rb;
>> +
>> +	rb = inval_selector;
>> +	for (i = 0; i < tlb_set; i++) {
>> +		asm volatile("tlbiel %0" : : "r" (rb));
>> +		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
>> +	}
>> +}
> 
> ie. no ptesyncs at all.
> 
> But there's no mention of that in the changelog. You need to explain why it is
> OK to drop the ptesyncs.

You are right. I should put ptesyncs in _flush_tlb(). Will make this
change in v2. Thanks for catching this.

> 
>> +/*
>> + * Generic routine to flush TLB on power7. This routine is used as
>> + * flush_tlb hook in cpu_spec for Power7 processor.
>> + *
>> + * action => FLUSH_TLB_ALL:  Invalidate all TLBs.
>> + *	     FLUSH_TLB_LPID: Invalidate TLB for current LPID.
>> + */
>> +void __flush_tlb_power7(unsigned int action)
>> +{
>> +	switch (action) {
>> +	case FLUSH_TLB_ALL:
>> +		_flush_tlb(POWER7_TLB_SETS, TLBIEL_INVAL_SET);
>> +		break;
>> +	case FLUSH_TLB_LPID:
>> +		_flush_tlb(POWER7_TLB_SETS, TLBIEL_INVAL_SET_LPID);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
>> +
>> +/*
>> + * Generic routine to flush TLB on power8. This routine is used as
>> + * flush_tlb hook in cpu_spec for power8 processor.
>> + *
>> + * action => FLUSH_TLB_ALL:  Invalidate all TLBs.
>> + *	     FLUSH_TLB_LPID: Invalidate TLB for current LPID.
>> + */
>> +void __flush_tlb_power8(unsigned int action)
>> +{
>> +	switch (action) {
>> +	case FLUSH_TLB_ALL:
>> +		_flush_tlb(POWER8_TLB_SETS, TLBIEL_INVAL_SET);
>> +		break;
>> +	case FLUSH_TLB_LPID:
>> +		_flush_tlb(POWER8_TLB_SETS, TLBIEL_INVAL_SET_LPID);
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
> 
> How about this:
> 
> void flush_tlb_206(unsigned num_sets, unsigned int action)
> {
> 	unsigned long rb;
> 	int i;
> 
> 	switch (action) {
> 	case FLUSH_TLB_ALL:
> 		rb = TLBIEL_INVAL_SET;
> 		break;
> 	case FLUSH_TLB_LPID:
> 		rb = TLBIEL_INVAL_SET_LPID;
> 		break;
> 	default:
> 		BUG();
> 	}
> 
> 	for (i = 0; i < num_sets; i++) {
> 		asm volatile("tlbiel %0" : : "r" (rb));
> 		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
> 	}
> }
> 
> void flush_tlb_power8(unsigned int action)
> {
> 	flush_tlb_206(POWER8_TLB_SETS, action);
> }
> 
> void flush_tlb_power7(unsigned int action)
> {
> 	flush_tlb_206(POWER7_TLB_SETS, action);
> }
> 

Agree. Will roll out v2 with above suggested changes.

Thanks,
-Mahesh.
