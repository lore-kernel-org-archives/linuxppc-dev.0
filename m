Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zfzvh1CBwzDqXw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 19:52:47 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1C8pqZe019449
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 03:52:45 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g377ahc3s-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 03:52:45 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 12 Feb 2018 08:52:43 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/mm/radix: Update pte fragment count from 16
 to 256 on radix
In-Reply-To: <20180212084911.14841-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180212084911.14841-1-aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 14:22:37 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877eriio8a.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> This needs more performance test. But right now we are wasting lot of space
> in the level 4 page table.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/hash-64k.h  | 9 ++++-----
>  arch/powerpc/include/asm/book3s/64/radix-64k.h | 8 ++++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 3bcf269f8f55..688f9018302e 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -24,16 +24,15 @@
>
>  /* PTE flags to conserve for HPTE identification */
>  #define _PAGE_HPTEFLAGS (H_PAGE_BUSY | H_PAGE_HASHPTE | H_PAGE_COMBO)
> -/*
> - * we support 16 fragments per PTE page of 64K size.
> - */
> -#define H_PTE_FRAG_NR	16
>  /*
>   * We use a 2K PTE page fragment and another 2K for storing
>   * real_pte_t hash index
>   */
>  #define H_PTE_FRAG_SIZE_SHIFT  12
> -#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
> +/*
> + * we support 16 fragments per PTE page of 64K size.
> + */
> +#define H_PTE_FRAG_NR	(PAGE_SIZE >> RADIX_PTE_FRAG_SIZE_SHIFT)
>
>  #ifndef __ASSEMBLY__
>  #include <asm/errno.h>
> diff --git a/arch/powerpc/include/asm/book3s/64/radix-64k.h b/arch/powerpc/include/asm/book3s/64/radix-64k.h
> index c7e71ba29555..8029732bb6c4 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix-64k.h
> @@ -10,4 +10,12 @@
>  #define RADIX_PUD_INDEX_SIZE	 9
>  #define RADIX_PGD_INDEX_SIZE  13
>
> +/*
> + * We use a 256 byte PTE page fragment in radix
> + */
> +#define RADIX_PTE_FRAG_SIZE_SHIFT  8
> +/*
> + * we support 16 fragments per PTE page of 64K size.
> + */
> +#define RADIX_PTE_FRAG_NR	(PAGE_SIZE >> RADIX_PTE_FRAG_SIZE_SHIFT)
>  #endif /* _ASM_POWERPC_PGTABLE_RADIX_64K_H */


missed git refresh

diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 27d096610369..404cdd74bc9c 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -561,8 +561,8 @@ void __init radix__early_init_mmu(void)
 	/*
 	 * For now radix also use the same frag size
 	 */
-	__pte_frag_nr = H_PTE_FRAG_NR;
-	__pte_frag_size_shift = H_PTE_FRAG_SIZE_SHIFT;
+	__pte_frag_nr = RADIX_PTE_FRAG_NR;
+	__pte_frag_size_shift = RADIX_PTE_FRAG_SIZE_SHIFT;
 
 	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
 		radix_init_native();
