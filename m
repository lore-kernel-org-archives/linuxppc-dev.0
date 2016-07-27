Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s07cn5Y7szDrKr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 07:37:29 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s07cn0Gkzz9t1S
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jul 2016 07:37:28 +1000 (AEST)
Message-ID: <1469655430.5978.159.camel@kernel.crashing.org>
Subject: Re: [PATCH v3 12/21] powerpc/mm: Convert early cpu/mmu feature
 check to use the new helpers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Date: Thu, 28 Jul 2016 07:37:10 +1000
In-Reply-To: <1469629097-30859-12-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
 <1469629097-30859-12-git-send-email-mpe@ellerman.id.au>
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

On Thu, 2016-07-28 at 00:18 +1000, Michael Ellerman wrote:
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h
> b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 70c995870297..6deda6ecc4f7 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -116,7 +116,7 @@ extern void hash__early_init_mmu_secondary(void);
>  extern void radix__early_init_mmu_secondary(void);
>  static inline void early_init_mmu_secondary(void)
>  {
> -       if (radix_enabled())
> +       if (__radix_enabled())
>                 return radix__early_init_mmu_secondary();
>         return hash__early_init_mmu_secondary();
>  }

This one can go, no ?

Cheers,
Ben.
