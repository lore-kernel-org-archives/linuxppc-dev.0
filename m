Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40D191A0038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 22:08:29 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 22:08:27 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ECDD52CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 22:08:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8UC8EOT39911470
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 22:08:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8UC7oB2032663
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 22:07:50 +1000
Message-ID: <560BD07B.60202@linux.vnet.ibm.com>
Date: Wed, 30 Sep 2015 17:37:23 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 19/31] powerpc/mm: Convert 4k hash insert to C
References: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1443580044-30659-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1443580044-30659-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/30/2015 07:57 AM, Aneesh Kumar K.V wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/Makefile        |   3 +
>  arch/powerpc/mm/hash64_64k.c    | 202 +++++++++++++++++++++
>  arch/powerpc/mm/hash_low_64.S   | 380 ----------------------------------------
>  arch/powerpc/mm/hash_utils_64.c |   4 +-
>  4 files changed, 208 insertions(+), 381 deletions(-)
>  create mode 100644 arch/powerpc/mm/hash64_64k.c
> 
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index 3eb73a38220d..f80ad1a76cc8 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -18,6 +18,9 @@ obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o
>  obj-$(CONFIG_PPC_STD_MMU)	+= hash_low_$(CONFIG_WORD_SIZE).o \
>  				   tlb_hash$(CONFIG_WORD_SIZE).o \
>  				   mmu_context_hash$(CONFIG_WORD_SIZE).o
> +ifeq ($(CONFIG_PPC_STD_MMU_64),y)
> +obj-$(CONFIG_PPC_64K_PAGES)	+= hash64_64k.o
> +endif
>  obj-$(CONFIG_PPC_ICSWX)		+= icswx.o
>  obj-$(CONFIG_PPC_ICSWX_PID)	+= icswx_pid.o
>  obj-$(CONFIG_40x)		+= 40x_mmu.o
> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> new file mode 100644
> index 000000000000..b137e50a3e57
> --- /dev/null
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -0,0 +1,202 @@
> +/*
> + * Copyright IBM Corporation, 2015
> + * Author Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of version 2.1 of the GNU Lesser General Public License
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + */
> +
> +#include <linux/mm.h>
> +#include <asm/machdep.h>
> +#include <asm/mmu.h>
> +
> +int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
> +		   pte_t *ptep, unsigned long trap, unsigned long flags,
> +		   int ssize, int subpg_prot)
> +{
> +	real_pte_t rpte;
> +	unsigned long *hidxp;
> +	unsigned long hpte_group;
> +	unsigned int subpg_index;
> +	unsigned long shift = 12; /* 4K */
> +	unsigned long rflags, pa, hidx;
> +	unsigned long old_pte, new_pte, subpg_pte;
> +	unsigned long vpn, hash, slot;
> +
> +	/*
> +	 * atomically mark the linux large page PTE busy and dirty
> +	 */
> +	do {
> +		pte_t pte = READ_ONCE(*ptep);
> +
> +		old_pte = pte_val(pte);
> +		/* If PTE busy, retry the access */

Small nit, need a gap between the above two lines ?

> +		if (unlikely(old_pte & _PAGE_BUSY))
> +			return 0;
> +		/* If PTE permissions don't match, take page fault */

We are already in page fault interrupt path,  will it be better
if we call it "take Linux page fault" instead as we will go back
walking the page table.
