Return-Path: <robers97@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNQnq1JJqzDqLV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 05:11:27 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id j13so62807qta.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 May 2017 12:11:27 -0700 (PDT)
Date: Wed, 10 May 2017 14:11:21 -0500
From: Steven Roberts <robers97@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au
Subject: Re: [v8,12/12] powerpc: rewrite local_t using soft_irq
Message-ID: <20170510191121.GB25540@oc1783850105.ibm.com>
References: <1492391857-8606-13-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1492391857-8606-13-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 17, 2017 at 06:47:37AM +0530, Madhavan Srinivasan wrote:
> Local atomic operations are fast and highly reentrant per CPU counters.
> Used for percpu variable updates. Local atomic operations only guarantee
> variable modification atomicity wrt the CPU which owns the data and
> these needs to be executed in a preemption safe way.
>
> Here is the design of this patch. Since local_* operations
> are only need to be atomic to interrupts (IIUC), we have two options.
> Either replay the "op" if interrupted or replay the interrupt after
> the "op". Initial patchset posted was based on implementing local_* operation
> based on CR5 which replay's the "op". Patchset had issues in case of
> rewinding the address pointor from an array. This make the slow path
> really slow. Since CR5 based implementation proposed using __ex_table to find
> the rewind addressr, this rasied concerns about size of __ex_table and vmlinux.
>
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-December/123115.html
>
> +static __inline__ int local_add_unless(local_t *l, long a, long u)
> +{
> +     long t;
> +     unsigned long flags;
> +
> +     powerpc_local_irq_pmu_save(flags);
> +     __asm__ __volatile__ (
> +     PPC_LL" %0,0(%1)\n\
> +     cmpw    0,%0,%3 \n\

Loading a long work here and comparing a single word.  Replace cmpw with PPC_LCMP.
> +     beq-    2f \n\
> +     add     %0,%2,%0 \n"
> +     PPC_STL" %0,0(%1) \n"
> +"       subf %0,%2,%0 \n\
> +2:"
> +        : "=&r" (t)
> +        : "r" (&(l->a.counter)), "r" (a), "r" (u)
> +        : "cc", "memory");
> +        powerpc_local_irq_pmu_restore(flags);
> +
> +     return t != u;
> +}
> +
> +#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
> +
> +#define local_sub_and_test(a, l)     (local_sub_return((a), (l)) == 0)
> +#define local_dec_and_test(l)                (local_dec_return((l)) == 0)
> +
> +/*
> + * Atomically test *l and decrement if it is greater than 0.
> + * The function returns the old value of *l minus 1.
> + */
> +static __inline__ long local_dec_if_positive(local_t *l)
> +{
> +     long t;
> +     unsigned long flags;
> +
> +     powerpc_local_irq_pmu_save(flags);
> +     __asm__ __volatile__(
> +     PPC_LL" %0,0(%1)\n\
> +     cmpwi   %0,1\n\

Same issue here.  Replace cmpwi with PPC_LCMPI.

> +     addi    %0,%0,-1\n\
> +     blt-    2f\n"
> +     PPC_STL "%0,0(%1)\n"
> +     "\n\
> +2:"  : "=&b" (t)
> +     : "r" (&(l->a.counter))
> +     : "cc", "memory");
> +     powerpc_local_irq_pmu_restore(flags);
> +
> +     return t;
> +}
> +
