Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHc3w3y2bzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:52:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: Re: [PATCH 1/7] powerpc: introduce pte_set_hash_slot() helper
In-Reply-To: <1504910713-7094-2-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-2-git-send-email-linuxram@us.ibm.com>
Date: Thu, 19 Oct 2017 15:52:27 +1100
Message-ID: <87k1zrkad0.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:
> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> index 9732837..6652669 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
> @@ -74,6 +74,31 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
>  	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
>  }
>  
> +/*
> + * Commit the hash slot and return pte bits that needs to be modified.
> + * The caller is expected to modify the pte bits accordingly and
> + * commit the pte to memory.
> + */
> +static inline unsigned long pte_set_hash_slot(pte_t *ptep, real_pte_t rpte,
> +		unsigned int subpg_index, unsigned long slot)
> +{
> +	unsigned long *hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
> +
> +	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
> +	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
                           ^
                           stray space here
> +	/*
> +	 * Commit the hidx bits to memory before returning.

I'd prefer we didn't use "commit", it implies the bits are actually
written to memory by the barrier, which is not true. The barrier is just
a barrier or fence which prevents some reorderings of the things before
it and the things after it.

> +	 * Anyone reading  pte  must  ensure hidx bits are
> +	 * read  only  after  reading the pte by using the
> +	 * read-side  barrier  smp_rmb().

That seems OK. Though I'm reminded that I dislike your justified
comments, the odd spacing is jarring to read.

>          __real_pte() can
> +	 * help ensure that.

It doesn't help, it *does* do that.

cheers
