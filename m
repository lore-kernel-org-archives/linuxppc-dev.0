Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6V8G2bbHzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 12:54:06 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3I2rWlA080500
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 22:54:00 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29w0e1nast-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Apr 2017 22:54:00 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 18 Apr 2017 08:23:56 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3I2rtSw21626972
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 08:23:55 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3I2rsWV015722
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 08:23:54 +0530
Subject: Re: [PATCH] selftests/powerpc/mm: Add a test for virtual address
 mapping
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20170412094112.13181-1-khandual@linux.vnet.ibm.com>
 <87inm3haej.fsf@skywalker.in.ibm.com>
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 18 Apr 2017 08:23:53 +0530
MIME-Version: 1.0
In-Reply-To: <87inm3haej.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <7aa0c002-cd4a-2fb3-9766-904678b1efd5@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/17/2017 10:56 AM, Aneesh Kumar K.V wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> This verifies virtual address mapping below and above the
>> 128TB range and makes sure that address returned are within
>> the expected range depending upon the hint passed from the
>> user space.
>>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>> Tested this on latest ppc-next with Aneesh's yesterday's patch
>> which can be found at https://patchwork.ozlabs.org/patch/749510/
>>
>>  tools/testing/selftests/powerpc/mm/.gitignore |  3 +-
>>  tools/testing/selftests/powerpc/mm/Makefile   |  2 +-
>>  tools/testing/selftests/powerpc/mm/vaddr.c    | 89 +++++++++++++++++++++++++++
>>  3 files changed, 92 insertions(+), 2 deletions(-)
>>  create mode 100644 tools/testing/selftests/powerpc/mm/vaddr.c
>>
>> diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
>> index e715a3f..af1f31f 100644
>> --- a/tools/testing/selftests/powerpc/mm/.gitignore
>> +++ b/tools/testing/selftests/powerpc/mm/.gitignore
>> @@ -1,4 +1,5 @@
>>  hugetlb_vs_thp_test
>>  subpage_prot
>>  tempfile
>> -prot_sao
>> \ No newline at end of file
>> +prot_sao
>> +vaddr
>> diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
>> index 1cffe54..7345db2 100644
>> --- a/tools/testing/selftests/powerpc/mm/Makefile
>> +++ b/tools/testing/selftests/powerpc/mm/Makefile
>> @@ -1,7 +1,7 @@
>>  noarg:
>>  	$(MAKE) -C ../
>>
>> -TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao
>> +TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao vaddr
>>  TEST_GEN_FILES := tempfile
>>
>>  include ../../lib.mk
>> diff --git a/tools/testing/selftests/powerpc/mm/vaddr.c b/tools/testing/selftests/powerpc/mm/vaddr.c
>> new file mode 100644
>> index 0000000..d6485e9
>> --- /dev/null
>> +++ b/tools/testing/selftests/powerpc/mm/vaddr.c
>> @@ -0,0 +1,89 @@
>> +/*
>> + * Copyright 2017, Anshuman Khandual, IBM Corp.
>> + * Licensed under GPLv2.
>> + */
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <string.h>
>> +#include <unistd.h>
>> +#include <errno.h>
>> +#include <numaif.h>
>> +#include <sys/mman.h>
>> +#include <sys/time.h>
>> +#include "utils.h"
>> +
>> +#define PAGE_SIZE        65536UL  /* 64KB */
>> +#define MAP_SIZE_16GB    262144UL /* 16GB  */
> 
> can we make it MMAP_CHUNK_SIZE ?

Sure, will do.

> 
>> +#define NR_SLICES_128TB  8192UL   /* 128TB */
> 
> NR_CHUNK_128TB ?

Sure, will do.

> 
>> +#define NR_SLICES_384TB  24576UL  /* 384TB */
> 
> Can you add more comments around that. Those numbers/names have special
> meaning on powerpc. I guess you are not doing anything related that.
> Hence rename slices to something else or add a comment saying how many
> 16GB slices. 

Sure will rename as CHUNKS instead.

> Also explain why you are taking 16GB as the size.

Sure, will do.

> 
>> +#define ADDR_MARK_128TB  0x800000000000UL /* Beyond 128TB */
>> +
>> +static char *hind_addr(void)
>> +{
>> +	int bits = 48 + rand() % 15;
>> +
>> +	return (char *) (1UL << bits);
>> +}
>> +
>> +static int validate_addr(char *ptr, int high_addr)
>> +{
>> +	unsigned long addr = (unsigned long) ptr;
>> +
>> +	if (high_addr) {
>> +		if (addr < ADDR_MARK_128TB) {
>> +			printf("Bad address %lx\n", addr);
>> +			return 1;
>> +		}
>> +		return 0;
>> +	}
>> +
>> +	if (addr > ADDR_MARK_128TB) {
>> +		printf("Bad address %lx\n", addr);
>> +		return 1;
>> +	}
>> +	return 0;
>> +}
>> +
>> +int vaddr(void)
>> +{
>> +	char *ptr[NR_SLICES_128TB];
>> +	char *hptr[NR_SLICES_384TB];
>> +	char *hint;
>> +	int  i;
>> +
>> +	for (i = 0; i < NR_SLICES_128TB; i++) {
>> +		ptr[i] = mmap(NULL, MAP_SIZE_16GB, PROT_READ | PROT_WRITE,
>> +					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> +
>> +		if (ptr[i] == MAP_FAILED)
>> +			break;
>> +
>> +		if (validate_addr(ptr[i], 0))
>> +			return 1;
>> +	}
>> +
>> +	for (i = 0; i < NR_SLICES_384TB; i++) {
>> +		hint = hind_addr();
> 
> Why add rand() why not a constant value ?

Because it can test hint address range starting from 128TB till 2^64.

> 
>> +		hptr[i] = mmap(hint, MAP_SIZE_16GB, PROT_READ | PROT_WRITE,
>> +					MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>> +
>> +		if (hptr[i] == MAP_FAILED)
>> +			break;
>> +
>> +		if (validate_addr(hptr[i], 1))
>> +			return 1;
>> +	}
> 
> We can also add check to make sure mmap fail if we passed a hint addr
> below 128TB ? 

After all of the range lower to the 128TB address is mapped ?
