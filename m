Return-Path: <arbab@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2zL34Ph4zDqKj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 05:35:07 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0HIY7Xw066033
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 13:35:04 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 281rb0h12h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 13:35:04 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.vnet.ibm.com>;
 Tue, 17 Jan 2017 13:35:03 -0500
Date: Tue, 17 Jan 2017 12:34:56 -0600
From: Reza Arbab <arbab@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 1/4] powerpc/mm: refactor radix physical page mapping
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-2-git-send-email-arbab@linux.vnet.ibm.com>
 <20170117064635.GB8963@dhcp-9-109-223-248.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20170117064635.GB8963@dhcp-9-109-223-248.in.ibm.com>
Message-Id: <20170117183456.4wzelaejta6w6f5m@arbab-vm>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks for your review!

On Tue, Jan 17, 2017 at 12:16:35PM +0530, Balbir Singh wrote:
>On Mon, Jan 16, 2017 at 01:07:43PM -0600, Reza Arbab wrote:
>> --- a/arch/powerpc/mm/pgtable-radix.c
>> +++ b/arch/powerpc/mm/pgtable-radix.c
>> @@ -107,54 +107,66 @@ int radix__map_kernel_page(unsigned long ea, unsigned long pa,
>>  	return 0;
>>  }
>>
>> +static inline void __meminit print_mapping(unsigned long start,
>> +					   unsigned long end,
>> +					   unsigned long size)
>> +{
>> +	if (end <= start)
>> +		return;
>
>Should we pr_err for start > end?

I think that would be overkill. The way this little inline is called, 
start > end is not possible. The real point is not to print anything if 
start == end. Using <= just seemed better in context.

>> +static int __meminit create_physical_mapping(unsigned long start,
>> +					     unsigned long end)
>> +{
>> +	unsigned long addr, mapping_size;
>> +
>> +	start = _ALIGN_UP(start, PAGE_SIZE);
>> +	for (addr = start; addr < end; addr += mapping_size) {
>> +		unsigned long gap, previous_size;
>> +		int rc;
>> +
>> +		gap = end - addr;
>> +		previous_size = mapping_size;
>> +
>> +		if (IS_ALIGNED(addr, PUD_SIZE) && gap >= PUD_SIZE &&
>> +		    mmu_psize_defs[MMU_PAGE_1G].shift)
>> +			mapping_size = PUD_SIZE;
>> +		else if (IS_ALIGNED(addr, PMD_SIZE) && gap >= PMD_SIZE &&
>> +			 mmu_psize_defs[MMU_PAGE_2M].shift)
>> +			mapping_size = PMD_SIZE;
>> +		else
>> +			mapping_size = PAGE_SIZE;
>> +
>> +		if (mapping_size != previous_size) {
>> +			print_mapping(start, addr, previous_size);
>> +			start = addr;
>> +		}
>> +
>> +		rc = radix__map_kernel_page((unsigned long)__va(addr), addr,
>> +					    PAGE_KERNEL_X, mapping_size);
>> +		if (rc)
>> +			return rc;
>
>Should we try a lower page size if map_kernel_page fails for this mapping_size?

The only way map_kernel_page can fail is -ENOMEM. If that's the case,
there's no way we're going to be able to map this range at all. Better 
to fail fast here, I would think.

-- 
Reza Arbab
