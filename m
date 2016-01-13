Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x241.google.com (mail-yk0-x241.google.com
 [IPv6:2607:f8b0:4002:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D3CF1A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 19:13:39 +1100 (AEDT)
Received: by mail-yk0-x241.google.com with SMTP id y10so28196609ykf.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 00:13:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1452582968-22669-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1452582968-22669-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 13 Jan 2016 11:13:37 +0300
Message-ID: <CAOJe8K26-ATFQC+42xB4EgtKe10OXDdVhEjEm3qq_5GQTFpT4w@mail.gmail.com>
Subject: Re: [RFC PATCH V1 15/33] powerpc/mm: Use helper for finding pte
 filter mask for gup
From: Denis Kirjanov <kda@linux-powerpc.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1/12/16, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/32/pgtable.h | 8 ++++++++
>  arch/powerpc/include/asm/book3s/64/hash.h    | 9 +++++++++
>  arch/powerpc/include/asm/nohash/pgtable.h    | 9 +++++++++
>  arch/powerpc/mm/hugetlbpage.c                | 5 +----
>  4 files changed, 27 insertions(+), 4 deletions(-)

This can be also placed to some common header to avoid code duplication

>
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h
> b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 77adada2f3b4..c0898e26ed4a 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -483,6 +483,14 @@ static inline unsigned long pte_io_cache_bits(void)
>  	return _PAGE_NO_CACHE | _PAGE_GUARDED;
>  }
>
> +static inline unsigned long gup_pte_filter(int write)
> +{
> +	unsigned long mask;
> +	mask = _PAGE_PRESENT | _PAGE_USER;
> +	if (write)
> +		mask |= _PAGE_RW;
> +	return mask;
> +}
>  #endif /* !__ASSEMBLY__ */
>
>  #endif /*  _ASM_POWERPC_BOOK3S_32_PGTABLE_H */
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h
> b/arch/powerpc/include/asm/book3s/64/hash.h
> index 1b27c0c8effa..ee8dd7e561b0 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -583,6 +583,15 @@ static inline unsigned long pte_io_cache_bits(void)
>  	return _PAGE_NO_CACHE | _PAGE_GUARDED;
>  }
>
> +static inline unsigned long gup_pte_filter(int write)
> +{
> +	unsigned long mask;
> +	mask = _PAGE_PRESENT | _PAGE_USER;
> +	if (write)
> +		mask |= _PAGE_RW;
> +	return mask;
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long
> addr,
>  				   pmd_t *pmdp, unsigned long old_pmd);
> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h
> b/arch/powerpc/include/asm/nohash/pgtable.h
> index 8c4bb8fda0de..e4173cb06e5b 100644
> --- a/arch/powerpc/include/asm/nohash/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
> @@ -229,6 +229,15 @@ static inline unsigned long pte_io_cache_bits(void)
>  	return _PAGE_NO_CACHE | _PAGE_GUARDED;
>  }
>
> +static inline unsigned long gup_pte_filter(int write)
> +{
> +	unsigned long mask;
> +	mask = _PAGE_PRESENT | _PAGE_USER;
> +	if (write)
> +		mask |= _PAGE_RW;
> +	return mask;
> +}
> +
>  #ifdef CONFIG_HUGETLB_PAGE
>  static inline int hugepd_ok(hugepd_t hpd)
>  {
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 26fb814f289f..4e970f58f8d9 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -417,10 +417,7 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned
> long addr,
>  		end = pte_end;
>
>  	pte = READ_ONCE(*ptep);
> -	mask = _PAGE_PRESENT | _PAGE_USER;
> -	if (write)
> -		mask |= _PAGE_RW;
> -
> +	mask = gup_pte_filter(write);
>  	if ((pte_val(pte) & mask) != mask)
>  		return 0;
>
> --
> 2.5.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
