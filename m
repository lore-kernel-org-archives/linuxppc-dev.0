Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqLM72KpvzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 09:09:55 +1000 (AEST)
Received: by mail-pa0-x22b.google.com with SMTP id zm5so11072252pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 16:09:55 -0700 (PDT)
Subject: Re: [V2] powerpc/Kconfig: Update config option based on page size.
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Rashmica Gupta <rashmicy@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
References: <3qk8fY48r6z9t45@ozlabs.org> <87y4893ar2.fsf@skywalker.in.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5716BAB2.4070807@gmail.com>
Date: Wed, 20 Apr 2016 09:09:38 +1000
MIME-Version: 1.0
In-Reply-To: <87y4893ar2.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20/04/16 00:59, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
>> On Fri, 2016-19-02 at 05:38:47 UTC, Rashmica Gupta wrote:
>>> Currently on PPC64 changing kernel pagesize from 4K to 64K leaves
>>> FORCE_MAX_ZONEORDER set to 13 - which produces a compile error.
>>>
>> ...
>>> So, update the range of FORCE_MAX_ZONEORDER from 9-64 to 8-9 for 64K pages
>>> and from 13-64 to 9-13 for 4K pages.
>>>
>>> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
>>> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
>>
>> Applied to powerpc next, thanks.
>>
>> https://git.kernel.org/powerpc/c/a7ee539584acf4a565b7439cea
>>
> 
> HPAGE_PMD_ORDER is not something we should check w.r.t 4k linux page
> size. We do have the below constraint w.r.t hugetlb pages
> 
> static inline bool hstate_is_gigantic(struct hstate *h)
> {
> 	return huge_page_order(h) >= MAX_ORDER;
> }
> 
> That require MAX_ORDER to be greater than 12.
> 

The build will fail for MAX_ZONEORDER beyond the specified limits.
MAX_ORDER > 12 for what page size?

My understanding is this

1. gigantic refers to the fact the regular allocators cannot allocate
this page
2. Use alloc_contig_range() with CONFIG_CMA for gigantic pages

I could be wrong

> Did we test hugetlbfs 4k config with this patch ? Will it work if we
> start marking hugepage as gigantic page ?

Nope.. I did not

Thanks for the review!
Balbir Singh
