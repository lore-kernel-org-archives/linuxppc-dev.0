Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN97l61HBzDw4G
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 13:55:31 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 144so355713pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 18:55:31 -0800 (PST)
Subject: Re: [PATCH v3 1/6] powerpc/mm: update ptep_set_access_flag to not do
 full mm tlb flush
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20161121183322.14585-1-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <229327ef-bafe-75c5-79d9-2bece549ea38@gmail.com>
Date: Tue, 22 Nov 2016 13:55:25 +1100
MIME-Version: 1.0
In-Reply-To: <20161121183322.14585-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 22/11/16 05:33, Aneesh Kumar K.V wrote:
> When we are updating pte, we just need to flush the tlb mapping for
> that pte. Right now we do a full mm flush because we don't track page
> size. Update the interface to track the page size and use that to
> do the right tlb flush.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  4 +++-
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++++--
>  arch/powerpc/include/asm/book3s/64/radix.h   | 14 +++++++-------
>  arch/powerpc/include/asm/nohash/32/pgtable.h |  4 +++-
>  arch/powerpc/include/asm/nohash/64/pgtable.h |  4 +++-
>  arch/powerpc/mm/pgtable-book3s64.c           |  3 ++-
>  arch/powerpc/mm/pgtable-radix.c              | 16 ++++++++++++++++
>  arch/powerpc/mm/pgtable.c                    | 10 ++++++++--
>  arch/powerpc/mm/tlb-radix.c                  | 15 ---------------
>  9 files changed, 47 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 6b8b2d57fdc8..0713626e9189 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -224,7 +224,9 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
>  
>  
>  static inline void __ptep_set_access_flags(struct mm_struct *mm,
> -					   pte_t *ptep, pte_t entry)
> +					   pte_t *ptep, pte_t entry,
> +					   unsigned long address,
> +					   unsigned long pg_sz)

I wonder if the change can be limited in scope by passing the struct vma instead
of struct mm as the first argument and not passing pg_sz (I don't like that
name at all, page_size if we decide to do it, please). Then extract the mm from
vma->mm


Balbir Singh.
