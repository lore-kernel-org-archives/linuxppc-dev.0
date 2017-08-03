Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNcz42xBqzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 03:50:24 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id h75so971584pfh.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Aug 2017 10:50:24 -0700 (PDT)
Date: Fri, 4 Aug 2017 03:50:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 14/14] powerpc: rewrite local_t using soft_irq
Message-ID: <20170804035005.1d462325@roar.ozlabs.ibm.com>
In-Reply-To: <1501732158-19009-15-git-send-email-maddy@linux.vnet.ibm.com>
References: <1501732158-19009-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1501732158-19009-15-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu,  3 Aug 2017 09:19:18 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> @@ -14,6 +17,202 @@ typedef struct
>  #define local_read(l)	atomic_long_read(&(l)->a)
>  #define local_set(l,i)	atomic_long_set(&(l)->a, (i))
>  
> +#ifdef CONFIG_PPC64
> +
> +static __inline__ void local_add(long i, local_t *l)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	powerpc_local_irq_pmu_save(flags);
> +	__asm__ __volatile__(
> +	PPC_LL" %0,0(%2)\n\
> +	add	%0,%1,%0\n"
> +	PPC_STL" %0,0(%2)\n"
> +	: "=&r" (t)
> +	: "r" (i), "r" (&(l->a.counter)));
> +	powerpc_local_irq_pmu_restore(flags);
> +}

Hey, so... why are any of these implemented in asm? We should
just do them all in C, right? I looked a bit harder at code gen
and a couple of them are still emitting larx/stcx.

> +
> +#define local_cmpxchg(l, o, n) \
> +	(cmpxchg_local(&((l)->a.counter), (o), (n)))
> +#define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))

e.g., these.

Thanks,
Nick
