Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tv3p13fxhzDqMq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 08:28:25 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v04LDbX6027671
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 16:28:23 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27s3tvckeu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 16:28:22 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Wed, 4 Jan 2017 14:28:22 -0700
Date: Wed, 4 Jan 2017 15:28:17 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v4 3/4] powerpc/mm: add radix__remove_section_mapping()
References: <1483476218-17271-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1483476218-17271-4-git-send-email-arbab@linux.vnet.ibm.com>
 <8760lv76q9.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <8760lv76q9.fsf@linux.vnet.ibm.com>
Message-Id: <20170104212817.qbrrbebq3ordfmnc@arbab-laptop.austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 04, 2017 at 10:37:58AM +0530, Aneesh Kumar K.V wrote:
>Reza Arbab <arbab@linux.vnet.ibm.com> writes:
>> +static void remove_pagetable(unsigned long start, unsigned long end)
>> +{
>> +	unsigned long addr, next;
>> +	pud_t *pud_base;
>> +	pgd_t *pgd;
>> +
>> +	spin_lock(&init_mm.page_table_lock);
>> +
>> +	for (addr = start; addr < end; addr = next) {
>> +		next = pgd_addr_end(addr, end);
>> +
>> +		pgd = pgd_offset_k(addr);
>> +		if (!pgd_present(*pgd))
>> +			continue;
>> +
>> +		if (pgd_huge(*pgd)) {
>> +			pte_clear(&init_mm, addr, (pte_t *)pgd);
>> +			continue;
>> +		}
>> +
>> +		pud_base = (pud_t *)pgd_page_vaddr(*pgd);
>> +		remove_pud_table(pud_base, addr, next);
>> +		free_pud_table(pud_base, pgd);
>> +	}
>> +
>> +	spin_unlock(&init_mm.page_table_lock);
>
>What is this lock protecting ?

The more I look into it, I'm not sure. This is still an artifact from 
the x86 functions, where they lock/unlock agressively, as you and Ben 
noted. I can take it out. 

>> +	flush_tlb_kernel_range(start, end);
>
>We can use radix__flush_tlb_kernel_range avoiding an if
>(radix_enabled()) conditional ?

Yes, good idea.

>(radix_enabled()) conditional ? Also if needed we could make all the
>above take a radix__ prefix ?

You mean rename all these new functions? We could, but I don't really 
see why. These functions are static to pgtable-radix.c, there aren't 
hash__ versions to differentiate from, and it seemed helpful to mirror 
the x86 names.

-- 
Reza Arbab
