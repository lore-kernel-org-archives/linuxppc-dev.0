Return-Path: <srs0=vbip=3z=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6Bbb3gGQzDqWq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 01:13:15 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w6Bbb34ksz8wN2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 01:13:15 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w6BbZ60SQz9s0Z
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Apr 2017 01:13:14 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3HF99bF072935
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2017 11:13:10 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ufd98f0f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2017 11:13:10 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 17 Apr 2017 20:43:07 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay09.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3HFD4Fj18219144
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2017 20:43:04 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3HFD39t008881
 for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2017 20:43:04 +0530
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
 <878tnd7zim.fsf@concordia.ellerman.id.au>
 <d50dfb98-68ac-0135-8e65-560aec1d752e@linux.vnet.ibm.com>
 <87efx4gwk2.fsf@concordia.ellerman.id.au>
 <e1377bf8-e574-6ffa-6b63-3748a01dcdfa@linux.vnet.ibm.com>
 <20170413215826.367dbdf0@kitsune.suse.cz>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 17 Apr 2017 20:43:02 +0530
MIME-Version: 1.0
In-Reply-To: <20170413215826.367dbdf0@kitsune.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c1591a61-6499-4364-9d37-a3035e0eaddf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 14 April 2017 01:28 AM, Michal Suchánek wrote:
> On Thu, 13 Apr 2017 01:59:13 +0530
> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>
>> On Friday 07 April 2017 07:16 PM, Michael Ellerman wrote:
>>> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>>>> On Friday 07 April 2017 07:24 AM, Michael Ellerman wrote:
>>>>> My preference would be that the fadump kernel "just works". If
>>>>> it's using too much memory then the fadump kernel should do
>>>>> whatever it needs to use less memory, eg. shrinking nr_cpu_ids
>>>>> etc. Do we actually know *why* the fadump kernel is running out
>>>>> of memory? Obviously large numbers of CPUs is one of the main
>>>>> drivers (lots of stacks required). But other than that what is
>>>>> causing the memory pressure? I would like some data on that
>>>>> before we proceed.
>>>> Almost the same amount of memory in comparison with the memory
>>>> required to boot the production kernel but that is unwarranted for
>>>> fadump (dump capture) kernel.
>>> That's not data! :)
>>>
>>> The dump kernel is booted with *much* less memory than the
>>> production kernel (that's the whole issue!) and so it doesn't need
>>> to create struct pages for all that memory, which means it should
>>> need less memory.
>>>
>>> The vfs caches are also sized based on the available memory, so they
>>> should also shrink in the dump kernel.
>>>
>>> I want some actual numbers on what's driving the memory usage.
>>>
>>> I tried some of these parameters to see how much memory they would
>>> save:
>> Hi Michael,
>>
>> Tried to get data to show parameters like numa=off &
>> cgroup_disable=memory matter too but parameter nr_cpus=1 is making
>> parameters like numa=off, cgroup_disable=memory insignificant. Also,
>> these parameters not using much of early memory reservations is
>> making quantification of memory saved for each of them that much more
>> difficult. But I would still like to argue that passing additional
>> parameters to fadump is better than enforcing nr_cpus=1 in the kernel
>> for:
>>
>>     a) With makedumpfile tool supporting multi-threading it would make
>> sense to leave the choice of how many CPUs to have, to the user.
>>
>>     b) Parameters like udev.children-max=2 can help to reduce the
>> number of parallel executed events bringing down the memory pressure
>> on fadump kernel (when it is booted with more than one CPU).
>>
>>     c) Ease of maintainability is better (considering any new kernel
>> features with some memory to save or stability to gain on disabling,
>> possible platform supports) with append approach over enforcing these
>> parameters
>>        in the kernel.
>>
>>     d) It would give user the flexibility to disable unwanted kernel
>> features in fadump kernel (numa=off, cgroup_disable=memory). For
>> every feature enabled in the production kernel, fadump kernel will
>> have the choice to
>>        opt out of it, provided there is such cmdline option.
> Hello,

Hi Michal,

> can't the extra parameters be passed in the devicetree?

Hmmm.. possible. Without change in f/w, this may not be guaranteed though.

> The docs say that the kernel can tell it's a fadump crash kernel by
> checking the devicetree ibm,dump-kernel property. Is there any reason

This node is exported by firmware

> more (optional) properties cannot be added?

Kernel change seems simple over f/w enhancement..

Thanks
Hari
