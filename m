Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm1Vg6wzVzDr5c
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 14:20:11 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u684J4Lu030906
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 00:20:09 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2415xnd3gg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 00:20:09 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 8 Jul 2016 09:50:05 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 92B74394004E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 09:50:03 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u684IvaR11731448
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 09:48:57 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u684K1qf021868
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 09:50:02 +0530
Date: Fri, 08 Jul 2016 09:49:59 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
CC: benh@au1.ibm.com, paulus@ozlabs.org, ego@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com
Subject: Re: [PATCH v7 07/11] powerpc/powernv: Add platform support for stop
 instruction
References: <1467924432-29003-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1467924432-29003-8-git-send-email-shreyas@linux.vnet.ibm.com>
 <1467944442.27479.155.camel@neuling.org>
In-Reply-To: <1467944442.27479.155.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <577F29EF.9090405@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/08/2016 07:50 AM, Michael Neuling wrote:
> 
>> diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
>> index d2f99ca..3d7fc06 100644
>> --- a/arch/powerpc/include/asm/cpuidle.h
>> +++ b/arch/powerpc/include/asm/cpuidle.h
>> @@ -13,6 +13,8 @@
>>  #ifndef __ASSEMBLY__
>>  extern u32 pnv_fastsleep_workaround_at_entry[];
>>  extern u32 pnv_fastsleep_workaround_at_exit[];
>> +
>> +extern u64 pnv_first_deep_stop_state;
> 
> mpe asked a question about this which you neither answered or addressed.
> "Should this have some safe initial value?"
> 
> I'm thinking we could do this which is what you have in the init call.
>    u64 pnv_first_deep_stop_state = MAX_STOP_STATE;
> 

I missed the comment. I'll make the change.
> 
>> @@ -439,7 +540,18 @@ timebase_resync:
>>  	 */
>>  	bne	cr4,clear_lock
>>  
>> -	/* Restore per core state */
>> +	/*
>> +	 * First thread in the core to wake up and its waking up with
>> +	 * complete hypervisor state loss. Restore per core hypervisor
>> +	 * state.
>> +	 */
>> +BEGIN_FTR_SECTION
>> +	ld	r4,_PTCR(r1)
>> +	mtspr	SPRN_PTCR,r4
>> +	ld	r4,_RPR(r1)
>> +	mtspr	SPRN_RPR,r4
> 
> RPR looks wrong here.  This should be on POWER8 too.
> 
> This has changed since v6 and not noted in the v7 comments.  Why are you
> changing this now?
> 
RPR is a per-core resource in P9. So with this patch, RPR will continue
to be restored per-subcore in P8 and will restored once per core in P9.

>> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>> +
>>  	ld	r4,_TSCR(r1)
>>  	mtspr	SPRN_TSCR,r4
>>  	ld	r4,_WORC(r1)
>> @@ -461,9 +573,7 @@ common_exit:
>>  
>>  	/* Waking up from winkle */
>>  
>> -	/* Restore per thread state */
>> -	bl	__restore_cpu_power8
>> -
>> +BEGIN_MMU_FTR_SECTION
>>  	/* Restore SLB  from PACA */
>>  	ld	r8,PACA_SLBSHADOWPTR(r13)
>>  
>> @@ -477,6 +587,9 @@ common_exit:
>>  	slbmte	r6,r5
>>  1:	addi	r8,r8,16
>>  	.endr
>> +END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
>> +
>> +	/* Restore per thread state */
> 
> This FTR section is too big  It ends up at 25 instructions with the loop.
> Probably better like this:
> 
> BEGIN_MMU_FTR_SECTION
> 	b	no_segments
> END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
> 	/* Restore SLB  from PACA */
> 	ld	r8,PACA_SLBSHADOWPTR(r13)
> 
> 	.rept	SLB_NUM_BOLTED
> 	li	r3, SLBSHADOW_SAVEAREA
> 	LDX_BE	r5, r8, r3
> 	addi	r3, r3, 8
> 	LDX_BE	r6, r8, r3
> 	andis.	r7,r5,SLB_ESID_V@h
> 	beq	1f
> 	slbmte	r6,r5
> 1:	addi	r8,r8,16
> 	.endr
> 
> no_segments:
> 
Cool. Will make the change.

Thanks,
Shreyas
