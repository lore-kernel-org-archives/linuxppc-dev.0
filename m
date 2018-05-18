Return-Path: <srs0=bj7n=if=mendozajonas.com=sam@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40nJS43ZBczF29F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 16:39:32 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40nJS422B3z8tFr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 May 2018 16:39:32 +1000 (AEST)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40nJS200R5z9s19
 for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2018 16:39:29 +1000 (AEST)
Message-ID: <865de9ab557621787a26db40c6bf55e1e54ca30d.camel@mendozajonas.com>
Subject: Re: [PATCH 1/3] powerpc/io: Add __raw_writeq_be() __raw_rm_writeq_be()
From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: alistair@popple.id.au, paulus@samba.org
Date: Fri, 18 May 2018 16:39:20 +1000
In-Reply-To: <20180514125033.12000-1-mpe@ellerman.id.au>
References: <20180514125033.12000-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-14 at 22:50 +1000, Michael Ellerman wrote:
> Add byte-swapping versions of __raw_writeq() and __raw_rm_writeq().
> 
> This allows us to avoid sparse warnings caused by passing __be64 to
> __raw_writeq(), which takes unsigned long:
> 
>   arch/powerpc/platforms/powernv/pci-ioda.c:1981:38:
>   warning: incorrect type in argument 1 (different base types)
>       expected unsigned long [unsigned] v
>       got restricted __be64 [usertype] <noident>
> 
> It's also generally preferable to use a byte-swapping accessor rather
> than doing it by hand in the code, which is more bug prone.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

For this and the following patches:

Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

> ---
>  arch/powerpc/include/asm/io.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
> index af074923d598..e0331e754568 100644
> --- a/arch/powerpc/include/asm/io.h
> +++ b/arch/powerpc/include/asm/io.h
> @@ -367,6 +367,11 @@ static inline void __raw_writeq(unsigned long v, volatile void __iomem *addr)
>  	*(volatile unsigned long __force *)PCI_FIX_ADDR(addr) = v;
>  }
>  
> +static inline void __raw_writeq_be(unsigned long v, volatile void __iomem *addr)
> +{
> +	__raw_writeq((__force unsigned long)cpu_to_be64(v), addr);
> +}
> +
>  /*
>   * Real mode versions of the above. Those instructions are only supposed
>   * to be used in hypervisor real mode as per the architecture spec.
> @@ -395,6 +400,11 @@ static inline void __raw_rm_writeq(u64 val, volatile void __iomem *paddr)
>  		: : "r" (val), "r" (paddr) : "memory");
>  }
>  
> +static inline void __raw_rm_writeq_be(u64 val, volatile void __iomem *paddr)
> +{
> +	__raw_rm_writeq((__force u64)cpu_to_be64(val), paddr);
> +}
> +
>  static inline u8 __raw_rm_readb(volatile void __iomem *paddr)
>  {
>  	u8 ret;
