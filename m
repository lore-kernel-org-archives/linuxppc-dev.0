Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sb9hJ0hnhzDsZf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 19:58:08 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id vz6so3305646pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 02:58:08 -0700 (PDT)
Date: Fri, 16 Sep 2016 19:57:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 05/13] powerpc: Add soft_enabled manipulation functions
Message-ID: <20160916195754.47de292e@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-6-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-6-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 15 Sep 2016 18:31:55 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Add new soft_enabled_* manipulation function and implement
> arch_local_* using the soft_enabled_* wrappers.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index f828b8f8df02..dc3c248f9244 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -53,21 +53,7 @@ static inline notrace void soft_enabled_set(unsigned long enable)
>  	: : "r" (enable), "i" (offsetof(struct paca_struct, soft_enabled)));
>  }
>  
> -static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
> -{
> -	unsigned long flags;
> -
> -	asm volatile(
> -		"lbz %0,%1(13); stb %2,%1(13)"
> -		: "=r" (flags)
> -		: "i" (offsetof(struct paca_struct, soft_enabled)),\
> -		  "r" (enable)
> -		: "memory");
> -
> -	return flags;
> -}
> -
> -static inline unsigned long arch_local_save_flags(void)
> +static inline notrace unsigned long soft_enabled_return(void)
>  {
>  	unsigned long flags;
>  
> @@ -79,20 +65,30 @@ static inline unsigned long arch_local_save_flags(void)
>  	return flags;
>  }
>  
> -static inline unsigned long arch_local_irq_disable(void)
> +static inline notrace unsigned long soft_enabled_set_return(unsigned long enable)
>  {
>  	unsigned long flags, zero;
>  
>  	asm volatile(
> -		"li %1,%3; lbz %0,%2(13); stb %1,%2(13)"
> +		"mr %1,%3; lbz %0,%2(13); stb %1,%2(13)"
>  		: "=r" (flags), "=&r" (zero)
>  		: "i" (offsetof(struct paca_struct, soft_enabled)),\
> -		  "i" (IRQ_DISABLE_MASK_LINUX)
> +		  "r" (enable)
>  		: "memory");
>  
>  	return flags;
>  }

As we talked about earlier, it would be nice to add builtin_constant
variants to avoid the extra instruction. If you prefer to do that
after this series, that's fine.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
