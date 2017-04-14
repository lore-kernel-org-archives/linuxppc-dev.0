Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w4TWq3tK8zDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Apr 2017 06:19:02 +1000 (AEST)
Date: Fri, 14 Apr 2017 22:18:57 +0200
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org, Anshuman Khandual
 <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] selftests/powerpc/mm: Add a test for virtual address
 mapping
Message-ID: <20170414221857.58171fce@neko>
In-Reply-To: <20170412094112.13181-1-khandual@linux.vnet.ibm.com>
References: <20170412094112.13181-1-khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, 12 Apr 2017 15:11:12 +0530
Anshuman Khandual <khandual@linux.vnet.ibm.com> wrote:

> This verifies virtual address mapping below and above the
> 128TB range and makes sure that address returned are within
> the expected range depending upon the hint passed from the
> user space.

This description does not mention anything PPC specific. Can this be
generalized to work with Intel L5 enabled kernel as well?

Thanks

Michal

> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
> Tested this on latest ppc-next with Aneesh's yesterday's patch
> which can be found at https://patchwork.ozlabs.org/patch/749510/
> 
>  tools/testing/selftests/powerpc/mm/.gitignore |  3 +-
>  tools/testing/selftests/powerpc/mm/Makefile   |  2 +-
>  tools/testing/selftests/powerpc/mm/vaddr.c    | 89
> +++++++++++++++++++++++++++ 3 files changed, 92 insertions(+), 2
> deletions(-) create mode 100644
> tools/testing/selftests/powerpc/mm/vaddr.c
> 
> diff --git a/tools/testing/selftests/powerpc/mm/.gitignore
> b/tools/testing/selftests/powerpc/mm/.gitignore index
> e715a3f..af1f31f 100644 ---
> a/tools/testing/selftests/powerpc/mm/.gitignore +++
> b/tools/testing/selftests/powerpc/mm/.gitignore @@ -1,4 +1,5 @@
>  hugetlb_vs_thp_test
>  subpage_prot
>  tempfile
> -prot_sao
> \ No newline at end of file
> +prot_sao
> +vaddr
> diff --git a/tools/testing/selftests/powerpc/mm/Makefile
> b/tools/testing/selftests/powerpc/mm/Makefile index 1cffe54..7345db2
> 100644 --- a/tools/testing/selftests/powerpc/mm/Makefile
> +++ b/tools/testing/selftests/powerpc/mm/Makefile
> @@ -1,7 +1,7 @@
>  noarg:
>  	$(MAKE) -C ../
>  
> -TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao
> +TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao vaddr
>  TEST_GEN_FILES := tempfile
>  
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/powerpc/mm/vaddr.c
> b/tools/testing/selftests/powerpc/mm/vaddr.c new file mode 100644
> index 0000000..d6485e9
> --- /dev/null
> +++ b/tools/testing/selftests/powerpc/mm/vaddr.c
> @@ -0,0 +1,89 @@
> +/*
> + * Copyright 2017, Anshuman Khandual, IBM Corp.
> + * Licensed under GPLv2.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <numaif.h>
> +#include <sys/mman.h>
> +#include <sys/time.h>
> +#include "utils.h"
> +
> +#define PAGE_SIZE        65536UL  /* 64KB */
> +#define MAP_SIZE_16GB    262144UL /* 16GB  */
> +#define NR_SLICES_128TB  8192UL   /* 128TB */
> +#define NR_SLICES_384TB  24576UL  /* 384TB */
> +#define ADDR_MARK_128TB  0x800000000000UL /* Beyond 128TB */
> +
> +static char *hind_addr(void)
> +{
> +	int bits = 48 + rand() % 15;
> +
> +	return (char *) (1UL << bits);
> +}
> +
> +static int validate_addr(char *ptr, int high_addr)
> +{
> +	unsigned long addr = (unsigned long) ptr;
> +
> +	if (high_addr) {
> +		if (addr < ADDR_MARK_128TB) {
> +			printf("Bad address %lx\n", addr);
> +			return 1;
> +		}
> +		return 0;
> +	}
> +
> +	if (addr > ADDR_MARK_128TB) {
> +		printf("Bad address %lx\n", addr);
> +		return 1;
> +	}
> +	return 0;
> +}
> +
> +int vaddr(void)
> +{
> +	char *ptr[NR_SLICES_128TB];
> +	char *hptr[NR_SLICES_384TB];
> +	char *hint;
> +	int  i;
> +
> +	for (i = 0; i < NR_SLICES_128TB; i++) {
> +		ptr[i] = mmap(NULL, MAP_SIZE_16GB, PROT_READ |
> PROT_WRITE,
> +					MAP_PRIVATE | MAP_ANONYMOUS,
> -1, 0); +
> +		if (ptr[i] == MAP_FAILED)
> +			break;
> +
> +		if (validate_addr(ptr[i], 0))
> +			return 1;
> +	}
> +
> +	for (i = 0; i < NR_SLICES_384TB; i++) {
> +		hint = hind_addr();
> +		hptr[i] = mmap(hint, MAP_SIZE_16GB, PROT_READ |
> PROT_WRITE,
> +					MAP_PRIVATE | MAP_ANONYMOUS,
> -1, 0); +
> +		if (hptr[i] == MAP_FAILED)
> +			break;
> +
> +		if (validate_addr(hptr[i], 1))
> +			return 1;
> +	}
> +
> +	for (i = 0; i < NR_SLICES_128TB; i++)
> +		munmap(ptr[i], MAP_SIZE_16GB);
> +
> +	for (i = 0; i < NR_SLICES_384TB; i++)
> +		munmap(hptr[i], MAP_SIZE_16GB);
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	return test_harness(vaddr, "vaddr-range");
> +}
