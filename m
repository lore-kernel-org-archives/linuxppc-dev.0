Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K2Mg2gg6zDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 10:42:07 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>, ego@linux.vnet.ibm.com,
 tyreld@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Disable CPU hotplug across migrations
In-Reply-To: <20180924085606.GA16671@in.ibm.com>
References: <153721164232.32706.4283915467151746975.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
 <CAHZ_5WxcDxV5vrdW5Y1QaucXLL8Z4xskEbm+y4VFeNsj-38e7g@mail.gmail.com>
 <d0a4995c-949b-f6a4-889a-908e6f72036e@linux.vnet.ibm.com>
 <87va6v5qhx.fsf@concordia.ellerman.id.au> <20180924085606.GA16671@in.ibm.com>
Date: Tue, 25 Sep 2018 10:42:05 +1000
Message-ID: <87h8ie5rxe.fsf@concordia.ellerman.id.au>
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

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> On Mon, Sep 24, 2018 at 05:00:42PM +1000, Michael Ellerman wrote:
>> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
>> > On 09/18/2018 05:32 AM, Gautham R Shenoy wrote:
>> >> On Tue, Sep 18, 2018 at 1:05 AM Nathan Fontenot
>> >>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>> >>> index 8afd146bc9c7..2c7ed31c736e 100644
>> >>> --- a/arch/powerpc/kernel/rtas.c
>> >>> +++ b/arch/powerpc/kernel/rtas.c
>> >>> @@ -981,6 +981,7 @@ int rtas_ibm_suspend_me(u64 handle)
>> >>>                 goto out;
>> >>>         }
>> >>>
>> >>> +       cpu_hotplug_disable();
>> >> 
>> >> So, some of the onlined CPUs ( via
>> >> rtas_online_cpus_mask(offline_mask);) can go still offline,
>> >> if the userspace issues an offline command, just before we execute
>> >> cpu_hotplug_disable().
>> >> 
>> >> So we are narrowing down the race, but it still exists. Am I missing something ?
>> >
>> > You're correct, this narrows the window in which a CPU can go offline.
>> >
>> > In testing with this patch we have not been able to re-create the failure but
>> > there is still a small window.
>> 
>> Well let's close it.
>> 
>> We just need to check that all present CPUs are online after we've
>> called cpu_hotplug_disable() don't we?
>
> Yes. However, we cannot use the cpu_up() API to bring the offline CPUs
> online, since will return with an -EBUSY if CPU-Hotplug has been
> disabled.

I'm not suggesting we try to bring them online after we've disabled CPU
hotplug, if we detect that race we can just fail the migration.

Can't we do:
 - save mask of offline CPUs
 - bring all offline CPUs online
 - disable CPU hotplug
 - check if any CPUs are offline
   - if so, we've raced with an offline
   - bail out of the migration with an error


Instead of bailing out we could go back to the start and try again for
some number of retries, but that's probably overkill anyway.

What am I missing?

cheers
