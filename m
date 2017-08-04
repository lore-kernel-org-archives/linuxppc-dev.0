Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP6Sk0Tk5zDqJ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 22:59:17 +1000 (AEST)
Message-ID: <1501851516.2664.89.camel@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com, Michael Ellerman
 <mpe@ellerman.id.au>
Date: Fri, 04 Aug 2017 22:58:36 +1000
In-Reply-To: <19e07887-2b70-324b-ae63-cb68a74f5fd8@linux.vnet.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <19e07887-2b70-324b-ae63-cb68a74f5fd8@linux.vnet.ibm.com>
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

On Fri, 2017-08-04 at 14:06 +0200, Frederic Barrat wrote:
> > +#ifdef CONFIG_PPC_BOOK3S_64
> > +static inline int mm_is_thread_local(struct mm_struct *mm)
> > +{
> > +     if (atomic_read(&mm->context.active_cpus) > 1)
> > +             return false;
> > +     return cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm));
> > +}
> > +#else /* CONFIG_PPC_BOOK3S_64 */
> 
> 
> While working on something related (mark memory context as needing 
> global TLBI if used behind a NPU or PSL):
> http://patchwork.ozlabs.org/patch/796775/
> 
> Michael raised the point that the store for the pte update cannot be 
> reordered with the load which decides the scope of the TLBI, and had 
> convinced me that a memory barrier was required.
> 
> Couldn't we have the same problem here, where the atomic read is 
> reordered with the store of the invalid PTE?

The store of the invalid PTE is done with a pte_update which contains a
sync as far as I can tell.

Cheers,
Ben.
