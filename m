Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qg1wt5dZ7zDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 20:21:50 +1000 (AEST)
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 15:51:45 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u36ALYVQ8519782
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 15:51:34 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u36FkphG001581
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 21:19:54 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michal Hocko <mhocko@kernel.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 James Dykman <jdykman@us.ibm.com>
Subject: Re: [PATCH 1/1] powerpc/mm: Add memory barrier in __hugepte_alloc()
In-Reply-To: <20160406095623.GA24283@dhcp22.suse.cz>
References: <20160405190547.GA12673@us.ibm.com>
 <20160406095623.GA24283@dhcp22.suse.cz>
Date: Wed, 06 Apr 2016 15:39:17 +0530
Message-ID: <8737qzxd4i.fsf@linux.vnet.ibm.com>
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

Michal Hocko <mhocko@kernel.org> writes:

> [ text/plain ]
> On Tue 05-04-16 12:05:47, Sukadev Bhattiprolu wrote:
> [...]
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index d991b9e..081f679 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -81,6 +81,13 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
>>  	if (! new)
>>  		return -ENOMEM;
>>  
>> +	/*
>> +	 * Make sure other cpus find the hugepd set only after a
>> +	 * properly initialized page table is visible to them.
>> +	 * For more details look for comment in __pte_alloc().
>> +	 */
>> +	smp_wmb();
>> +
>
> what is the pairing memory barrier?
>
>>  	spin_lock(&mm->page_table_lock);
>>  #ifdef CONFIG_PPC_FSL_BOOK3E
>>  	/*

This is documented in __pte_alloc(). I didn't want to repeat the same
here.

	/*
	 * Ensure all pte setup (eg. pte page lock and page clearing) are
	 * visible before the pte is made visible to other CPUs by being
	 * put into page tables.
	 *
	 * The other side of the story is the pointer chasing in the page
	 * table walking code (when walking the page table without locking;
	 * ie. most of the time). Fortunately, these data accesses consist
	 * of a chain of data-dependent loads, meaning most CPUs (alpha
	 * being the notable exception) will already guarantee loads are
	 * seen in-order. See the alpha page table accessors for the
	 * smp_read_barrier_depends() barriers in page table walking code.
	 */
	smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */


-aneesh
