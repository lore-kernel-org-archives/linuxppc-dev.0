Return-Path: <clg@kaod.org>
Received: from 14.mo7.mail-out.ovh.net (14.mo7.mail-out.ovh.net
 [178.33.251.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40crDR0zL1zDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 22:00:06 +1000 (AEST)
Received: from player714.ha.ovh.net (unknown [10.109.105.118])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id ECD01A5BBC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2018 13:42:35 +0200 (CEST)
Subject: Re: [PATCH 3/4] powerpc/xive: shutdown XIVE when kexec or kdump is
 performed
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20180403071548.19829-1-clg@kaod.org>
 <20180403071548.19829-4-clg@kaod.org>
 <87bmdv8zy9.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7553a1d1-1de0-5dfe-a666-26aef6d4e169@kaod.org>
Date: Fri, 4 May 2018 13:42:33 +0200
MIME-Version: 1.0
In-Reply-To: <87bmdv8zy9.fsf@concordia.ellerman.id.au>
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
>> The hcall H_INT_RESET should be called to make sure XIVE is fully
>> reseted.
>>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>  arch/powerpc/platforms/pseries/kexec.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
>> index eeb13429d685..1d9bbf8e7357 100644
>> --- a/arch/powerpc/platforms/pseries/kexec.c
>> +++ b/arch/powerpc/platforms/pseries/kexec.c
>> @@ -52,8 +52,11 @@ void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
>>  		}
>>  	}
>>  
>> -	if (xive_enabled())
>> +	if (xive_enabled()) {
>>  		xive_kexec_teardown_cpu(secondary);
>> -	else
>> +
>> +		if (!secondary)
>> +			xive_shutdown();
> 
> Couldn't that logic go in xive_kexec_teardown_cpu()?

On powernv, we wait for the secondaries to reach OPAL before doing a 
XIVE shutdown. This is another kexec barrier but it is after the 
KEXEC_STATE_REAL_MODE barrier if I am correct.

So I don't think we can move the code in the  xive_kexec_teardown_cpu()

> Why do we not want to do it on powernv?
>> Actually we *do* do it on powernv, but elsewhere.

yes in a different file.

Thanks,

C.

> cheers
> 
>> +	} else
>>  		xics_kexec_teardown_cpu(secondary);
>>  }
>> -- 
>> 2.13.6
