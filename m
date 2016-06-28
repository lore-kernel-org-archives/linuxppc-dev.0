Return-Path: <nfont@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfBC35ZqHzDqqZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 02:31:26 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5SGTFFB112246
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 12:31:24 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23sm9fbjm3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 12:31:24 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 28 Jun 2016 10:31:23 -0600
Subject: Re: [PATCH] powerpc/pseries: Auto online hotplugged memory
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <5767F4D0.7070504@linux.vnet.ibm.com>
 <1466470648.9938.0.camel@ellerman.id.au>
 <5768A2EB.5030808@linux.vnet.ibm.com>
 <1466746547.11831.2.camel@ellerman.id.au>
 <57713AFD.5040801@linux.vnet.ibm.com>
 <1467085570.32607.1.camel@ellerman.id.au>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Tue, 28 Jun 2016 11:31:16 -0500
MIME-Version: 1.0
In-Reply-To: <1467085570.32607.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <5772A654.6090801@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/27/2016 10:46 PM, Michael Ellerman wrote:
> On Mon, 2016-06-27 at 09:41 -0500, Nathan Fontenot wrote:
>> On 06/24/2016 12:35 AM, Michael Ellerman wrote:
>>> On Mon, 2016-06-20 at 21:14 -0500, Nathan Fontenot wrote:
>>>> On 06/20/2016 07:57 PM, Michael Ellerman wrote:
>>>>> On Mon, 2016-06-20 at 08:51 -0500, Nathan Fontenot wrote:
>>>>>
>>>>>> Auto online hotplugged memory
>>>>>>
>>>>>> A recent update (commit id 31bc3858ea3) to the core mm hotplug code
>>>>>> introduced the memhp_auto_online variable to allow for automatically
>>>>>> onlining memory that is added.
>>>>>>
>>>>>> This patch update the pseries memory hotplug code to enable this so that
>>>>>> any memory DLPAR added to the system is automatically onlined. The code
>>>>>> to add the memory block for memory added from add_memory() is removed as
>>>>>> this is not needed, the memory_add code does this.
>>>>>
>>>>> Is this a bug fix, or just a cleanup?
>>>>
>>>> Hmmm.. some cleanup and some new feature. The removal of the memblock_add()
>>>> call is a cleanup and the setting of the memhp_auto_online variable is
>>>> taking advantage of a feature I was not previously aware of.
>>>
>>> OK. Looking at usage of memhp_auto_online it's not clear to me that you're
>>> supposed to be setting it in arch code.
>>>
>>> eg. if I build my kernel with CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=n, I will
>>> expect it to not be onlined by default.
>>>
>>> Similarly if I boot with memhp_default_state=offline on the kernel command line.
>>>
>>> But this patch would then mean it is onlined by default. So that seems kind of
>>> confusing for users.
>>
>> Yes, but we already online memory when it is DLPAR added to the system. This has
>> always been the default behavior for pseries. I was using the memhp_auto_online
>> setting so that the memory will be added as part of the memory_add call instead
>> of having to online the memory as a separate step in the pseries code.
>>
>> In other words, I am not changing the existing behavior of pseries code. 
> 
> Yep, that's good.
> 
> What's not good is giving the user an option and then ignoring it.

True, I just trying to preserve existing behavior.

> 
>> Perhaps something a bit different? I could save and restore the memhp_auto_online
>> setting across the call to memory_add, or perhpas ther should be an
>> add_memory_and_online() variant of the add_memory() call that always onlines memory.
>  
> No I think we should just honor the setting.
> 
> To retain the existing behavour on pseries we just set CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=y
> in the pseries defconfig.
> 
> That way users can control the behaviour, which is good, and all the existing
> documentation applies equally to powerpc as other arches. If we do something
> different, like force onlining it, then we need to go and update all the docs to
> say "memhp_auto_online - ignored on powerpc".
> 

Sounds good, I'll send a new patch to set the config option for pseries and update
the dlpar memory add code accordingly.

Thanks,
-Nathan
