Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJM9D1gkhzDrLR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 05:14:23 +1000 (AEST)
Subject: Re: [PATCH v2] powerpc/mm: Check for _PAGE_PTE in *_devmap()
References: <20170727153553.9160-1-oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: joserz@linux.vnet.ibm.com, sjitindarsingh@gmail.com,
 Oliver O'Halloran <oohall@gmail.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <f35cab60-4f43-8017-3a59-f26a19583a69@redhat.com>
Date: Thu, 27 Jul 2017 21:14:19 +0200
MIME-Version: 1.0
In-Reply-To: <20170727153553.9160-1-oohall@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27/07/2017 17:35, oohall@gmail.com (Oliver O'Halloran) wrote:
> The ISA radix translation tree contains two different types of entry,
> directories and leaves. The formats of the two entries are different
> with the directory entries containing no spare bits for use by software.
> As a result we need to ensure that the *_devmap() family of functions
> check fail for everything except leaf (PTE) entries.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
> "i'll just tweak the mbox before i sent it, what's the worst that can happen"
> *completely breaks KVM*
> "..."
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index d1da415..6bc6248 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -610,7 +610,9 @@ static inline pte_t pte_mkdevmap(pte_t pte)
>  
>  static inline int pte_devmap(pte_t pte)
>  {
> -	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_DEVMAP));
> +	uint64_t mask = cpu_to_be64(_PAGE_DEVMAP | _PAGE_PTE);
> +
> +	return (pte_raw(pte) & mask) == mask;
>  }
>  
>  static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> 

Tested-by: Laurent Vivier <lvivier@redhat.com>
