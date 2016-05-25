Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDwvK2X4szDqM1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 12:19:09 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 25 May 2016 12:19:06 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F2BD32CE806F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 12:18:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4P2IQr940304664
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 12:18:29 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4P2HTUF011241
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 12:17:29 +1000
Message-ID: <57450B0A.8080309@linux.vnet.ibm.com>
Date: Wed, 25 May 2016 07:46:42 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: ego@linux.vnet.ibm.com
CC: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [PATCH v3 7/9] powerpc/powernv: Add platform support for stop
 instruction
References: <1464016722-7488-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464016722-7488-8-git-send-email-shreyas@linux.vnet.ibm.com>
 <20160524102449.GE12860@in.ibm.com>
In-Reply-To: <20160524102449.GE12860@in.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/24/2016 03:54 PM, Gautham R Shenoy wrote:
> Hi Shreyas,
> 
> On Mon, May 23, 2016 at 08:48:40PM +0530, Shreyas B. Prabhu wrote:
>> @@ -412,7 +517,8 @@ subcore_state_restored:
>>  first_thread_in_core:
>>
>>  	/*
>> -	 * First thread in the core waking up from fastsleep. It needs to
>> +	 * First thread in the core waking up from any state which can cause
>> +	 * partial or complete hypervisor state loss. It needs to
>>  	 * call the fastsleep workaround code if the platform requires it.
>>  	 * Call it unconditionally here. The below branch instruction will
>>  	 * be patched out when the idle states are discovered if platform
> 
> Please update the comment to 
> 
> "The below branch instruction will be patched out if the platform does
> not have fastsleep or does not require the workaround. Patching will
> be performed during the discovery of idle-states."

I've updated this in v4.
> 
>> @@ -423,8 +529,10 @@ pnv_fastsleep_workaround_at_exit:
>>  	b	fastsleep_workaround_at_exit
>>
>>  timebase_resync:
>> -	/* Do timebase resync if we are waking up from sleep. Use cr3 value
>> -	 * set in exceptions-64s.S */
>> +	/*
>> +	 * Use cr3 which indicates that we are waking up with atleast partial
>> +	 * hypervisor state loss to determine if TIMEBASE RESYNC is needed.
>> +	 */
>>  	ble	cr3,clear_lock
>>  	/* Time base re-sync */
>>  	li	r0,OPAL_RESYNC_TIMEBASE
> 
> 
> [..snip..]
>> @@ -264,6 +275,32 @@ static int __init pnv_init_idle_states(void)
>>  		goto out_free;
>>  	}
>>
>> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
>> +		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
>> +					GFP_KERNEL);
>> +		if (!psscr_val)
>> +			goto out_free;
>> +		if (of_property_read_u64_array(power_mgt,
>> +			"ibm,cpu-idle-state-psscr",
>> +			psscr_val, dt_idle_states)) {
>> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
>> +			goto out_free_psscr;
>> +		}
>> +
>> +		/*
>> +		 * Set pnv_first_deep_stop_state to the first stop level
>> +		 * to cause hypervisor state loss
>> +		 */
>> +		pnv_first_deep_stop_state = 0xF;
>   		
> #define MAX_STOP_STATES	0xF ?

I changed this to MAX_POSSIBLE_STOP_STATE since 0xF is the max possible
stop state allowed by the ISA.

Thanks for the review,

-Shreyas
