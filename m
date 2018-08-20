Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41v3QF5t4ZzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 16:13:09 +1000 (AEST)
Subject: Re: [PATCH 1/3] arch/powerpc/hugetlb: Use pte_access_permitted for
 hugetlb access check
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
References: <20171204021912.25974-1-aneesh.kumar@linux.vnet.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7d224ed7-f503-fa79-36b8-fddd31dc45c3@c-s.fr>
Date: Mon, 20 Aug 2018 08:12:55 +0200
MIME-Version: 1.0
In-Reply-To: <20171204021912.25974-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 04/12/2017 à 03:19, Aneesh Kumar K.V a écrit :
> No functional change in this patch. This update gup_hugepte to use the
> helper. This will help later when we add memory keys.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>   arch/powerpc/mm/hugetlbpage.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index a9b9083c5e49..c7e5afe5e118 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -855,9 +855,7 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>   
>   	pte = READ_ONCE(*ptep);
>   
> -	if (!pte_present(pte) || !pte_read(pte))
> -		return 0;
> -	if (write && !pte_write(pte))
> +	if (!pte_access_permitted(pte, write))

Seems like pte_access_permitted() doesn't check _PAGE_RO whereas 
pte_write() does.

Christophe

>   		return 0;
>   
>   	/* hugepages are never "special" */
> 
