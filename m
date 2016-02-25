Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 94DBB1A0035
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 16:41:09 +1100 (AEDT)
Date: Thu, 25 Feb 2016 16:41:06 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 11/18] powerpc/mm: Hugetlbfs is book3s_64 and
 fsl_book3e (32 or 64)
Message-ID: <20160225054106.GH18753@oak.ozlabs.ibm.com>
References: <1456202900-5454-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1456202900-5454-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456202900-5454-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 23, 2016 at 10:18:13AM +0530, Aneesh Kumar K.V wrote:
> We move large part of fsl related code to hugetlbpage-book3e.c.
> Only code movement. This also avoid #ifdef in the code.
> 
> Eventhough we allow hugetlbfs only for book3s 64 and fsl book3e, I am
> still retaining the #ifdef in hugetlbpage-book3e.c. It looks like there
> was an attempt to support hugetlbfs on other non hash platforms. I
> didn't want to loose that work.

Well... that stuff is always in git.  It seems that the only 64-bit
non-Freescale Book E platform we had was A2, and that code got deleted
because the product was never released.

You get rid of some but not all of the ifdefs in hugetlbpage-book3e.c,
and the result is a bit confusing (see below).  In fact that file will
only get compiled for Freescale Book E processors, because the
Makefile has an ifdef on HUGETLB_PAGE, which ultimately depends on
SYS_SUPPORTS_HUGETLBFS, which is only set for Freescale Book E and
64-bit server.

However, a larger question is why this cleanup is necessary for
preparing for the radix tree.  Nothing in the following patches in
this series seems to depend on this patch.

> diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
> index 7e6d0880813f..4c43a104e35c 100644
> --- a/arch/powerpc/mm/hugetlbpage-book3e.c
> +++ b/arch/powerpc/mm/hugetlbpage-book3e.c
> @@ -7,6 +7,39 @@
>   */
>  #include <linux/mm.h>
>  #include <linux/hugetlb.h>
> +#include <linux/bootmem.h>
> +#include <linux/moduleparam.h>
> +#include <linux/memblock.h>
> +#include <asm/tlb.h>
> +#include <asm/setup.h>
> +
> +/*
> + * Tracks gpages after the device tree is scanned and before the
> + * huge_boot_pages list is ready.  On non-Freescale implementations, this is
> + * just used to track 16G pages and so is a single array.  FSL-based
> + * implementations may have more than one gpage size, so we need multiple
> + * arrays
> + */

This comment should be fixed to refer only to FSL implementations.

> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +#define MAX_NUMBER_GPAGES	128
> +struct psize_gpages {
> +	u64 gpage_list[MAX_NUMBER_GPAGES];
> +	unsigned int nr_gpages;
> +};
> +static struct psize_gpages gpage_freearray[MMU_PAGE_COUNT];
> +#endif
> +
> +/*
> + * These macros define how to determine which level of the page table holds
> + * the hpdp.
> + */
> +#ifdef CONFIG_PPC_FSL_BOOK3E
> +#define HUGEPD_PGD_SHIFT PGDIR_SHIFT
> +#define HUGEPD_PUD_SHIFT PUD_SHIFT
> +#else
> +#define HUGEPD_PGD_SHIFT PUD_SHIFT
> +#define HUGEPD_PUD_SHIFT PMD_SHIFT
> +#endif

This ifdef is confusing, because the other code you are adding to this
file only handles the FSL hugepd scheme.

> diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
> index 08efcad7cae0..821f5213d925 100644
> --- a/arch/powerpc/mm/hugetlbpage-hash64.c
> +++ b/arch/powerpc/mm/hugetlbpage-hash64.c
> @@ -14,6 +14,17 @@
>  #include <asm/cacheflush.h>
>  #include <asm/machdep.h>
>  
> +/*
> + * Tracks gpages after the device tree is scanned and before the
> + * huge_boot_pages list is ready.  On non-Freescale implementations, this is
> + * just used to track 16G pages and so is a single array.  FSL-based
> + * implementations may have more than one gpage size, so we need multiple
> + * arrays
> + */

This comment should be fixed to not refer to FSL-based
implementations.

Paul.
