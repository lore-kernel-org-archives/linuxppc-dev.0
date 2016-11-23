Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP1230D2tzDw70
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 22:53:30 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uANBnJrf105038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:53:28 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26w6hpnyt4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:53:28 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 23 Nov 2016 04:53:27 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5 1/7] powerpc/mm: update ptep_set_access_flag to not do
 full mm tlb flush
In-Reply-To: <fe12e986-0c81-a71c-29a2-a8ca4ea2600c@gmail.com>
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
 <fe12e986-0c81-a71c-29a2-a8ca4ea2600c@gmail.com>
Date: Wed, 23 Nov 2016 17:23:21 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y40ah0pa.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 23/11/16 22:09, Aneesh Kumar K.V wrote:
>> When we are updating pte, we just need to flush the tlb mapping for
>> that pte. Right now we do a full mm flush because we don't track page
>> size. Update the interface to track the page size and use that to
>> do the right tlb flush.
>> 
>
> Could you also clarify the scope -- this seems to be _radix_ only.
> The problem statement is not very clear and why doesn't the flush_tlb_page()
> following ptep_set_access_flags() work? What else do we need to do?

Yes it modifies only radix part.  Don't understand the flush_tlb_page()
part of the comment above. We are modifying the tlbflush that we need to do in the pte update
sequence for DD1. ie, we need to do the flush before we can set the pte
with new value.

Also in this specific case, we can idealy drop that flush_tlb_page,
because relaxing an access really don't need a tlb flush from generic
architecture point of view. I left it there to make sure, we measure and
get the invalidate path correct before going ahead with that
optimization.


>
>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/book3s/32/pgtable.h |  4 +++-
>>  arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++++--
>>  arch/powerpc/include/asm/book3s/64/radix.h   | 14 +++++++-------
>>  arch/powerpc/include/asm/nohash/32/pgtable.h |  4 +++-
>>  arch/powerpc/include/asm/nohash/64/pgtable.h |  4 +++-
>>  arch/powerpc/mm/pgtable-book3s64.c           |  3 ++-
>>  arch/powerpc/mm/pgtable-radix.c              | 16 ++++++++++++++++
>>  arch/powerpc/mm/pgtable.c                    | 10 ++++++++--
>>  arch/powerpc/mm/tlb-radix.c                  | 15 ---------------
>>  9 files changed, 47 insertions(+), 30 deletions(-)
>> 

-aneesh
