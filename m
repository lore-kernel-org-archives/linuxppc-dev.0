Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNzD82KcbzDw1x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 21:32:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 1/7] powerpc/mm: update ptep_set_access_flag to not do
 full mm tlb flush
In-Reply-To: <20161122080149.31306-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161122080149.31306-1-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 23 Nov 2016 21:32:07 +1100
Message-ID: <87mvgqtrko.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
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

I'd much rather you called these page_size, rather than pg_sz.

It's confusing enough that we have things called "psize" which are not
page sizes, but then adding pg_sz as well just makes it worse.

So can we stick with page_size for things that are page sizes (in
bytes), and psize for things that are MMU_PAGE_xx values.

cheers
