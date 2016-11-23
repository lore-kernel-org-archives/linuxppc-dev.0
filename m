Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP5fS0mcQzDwLC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 02:21:51 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id e9so1301006pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 07:21:51 -0800 (PST)
Subject: Re: [PATCH v5 1/7] powerpc/mm: update ptep_set_access_flag to not do
 full mm tlb flush
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
 <fe12e986-0c81-a71c-29a2-a8ca4ea2600c@gmail.com>
 <87y40ah0pa.fsf@linux.vnet.ibm.com>
 <248c0fa0-4094-429c-fa3b-1a53c75bcfbe@gmail.com>
 <87shqigt67.fsf@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <f6825375-404f-7030-3b59-f75c7c50b98b@gmail.com>
Date: Thu, 24 Nov 2016 02:21:56 +1100
MIME-Version: 1.0
In-Reply-To: <87shqigt67.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24/11/16 01:36, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> On 23/11/16 22:53, Aneesh Kumar K.V wrote:
>>> Balbir Singh <bsingharora@gmail.com> writes:
>>>
>>>> On 23/11/16 22:09, Aneesh Kumar K.V wrote:
>>>>> When we are updating pte, we just need to flush the tlb mapping for
>>>>> that pte. Right now we do a full mm flush because we don't track page
>>>>> size. Update the interface to track the page size and use that to
>>>>> do the right tlb flush.
>>>>>
>>>>
>>>> Could you also clarify the scope -- this seems to be _radix_ only.
>>>> The problem statement is not very clear and why doesn't the flush_tlb_page()
>>>> following ptep_set_access_flags() work? What else do we need to do?
>>>
>>> Yes it modifies only radix part.  Don't understand the flush_tlb_page()
>>> part of the comment above. We are modifying the tlbflush that we need to do in the pte update
>>> sequence for DD1. ie, we need to do the flush before we can set the pte
>>> with new value.
>>>
>>> Also in this specific case, we can idealy drop that flush_tlb_page,
>>> because relaxing an access really don't need a tlb flush from generic
>>> architecture point of view. I left it there to make sure, we measure and
>>> get the invalidate path correct before going ahead with that
>>> optimization.
>>>
>>
>> OK.. here is my untested solution. I've only compiled it.
>> It breaks the 64/hash/radix abstractions, but it makes the
>> changes much simpler
>>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> 
> I find the below one more confusing and complicated, spreading the
> details of DD1 around the code. I am not sure what extra i could have
> done to simplify the code. We have done the arch pte updates such that
> most of the update use the pte_update() interface and the one which relax
> the access bits get to ptep_set_access_flag. All pte updated rules are
> contained there. What you did below is that you moved the dd1 sequence
> out to a place where page size is available. What I did in my patch is to
> pass page size around. IMHO it is a matter of style. I also want to pass
> page size around so that we keep huge_pte_update, pte_update,
> ptep_set_access_flags all similar.
> 

Agreed and the reason I did it that way is that after a while we know
the _dd1_ variants need not be supported/maintained at all. It is a
matter of style and I was wondering if we need to change the API
to pass address and page_size as a permanent solution.

Balbir Singh.
