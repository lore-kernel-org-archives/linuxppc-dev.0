Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tj8Bd71npzDwH8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 05:11:53 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBJI8Ujr117695
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 13:11:52 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27egp48q3c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 13:11:51 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Mon, 19 Dec 2016 11:11:51 -0700
Date: Mon, 19 Dec 2016 12:11:45 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v3 4/5] powerpc/mm: add radix__remove_section_mapping()
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-5-git-send-email-arbab@linux.vnet.ibm.com>
 <87wpewtfl4.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <87wpewtfl4.fsf@linux.vnet.ibm.com>
Message-Id: <20161219181145.byelpwc2gnwxxkxe@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 19, 2016 at 03:18:07PM +0530, Aneesh Kumar K.V wrote:
>Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>> +static void remove_pte_table(pte_t *pte_start, unsigned long addr,
>> +			     unsigned long end)
>> +{
>> +	unsigned long next;
>> +	pte_t *pte;
>> +
>> +	pte = pte_start + pte_index(addr);
>> +	for (; addr < end; addr = next, pte++) {
>> +		next = (addr + PAGE_SIZE) & PAGE_MASK;
>> +		if (next > end)
>> +			next = end;
>> +
>> +		if (!pte_present(*pte))
>> +			continue;
>> +
>> +		spin_lock(&init_mm.page_table_lock);
>> +		pte_clear(&init_mm, addr, pte);
>> +		spin_unlock(&init_mm.page_table_lock);
>> +	}
>> +
>> +	flush_tlb_mm(&init_mm);
>
>Why call a flush here. we do that at the end of remove_page_table .
>Isn't that sufficient ?

This was carried over from the x86 version of the function, where they 
do flush_tlb_all(). I can experiment to make sure things work without 
it.

>> +static void remove_pagetable(unsigned long start, unsigned long end,
>> +			     unsigned long map_page_size)
>> +{
>> +	unsigned long next;
>> +	unsigned long addr;
>> +	pgd_t *pgd;
>> +	pud_t *pud;
>> +
>> +	for (addr = start; addr < end; addr = next) {
>> +		next = pgd_addr_end(addr, end);
>> +
>> +		pgd = pgd_offset_k(addr);
>> +		if (!pgd_present(*pgd))
>> +			continue;
>> +
>> +		pud = (pud_t *)pgd_page_vaddr(*pgd);
>> +		remove_pud_table(pud, addr, next, map_page_size);
>> +		free_pud_table(pud, pgd);
>> +	}
>> +
>> +	flush_tlb_mm(&init_mm);
>
>
>So we want to flush the full kernel tlb when we do a hotplug ?
>May be check using flush_tlb_kernel_range(). Also that flush_tlb_mm() do
>check for mm_is_thread_local(). Do we update init_mm correct to handle
>that check ? I assume we want a tlbie() here instead of tlbiel() ?

I'll try using flush_tlb_kernel_range() instead. That sure does seem 
more appropriate.

-- 
Reza Arbab
