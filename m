Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yRSGH4sRBzDr4J
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Nov 2017 10:28:39 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id a8so503978pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 16:28:39 -0700 (PDT)
Date: Wed, 1 Nov 2017 10:28:19 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V"
 <aneesh.kumar@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH 6/7] powerpc/64s/radix: reset mm_cpumask for single
 thread process when possible
Message-ID: <20171101102819.3d955de6@roar.ozlabs.ibm.com>
In-Reply-To: <20171031071828.28448-1-npiggin@gmail.com>
References: <20171031064432.25190-1-npiggin@gmail.com>
 <20171031071828.28448-1-npiggin@gmail.com>
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

On Tue, 31 Oct 2017 18:18:27 +1100
Nicholas Piggin <npiggin@gmail.com> wrote:

> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 49cc581a31cd..db7e696e4faf 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -255,10 +255,18 @@ void radix__flush_tlb_mm(struct mm_struct *mm)
>  		return;
>  
>  	preempt_disable();
> -	if (!mm_is_thread_local(mm))
> -		_tlbie_pid(pid, RIC_FLUSH_TLB);
> -	else
> +	if (!mm_is_thread_local(mm)) {
> +		if (atomic_read(&mm->mm_users) == 1 && current->mm == mm) {
> +			_tlbie_pid(pid, RIC_FLUSH_ALL);
> +			atomic_set(&mm->context.active_cpus, 1);
> +			cpumask_clear(mm_cpumask(mm));
> +			cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));

Ben and Michael pointed out this could be racy. At least mmget_not_zero
could in theory come in here, grab the mm, and use_mm it. Needs a bit
more auditing throughout the tree first.

We could close races by putting a lock around the mm_is_thread_local test
and resetting the cpumask and counter, taken in mm switch path as well.
Would be nice to avoid that if the use_mm/mmget/etc APIs don't get in the
way.

Thanks,
Nick
