Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 570361A038D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 12:33:40 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 99CF4140E43
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 12:33:39 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 14 Oct 2015 07:03:37 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B2F60E0024
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 07:03:32 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9E1XZuj3670350
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 07:03:35 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9E1XYsd018664
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Oct 2015 07:03:35 +0530
Date: Wed, 14 Oct 2015 12:33:32 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 2/8] powerpc/eeh: More relexed hotplug criterion
Message-ID: <20151014013332.GA25472@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1444276739-20372-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <87612b4rye.fsf@gamma.ozlabs.ibm.com>
 <20151012232510.GA14333@gwshan>
 <87y4f732ll.fsf@gamma.ozlabs.ibm.com>
 <20151013042828.GA28681@gwshan>
 <87si5e2uv4.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87si5e2uv4.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 14, 2015 at 10:48:15AM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>> I think you're talking about the situation reported from the bug. It's
>> CAN_RECOVER instead of NONE returned from error_detected(). With the
>> CAN_RECOVER, the driver hopes the EEH core to enable the IO path so that
>> it can collect diag-data from IO space at late point.
>
>Oh. That's an interesting decision from the driver's point of view.
>
>I obviously need to re-read the patch and the surrounding code and try
>again to make sense of it later. Thanks for your attempts to explain it!
>

Yeah, that was the tricky solution we had after discussion. Obviously,
that's breaking EEH core's assumption that driver implements all error
handlers or none of them as you said. Unfortunately, I think there might
have more drivers to continue breaking but EEH core has to support. On
the other hand, the error handlers could be used for purposes other than
recovery, which is good.

Thanks,
Gavin

>>
>>>Partial hotplug is pretty hacky to begin with, and a driver being able
>>>to opt out of EEH selectively is a useful feature, so we probably want
>>>to redesign the state machine to handle them both better. That would be
>>>a long term project.
>>>

>>>>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>  arch/powerpc/kernel/eeh_driver.c | 5 ++++-
>>>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>>>>>> index 3a626ed..32178a4 100644
>>>>>> --- a/arch/powerpc/kernel/eeh_driver.c
>>>>>> +++ b/arch/powerpc/kernel/eeh_driver.c
>>>>>> @@ -416,7 +416,10 @@ static void *eeh_rmv_device(void *data, void *userdata)
>>>>>>  	driver = eeh_pcid_get(dev);
>>>>>>  	if (driver) {
>>>>>>  		eeh_pcid_put(dev);
>>>>>> -		if (driver->err_handler)
>>>>>> +		if (driver->err_handler &&
>>>>>> +		    driver->err_handler->error_detected &&
>>>>>> +		    driver->err_handler->slot_reset &&
>>>>>> +		    driver->err_handler->resume)
>>>>>>  			return NULL;
>>>>>>  	}
>>>>>>  
>>>>>> -- 
>>>>>> 2.1.0
>>>>>>
>>>>>> _______________________________________________
>>>>>> Linuxppc-dev mailing list
>>>>>> Linuxppc-dev@lists.ozlabs.org
>>>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
