Return-Path: <preeti@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 57B341A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 May 2015 13:46:55 +1000 (AEST)
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F1E614030D
 for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2015 13:46:54 +1000 (AEST)
Received: from /spool/local
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 7 May 2015 23:46:51 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B78CF6E803C
 for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2015 23:38:36 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t483kmOX53608550
 for <linuxppc-dev@ozlabs.org>; Fri, 8 May 2015 03:46:48 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t483klGd015781
 for <linuxppc-dev@ozlabs.org>; Thu, 7 May 2015 23:46:47 -0400
Message-ID: <554C31A4.8050903@linux.vnet.ibm.com>
Date: Fri, 08 May 2015 09:16:44 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 4/6] cpufreq: powernv: Call throttle_check() on
 receiving OCC_THROTTLE
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <5548824C.2030602@linux.vnet.ibm.com> <554B584A.3030507@linux.vnet.ibm.com>
 <4161534.4Jyd5dl4um@vostro.rjw.lan>
In-Reply-To: <4161534.4Jyd5dl4um@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, viresh.kumar@linaro.org,
 linux-kernel@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/08/2015 02:29 AM, Rafael J. Wysocki wrote:
> On Thursday, May 07, 2015 05:49:22 PM Preeti U Murthy wrote:
>> On 05/05/2015 02:11 PM, Preeti U Murthy wrote:
>>> On 05/05/2015 12:03 PM, Shilpasri G Bhat wrote:
>>>> Hi Preeti,
>>>>
>>>> On 05/05/2015 09:30 AM, Preeti U Murthy wrote:
>>>>> Hi Shilpa,
>>>>>
>>>>> On 05/04/2015 02:24 PM, Shilpasri G Bhat wrote:
>>>>>> Re-evaluate the chip's throttled state on recieving OCC_THROTTLE
>>>>>> notification by executing *throttle_check() on any one of the cpu on
>>>>>> the chip. This is a sanity check to verify if we were indeed
>>>>>> throttled/unthrottled after receiving OCC_THROTTLE notification.
>>>>>>
>>>>>> We cannot call *throttle_check() directly from the notification
>>>>>> handler because we could be handling chip1's notification in chip2. So
>>>>>> initiate an smp_call to execute *throttle_check(). We are irq-disabled
>>>>>> in the notification handler, so use a worker thread to smp_call
>>>>>> throttle_check() on any of the cpu in the chipmask.
>>>>>
>>>>> I see that the first patch takes care of reporting *per-chip* throttling
>>>>> for pmax capping condition. But where are we taking care of reporting
>>>>> "pstate set to safe" and "freq control disabled" scenarios per-chip ?
>>>>>
>>>>
>>>> IMO let us not have "psafe" and "freq control disabled" states managed per-chip.
>>>> Because when the above two conditions occur it is likely to happen across all
>>>> chips during an OCC reset cycle. So I am setting 'throttled' to false on
>>>> OCC_ACTIVE and re-verifying if it actually is the case by invoking
>>>> *throttle_check().
>>>
>>> Alright like I pointed in the previous reply, a comment to indicate that
>>> psafe and freq control disabled conditions will fail when occ is
>>> inactive and that all chips face the consequence of this will help.
>>
>> From your explanation on the thread of the first patch of this series,
>> this will not be required.
>>
>> So,
>> Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> 
> OK, so is the whole series reviewed now?

Yes the whole series has been reviewed.

Regards
Preeti U Murthy


> 
> 
