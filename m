Return-Path: <srs0=m5y3=3p=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzrhg39qdzDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 17:25:39 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vzrhg1wXLz8sxT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 17:25:39 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vzrhf5th1z9s7s
 for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2017 17:25:38 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v377OPCK115024
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 03:25:36 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29p61qrxac-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 07 Apr 2017 03:25:36 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 7 Apr 2017 17:25:27 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v377PGlu50921702
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 17:25:24 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v377OqNi029284
 for <linuxppc-dev@ozlabs.org>; Fri, 7 Apr 2017 17:24:52 +1000
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
To: Michael Ellerman <mpe@ellerman.id.au>
References: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
 <878tnd7zim.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 7 Apr 2017 12:54:34 +0530
MIME-Version: 1.0
In-Reply-To: <878tnd7zim.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <d50dfb98-68ac-0135-8e65-560aec1d752e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,


On Friday 07 April 2017 07:24 AM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>
>> In case of fadump, capture (fadump) kernel boots like a normal kernel.
>> While this has its advantages, the capture kernel would initialize all
>> the components like normal kernel, which may not necessarily be needed
>> for a typical dump capture kernel. So, fadump capture kernel ends up
>> needing more memory than a typical (read kdump) capture kernel to boot.
>>
>> This can be overcome by introducing parameters like fadump_nr_cpus=1,
>> similar to nr_cpus=1 parameter, applicable only when fadump is active.
>> But this approach needs introduction of special parameters applicable
>> only when fadump is active (capture kernel), for every parameter that
>> reduces memory/resource consumption.
>>
>> A better approach would be to pass extra parameters to fadump capture
>> kernel. As firmware leaves the memory contents intact from the time of
>> crash till the new kernel is booted up, parameters to append to capture
>> kernel can be saved in real memory region and retrieved later when the
>> capture kernel is in its early boot process for appending to command
>> line parameters.
>>
>> This patch introduces a new node /sys/kernel/fadump_cmdline_append to
>> specify the parameters to pass to fadump capture kernel, saves them in
>> real memory region and appends these parameters to capture kernel early
>> in its boot process.
> As we discussed on IRC I don't really like this.
>
> It's clever, (ab)using the fact that the first kernel's memory is left
> intact. But it's also a bit gross :)

No doubt. It is an ugly trick :)

> It also has a few real problems, like hard coding 128MB as the handover
> location. You may not have memory there, or it may be reserved.
>

Yeah, there is a chance that appending parameters is not possible
like in the scenarios you mentioned above. My intention behind this
hack is to build on this handover area later to probably pass off a
special intird which brings down the dump capture time and memory
consumption further. But to put it in your words, it would be abusing
it even more :P . So, I would take it as a road not worthing taking..

> My preference would be that the fadump kernel "just works". If it's
> using too much memory then the fadump kernel should do whatever it needs
> to use less memory, eg. shrinking nr_cpu_ids etc.

> Do we actually know *why* the fadump kernel is running out of memory?
> Obviously large numbers of CPUs is one of the main drivers (lots of
> stacks required). But other than that what is causing the memory
> pressure? I would like some data on that before we proceed.

Almost the same amount of memory in comparison with the memory
required to boot the production kernel but that is unwarranted for fadump
(dump capture) kernel. Let's say the production kernel is configured for
memory cgroups or hugepages which is not required in a dump capture kernel
but with no option to say so, we are wasting that much more memory on fadump
and eventually depriving the production kernel of that memory.

So, if parameters like cgroup_disable=memory, transparent_hugepages=never,
numa=off, nr_cpus=1, etc.. are passed to fadump (dump capture) kernel it 
would
be beneficial. Not to mention any future additions to the kernel that 
increase the
footprint of a production kernel..

> If we *must* have a way to pass command line arguments to the fadump
> kernel then I think we should just use a command line argument that
> specifies them.
>
> eg: fadump_append=nr_cpus=1,use_less_memory,some_other_obscure_parameter=100
>
>

Hmmm.. this sounds like a better interface. But I would like know your 
preference on
how to process fadump_append parameter:

1. Modify cmdline early in fadump kernel boot process (before parsing 
parameters) to change
    fadump_append="nr_cpus=1 cgroup_disable=memory" in cmdline to 
"nr_cpus=1 cgroup_disable=memory"
    so that fadump doesn't have to bother about processing this 
parameters later.
2. A parse function in fadump to parse fadump_append parameters. A 
function similar to parse_early_param()
    meant for fadump_append parameter alone..
3. fadump code processes fadump_append for each parameter passed in it.

The third one sounds like a nightmare to me as we need to make fadump 
code aware of every new parameter
we want to enforce on fadump..

Thanks
Hari
