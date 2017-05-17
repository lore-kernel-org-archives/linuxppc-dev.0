Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSQCx6RmPzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 16:59:25 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4H6xGN7005871
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 02:59:18 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2agemcyms1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 02:59:17 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 17 May 2017 00:59:09 -0600
Subject: Re: [PATCH] powerpc/mm/hugetlb: Add support for reserving gigantic
 huge pages via kernel command line
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
References: <1494926691-24664-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <768f38fe-d2ad-df4a-19e3-910b4a584614@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 17 May 2017 12:29:01 +0530
MIME-Version: 1.0
In-Reply-To: <768f38fe-d2ad-df4a-19e3-910b4a584614@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <ae83b995-5f14-2c1d-3815-0816f0dc8f02@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 17 May 2017 10:31 AM, Anshuman Khandual wrote:
> On 05/16/2017 02:54 PM, Aneesh Kumar K.V wrote:
>> +void __init reserve_hugetlb_gpages(void)
>> +{
>> +	char buf[10];
>> +	phys_addr_t base;
>> +	unsigned long gpage_size = 1UL << 34;
>> +	static __initdata char cmdline[COMMAND_LINE_SIZE];
>> +
>> +	if (radix_enabled())
>> +		gpage_size = 1UL << 30;
>> +
>> +	strlcpy(cmdline, boot_command_line, COMMAND_LINE_SIZE);
>> +	parse_args("hugetlb gpages", cmdline, NULL, 0, 0, 0,
>> +		   NULL, &do_gpage_early_setup);
>> +
>> +	if (!gpage_npages)
>> +		return;
>> +
>> +	string_get_size(gpage_size, 1, STRING_UNITS_2, buf, sizeof(buf));
>> +	pr_info("Trying to reserve %ld %s pages\n", gpage_npages, buf);
>> +
>> +	/* Allocate one page at a time */
>> +	while(gpage_npages) {
>> +		base = memblock_alloc_base(gpage_size, gpage_size,
>> +					   MEMBLOCK_ALLOC_ANYWHERE);
>> +		add_gpage(base, gpage_size, 1);
>
> For 16GB pages (1UL << 34) on POWER8, we already do these functions
> inside htab_dt_scan_hugepage_blocks(). IIUC this happens just by
> scanning DT without even specifying any gpages in kernel command
> line.
>
> memblock_reserve()
> add_gpage()
>
> Then attempting to allocate from memblock and adding it again into
> gigantic pages list wont collide ?

That is for pseries.ie, pSeries will get the hugpages reserved by phyp 
and the details of those pages are passed via device tree. Not sure what 
is the conflict here. If we use the above kernel parameter, we will try 
to allocate another 'x' number of hugepages.

> More over its trying to allocate
> across the RAM not specifically on the gpages mentioned in device
> tree by the platform. Are we trying to support 16GB pages just from
> any memory without platform notification through DT ?
>

There are two ways to specify gpages, one via device tree which is used 
only in case of pseries and other hugepagesz=size hugepags=no-of-hugepages.

-aneesh
