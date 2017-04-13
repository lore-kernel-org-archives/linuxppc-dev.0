Return-Path: <srs0=czqw=3v=linux.vnet.ibm.com=aneesh.kumar@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3Q7G3JCKzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 12:42:34 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3w3Q7G2XsYz8vpx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 12:42:34 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3w3Q7F65gpz9s7f
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2017 12:42:33 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3D2Y4uV037509
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 22:42:31 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29srxt9a63-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Apr 2017 22:42:31 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 20:42:30 -0600
Subject: Re: [PATCH] powerpc/mm: Fix swapper_pg_dir size on 64-bit hash w/64K
 pages
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1491991867-8758-1-git-send-email-mpe@ellerman.id.au>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 08:12:18 +0530
MIME-Version: 1.0
In-Reply-To: <1491991867-8758-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c9c6fbda-a8ad-377f-4c89-dd92f2752733@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 12 April 2017 03:41 PM, Michael Ellerman wrote:
> Recently in commit f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB"),
> we increased H_PGD_INDEX_SIZE to 15 when we're building with 64K pages. This
> makes it larger than RADIX_PGD_INDEX_SIZE (13), which means the logic to
> calculate MAX_PGD_INDEX_SIZE in book3s/64/pgtable.h is wrong.
>
> The end result is that the PGD (Page Global Directory, ie top level page table)
> of the kernel (aka. swapper_pg_dir), is too small.
>
> This generally doesn't lead to a crash, as we don't use the full range in normal
> operation. However if we try to dump the kernel pagetables we can trigger a
> crash because we walk off the end of the pgd into other memory and eventually
> try to dereference something bogus:
>
>   $ cat /sys/kernel/debug/kernel_pagetables
>   Unable to handle kernel paging request for data at address 0xe8fece0000000000
>   Faulting instruction address: 0xc000000000072314
>   cpu 0xc: Vector: 380 (Data SLB Access) at [c0000000daa13890]
>       pc: c000000000072314: ptdump_show+0x164/0x430
>       lr: c000000000072550: ptdump_show+0x3a0/0x430
>      dar: e802cf0000000000
>   seq_read+0xf8/0x560
>   full_proxy_read+0x84/0xc0
>   __vfs_read+0x6c/0x1d0
>   vfs_read+0xbc/0x1b0
>   SyS_read+0x6c/0x110
>   system_call+0x38/0xfc
>
> The root cause is that MAX_PGD_INDEX_SIZE isn't actually computed to be
> the max of H_PGD_INDEX_SIZE or RADIX_PGD_INDEX_SIZE. To fix that move
> the calculation into asm-offsets.c where we can do it easily using
> max().
>
> Fixes: f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

  Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 4 ----
>  arch/powerpc/kernel/asm-offsets.c            | 4 ++--
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index fb72ff6b98e6..fb8380a2d8d5 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -232,10 +232,6 @@ extern unsigned long __pte_frag_nr;
>  extern unsigned long __pte_frag_size_shift;
>  #define PTE_FRAG_SIZE_SHIFT __pte_frag_size_shift
>  #define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
> -/*
> - * Pgtable size used by swapper, init in asm code
> - */
> -#define MAX_PGD_TABLE_SIZE (sizeof(pgd_t) << RADIX_PGD_INDEX_SIZE)
>
>  #define PTRS_PER_PTE	(1 << PTE_INDEX_SIZE)
>  #define PTRS_PER_PMD	(1 << PMD_INDEX_SIZE)
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index e7c8229a8812..8e1163426ccb 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -400,8 +400,8 @@ int main(void)
>  	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
>  #endif
>
> -#ifdef MAX_PGD_TABLE_SIZE
> -	DEFINE(PGD_TABLE_SIZE, MAX_PGD_TABLE_SIZE);
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	DEFINE(PGD_TABLE_SIZE, (sizeof(pgd_t) << max(RADIX_PGD_INDEX_SIZE, H_PGD_INDEX_SIZE)));
>  #else
>  	DEFINE(PGD_TABLE_SIZE, PGD_TABLE_SIZE);
>  #endif
>
