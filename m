Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6b9q5RS6zDqqQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 23:41:19 +1100 (AEDT)
Subject: Re: [PATCH v9 08/12] mm: zero reserved and unavailable struct pages
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, mark.rutland@arm.com, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org, mgorman@techsingularity.net,
 steven.sistare@oracle.com, daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20170920201714.19817-1-pasha.tatashin@oracle.com>
 <20170920201714.19817-9-pasha.tatashin@oracle.com>
 <20171003131817.omzbam3js67edp3s@dhcp22.suse.cz>
 <691dba28-718c-e9a9-d006-88505eb5cd7e@oracle.com>
 <20171004085636.w2rnwf5xxhahzuy7@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <9198a33d-cd40-dd70-4823-7f70c57ef9a2@oracle.com>
Date: Wed, 4 Oct 2017 08:40:11 -0400
MIME-Version: 1.0
In-Reply-To: <20171004085636.w2rnwf5xxhahzuy7@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Could you be more specific where is such a memory reserved?
>>>
>>
>> I know of one example: trim_low_memory_range() unconditionally reserves from
>> pfn 0, but e820__memblock_setup() might provide the exiting memory from pfn
>> 1 (i.e. KVM).
> 
> Then just initialize struct pages for that mapping rigth there where a
> special API is used.
> 
>> But, there could be more based on this comment from linux/page-flags.h:
>>
>>   19  * PG_reserved is set for special pages, which can never be swapped out.
>> Some
>>   20  * of them might not even exist (eg empty_bad_page)...
> 
> I have no idea wht empty_bad_page is but a quick grep shows that this is
> never used. I might be wrong here but if somebody is reserving a memory
> in a special way then we should handle the initialization right there.
> E.g. create an API for special memblock reservations.
> 

Hi Michal,

The reservations happen before struct pages are allocated and mapped. 
So, it is not always possible to do it at call sites.

Previously, I have solved this problem like this:

https://patchwork.kernel.org/patch/9886163

But, I was not too happy with that approach, so I replaced it with the 
current approach as it is more generic, and solves similar issues if 
they happen in other places. Also, the comment in page-flags got me 
scared that there are probably other places perhaps on other 
architectures that can have the similar issue.

In addition, I did not like my solution, I was simply shrinking the low 
reservation from:
[0 - reserve_low) to [min_pfn - reserve_low), but if min_pfn > 
reserve_low can we skip low reservation entirely? I was not sure.

The current approach notifies us if there are such pages, and we can 
fix/remove them in the future without crashing kernel in the meantime.

Pasha
