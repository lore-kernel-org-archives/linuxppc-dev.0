Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y69Zw6Hf2zDqlP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 07:28:08 +1100 (AEDT)
Subject: Re: [PATCH v9 12/12] mm: stop zeroing memory during allocation in
 vmemmap
From: Pasha Tatashin <pasha.tatashin@oracle.com>
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
 <20170920201714.19817-13-pasha.tatashin@oracle.com>
 <20171003131952.aqq377pjug5me6go@dhcp22.suse.cz>
 <c028f65a-b4a6-e56d-3a50-5d7ad9af50cb@oracle.com>
Message-ID: <e5872937-b166-fd48-d46d-1921c738d4b1@oracle.com>
Date: Tue, 3 Oct 2017 16:26:51 -0400
MIME-Version: 1.0
In-Reply-To: <c028f65a-b4a6-e56d-3a50-5d7ad9af50cb@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michal,

I decided not to merge these two patches, because in addition to sparc 
optimization move, we have this dependancies:

mm: zero reserved and unavailable struct pages

must be before

mm: stop zeroing memory during allocation in vmemmap.

Otherwise, we can end-up with struct pages that are not zeroed properly.

However, the first patch depends on
mm: zero struct pages during initialization

As it uses mm_zero_struct_page().

Pasha


On 10/03/2017 11:34 AM, Pasha Tatashin wrote:
> On 10/03/2017 09:19 AM, Michal Hocko wrote:
>> On Wed 20-09-17 16:17:14, Pavel Tatashin wrote:
>>> vmemmap_alloc_block() will no longer zero the block, so zero memory
>>> at its call sites for everything except struct pages.  Struct page 
>>> memory
>>> is zero'd by struct page initialization.
>>>
>>> Replace allocators in sprase-vmemmap to use the non-zeroing version. So,
>>> we will get the performance improvement by zeroing the memory in 
>>> parallel
>>> when struct pages are zeroed.
>>
>> Is it possible to merge this patch with 
>> http://lkml.kernel.org/r/20170920201714.19817-7-pasha.tatashin@oracle.com
> 
> Yes, I will do that. It would also require re-arranging
> [PATCH v9 07/12] sparc64: optimized struct page zeroing
> optimization to come after this patch.
> 
> Pasha
