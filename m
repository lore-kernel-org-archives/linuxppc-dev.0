Return-Path: <npiggin@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5XZX6pqSzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 14:40:20 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6A4ceE3029177
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 00:40:17 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bjvs2cg1d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 00:40:17 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <npiggin@au1.ibm.com>;
 Mon, 10 Jul 2017 14:40:14 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6A4eD6I18546806
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 14:40:13 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6A4e4Ws010466
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 14:40:04 +1000
Date: Mon, 10 Jul 2017 14:40:06 +1000
From: Nicholas Piggin <npiggin@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>, Michael Neuling
 <michael.neuling@au1.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] powerpc/mm/radix: Synchronize updates to the
 process table
In-Reply-To: <1499461936.3397.13.camel@kernel.crashing.org>
References: <1499461936.3397.13.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20170710144006.669cab3a@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 07 Jul 2017 16:12:16 -0500
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> When writing to the process table, we need to ensure the store is
> visible to a subsequent access by the MMU. We assume we never have
> the PID active while doing the update, so a ptesync/isync pair
> should hopefully be a big enough hammer for our purpose.
> 

Do we need this if it's going from invalid->valid?

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Note: Architecturally, we also need to use a tlbie(l) with RIC=2
> to flush the process table cache. However this is (very) expensive
> and we know that POWER9 will invalidate its cache when hitting the
> mtpid instruction.
> 
> To be safe, we should add the tlbie for any ARCH300 processor we
> don't know about though. (Aneesh, Nick do we need a ftr bit ?)

Good question, I'm not sure. Aside from this particular thing, it
seems like a good idea in general to add implementation specific
tests into the ftr framework.

We could add the PVR into it so we don't have to pollute FTR bits.
The POWER9_DD1 bit for example could just be a PVR mask and cmp.


> 
>  arch/powerpc/mm/mmu_context_book3s64.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index 9404b5e..e3e2803 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -138,6 +138,14 @@ static int radix__init_new_context(struct mm_struct *mm)
>  	rts_field = radix__get_tree_size();
>  	process_tb[index].prtb0 = cpu_to_be64(rts_field | __pa(mm->pgd) | RADIX_PGD_INDEX_SIZE);
>  
> +	/*
> +	 * Order the above store with subsequent update of the PID
> +	 * register (at which point HW can start loading/caching
> +	 * the entry) and the corresponding load by the MMU from
> +	 * the L2 cache.
> +	 */
> +	asm volatile("ptesync;isync" : : : "memory");
> +
>  	mm->context.npu_context = NULL;
>  
>  	return index;
> 
