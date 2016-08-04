Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4pYb6sdwzDqS9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 22:05:55 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s4pYb3JlYz9t0q
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 22:05:55 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u74C4J79070588
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 08:05:53 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkaj8s9x-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 04 Aug 2016 08:05:53 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 4 Aug 2016 22:05:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4AAC52CE8056
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Aug 2016 22:05:47 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u74C5l4422937758
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 22:05:47 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u74C5krX029030
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Aug 2016 22:05:47 +1000
Subject: Re: [PATCH] powerpc/book3s: Fix MCE console messages for
 unrecoverable MCE.
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <147028600879.16761.7577655191376075114.stgit@jupiter.in.ibm.com>
 <87bn18g8l9.fsf@concordia.ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 4 Aug 2016 17:35:45 +0530
MIME-Version: 1.0
In-Reply-To: <87bn18g8l9.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <3ad321e8-0cbd-1b23-0152-e70cda4815f0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2016 03:27 PM, Michael Ellerman wrote:
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> When machine check occurs with MSR(RI=0), it means MC interrupt is
>> unrecoverable and kernel goes down to panic path. But the console
>> message still shows it as recovered. This patch fixes the MCE console
>> messages.
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/mce.c             |    3 ++-
>>  arch/powerpc/platforms/powernv/opal.c |    2 ++
>>  2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
>> index ef267fd..5e7ece0 100644
>> --- a/arch/powerpc/kernel/mce.c
>> +++ b/arch/powerpc/kernel/mce.c
>> @@ -92,7 +92,8 @@ void save_mce_event(struct pt_regs *regs, long handled,
>>  	mce->in_use = 1;
>>  
>>  	mce->initiator = MCE_INITIATOR_CPU;
>> -	if (handled)
>> +	/* Mark it recovered if we have handled it and MSR(RI=1). */
>> +	if (handled && (regs->msr & MSR_RI))
>>  		mce->disposition = MCE_DISPOSITION_RECOVERED;
> 
> This seems like it has bigger implications than just changing the
> printk output? We're now (correctly) marking any MC where RI=0 as
> unrecoverable.
> 
> Or is the only place that uses this the code below which *also* checks
> MSR_RI?

We would always check MSR_RI at code below and panic correctly. It was
just that we were always printing it as recovered and then panic.

> 
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 5385434..8154171 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -401,6 +401,8 @@ static int opal_recover_mce(struct pt_regs *regs,
>>  
>>  	if (!(regs->msr & MSR_RI)) {
>>  		/* If MSR_RI isn't set, we cannot recover */
> 
> Why do we check MSR_RI again here? Shouldn't we just be looking at the evt->disposition?

When MSR_RI=0, where SRR0/SRR1 registers values have been thrashed,
kernel can not continue reliably if we return from interrupt. It should
definitely go down to panic path. Hence we check for RI=0 and return 0.
Where as, if MSR_RI=1 and disposition is "unrecovered", we can minimise
the damage to user process if this MCE was hit in user space context.

The print is just to tell that the kernel panic'ed because MCE occured
during a rare window where MSR RI bit was set to zero(0) and not that
handler could not fix the error.

> 
>> +		printk(KERN_ERR "Machine check interrupt unrecoverable:"
>> +				" MSR(RI=0)\n");
> 
> Are we sure it's safe to call printk() there?

Yes, we had just printed MCE event info before we came here.

> 
> Please don't split the message across lines, and use pr_err() like the
> rest of the code in this file. So it would be:
> 
> 		pr_err("Machine check interrupt unrecoverable: MSR(RI=0)\n");

Sure. Will make the change.

> 
>>  		recovered = 0;
>>  	} else if (evt->disposition == MCE_DISPOSITION_RECOVERED) {
>>  		/* Platform corrected itself */
> 
> cheers
> 
