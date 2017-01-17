Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2zMd73wVzDqD0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 05:36:29 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0HIXnTw029479
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 13:36:27 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 281qd83num-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 13:36:27 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Tue, 17 Jan 2017 11:36:26 -0700
Date: Tue, 17 Jan 2017 12:36:21 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 3/4] powerpc/mm: add radix__remove_section_mapping()
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-4-git-send-email-arbab@linux.vnet.ibm.com>
 <20170117072251.GD8963@dhcp-9-109-223-248.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20170117072251.GD8963@dhcp-9-109-223-248.in.ibm.com>
Message-Id: <20170117183620.y4kkxacuo6p7r5lb@arbab-vm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 17, 2017 at 12:52:51PM +0530, Balbir Singh wrote:
>Shouldn't most of these functions have __meminit?

I don't think so. The mapping functions are __meminit, but the unmapping 
functions are completely within #ifdef CONFIG_MEMORY_HOTPLUG already.

>On Mon, Jan 16, 2017 at 01:07:45PM -0600, Reza Arbab wrote:
>>  #ifdef CONFIG_MEMORY_HOTPLUG
>> +static void free_pte_table(pte_t *pte_start, pmd_t *pmd)
>> +{
>> +	pte_t *pte;
>> +	int i;
>> +
>> +	for (i = 0; i < PTRS_PER_PTE; i++) {
>> +		pte = pte_start + i;
>> +		if (!pte_none(*pte))
>> +			return;
>
>If !pte_none() we fail the hotplug? Or silently
>leave the allocated pte's around. I guess this is
>the same as x86

The latter--it's not a failure. If you provided remove_pagetable() an 
unaligned address range, there could be a pte left unremoved at either 
end.

>> +static void remove_pmd_table(pmd_t *pmd_start, unsigned long addr,
>> +			     unsigned long end)
>> +{
>> +	unsigned long next;
>> +	pte_t *pte_base;
>> +	pmd_t *pmd;
>> +
>> +	pmd = pmd_start + pmd_index(addr);
>> +	for (; addr < end; addr = next, pmd++) {
>> +		next = pmd_addr_end(addr, end);
>> +
>> +		if (!pmd_present(*pmd))
>> +			continue;
>> +
>> +		if (pmd_huge(*pmd)) {
>> +			pte_clear(&init_mm, addr, (pte_t *)pmd);
>
>pmd_clear()?

I used pte_clear() to mirror what happens in radix__map_kernel_page():

		if (map_page_size == PMD_SIZE) {
			ptep = (pte_t *)pmdp;
			goto set_the_pte;
		}

		[...]

	set_the_pte:
		set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, flags));

Would pmd_clear() be equivalent, since the pointer got set like a pte?

>> +static void remove_pagetable(unsigned long start, unsigned long end)
>> +{
>> +	unsigned long addr, next;
>> +	pud_t *pud_base;
>> +	pgd_t *pgd;
>> +
>> +	spin_lock(&init_mm.page_table_lock);
>> +
>
>x86 does more granular lock acquisition only during
>clearing the relevant entries. I suppose we don't have
>to worry about it since its not fast path and frequent.

Yep. Ben thought the locking in remove_pte_table() was actually too 
granular, and Aneesh questioned what was being protected in the first 
place. So I left one lock/unlock in the outermost function for now.

-- 
Reza Arbab
