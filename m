Return-Path: <clg@kaod.org>
Received: from 9.mo5.mail-out.ovh.net (9.mo5.mail-out.ovh.net [178.32.96.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40crM36WM1zDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:05:50 +1000 (AEST)
Received: from player714.ha.ovh.net (unknown [10.109.105.64])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id CE22B1A8538
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 13:27:03 +0200 (CEST)
Subject: Re: [PATCH 2/4] powerpc/xive: fix hcall H_INT_RESET to support long
 busy delays
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20180403071548.19829-1-clg@kaod.org>
 <20180403071548.19829-3-clg@kaod.org>
 <87efir8zyh.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f958b9d0-930a-d712-30ae-3d065cb0f0e0@kaod.org>
Date: Fri, 4 May 2018 13:27:01 +0200
MIME-Version: 1.0
In-Reply-To: <87efir8zyh.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2018 12:41 PM, Michael Ellerman wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
>> index 091f1d0d0af1..7113f5d87952 100644
>> --- a/arch/powerpc/sysdev/xive/spapr.c
>> +++ b/arch/powerpc/sysdev/xive/spapr.c
>> @@ -108,6 +109,52 @@ static void xive_irq_bitmap_free(int irq)
>>  	}
>>  }
>>  
>> +
>> +/* Based on the similar routines in RTAS */
>> +static unsigned int plpar_busy_delay_time(long rc)
>> +{
>> +	unsigned int ms = 0;
>> +
>> +	if (H_IS_LONG_BUSY(rc)) {
>> +		ms = get_longbusy_msecs(rc);
>> +	} else if (rc == H_BUSY) {
>> +		ms = 10; /* seems appropriate for XIVE hcalls */
>> +	}
>> +
>> +	return ms;
>> +}
>> +
>> +static unsigned int plpar_busy_delay(int rc)
>> +{
>> +	unsigned int ms;
>> +
>> +	might_sleep();
>> +	ms = plpar_busy_delay_time(rc);
>> +	if (ms && need_resched())
>> +		msleep(ms);
> 
> This is called from kexec shutdown isn't it?
> 
> In which case I don't think msleep() is a great idea.>> We could be crashing for example.

yes.

> An mdelay would be safer I think?

I agree but we would mdelay be OK ? The hcall can take up to 160ms.

Thanks,

C. 
