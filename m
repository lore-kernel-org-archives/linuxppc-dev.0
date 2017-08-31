Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjdxS21BvzDqGZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 20:33:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: John Allen <jallen@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pseries: Don't attempt to acquire drc during
 memory hot add for assigned lmbs
In-Reply-To: <c2e6a370-b648-4a25-8fe8-2dad41dce5c8@linux.vnet.ibm.com>
References: <fc2ad536-a772-f006-43c4-1ddf6e296ebb@linux.vnet.ibm.com>
 <87bmmx3hr8.fsf@concordia.ellerman.id.au>
 <cad79893-3d1a-f2ea-892f-6481a22f261a@linux.vnet.ibm.com>
 <c2e6a370-b648-4a25-8fe8-2dad41dce5c8@linux.vnet.ibm.com>
Date: Thu, 31 Aug 2017 20:32:58 +1000
Message-ID: <87a82gt4bp.fsf@concordia.ellerman.id.au>
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

John Allen <jallen@linux.vnet.ibm.com> writes:

> On 08/30/2017 09:35 AM, Nathan Fontenot wrote:
>> On 08/29/2017 09:35 PM, Michael Ellerman wrote:
>>> John Allen <jallen@linux.vnet.ibm.com> writes:
>>>
>>>> Check if an LMB is assigned before attempting to call dlpar_acquire_drc in
>>>> order to avoid any unnecessary rtas calls. This substantially reduces the
>>>> running time of memory hot add on lpars with large amounts of memory.
>>>>
>>>> Signed-off-by: John Allen <jallen@linux.vnet.ibm.com>
>>>> ---
>>>> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>>> index ca9b2f4..95cf2ff 100644
>>>> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
>>>> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
>>>> @@ -817,6 +817,9 @@ static int dlpar_memory_add_by_count(u32 lmbs_to_add, struct property *prop)
>>>>  		return -EINVAL;
>>>>
>>>>  	for (i = 0; i < num_lmbs && lmbs_to_add != lmbs_added; i++) {
>>>> +		if (lmbs[i].flags & DRCONF_MEM_ASSIGNED)
>>>> +			continue;
>>>> +
>>>>  		rc = dlpar_acquire_drc(lmbs[i].drc_index);
>>>>  		if (rc)
>>>>  			continue;
>>>
>>> This doesn't build for me, see below. What compiler are you using to
>>> test this?> 
>>>   arch/powerpc/platforms/pseries/hotplug-memory.c: In function 'dlpar_memory':
>>>   arch/powerpc/platforms/pseries/hotplug-memory.c:1081:2: error: 'rc' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>>     return rc;
>>>     ^
>>>
>> 
>> I don't see this build failure either, looks like its time to update my
>> compiler too.
>
> This also builds for me. I'm using gcc version 4.8.5

OK, that is fairly old.

I generally use 6.x or 7.x, but I see the warning on 5.4.1 also.

cheers
