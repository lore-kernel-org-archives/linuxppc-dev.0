Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7rmN30qgzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 00:57:07 +1100 (AEDT)
Subject: Re: [PATCH] mm: deferred_init_memmap improvements
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 mhocko@kernel.org, ard.biesheuvel@linaro.org, mark.rutland@arm.com,
 will.deacon@arm.com, catalin.marinas@arm.com, sam@ravnborg.org,
 mgorman@techsingularity.net, steven.sistare@oracle.com,
 daniel.m.jordan@oracle.com, bob.picco@oracle.com
References: <20171004152902.17300-1-pasha.tatashin@oracle.com>
 <071d574f-1d8c-5be9-ec92-6227db01bbd3@linux.vnet.ibm.com>
From: Pasha Tatashin <pasha.tatashin@oracle.com>
Message-ID: <0a836d3f-1a0c-8a9e-f4b2-eeb72a08a3e3@oracle.com>
Date: Fri, 6 Oct 2017 09:55:49 -0400
MIME-Version: 1.0
In-Reply-To: <071d574f-1d8c-5be9-ec92-6227db01bbd3@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anshuman,

Thank you very much for looking at this. My reply below::

On 10/06/2017 02:48 AM, Anshuman Khandual wrote:
> On 10/04/2017 08:59 PM, Pavel Tatashin wrote:
>> This patch fixes another existing issue on systems that have holes in
>> zones i.e CONFIG_HOLES_IN_ZONE is defined.
>>
>> In for_each_mem_pfn_range() we have code like this:
>>
>> if (!pfn_valid_within(pfn)
>> 	goto free_range;
>>
>> Note: 'page' is not set to NULL and is not incremented but 'pfn' advances.
> 
> page is initialized to NULL at the beginning of the function.

Yes, it is initialized to NULL but at the beginning of 
for_each_mem_pfn_range() loop

> PFN advances but we dont proceed unless pfn_valid_within(pfn)
> holds true which basically should have checked with arch call
> back if the PFN is valid in presence of memory holes as well.
> Is not this correct ?

Correct, if pfn_valid_within() is false we jump to the "goto 
free_range;", which is at the end of for (; pfn < end_pfn; pfn++) loop, 
so we are not jumping outside of this loop.

> 
>> Thus means if deferred struct pages are enabled on systems with these kind
>> of holes, linux would get memory corruptions. I have fixed this issue by
>> defining a new macro that performs all the necessary operations when we
>> free the current set of pages.
> 
> If we bail out in case PFN is not valid, then how corruption
> can happen ?
> 

We are not bailing out. We continue next iteration with next pfn, but 
page is not incremented.

Please let me know if I am missing something.

Thank you,
Pasha
