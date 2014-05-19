Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B368D1A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 13:06:09 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 19 May 2014 13:06:05 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0A9192CE8055
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 13:06:00 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4J2iQSb6226366
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 12:44:27 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4J35wkq018244
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 May 2014 13:05:59 +1000
Message-ID: <53797511.1050409@linux.vnet.ibm.com>
Date: Mon, 19 May 2014 08:35:53 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V4 0/2] mm: FAULT_AROUND_ORDER patchset performance data
 for powerpc
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
 <537479E7.90806@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405151026540.4664@eggly.anvils>
 <87wqdik4n5.fsf@rustcorp.com.au>
In-Reply-To: <87wqdik4n5.fsf@rustcorp.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, riel@redhat.com, ak@linux.intel.com,
 dave.hansen@intel.com, peterz@infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 mgorman@suse.de, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org, kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 19 May 2014 05:42 AM, Rusty Russell wrote:
> Hugh Dickins <hughd@google.com> writes:
>> On Thu, 15 May 2014, Madhavan Srinivasan wrote:
>>>
>>> Hi Ingo,
>>>
>>> 	Do you have any comments for the latest version of the patchset. If
>>> not, kindly can you pick it up as is.
>>>
>>>
>>> With regards
>>> Maddy
>>>
>>>> Kirill A. Shutemov with 8c6e50b029 commit introduced
>>>> vm_ops->map_pages() for mapping easy accessible pages around
>>>> fault address in hope to reduce number of minor page faults.
>>>>
>>>> This patch creates infrastructure to modify the FAULT_AROUND_ORDER
>>>> value using mm/Kconfig. This will enable architecture maintainers
>>>> to decide on suitable FAULT_AROUND_ORDER value based on
>>>> performance data for that architecture. First patch also defaults
>>>> FAULT_AROUND_ORDER Kconfig element to 4. Second patch list
>>>> out the performance numbers for powerpc (platform pseries) and
>>>> initialize the fault around order variable for pseries platform of
>>>> powerpc.
>>
>> Sorry for not commenting earlier - just reminded by this ping to Ingo.
>>
>> I didn't study your numbers, but nowhere did I see what PAGE_SIZE you use.
>>
>> arch/powerpc/Kconfig suggests that Power supports base page size of
>> 4k, 16k, 64k or 256k.
>>
>> I would expect your optimal fault_around_order to depend very much on
>> the base page size.
> 
> It was 64k, which is what PPC64 uses on all the major distributions.
> You really only get a choice of 4k and 64k with 64 bit power.
> 
This is true. PPC64 support multiple pagesize and yes the default page
size of 64k, is taken as base pagesize for the tests.

>> Perhaps fault_around_size would provide a more useful default?
> 
> That seems to fit.  With 4k pages and order 4, you're asking for 64k.
> Maddy's result shows 64k is also reasonable for 64k pages.
> 
> Perhaps we try to generalize from two data points (a slight improvement
> over doing it from 1!), eg:
> 
> /* 4 seems good for 4k-page x86, 0 seems good for 64k page ppc64, so: */
> unsigned int fault_around_order __read_mostly =
>         (16 - PAGE_SHIFT < 0 ? 0 : 16 - PAGE_SHIFT);
> 

This may be right. But these are the concerns, will not this make other
arch to pick default without any tuning and also this will remove the
compile time option to disable the feature?

Thanks for review
With regards
Maddy



> Cheers,
> Rusty.
> 
