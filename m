Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3snypL3mPxzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Oct 2016 10:25:46 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 190so3539560pfv.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Oct 2016 16:25:46 -0700 (PDT)
Subject: Re: [PATCH] powerpc: During context switch, check before setting
 mm_cpumask
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, npiggin@gmail.com, cyrilbur@gmail.com
References: <1475476829-6296-1-git-send-email-anton@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <b0537503-e415-ec23-f2c9-88d18209473e@gmail.com>
Date: Tue, 4 Oct 2016 10:25:31 +1100
MIME-Version: 1.0
In-Reply-To: <1475476829-6296-1-git-send-email-anton@ozlabs.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/10/16 17:40, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> During context switch, switch_mm() sets our current CPU in mm_cpumask.
> We can avoid this atomic sequence in most cases by checking before
> setting the bit.
> 
> Testing on a POWER8 using our context switch microbenchmark:
> 
> tools/testing/selftests/powerpc/benchmarks/context_switch \
> 	--process --no-fp --no-altivec --no-vector
> 
> Performance improves 2%.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/include/asm/mmu_context.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 475d1be..5c45114 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -72,7 +72,8 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
>  			     struct task_struct *tsk)
>  {
>  	/* Mark this context has been used on the new CPU */
> -	cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
> +	if (!cpumask_test_cpu(smp_processor_id(), mm_cpumask(next)))
> +		cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
>  

I think this makes sense, in fact I think in the longer term we can
even use __set_bit() reorder-able version since we have a sync
coming out of schedule(). The read side for TLB flush can use a RMB

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh.
