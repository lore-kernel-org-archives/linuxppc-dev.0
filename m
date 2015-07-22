Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427DE1A1A41
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 01:42:30 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Wed, 22 Jul 2015 09:42:28 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0468A19D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 09:33:07 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6MFfaa046923790
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 08:41:36 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6MFg7M6029792
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 09:42:07 -0600
Message-ID: <55AFB9CF.6030901@linux.vnet.ibm.com>
Date: Wed, 22 Jul 2015 10:42:07 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [4/6] pseries: Add CPU dlpar remove functionality
References: <20150721092732.B800B140E0F@ozlabs.org>
 <55AEBAD3.6080601@linux.vnet.ibm.com>
 <1437527519.16792.2.camel@ellerman.id.au>
In-Reply-To: <1437527519.16792.2.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/21/2015 08:11 PM, Michael Ellerman wrote:
> On Tue, 2015-07-21 at 16:34 -0500, Nathan Fontenot wrote:
>> On 07/21/2015 04:27 AM, Michael Ellerman wrote:
>>> On Mon, 2015-22-06 at 21:00:49 UTC, Nathan Fontenot wrote:
>>>> +static int dlpar_cpu_remove_by_count(struct device_node *parent,
>>>> +				     u32 cpus_to_remove)
>>>> +{
>>>> +	struct dr_cpu *dr_cpus;
>>>> +	int dr_cpus_removed = 0;
>>>> +	int dr_cpus_present = 0;
>>>> +	int dr_cpus_possible;
>>>> +	int i, rc;
>>>> +
>>>> +	pr_info("Attempting to hot-remove %d CPUs\n", cpus_to_remove);
>>>> +
>>>> +	dr_cpus = get_dlpar_cpus(parent);
>>>
>>> So I think this should be:
>>>
>>>> +	dr_cpus = get_dlpar_cpus(parent, cpus_to_remove);
>>>
>>>> +	if (!dr_cpus) {
>>>> +		pr_info("Could not gather dr CPU info\n");
>>>> +		return -EINVAL;
>>>> +	}
>>>
>>> And get_dlpar_cpus() should return cpus_to_remove worth of present cpus, or it
>>> should error, meaning the below then won't be needed:
>>
>> When adding cpus by count we may need more than just cpus_to_remove worth
>> of present cpus. The goal was to provide all possibilities so we could
>> continue trying to satisfy the request even if one or more cpus fails
>> to remove.
>>
>> From this comment and comments below I think your approach is that we
>> should bail if any error occurs during cpu remove. Is this what we
>> should be doing?
> 
> I think so. But you can convince me otherwise if you like :)
> 
> It seems to me that we don't expect failures in the general case, so a failure
> genuinely indicates something has gone wrong. In which case it's best to stop
> and back out the request, rather than trying to continue and possibly making
> things worse.
> 
> There's also the dilemma that if you get an error offlining one cpu, but then
> continue and manage to offline enough cpus, should you report an error to the
> caller (userspace)?
> 
> So I think it's better to bail on the first error, undo what's been done, and
> then report the error to the caller.

Thinking through this and I cannot come up with a reason good enough to justify
not bailing on the first error. I'll re-work the patch for this and resend.

> 
>>> Though looking closer I don't see where we ever pass or receive a
>>> pseries_hp_errorlog to or from firmware? So I'm a bit confused why we're
>>> bothering with the __be32 shenanigans. Hopefully I've just missed a detail
>>> somewhere.
>>>
>>
>> That patch is coming. For hotplug in KVM guests the pseries_hp_errorlog
>> is received when we call rtas_check_exception(). Currently these are
>> sent up to rtas_errd in userspace, When this partchset goes in I planned
>> on sending a patch to have cpu and memory hotplug requests handled entirely
>> in the kernel instead of going to userspace.
> 
> OK that makes sense.
> 
> I'll wait to see that patch, but when it comes I'll probably tell you to do the
> endian swaps once when we receive the error log, rather than at each usage.
> 

I'll make a note to look into this. The issue I find is that it gets ugly because
we need to use some of these values (such as drc_index) in cpu format at times 
and in BE at different times (such as comparing to device tree values or making
rtas calls). My goal was to pass around the values in cpu format and
do the endian swaps when needed.

-Nathan
