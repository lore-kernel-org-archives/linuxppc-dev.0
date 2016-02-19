Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 867DB1A0686
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 22:30:46 +1100 (AEDT)
Received: by mail-pa0-x22f.google.com with SMTP id yy13so49031788pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 03:30:46 -0800 (PST)
Subject: Re: [PATCH] powerpc/mm/hash: Clear the invalid slot information
 correctly
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1455813884-8283-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56C6FCDD.8010302@gmail.com>
Date: Fri, 19 Feb 2016 22:30:37 +1100
MIME-Version: 1.0
In-Reply-To: <1455813884-8283-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 19/02/16 03:44, Aneesh Kumar K.V wrote:
> We can get a hash pte fault with 4k base page size and find the pte
> already inserted with 64K base page size. In that case we need to clear
> the existing slot information from the old pte. Fix this correctly
>
> With THP, we also clear the slot information with respect to all
> the 64K hash pte mapping that 16MB page. They are all invalid
> now. This make sure we don't find the slot valid when we fault with
> 4k base page size. Finding the slot valid should not result in any wrong
> behavior because we do check again in hash page table for the validity.
> But we can avoid that check completely.
>
> Fixes: a43c0eb8364c022 ("powerpc/mm: Convert 4k hash insert to C")
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash64_4k.c       |  2 +-
>  arch/powerpc/mm/hash64_64k.c      | 12 +++++++++---
>  arch/powerpc/mm/hugepage-hash64.c |  7 ++++++-
>  3 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
> index e7c04542ba62..e3e76b929f33 100644
> --- a/arch/powerpc/mm/hash64_4k.c
> +++ b/arch/powerpc/mm/hash64_4k.c
> @@ -106,7 +106,7 @@ repeat:
>  			}
>  		}
>  		/*
> -		 * Hypervisor failure. Restore old pmd and return -1
> +		 * Hypervisor failure. Restore old pte and return -1
>  		 * similar to __hash_page_*
>  		 */
>  		if (unlikely(slot == -2)) {
> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
> index 0762c1e08c88..b3895720edb0 100644
> --- a/arch/powerpc/mm/hash64_64k.c
> +++ b/arch/powerpc/mm/hash64_64k.c
> @@ -111,7 +111,13 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>  	 */
>  	if (!(old_pte & _PAGE_COMBO)) {
>  		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
> -		old_pte &= ~_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND;
> +		/*
> +		 * clear the old slot details from the old and new pte.
> +		 * On hash insert failure we use old pte value and we don't
> +		 * want slot information there if we have a insert failure.
> +		 */
> +		old_pte &= ~(_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND);
> +		new_pte &= ~(_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND);
>  		goto htab_insert_hpte;
>  	}
>  	/*
> @@ -182,7 +188,7 @@ repeat:
>  		}
>  	}
>  	/*
> -	 * Hypervisor failure. Restore old pmd and return -1
> +	 * Hypervisor failure. Restore old pte and return -1
>  	 * similar to __hash_page_*
>  	 */
>  	if (unlikely(slot == -2)) {
> @@ -305,7 +311,7 @@ repeat:
>  			}
>  		}
>  		/*
> -		 * Hypervisor failure. Restore old pmd and return -1
> +		 * Hypervisor failure. Restore old pte and return -1
>  		 * similar to __hash_page_*
>  		 */
>  		if (unlikely(slot == -2)) {
> diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
> index 49b152b0f926..8424f46c2bf7 100644
> --- a/arch/powerpc/mm/hugepage-hash64.c
> +++ b/arch/powerpc/mm/hugepage-hash64.c
> @@ -78,9 +78,14 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>  		 * base page size. This is because demote_segment won't flush
>  		 * hash page table entries.
>  		 */
> -		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO))
> +		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO)) {
>  			flush_hash_hugepage(vsid, ea, pmdp, MMU_PAGE_64K,
>  					    ssize, flags);
> +			/*
> +			 * clear the old slot information 
> +			 */
Redundant comment, something more useful? why clear it?
> +			memset(hpte_slot_array, 0, PTE_FRAG_SIZE);
> +		}
>  	}
>  
>  	valid = hpte_valid(hpte_slot_array, index);
