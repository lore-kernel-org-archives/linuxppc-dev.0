Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qp1hf5CyxzDqKH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 05:35:30 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 05:35:28 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 756102CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 05:35:25 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3HJZHY54915626
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 05:35:25 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3HJYqCT021832
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 05:34:52 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 18/68] powerpc/mm: Move hash and no hash code to
 separate files
In-Reply-To: <570B329E.8060607@gmail.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <570B329E.8060607@gmail.com>
Date: Sun, 17 Apr 2016 15:50:10 +0530
Message-ID: <87k2jwa65h.fsf@skywalker.in.ibm.com>
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

Balbir Singh <bsingharora@gmail.com> writes:
>> +
.......

>> +/*
>> + * map_kernel_page currently only called by __ioremap
>> + * map_kernel_page adds an entry to the ioremap page table
>> + * and adds an entry to the HPT, possibly bolting it
>> + */
>> +int map_kernel_page(unsigned long ea, unsigned long pa, unsigned long flags)
>> +{
>> +	pgd_t *pgdp;
>> +	pud_t *pudp;
>> +	pmd_t *pmdp;
>> +	pte_t *ptep;
>> +
>> +	if (slab_is_available()) {
>> +		pgdp = pgd_offset_k(ea);
>> +		pudp = pud_alloc(&init_mm, pgdp, ea);
>> +		if (!pudp)
>> +			return -ENOMEM;
>> +		pmdp = pmd_alloc(&init_mm, pudp, ea);
>> +		if (!pmdp)
>> +			return -ENOMEM;
>> +		ptep = pte_alloc_kernel(pmdp, ea);
>> +		if (!ptep)
>> +			return -ENOMEM;
>> +		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT,
>> +							  __pgprot(flags)));
>> +	} else {
>> +		/*
>> +		 * If the mm subsystem is not fully up, we cannot create a
>> +		 * linux page table entry for this mapping.  Simply bolt an
>> +		 * entry in the hardware page table.
>> +		 *
>> +		 */
>> +		if (htab_bolt_mapping(ea, ea + PAGE_SIZE, pa, flags,
>> +				      mmu_io_psize, mmu_kernel_ssize)) {
>> +			printk(KERN_ERR "Failed to do bolted mapping IO "
>> +			       "memory at %016lx !\n", pa);
>> +			return -ENOMEM;
>
> What happens when we do unmap this? I know this code has been around for a while
> so its not new

you mean iounmap ? it do call vunmap, which look for a linux page table
entry. If it is a bolt_mapping entry as above, we will not have a linux
page table entry and that unmap will not relaly remove the mapping. 

>
>> +		}
>> +	}
>> +
>> +	smp_wmb();
>> +	return 0;
>> +}

-aneesh
