Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qb6mR1mzRzDq5v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 12:45:58 +1100 (AEDT)
Received: by mail-pa0-x229.google.com with SMTP id fe3so54141063pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 18:45:58 -0700 (PDT)
Subject: Re: [PATCH 04/65] powerpc/mm: Use pte_user instead of opencoding
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1459067053-10835-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56FC814F.5090102@gmail.com>
Date: Thu, 31 Mar 2016 12:45:51 +1100
MIME-Version: 1.0
In-Reply-To: <1459067053-10835-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 27/03/16 19:23, Aneesh Kumar K.V wrote:
> We have common declaration in pte-common.h Add book3s specific one
> and switch to pte_user. In the later patch we will be switching
> _PAGE_USER to _PAGE_PRIVILEGED
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 5 +++++
>  arch/powerpc/perf/callchain.c                | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 77d3ce05798e..4ac6221802ad 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -185,6 +185,11 @@ extern struct page *pgd_page(pgd_t pgd);
>  #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~_PAGE_PTE })
>  #define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
>  
> +static inline bool pte_user(pte_t pte)
> +{
> +	return (pte_val(pte) & _PAGE_USER);
> +}
Ideally this should be
    return !!(pte_val(pte) & _PAGE_USER)
for consistency with page_present() and the fact that it returns a bool

> +
>  #ifdef CONFIG_MEM_SOFT_DIRTY
>  #define _PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS + _PAGE_BIT_SWAP_TYPE))
>  #else
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> index e04a6752b399..0071de76d776 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -137,7 +137,7 @@ static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
>  	offset = addr & ((1UL << shift) - 1);
>  
>  	pte = READ_ONCE(*ptep);
> -	if (!pte_present(pte) || !(pte_val(pte) & _PAGE_USER))
> +	if (!pte_present(pte) || !pte_user(pte))
>  		goto err_out;
>  	pfn = pte_pfn(pte);
>  	if (!page_is_ram(pfn))

Makes sense

Acked-by: Balbir Singh <bsingharora@gmail.com>
