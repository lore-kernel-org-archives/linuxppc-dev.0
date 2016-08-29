Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x241.google.com (mail-pa0-x241.google.com
 [IPv6:2607:f8b0:400e:c03::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMtxM31GlzDrgW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 11:15:19 +1000 (AEST)
Received: by mail-pa0-x241.google.com with SMTP id cf3so8006821pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 18:15:19 -0700 (PDT)
Date: Mon, 29 Aug 2016 11:15:07 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v4 12/12] powerpc: rewrite local_t using soft_irq
Message-ID: <20160829111507.1434e07c@roar.ozlabs.ibm.com>
In-Reply-To: <1472409448-18172-13-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472409448-18172-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1472409448-18172-13-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon, 29 Aug 2016 00:07:28 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
> index b8da91363864..e3f5fa77476c 100644
> --- a/arch/powerpc/include/asm/local.h
> +++ b/arch/powerpc/include/asm/local.h
> @@ -4,6 +4,8 @@
>  #include <linux/percpu.h>
>  #include <linux/atomic.h>
>  
> +#include <asm/hw_irq.h>
> +
>  typedef struct
>  {
>  	atomic_long_t a;
> @@ -14,24 +16,50 @@ typedef struct
>  #define local_read(l)	atomic_long_read(&(l)->a)
>  #define local_set(l,i)	atomic_long_set(&(l)->a, (i))
>  
> -#define local_add(i,l)	atomic_long_add((i),(&(l)->a))
> -#define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
> -#define local_inc(l)	atomic_long_inc(&(l)->a)
> -#define local_dec(l)	atomic_long_dec(&(l)->a)
> +static __inline__ void local_add(long i, local_t *l)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	flags = soft_irq_set_mask(IRQ_DISABLE_MASK_PMU | IRQ_DISABLE_MASK_LINUX);
> +	__asm__ __volatile__(
> +	PPC_LL" %0,0(%2)\n\
> +	add     %0,%1,%0\n"
> +	PPC_STL" %0,0(%2)\n"
> +	: "=&r" (t)
> +	: "r" (i), "r" (&(l->a.counter)));
> +	arch_local_irq_restore(flags);
> +}

I wonder about the API.

So all code outside arch/powerpc just implicitly uses the "LINUX" mask
level, and the normal local_irq_disable(), etc. functions, which is
the same as we have today. That's fine.

The new functionality being provided here is PMU disabling which
arch/powerpc code may now use. I wonder if we should give an API that's
slightly more like the existing generic irq one? For example:

local_irq_and_pmu_save(flags);
local_irq_and_pmu_restore(flags);

And it *might* also be kind of nice to make CONFIG_TRACE_IRQFLAGS work
with these, which would mean putting trace_hardirqs_on|off() in there.
