Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 246A01A0846
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 12:06:59 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 20 May 2014 12:06:59 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 36C7A2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 12:06:57 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4K1jM5K35848366
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 11:45:23 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4K26t4V018775
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 12:06:56 +1000
Message-ID: <537AB8B2.3040000@linux.vnet.ibm.com>
Date: Tue, 20 May 2014 07:36:42 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH V4 0/2] mm: FAULT_AROUND_ORDER patchset performance data
 for powerpc
References: <1399541296-18810-1-git-send-email-maddy@linux.vnet.ibm.com>
 <537479E7.90806@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405151026540.4664@eggly.anvils>
 <87wqdik4n5.fsf@rustcorp.com.au> <53797511.1050409@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1405191531150.1317@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1405191531150.1317@eggly.anvils>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org,
 dave.hansen@intel.com, peterz@infradead.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 20 May 2014 04:53 AM, Hugh Dickins wrote:
> On Mon, 19 May 2014, Madhavan Srinivasan wrote:
>> On Monday 19 May 2014 05:42 AM, Rusty Russell wrote:
>>> Hugh Dickins <hughd@google.com> writes:
>>>> On Thu, 15 May 2014, Madhavan Srinivasan wrote:
>>>>>
>>>>> Hi Ingo,
>>>>>
>>>>> 	Do you have any comments for the latest version of the patchset. If
>>>>> not, kindly can you pick it up as is.
>>>>>
>>>>>
>>>>> With regards
>>>>> Maddy
>>>>>
>>>>>> Kirill A. Shutemov with 8c6e50b029 commit introduced
>>>>>> vm_ops->map_pages() for mapping easy accessible pages around
>>>>>> fault address in hope to reduce number of minor page faults.
>>>>>>
>>>>>> This patch creates infrastructure to modify the FAULT_AROUND_ORDER
>>>>>> value using mm/Kconfig. This will enable architecture maintainers
>>>>>> to decide on suitable FAULT_AROUND_ORDER value based on
>>>>>> performance data for that architecture. First patch also defaults
>>>>>> FAULT_AROUND_ORDER Kconfig element to 4. Second patch list
>>>>>> out the performance numbers for powerpc (platform pseries) and
>>>>>> initialize the fault around order variable for pseries platform of
>>>>>> powerpc.
>>>>
>>>> Sorry for not commenting earlier - just reminded by this ping to Ingo.
>>>>
>>>> I didn't study your numbers, but nowhere did I see what PAGE_SIZE you use.
>>>>
>>>> arch/powerpc/Kconfig suggests that Power supports base page size of
>>>> 4k, 16k, 64k or 256k.
>>>>
>>>> I would expect your optimal fault_around_order to depend very much on
>>>> the base page size.
>>>
>>> It was 64k, which is what PPC64 uses on all the major distributions.
>>> You really only get a choice of 4k and 64k with 64 bit power.
>>>
>> This is true. PPC64 support multiple pagesize and yes the default page
>> size of 64k, is taken as base pagesize for the tests.
>>
>>>> Perhaps fault_around_size would provide a more useful default?
>>>
>>> That seems to fit.  With 4k pages and order 4, you're asking for 64k.
>>> Maddy's result shows 64k is also reasonable for 64k pages.
>>>
>>> Perhaps we try to generalize from two data points (a slight improvement
>>> over doing it from 1!), eg:
>>>
>>> /* 4 seems good for 4k-page x86, 0 seems good for 64k page ppc64, so: */
>>> unsigned int fault_around_order __read_mostly =
>>>         (16 - PAGE_SHIFT < 0 ? 0 : 16 - PAGE_SHIFT);
> 
> Rusty's bimodal answer doesn't seem the right starting point to me.
> 
> Shouldn't FAULT_AROUND_ORDER and fault_around_order be changed to be
> the order of the fault-around size in bytes, and fault_around_pages()
> use 1UL << (fault_around_order - PAGE_SHIFT)
> - when that doesn't wrap, of course!
> 
> That would at least have a better chance of being appropriate for
> architectures with 8k and 16k pages (Itanium springs to mind).
> 
> Not necessarily right for them, since each architecture may have
> different faulting overheads; but a better chance of being right
> than blindly assuming 4k or 64k pages for everyone.
> 
> I'd be glad to see that change go into v3.15: what do you think,
> Kirill, are we too late to make such a change now?
> Or do you see some objection to it?
> 
>> This may be right. But these are the concerns, will not this make other
>> arch to pick default without any tuning
> 
> Wasn't FAULT_AROUND_ORDER 4 chosen solely on the basis of x86 4k pages?
> Did other architectures, with other page sizes, back that default?
> Clearly not powerpc.

Ok.

> 
>> and also this will remove the
>> compile time option to disable the feature?
> 
> Compile time option meaning your FAULT_AROUND_ORDER in mm/Kconfig
> for v3.16?
> 
> I'm not sure whether Rusty was arguing against that or not I think

> we are all three concerned to have a more sensible default than what's
> there at present.  I don't feel very strongly about your Kconfig

Added it as one way to reset or disable the default value. But then I
guess we decided on having FAULT_AROUND_ORDER as a variable which is
more important than Kconfig option.

> option: I've no objection, if it were to default to byte order 16.
> 

Thanks for review
With regards
Maddy

> Hugh
> 
