Return-Path: <haren@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ys66p1Zg0zDrbG
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 16:07:13 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB6548aA028978
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Dec 2017 00:07:11 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ep511m3q9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Dec 2017 00:07:10 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <haren@linux.vnet.ibm.com>;
 Tue, 5 Dec 2017 22:07:10 -0700
Date: Tue, 05 Dec 2017 21:07:04 -0800
From: Haren Myneni <haren@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>
CC: Nicholas Piggin <npiggin@gmail.com>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [rfc] powernv/kdump: Fix cases where the kdump kernel can get
 HMI's
References: <20171202134808.27480-1-bsingharora@gmail.com>
 <20171203123658.056226c1@roar.ozlabs.ibm.com>
 <CAKTCnz=w5KEECS2RwWjrfDVgMVZWYJqQb4C8EOUbfZh2Bb=z4A@mail.gmail.com>
 <20171204131033.2df6ea84@roar.ozlabs.ibm.com>
 <CAKTCnzkwJMhq2qRO=WNGj-nUVjd-0omHLURdB6VLQ35S8fgqcA@mail.gmail.com>
In-Reply-To: <CAKTCnzkwJMhq2qRO=WNGj-nUVjd-0omHLURdB6VLQ35S8fgqcA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <5A277AF8.8090508@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/05/2017 08:29 PM, Balbir Singh wrote:
> On Mon, Dec 4, 2017 at 2:10 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> On Mon, 4 Dec 2017 11:37:01 +1100
>> Balbir Singh <bsingharora@gmail.com> wrote:
>>
>>> On Sun, Dec 3, 2017 at 1:36 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>> Seems like a reasonable approach. Why do we only do this for
>>>> powernv? It seems like a good idea in general to pull all
>>>> offlined CPUs out and into the same state for all platforms
>>>> and for all shutdown/restart/crash paths.
>>>>
>>>
>>> The reason is largely wake-up related, do we expect offline CPUs to wake
>>> up in the kdump kernel. Largely the infrastructure allows us to selectively
>>> decide what platforms need this support. I did not want to break the world
>>> by enabling it across platforms (pseries for example) without good reason.
>>
>> What happens if a pseries offlined CPU gets an exception for some reason
>> though? It seems like it would return into pseries_mach_cpu_die of the
>> old kernel which will go wrong.
>>
>> Maybe the platform has stronger guarantees that it won't wake up there,
>> like requiring a specific hcall or something?
>>
>> I was just thinking trying to move all platforms in general to the same
>> scheme would be preferable, unless there is a good reason not to. Just
>> for sharing code and behaviour.
>>
> 
> I am all for it, can I propose we start with powernv, since I've tested that
> and as I test I can start enabling other platforms with follow-on patches.
> 
>>>
>>>> Also I wonder if there is anything we should do on the other
>>>> side of the equation for the kdump kernel to pull CPUs into a
>>>> known state rather than rely on the crash kernel to do it for
>>>> us. We might have a better ability to do that with system
>>>> reset IPIs now.
>>>>
>>>
>>> Yes, but do we need to do that or quickly dump the vmcore to a file
>>> and exit?
>>
>> Well if the previous kernel did not shut them down properly, we need
>> to do that. Don't we? My point is the previous kernel crashed somehow,
>> we should be trying to fix everything up rather than hoping it crashed
>> "nicely" for us.
>>
>> Yes we shouldn't disturb things as much as possible, but we've booted
>> an entire new kernel in its own reserved memory, so I'm not sure if
>> it's such a concern to try fixing up wayward CPUs.
> 
> I think it might be a little late to fix them up, since their stack traces won't
> show up in the crash. We can of-course revisit this if required. Consider
> for example a crash I saw where the kernel crashed and held a spinlock
> at the time of crash, other CPUs were stuck spinning on that lock and did
> not report back on either side of the crash. I think we'd want our dump to
> show that. In my case I'm waking up offline CPUs to prevent them from
> waking up and doing processing that would otherwise break the system.
> I'm open to doing the same thing on the other-side, but I think the logic
> is more complex on the new kernel side

We do not need collect stack traces for offline CPUs at the time of crash anyway. Even if these CPUs to be online, has to be after collecting the current CPU states and just before kdump boot. 

In the case of CPUs stuck with IRQs disabled, they will respond anyway with NMI. Before Nick's NMI patches, these cpus states were not collected with IPI. 

Why do we need to bring offline CPUs online in kdump boot? I thought we always boot kdump kernel with single CPU. 

Thanks
Haren


> 
> Balbir Singh.
> 
