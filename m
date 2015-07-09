Return-Path: <labbott@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D60C1A1A61
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 08:38:55 +1000 (AEST)
Subject: Re: [RFC] genalloc:add an gen_pool_alloc_align func to genalloc
To: Scott Wood <scottwood@freescale.com>
References: <1436428063-893-1-git-send-email-B45475@freescale.com>
 <559EECCF.6060702@redhat.com> <1436480222.2658.151.camel@freescale.com>
Cc: Zhao Qiang <B45475@freescale.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 olof@lixom.net, catalin.marinas@arm.com, X.xie@freescale.com
From: Laura Abbott <labbott@redhat.com>
Message-ID: <559EF7FB.20907@redhat.com>
Date: Thu, 9 Jul 2015 15:38:51 -0700
MIME-Version: 1.0
In-Reply-To: <1436480222.2658.151.camel@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2015 03:17 PM, Scott Wood wrote:
> On Thu, 2015-07-09 at 14:51 -0700, Laura Abbott wrote:
>> On 07/09/2015 12:47 AM, Zhao Qiang wrote:
>>> Bytes alignment is required to manage some special ram,
>>> so add gen_pool_alloc_align func to genalloc.
>>> rename gen_pool_alloc to gen_pool_alloc_align with a align parameter,
>>> then provide gen_pool_alloc to call gen_pool_alloc_align with
>>> align = 1 Byte.
>>>
>>> Signed-off-by: Zhao Qiang <B45475@freescale.com>
>>> ---
>>> FSL's IP block QE require this function to manage muram.
>>> QE supported only PowerPC, and its code was put under arch/powerpc
>>> directory,
>>> using arch/powerpc/lib/rheap.c to manage muram.
>>> Now it support both arm(ls1021,ls1043,ls2085 and such on) and powerpc,
>>> the code need to move from arch/powerpc to public direcory,
>>> Scott wood hopes to use genalloc to manage the muram, after discussing
>>> with scott, we decide to add gen_pool_alloc_align to meet the requirement
>>> for bytes-alignment.
>>
>> gen_pool supports custom allocation algorithms. I thought this was discussed
>> previously and the conclusion was that if you wanted alignment you should
>> use custom allocation algorithms. I'm failing at finding any thread
>> discussing it though.
>
> I hope that by "custom algorithm" you don't mean something implemented
> outside lib/genalloc.c, as this does not seem like such a specialized
> requirement that everyone must reimplement it separately.
>

If the functions are generic enough (which I think they are) they could stay
in genalloc.c as another option for people to use.

>> Perhaps another option would be to add another runtime argument to gen_pool
>> where you could pass the alignment to your custom allocation function. This
>> way alignment isn't inherently coded into any of the algorithms.
>
> That wouldn't let the alignment change for each allocation (and could already
> be done with pool->data).  I suppose one could call get_pool_set_algo() with
> different data (or modify the memory that pool->data is already pointing to)
> before each allocation, but that's a bit clunky...  If making alignment part
> of the mainstream flow is undesired for some reason, how about a
> gen_pool_alloc_data() that lets it be passed in per-allocation (with
> gen_pool_alloc() being a wrapper that passes in pool->data)?
>

Yes, that's what I was thinking. I dropped the alloc from my 'runtime argument
to gen_pool_alloc' so it wasn't clear I was talking about allocation time and
not pool creation time.

> Yes, I know, we could do it in a wrapper (like cpm_muram_alloc()
> unnecessarily does), but why not make the interface better match the way it's
> used?

Agreed.

>
> -Scott
>

Thanks,
Laura
