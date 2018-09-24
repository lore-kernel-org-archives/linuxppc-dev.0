Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42JZpy525HzDqSh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2018 17:00:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, ego@linux.vnet.ibm.com,
 tyreld@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Disable CPU hotplug across migrations
In-Reply-To: <d0a4995c-949b-f6a4-889a-908e6f72036e@linux.vnet.ibm.com>
References: <153721164232.32706.4283915467151746975.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <CAHZ_5WxcDxV5vrdW5Y1QaucXLL8Z4xskEbm+y4VFeNsj-38e7g@mail.gmail.com>
 <d0a4995c-949b-f6a4-889a-908e6f72036e@linux.vnet.ibm.com>
Date: Mon, 24 Sep 2018 17:00:42 +1000
Message-ID: <87va6v5qhx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
> On 09/18/2018 05:32 AM, Gautham R Shenoy wrote:
>> Hi Nathan,
>> On Tue, Sep 18, 2018 at 1:05 AM Nathan Fontenot
>> <nfont@linux.vnet.ibm.com> wrote:
>>>
>>> When performing partition migrations all present CPUs must be online
>>> as all present CPUs must make the H_JOIN call as part of the migration
>>> process. Once all present CPUs make the H_JOIN call, one CPU is returned
>>> to make the rtas call to perform the migration to the destination system.
>>>
>>> During testing of migration and changing the SMT state we have found
>>> instances where CPUs are offlined, as part of the SMT state change,
>>> before they make the H_JOIN call. This results in a hung system where
>>> every CPU is either in H_JOIN or offline.
>>>
>>> To prevent this this patch disables CPU hotplug during the migration
>>> process.
>>>
>>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/kernel/rtas.c |    2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>>> index 8afd146bc9c7..2c7ed31c736e 100644
>>> --- a/arch/powerpc/kernel/rtas.c
>>> +++ b/arch/powerpc/kernel/rtas.c
>>> @@ -981,6 +981,7 @@ int rtas_ibm_suspend_me(u64 handle)
>>>                 goto out;
>>>         }
>>>
>>> +       cpu_hotplug_disable();
>> 
>> So, some of the onlined CPUs ( via
>> rtas_online_cpus_mask(offline_mask);) can go still offline,
>> if the userspace issues an offline command, just before we execute
>> cpu_hotplug_disable().
>> 
>> So we are narrowing down the race, but it still exists. Am I missing something ?
>
> You're correct, this narrows the window in which a CPU can go offline.
>
> In testing with this patch we have not been able to re-create the failure but
> there is still a small window.

Well let's close it.

We just need to check that all present CPUs are online after we've
called cpu_hotplug_disable() don't we?

cheers
