Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FFBD1A0F8C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 16:28:31 +1100 (AEDT)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 8 Jan 2015 15:28:27 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id CE75F2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 16:28:25 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t085SOiM48234556
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jan 2015 16:28:25 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t085SOHi020566
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jan 2015 16:28:24 +1100
Received: from [9.124.35.103] (mars.in.ibm.com [9.124.35.103] (may be forged))
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 t085SDf5020360
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Jan 2015 16:28:23 +1100
Message-ID: <54AE156B.1000907@linux.vnet.ibm.com>
Date: Thu, 08 Jan 2015 10:58:11 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/book3s: Fix the MCE code to use
 CONFIG_KVM_BOOK3S_HV_POSSIBLE
References: <20150107044237.5803.85825.stgit@mars.in.ibm.com>
 <87iogjovit.fsf@linux.vnet.ibm.com>
In-Reply-To: <87iogjovit.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/07/2015 01:46 PM, Aneesh Kumar K.V wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> commit id 9975f5e added new config variable CONFIG_KVM_BOOK3S_HV_POSSIBLE
>> that helps to select the relevant code in the kernel when HV and PR
>> bits are built as separate modules. As part of that commit, all the
>> instances of #ifdef CONFIG_KVM_BOOK3S_64_HV was replaced with
>> CONFIG_KVM_BOOK3S_HV_POSSIBLE. But the MCE code still depends on
>> CONFIG_KVM_BOOK3S_64_HV which is wrong. When HV bits are built as a
>> separate module the relevent MCE code gets excluded. This patch fixes
>> the MCE code to use CONFIG_KVM_BOOK3S_HV_POSSIBLE.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/exceptions-64s.S |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
>> index c2df815..7335857 100644
>> --- a/arch/powerpc/kernel/exceptions-64s.S
>> +++ b/arch/powerpc/kernel/exceptions-64s.S
>> @@ -1408,7 +1408,7 @@ machine_check_handle_early:
>>  	bne	9f			/* continue in V mode if we are. */
>>
>>  5:
>> -#ifdef CONFIG_KVM_BOOK3S_64_HV
>> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>>  	/*
>>  	 * We are coming from kernel context. Check if we are coming from
>>  	 * guest. if yes, then we can continue. We will fall through
> 
> Do we also need to update the HSTATE_IN_GUEST check to avoid checking
> the PR guest mode ?ie, 

Not required. If we are coming from guest (HSTATE_IN_GUEST != 0) we fall
through do_kvm_200->kvmppc_interrupt and for PR guest it would lead us
to kvmppc_interrupt_pr which will inject MCE in PR guest.

Having said that I just realized that I should use #ifdef
CONFIG_KVM_BOOK3S_64_HANDLER instead. The check holds good for both HV
and PR guests.

Thanks,
-Mahesh.

> 
> 	lbz	r11,HSTATE_IN_GUEST(r13)
> 	cmpwi	r11,0			/* Check if coming from guest */
> 
> checking for 0 is what you want there ?
> 
> -aneesh
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
