Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 324C92C00A2
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Dec 2013 14:52:16 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 24 Dec 2013 09:22:12 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4709F394002D
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Dec 2013 09:22:09 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBO3q6Mu2031958
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Dec 2013 09:22:06 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBO3q7kT018410
 for <linuxppc-dev@ozlabs.org>; Tue, 24 Dec 2013 09:22:08 +0530
Message-ID: <52B9049D.4020403@linux.vnet.ibm.com>
Date: Tue, 24 Dec 2013 09:20:53 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH V4 08/10] powerpc, perf: Enable SW filtering in branch
 stack sampling framework
References: <20131209062146.EABBE2C00C1@ozlabs.org>
 <52B42394.4060705@linux.vnet.ibm.com> <1387855790.15093.1.camel@concordia>
In-Reply-To: <1387855790.15093.1.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
 eranian@google.com, linuxppc-dev@ozlabs.org, acme@ghostprotocols.net,
 sukadev@linux.vnet.ibm.com, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/24/2013 08:59 AM, Michael Ellerman wrote:
> On Fri, 2013-12-20 at 16:31 +0530, Anshuman Khandual wrote:
>> On 12/09/2013 11:51 AM, Michael Ellerman wrote:
>>> On Wed, 2013-04-12 at 10:32:40 UTC, Anshuman Khandual wrote:
>>>> +
>>>> +	if (bhrb_sw_filter & PERF_SAMPLE_BRANCH_IND_CALL) {
>>>> +		/* XL-form instruction */
>>>> +		if (instr_is_branch_xlform(*addr)) {
>>>> +
>>>> +			/* LR should be set */
>>>> +			if (is_branch_link_set(*addr)) {
>>>> +				/*
>>>> +			 	 * Conditional and unconditional
>>>> +			 	 * branch to CTR.
>>>> +			 	 */
>>>> +				if (is_xlform_ctr(*addr))
>>>> +					result = true;
>>>> +
>>>> +				/*
>>>> +			 	 * Conditional and unconditional
>>>> +			 	 * branch to LR.
>>>> +			 	 */
>>>> +				if (is_xlform_lr(*addr))
>>>> +					result = true;
>>>> +
>>>> +				/*
>>>> +			 	 * Conditional and unconditional
>>>> +			 	 * branch to TAR.
>>>> +			 	 */
>>>> +				if (is_xlform_tar(*addr))
>>>> +					result = true;
>>>
>>> What other kind of XL-Form branch is there?
>>
>> I am not sure. Do you know of any ?
> 
> That was my point. There are no other types, so you can just do:
> 
> 	if (bhrb_sw_filter & PERF_SAMPLE_BRANCH_IND_CALL)
> 		if (instr_is_branch_xlform(*addr) && is_branch_link_set(*addr))
> 			return true;
> 

Done

>>>> +	if (bhrb_sw_filter & PERF_SAMPLE_BRANCH_COND) {
>>>> +
>>>> +		/* I-form instruction - excluded */
>>>> +		if (instr_is_branch_iform(*addr))
>>>> +			goto out;
>>>> +
>>>> +		/* B-form or XL-form instruction */
>>>> +		if (instr_is_branch_bform(*addr) || instr_is_branch_xlform(*addr))  {
>>>> +
>>>> +			/* Not branch always  */
>>>> +			if (!is_bo_always(*addr)) {
>>>> +
>>>> +				/* Conditional branch to CTR register */
>>>> +				if (is_bo_ctr(*addr))
>>>> +					goto out;
>>>
>>> We might have discussed this but why not?
>>
>> Did not get that, discuss what ?
> 
> Why are we saying a conditional branch to the CTR is not a conditional branch?
> 
> It is conditional, so I think it should be included.
> 

I believe conditional branch to CTR register and the below conditional branch
with static hint are excluded when processed with BHRB PMU based filter IFM3,
Here the SW implemented filter try to match those exclusions, so that a user
should not see any difference in results whether the filter is processed
either in PMU or in SW.

>>>> +
>>>> +				/* CR[BI] conditional branch with static hint */
>>>
>>> A conditional branch with a static hint is still a conditional branch?
>>
>> No its not. 
> 
> Yes it is?
> 
> In fact they could be very interesting branches. Because the compiler or
> programmer has statically hinted them, if the hint is wrong they may be a major
> source of branch midpredicts.
> 
> 
>>>> +				if (is_bo_crbi_off(*addr) || is_bo_crbi_on(*addr)) {
>>>> +					if (is_bo_crbi_hint(*addr))
>>>> +						goto out;
>>>> +				}
>>>> +
>>>> +				result = true;
>>>> +			}
>>>> +		}
>>>> +	}
>>>> +out:
>>>> +	return result;
>>>> +}
> 
>>>> +	} else {
>>>> +		/*
>>>> +		 * Userspace address needs to be
>>>> +		 * copied first before analysis.
>>>> +		 */
>>>> +		pagefault_disable();
>>>> +		ret =  __get_user_inatomic(instr, (unsigned int __user *)addr);
>>>
>>> I suspect you borrowed this incantation from the callchain code. Unlike that
>>> code you don't fallback to reading the page tables directly.
>>>
>>> I'd rather see the accessor in the callchain code made generic and have you
>>> call it here.
>>
>> You have mentioned to take care of this issue yourself.
> 
> Yes I will.

Thanks !!
