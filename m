Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41x2wF0mmlzF2vj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 21:57:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/mm/hash: Only need the Nest MMU workaround
 for R -> RW transition
In-Reply-To: <20180823192319.5f06041f@roar.ozlabs.ibm.com>
References: <20180822171605.15054-1-aneesh.kumar@linux.ibm.com>
 <20180822171605.15054-2-aneesh.kumar@linux.ibm.com>
 <20180823192319.5f06041f@roar.ozlabs.ibm.com>
Date: Thu, 23 Aug 2018 21:57:32 +1000
Message-ID: <877ekhl2hf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Wed, 22 Aug 2018 22:46:05 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>
>> The Nest MMU workaround is only needed for RW upgrades. Avoid doing that
>> for other pte updates.
>> 
>> We also avoid clearing the pte while marking it invalid. This is because other
>> page table walk will find this pte none and can result in unexpected behaviour
>> due to that. Instead we clear _PAGE_PRESENT and set the software pte bit
>> _PAGE_INVALID. pte_present is already updated to check for bot the bits. This
>> make sure page table walkers will find the pte present and things like
>> pte_pfn(pte) returns the right value.
>> 
>> Based on the original patch from Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  arch/powerpc/mm/pgtable-radix.c | 8 +++++---
>
> This is powerpc/mm/radix, isn't it? Subject says hash.

I fixed it when applying.

> Could we make this fix POWER9 only and use a RSV bit for it
> rather than use up a SW bit? Other than that,
>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks.

cheers
