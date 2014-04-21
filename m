Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4DDC114008E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 15:25:49 +1000 (EST)
Message-ID: <1398057937.19682.39.camel@pasglop>
Subject: Re: [PATCH] powerpc/mm: Fix tlbie to add AVAL fields for 64K pages
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 21 Apr 2014 15:25:37 +1000
In-Reply-To: <1398056856-17891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1398056856-17891-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-21 at 10:37 +0530, Aneesh Kumar K.V wrote:
> The if condition check was based on a draft ISA doc. Remove the same.

Is this a real bug ? Do we need to send that back to stable ?

Ben.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_native_64.c | 38 ++++++++++++++++----------------------
>  1 file changed, 16 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
> index 3ea26c25590b..cf1d325eae8b 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -82,17 +82,14 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
>  		va &= ~((1ul << mmu_psize_defs[apsize].shift) - 1);
>  		va |= penc << 12;
>  		va |= ssize << 8;
> -		/* Add AVAL part */
> -		if (psize != apsize) {
> -			/*
> -			 * MPSS, 64K base page size and 16MB parge page size
> -			 * We don't need all the bits, but rest of the bits
> -			 * must be ignored by the processor.
> -			 * vpn cover upto 65 bits of va. (0...65) and we need
> -			 * 58..64 bits of va.
> -			 */
> -			va |= (vpn & 0xfe);
> -		}
> +		/*
> +		 * AVAL bits:
> +		 * We don't need all the bits, but rest of the bits
> +		 * must be ignored by the processor.
> +		 * vpn cover upto 65 bits of va. (0...65) and we need
> +		 * 58..64 bits of va.
> +		 */
> +		va |= (vpn & 0xfe); /* AVAL */
>  		va |= 1; /* L */
>  		asm volatile(ASM_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%1,%0), %2)
>  			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
> @@ -133,17 +130,14 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
>  		va &= ~((1ul << mmu_psize_defs[apsize].shift) - 1);
>  		va |= penc << 12;
>  		va |= ssize << 8;
> -		/* Add AVAL part */
> -		if (psize != apsize) {
> -			/*
> -			 * MPSS, 64K base page size and 16MB parge page size
> -			 * We don't need all the bits, but rest of the bits
> -			 * must be ignored by the processor.
> -			 * vpn cover upto 65 bits of va. (0...65) and we need
> -			 * 58..64 bits of va.
> -			 */
> -			va |= (vpn & 0xfe);
> -		}
> +		/*
> +		 * AVAL bits:
> +		 * We don't need all the bits, but rest of the bits
> +		 * must be ignored by the processor.
> +		 * vpn cover upto 65 bits of va. (0...65) and we need
> +		 * 58..64 bits of va.
> +		 */
> +		va |= (vpn & 0xfe);
>  		va |= 1; /* L */
>  		asm volatile(".long 0x7c000224 | (%0 << 11) | (1 << 21)"
>  			     : : "r"(va) : "memory");
