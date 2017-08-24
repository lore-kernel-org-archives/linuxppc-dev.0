Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdLnf31zMzDqMc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 20:56:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: John Allen <jallen@linux.vnet.ibm.com>
Subject: Re: [PATCH V9 1/2] powerpc/numa: Update CPU topology when VPHN enabled
In-Reply-To: <98ae0ab7-5c46-c9a5-d927-109338fa8826@linux.vnet.ibm.com>
References: <9a2f448d-0a5d-95e7-5ec1-b7bac1cb1f75@linux.vnet.ibm.com>
 <87efs2y0ii.fsf@concordia.ellerman.id.au>
 <98ae0ab7-5c46-c9a5-d927-109338fa8826@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 20:56:21 +1000
Message-ID: <87y3q9utd6.fsf@concordia.ellerman.id.au>
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

> On 08/23/2017 06:41 AM, Michael Ellerman wrote:
>> Michael Bringmann <mwb@linux.vnet.ibm.com> writes:
>> 
>>> powerpc/numa: Correct the currently broken capability to set the
>>> topology for shared CPUs in LPARs.  At boot time for shared CPU
>>> lpars, the topology for each shared CPU is set to node zero, however,
>>> this is now updated correctly using the Virtual Processor Home Node
>>> (VPHN) capabilities information provided by the pHyp.
>>>
>>> Also, update initialization checks for device-tree attributes to
>>> independently recognize PRRN or VPHN usage.
>> 
>> Did you ever do anything to address Nathan's comments on v4 ?
>> 
>>   http://patchwork.ozlabs.org/patch/767587/
>
> Looking at this patch I do not see that VPHN is always enabled.

You mean *this* patch? Or v4?

I think you mean this patch, in which case I agree.

>> Also your change log doesn't describe anything about what the patch does
>> and why it is the correct fix for the problem.
>> 
>> When a DLPAR happens you modify the VPHN timer to run in 1 nsec, but you
>> don't wait for it. Why would we not just run the logic synchronously?
>> 
>> It also seems to make VPHN and PRRN no longer exclusive, which looking
>> at PAPR seems like it might be correct, but is also a major change so
>> please justify it in detail.
>
> This is correct, they are not exclusive. When we first added PRRN support
> we mistakenly thought they were exclusive which is why the code currently
> only starts PRRN, or VPHN if PRRN is not present.

OK.

So we need a patch that does that and only that, and clearly explains
why we're doing that and why it's the correct thing to do.

Then a 2nd patch can fiddle with the timer, if we must.

...
>>> +static int topology_timer_secs = TOPOLOGY_DEF_TIMER_SECS;
>>> +static int topology_inited;
>>> +static int topology_update_needed;
>> 
>> None of this code should be in numa.c. Which is not your fault but I'm
>> inclined to move it before we make it worse.
>
> Agreed. Perhaps this should all be in mm/vphn.c

Actually I was thinking platforms/pseries/vphn.c

cheers
