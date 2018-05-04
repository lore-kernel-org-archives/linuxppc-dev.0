Return-Path: <clg@kaod.org>
Received: from 15.mo5.mail-out.ovh.net (15.mo5.mail-out.ovh.net
 [178.33.107.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40cr0d2bcWzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 21:49:52 +1000 (AEST)
Received: from player714.ha.ovh.net (unknown [10.109.120.51])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 825871A862E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 13:49:49 +0200 (CEST)
Subject: Re: [PATCH 4/4] powerpc/xive: prepare all hcalls to support long busy
 delays
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20180403071548.19829-1-clg@kaod.org>
 <20180403071548.19829-5-clg@kaod.org>
 <87d0yb8zye.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2a986f3b-ba79-02ac-7a8a-298371f971ef@kaod.org>
Date: Fri, 4 May 2018 13:49:47 +0200
MIME-Version: 1.0
In-Reply-To: <87d0yb8zye.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2018 12:42 PM, Michael Ellerman wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> This is not the case for the moment, but future releases of pHyp might
>> need to introduce some synchronisation routines under the hood which
>> would make the XIVE hcalls longer to complete.
>>
>> As this was done for H_INT_RESET, let's wrap the other hcalls in a
>> loop catching the H_LONG_BUSY_* codes.
> 
> Are we sure it's safe to msleep() in all these paths?

Hmm. No. we could be under lock as these are called at the bottom of 
the stack of the irq layer. Should we use mdelay() then ?  

What about the rtas_busy_delay() in rtas.c ? I was wondering why we 
were using msleep() there also.

Thanks,

C.

> cheers
> 
>> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
>> index 7113f5d87952..97ea0a67a173 100644
>> --- a/arch/powerpc/sysdev/xive/spapr.c
>> +++ b/arch/powerpc/sysdev/xive/spapr.c
>> @@ -165,7 +165,10 @@ static long plpar_int_get_source_info(unsigned long flags,
>>  	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
>>  	long rc;
>>  
>> -	rc = plpar_hcall(H_INT_GET_SOURCE_INFO, retbuf, flags, lisn);
>> +	do {
>> +		rc = plpar_hcall(H_INT_GET_SOURCE_INFO, retbuf, flags, lisn);
>> +	} while (plpar_busy_delay(rc));
>> +
>>  	if (rc) {
>>  		pr_err("H_INT_GET_SOURCE_INFO lisn=%ld failed %ld\n", lisn, rc);
>>  		return rc;
>> @@ -198,8 +201,11 @@ static long plpar_int_set_source_config(unsigned long flags,
>>  		flags, lisn, target, prio, sw_irq);
>>  
>>  
>> -	rc = plpar_hcall_norets(H_INT_SET_SOURCE_CONFIG, flags, lisn,
>> -				target, prio, sw_irq);
>> +	do {
>> +		rc = plpar_hcall_norets(H_INT_SET_SOURCE_CONFIG, flags, lisn,
>> +					target, prio, sw_irq);
>> +	} while (plpar_busy_delay(rc));
>> +
>>  	if (rc) {
>>  		pr_err("H_INT_SET_SOURCE_CONFIG lisn=%ld target=%lx prio=%lx failed %ld\n",
>>  		       lisn, target, prio, rc);
>> @@ -218,7 +224,11 @@ static long plpar_int_get_queue_info(unsigned long flags,
>>  	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
>>  	long rc;
>>  
>> -	rc = plpar_hcall(H_INT_GET_QUEUE_INFO, retbuf, flags, target, priority);
>> +	do {
>> +		rc = plpar_hcall(H_INT_GET_QUEUE_INFO, retbuf, flags, target,
>> +				 priority);
>> +	} while (plpar_busy_delay(rc));
>> +
>>  	if (rc) {
>>  		pr_err("H_INT_GET_QUEUE_INFO cpu=%ld prio=%ld failed %ld\n",
>>  		       target, priority, rc);
>> @@ -247,8 +257,11 @@ static long plpar_int_set_queue_config(unsigned long flags,
>>  	pr_devel("H_INT_SET_QUEUE_CONFIG flags=%lx target=%lx priority=%lx qpage=%lx qsize=%lx\n",
>>  		flags,  target, priority, qpage, qsize);
>>  
>> -	rc = plpar_hcall_norets(H_INT_SET_QUEUE_CONFIG, flags, target,
>> -				priority, qpage, qsize);
>> +	do {
>> +		rc = plpar_hcall_norets(H_INT_SET_QUEUE_CONFIG, flags, target,
>> +					priority, qpage, qsize);
>> +	} while (plpar_busy_delay(rc));
>> +
>>  	if (rc) {
>>  		pr_err("H_INT_SET_QUEUE_CONFIG cpu=%ld prio=%ld qpage=%lx returned %ld\n",
>>  		       target, priority, qpage, rc);
>> @@ -262,7 +275,10 @@ static long plpar_int_sync(unsigned long flags, unsigned long lisn)
>>  {
>>  	long rc;
>>  
>> -	rc = plpar_hcall_norets(H_INT_SYNC, flags, lisn);
>> +	do {
>> +		rc = plpar_hcall_norets(H_INT_SYNC, flags, lisn);
>> +	} while (plpar_busy_delay(rc));
>> +
>>  	if (rc) {
>>  		pr_err("H_INT_SYNC lisn=%ld returned %ld\n", lisn, rc);
>>  		return  rc;
>> @@ -285,7 +301,11 @@ static long plpar_int_esb(unsigned long flags,
>>  	pr_devel("H_INT_ESB flags=%lx lisn=%lx offset=%lx in=%lx\n",
>>  		flags,  lisn, offset, in_data);
>>  
>> -	rc = plpar_hcall(H_INT_ESB, retbuf, flags, lisn, offset, in_data);
>> +	do {
>> +		rc = plpar_hcall(H_INT_ESB, retbuf, flags, lisn, offset,
>> +				 in_data);
>> +	} while (plpar_busy_delay(rc));
>> +
>>  	if (rc) {
>>  		pr_err("H_INT_ESB lisn=%ld offset=%ld returned %ld\n",
>>  		       lisn, offset, rc);
>> -- 
>> 2.13.6
