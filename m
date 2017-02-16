Return-Path: <sjitindarsingh@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP4ZB6TqHzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:33:22 +1100 (AEDT)
Message-ID: <1487223194.2288.10.camel@gmail.com>
Subject: Re: [PATCH] powerpc/64: Call H_REGISTER_PROC_TBL when running as a
 HPT guest on POWER9
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
Cc: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 16 Feb 2017 16:33:14 +1100
In-Reply-To: <20170216050339.GC19110@fergus.ozlabs.ibm.com>
References: <20170216050339.GC19110@fergus.ozlabs.ibm.com>
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

On Thu, 2017-02-16 at 16:03 +1100, Paul Mackerras wrote:
> On POWER9, since commit cc3d2940133d ("powerpc/64: Enable use of
> radix
> MMU under hypervisor on POWER9", 2017-01-30), we set both the radix
> and
> HPT bits in the client-architecture-support (CAS) vector, which tells
> the hypervisor that we can do either radix or HPT.  According to
> PAPR,
> if we use this combination we are promising to do a
> H_REGISTER_PROC_TBL
> hcall later on to let the hypervisor know whether we are doing radix
> or HPT.  We currently do this call if we are doing radix but not if
> we are doing HPT.  If the hypervisor is able to support both radix
> and HPT guests, it would be entitled to defer allocation of the HPT
> until the H_REGISTER_PROC_TBL call, and to fail any attempts to
> create
> HPTEs until the H_REGISTER_PROC_TBL call.  Thus we need to do a
> H_REGISTER_PROC_TBL call when we are doing HPT; otherwise we may
> crash at boot time.
> 
> This adds the code to call H_REGISTER_PROC_TBL in this case, before
> we attempt to create any HPT entries using H_ENTER.
> 
> Fixes: cc3d2940133d ("powerpc/64: Enable use of radix MMU under
> hypervisor on POWER9")
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
> This needs to go in after the topic/ppc-kvm branch.
> 
> arch/powerpc/mm/hash_utils_64.c       | 6 ++++++
>  arch/powerpc/platforms/pseries/lpar.c | 8 ++++++--
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hash_utils_64.c
> b/arch/powerpc/mm/hash_utils_64.c
> index 8033493..b0ed96e 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -839,6 +839,12 @@ static void __init htab_initialize(void)
>  		/* Using a hypervisor which owns the htab */
>  		htab_address = NULL;
>  		_SDR1 = 0; 
> +		/*
> +		 * On POWER9, we need to do a H_REGISTER_PROC_TBL
> hcall
> +		 * to inform the hypervisor that we wish to use the
> HPT.
> +		 */
> +		if (cpu_has_feature(CPU_FTR_ARCH_300))
> +			register_process_table(0, 0, 0);
>  #ifdef CONFIG_FA_DUMP
>  		/*
>  		 * If firmware assisted dump is active firmware
> preserves
> diff --git a/arch/powerpc/platforms/pseries/lpar.c
> b/arch/powerpc/platforms/pseries/lpar.c
> index 0587655..5b47026 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -609,15 +609,18 @@ static int __init disable_bulk_remove(char
> *str)
>  
>  __setup("bulk_remove=", disable_bulk_remove);
>  
> -/* Actually only used for radix, so far */
>  static int pseries_lpar_register_process_table(unsigned long base,
>  			unsigned long page_size, unsigned long
> table_size)
>  {
>  	long rc;
> -	unsigned long flags = PROC_TABLE_NEW;
> +	unsigned long flags = 0;
>  
> +	if (table_size)
> +		flags |= PROC_TABLE_NEW;
>  	if (radix_enabled())
>  		flags |= PROC_TABLE_RADIX | PROC_TABLE_GTSE;
> +	else
> +		flags |= PROC_TABLE_HPT_SLB;
>  	for (;;) {
>  		rc = plpar_hcall_norets(H_REGISTER_PROC_TBL, flags,
> base,
>  					page_size, table_size);
> @@ -643,6 +646,7 @@ void __init hpte_init_pseries(void)
>  	mmu_hash_ops.flush_hash_range	 =
> pSeries_lpar_flush_hash_range;
>  	mmu_hash_ops.hpte_clear_all      = pseries_hpte_clear_all;
>  	mmu_hash_ops.hugepage_invalidate =
> pSeries_lpar_hugepage_invalidate;
> +	register_process_table		 =
> pseries_lpar_register_process_table;
>  }
>  
>  void radix_init_pseries(void)
FWIW:

Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
