Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHWTt3rCvzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 15:25:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Cc: Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [RFC PATCH 2/2] powerpc: Consolidate variants of real-mode MMIOs
In-Reply-To: <1486433887.4850.108.camel@kernel.crashing.org>
References: <1486433887.4850.108.camel@kernel.crashing.org>
Date: Tue, 07 Feb 2017 15:25:22 +1100
Message-ID: <8760kmfwzx.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> We have all sort of variants of MMIO accessors for the real mode
> instructions. This creates a clean set of accessors based on
> Linux normal naming conventions, replacing all occurrences of
> the old ones in the tree.
>
> I have purposefully removed the "out/in" variants in favor of
> only including __raw variants. Any code using these is already
> pretty much hand tuned to operate in a very specific environment.
> I've fixed up the 2 users (only one of them actually needed
> a barrier in the first place).

> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index 5ed2924..45c136a 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -417,15 +372,64 @@ static inline void __raw_writeq(unsigned long v, volatile void __iomem *addr)
>  }
>  
>  /*
> - * Real mode version of the above. stdcix is only supposed to be used
> - * in hypervisor real mode as per the architecture spec.
> + * Real mode versions of the above. Those instructions are only supposed
> + * to be used in hypervisor real mode as per the architecture spec.
>   */
> +static inline void __raw_rm_writeb(u8 val, volatile void __iomem *paddr)
> +{
> +	__asm__ __volatile__("stbcix %0,0,%1"
> +		: : "r" (val), "r" (paddr) : "memory");
> +}

I've never liked the "rm" naming. It makes me think rm -rf.

Can we just call them real_mode_writeb() and so on? Or add more
leading underscores to your taste.

cheers
