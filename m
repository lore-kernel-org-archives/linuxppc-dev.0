Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GKkD1plQzF3M0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 01:03:47 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8KEtLlK075493
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 11:03:45 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mmcrguqka-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 11:03:45 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 20 Sep 2018 09:03:44 -0600
Subject: Re: [PATCH] powerpc/pseries: Disable CPU hotplug across migrations
To: ego@linux.vnet.ibm.com, tyreld@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
References: <153721164232.32706.4283915467151746975.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <CAHZ_5WxcDxV5vrdW5Y1QaucXLL8Z4xskEbm+y4VFeNsj-38e7g@mail.gmail.com>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Thu, 20 Sep 2018 10:03:40 -0500
MIME-Version: 1.0
In-Reply-To: <CAHZ_5WxcDxV5vrdW5Y1QaucXLL8Z4xskEbm+y4VFeNsj-38e7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d0a4995c-949b-f6a4-889a-908e6f72036e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/18/2018 05:32 AM, Gautham R Shenoy wrote:
> Hi Nathan,
> On Tue, Sep 18, 2018 at 1:05 AM Nathan Fontenot
> <nfont@linux.vnet.ibm.com> wrote:
>>
>> When performing partition migrations all present CPUs must be online
>> as all present CPUs must make the H_JOIN call as part of the migration
>> process. Once all present CPUs make the H_JOIN call, one CPU is returned
>> to make the rtas call to perform the migration to the destination system.
>>
>> During testing of migration and changing the SMT state we have found
>> instances where CPUs are offlined, as part of the SMT state change,
>> before they make the H_JOIN call. This results in a hung system where
>> every CPU is either in H_JOIN or offline.
>>
>> To prevent this this patch disables CPU hotplug during the migration
>> process.
>>
>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/rtas.c |    2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>> index 8afd146bc9c7..2c7ed31c736e 100644
>> --- a/arch/powerpc/kernel/rtas.c
>> +++ b/arch/powerpc/kernel/rtas.c
>> @@ -981,6 +981,7 @@ int rtas_ibm_suspend_me(u64 handle)
>>                 goto out;
>>         }
>>
>> +       cpu_hotplug_disable();
> 
> So, some of the onlined CPUs ( via
> rtas_online_cpus_mask(offline_mask);) can go still offline,
> if the userspace issues an offline command, just before we execute
> cpu_hotplug_disable().
> 
> So we are narrowing down the race, but it still exists. Am I missing something ?

You're correct, this narrows the window in which a CPU can go offline.

In testing with this patch we have not been able to re-create the failure but
there is still a small window.

-Nathan

> 
>>         stop_topology_update();
>>
>>         /* Call function on all CPUs.  One of us will make the
>> @@ -995,6 +996,7 @@ int rtas_ibm_suspend_me(u64 handle)
>>                 printk(KERN_ERR "Error doing global join\n");
>>
>>         start_topology_update();
>> +       cpu_hotplug_enable();
>>
>>         /* Take down CPUs not online prior to suspend */
>>         cpuret = rtas_offline_cpus_mask(offline_mask);
>>
> 
> 
