Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS4YD4sVyzDvPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 22:42:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 4/7] powerpc/mm: Add radix__tlb_flush_pte
In-Reply-To: <20161128061704.4914-5-aneesh.kumar@linux.vnet.ibm.com>
References: <20161128061704.4914-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161128061704.4914-5-aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 28 Nov 2016 22:42:38 +1100
Message-ID: <87polfrftd.fsf@concordia.ellerman.id.au>
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

> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 3493cf4e0452..7648952e4f08 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -428,3 +428,21 @@ void radix__flush_tlb_all(void)
>  		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(0) : "memory");
>  	asm volatile("eieio; tlbsync; ptesync": : :"memory");
>  }
> +
> +void radix__flush_tlb_pte(unsigned long old_pte, struct mm_struct *mm,
> +			  unsigned long address)
> +{
> +	/*
> +	 * We track page size in pte only for DD1, So we can
> +	 * call this only on DD1.
> +	 */
> +	if (!cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> +		VM_WARN_ON(1);
> +		return;
> +	}

That's a bit gross but I guess it's OK.

How about we give the function a name that makes it obvious as well?

Like radix__flush_tlb_pte_p9_dd1() - ugly but unlikely anyone would call
it by accident outside of a workaround.

cheers
