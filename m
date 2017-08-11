Return-Path: <pasha.tatashin@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTT7T0xSpzDr2T
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 01:14:28 +1000 (AEST)
Subject: Re: [v6 00/15] complete deferred page initialization
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <20170811075826.GB30811@dhcp22.suse.cz>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <23e22449-89f0-507d-e92a-9ee947a7c363@oracle.com>
Date: Fri, 11 Aug 2017 11:13:07 -0400
MIME-Version: 1.0
In-Reply-To: <20170811075826.GB30811@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/11/2017 03:58 AM, Michal Hocko wrote:
> [I am sorry I didn't get to your previous versions]

Thank you for reviewing this work. I will address your comments, and 
send-out a new patches.

>>
>> In this work we do the following:
>> - Never read access struct page until it was initialized
> 
> How is this enforced? What about pfn walkers? E.g. page_ext
> initialization code (page owner in particular)

This is hard to enforce 100%. But, because we have a patch in this 
series that sets all memory that was allocated by 
memblock_virt_alloc_try_nid_raw() to ones with debug options enabled, 
and because Linux has a good set of asserts in place that check struct 
pages to be sane, especially the ones that are enabled with this config: 
CONFIG_DEBUG_VM_PGFLAGS. I was able to find many places in linux which 
accessed struct pages before __init_single_page() is performed, and fix 
them. Most of these places happen only when deferred struct page 
initialization code is enabled.

> 
>> - Never set any fields in struct pages before they are initialized
>> - Zero struct page at the beginning of struct page initialization
> 
> Please give us a more highlevel description of how your reimplementation
> works and how is the patchset organized. I will go through those patches
> but it is always good to give an overview in the cover letter to make
> the review easier.

Ok, will add more explanation to the cover letter.

>> Single threaded struct page init: 7.6s/T improvement
>> Deferred struct page init: 10.2s/T improvement
> 
> What are before and after numbers and how have you measured them.

When I send out this series the next time I will include before vs. 
after on the machine I tested, including links to dmesg output.

I used my early boot timestamps for x86 and sparc to measure the data. 
Early boot timestamps for sparc is already part of mainline, the x86 
patches are out for review: https://lkml.org/lkml/2017/8/10/946 (should 
have changed subject line there :) ).
