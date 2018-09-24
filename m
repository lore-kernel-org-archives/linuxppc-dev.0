Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JxBz1fwYzF3JS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 06:49:14 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8OKiZ8u017616
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 16:49:12 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mq3usgr4q-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 16:49:12 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Mon, 24 Sep 2018 16:49:11 -0400
Subject: Re: [PATCH] powerpc/pseries: Disable CPU hotplug across migrations
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, ego@linux.vnet.ibm.com,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
References: <153721164232.32706.4283915467151746975.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <CAHZ_5WxcDxV5vrdW5Y1QaucXLL8Z4xskEbm+y4VFeNsj-38e7g@mail.gmail.com>
 <d0a4995c-949b-f6a4-889a-908e6f72036e@linux.vnet.ibm.com>
 <87va6v5qhx.fsf@concordia.ellerman.id.au> <20180924085606.GA16671@in.ibm.com>
 <b61828ef-b07f-93b1-6185-d4d62bd8fd77@linux.vnet.ibm.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Mon, 24 Sep 2018 13:49:06 -0700
MIME-Version: 1.0
In-Reply-To: <b61828ef-b07f-93b1-6185-d4d62bd8fd77@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <89531902-477b-660a-227c-8563e4ca076a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/24/2018 07:30 AM, Nathan Fontenot wrote:
> On 09/24/2018 03:56 AM, Gautham R Shenoy wrote:
>> Hi Michael,
>>
>> On Mon, Sep 24, 2018 at 05:00:42PM +1000, Michael Ellerman wrote:
>>> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
>>>> On 09/18/2018 05:32 AM, Gautham R Shenoy wrote:
>>>>> Hi Nathan,
>>>>> On Tue, Sep 18, 2018 at 1:05 AM Nathan Fontenot
>>>>> <nfont@linux.vnet.ibm.com> wrote:
>>>>>>
>>>>>> When performing partition migrations all present CPUs must be online
>>>>>> as all present CPUs must make the H_JOIN call as part of the migration
>>>>>> process. Once all present CPUs make the H_JOIN call, one CPU is returned
>>>>>> to make the rtas call to perform the migration to the destination system.
>>>>>>
>>>>>> During testing of migration and changing the SMT state we have found
>>>>>> instances where CPUs are offlined, as part of the SMT state change,
>>>>>> before they make the H_JOIN call. This results in a hung system where
>>>>>> every CPU is either in H_JOIN or offline.
>>>>>>
>>>>>> To prevent this this patch disables CPU hotplug during the migration
>>>>>> process.
>>>>>>
>>>>>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>>>>>> ---
>>>>>>  arch/powerpc/kernel/rtas.c |    2 ++
>>>>>>  1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>>>>>> index 8afd146bc9c7..2c7ed31c736e 100644
>>>>>> --- a/arch/powerpc/kernel/rtas.c
>>>>>> +++ b/arch/powerpc/kernel/rtas.c
>>>>>> @@ -981,6 +981,7 @@ int rtas_ibm_suspend_me(u64 handle)
>>>>>>                 goto out;
>>>>>>         }
>>>>>>
>>>>>> +       cpu_hotplug_disable();
>>>>>
>>>>> So, some of the onlined CPUs ( via
>>>>> rtas_online_cpus_mask(offline_mask);) can go still offline,
>>>>> if the userspace issues an offline command, just before we execute
>>>>> cpu_hotplug_disable().
>>>>>
>>>>> So we are narrowing down the race, but it still exists. Am I missing something ?
>>>>
>>>> You're correct, this narrows the window in which a CPU can go offline.
>>>>
>>>> In testing with this patch we have not been able to re-create the failure but
>>>> there is still a small window.
>>>
>>> Well let's close it.
>>>
>>> We just need to check that all present CPUs are online after we've
>>> called cpu_hotplug_disable() don't we?
>>
>> Yes. However, we cannot use the cpu_up() API to bring the offline CPUs
>> online, since will return with an -EBUSY if CPU-Hotplug has been
>> disabled. _cpu_up() works, but it is (understandably) a static
>> function in kernel/cpu.c
>>
>> So, we might need a new APIs along the lines of
>> disable_nonboot_cpus()/enable_nonboot_cpus() 
>> that is currently being used by the suspend subsystem, only that we
>> would need the APIs to
>>       - Disable hotplug and online all the CPUs in an atomic
>>       fashion. Would be good if the API returns the cpumask of CPUs
>>       which were offline, which were brought online by this API.
>>
>>       - Restore the state of the machine by offlining the CPUs which
>>       we brought online, and enable hotplug again. 
>>       
> 
> There is already code in the LPM path that saves a cpu mask of the offline
> cpus prior to bringing them all online so we can offline them again after
> the migration.
> 
> The missing piece to fully close the window is an API that will allow us to
> online cpus while cpu hotplug is disabled.
> 
> Since we have not been able to re-create the failure with this patch would
> it be ok to pull in this patch while other options are explored?

I think mpe initially applied this to -next. Not sure if he dropped it, but I would definitely give a +1 to carrying this workaround for now until we can put together an API that fully closes the gap. We are hot with LPM blocked tests at the moment.

-Tyrel

> 
> -Nathan
> 
>>>
>>> cheers
>>>
> 
