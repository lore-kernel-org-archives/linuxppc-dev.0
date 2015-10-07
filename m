Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E544A1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Oct 2015 02:33:34 +1100 (AEDT)
Message-ID: <56152578.6070802@freescale.com>
Date: Wed, 7 Oct 2015 17:00:24 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>
Subject: Re: [PATCH v2 05/18] powerpc/85xx: Load all early TLB entries at once
References: <1444189702-17241-1-git-send-email-scottwood@freescale.com>
 <1444189702-17241-6-git-send-email-scottwood@freescale.com>
In-Reply-To: <1444189702-17241-6-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/07/2015 06:48 AM, Scott Wood wrote:
> Use an AS=1 trampoline TLB entry to allow all normal TLB1 entries to
> be loaded at once.  This avoids the need to keep the translation that
> code is executing from in the same TLB entry in the final TLB
> configuration as during early boot, which in turn is helpful for
> relocatable kernels (e.g. kdump) where the kernel is not running from
> what would be the first TLB entry.
> 
> On e6500, we limit map_mem_in_cams() to the primary hwthread of a
> core (the boot cpu is always considered primary, as a kdump kernel
> can be entered on any cpu).  Each TLB only needs to be set up once,
> and when we do, we don't want another thread to be running when we
> create a temporary trampoline TLB1 entry.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  arch/powerpc/kernel/setup_64.c   |  8 +++++
>  arch/powerpc/mm/fsl_booke_mmu.c  | 15 ++++++++--
>  arch/powerpc/mm/mmu_decl.h       |  1 +
>  arch/powerpc/mm/tlb_nohash.c     | 19 +++++++++++-
>  arch/powerpc/mm/tlb_nohash_low.S | 63 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 102 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index bdcbb71..505ec2c 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -108,6 +108,14 @@ static void setup_tlb_core_data(void)
>  	for_each_possible_cpu(cpu) {
>  		int first = cpu_first_thread_sibling(cpu);
>  
> +		/*
> +		 * If we boot via kdump on a non-primary thread,
> +		 * make sure we point at the thread that actually
> +		 * set up this TLB.
> +		 */
> +		if (cpu_first_thread_sibling(boot_cpuid) == first)
> +			first = boot_cpuid;
> +
>  		paca[cpu].tcd_ptr = &paca[first].tcd;
>  
>  		/*
> diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
> index 354ba3c..36d3c55 100644
> --- a/arch/powerpc/mm/fsl_booke_mmu.c
> +++ b/arch/powerpc/mm/fsl_booke_mmu.c
> @@ -105,8 +105,9 @@ unsigned long p_mapped_by_tlbcam(phys_addr_t pa)
>   * an unsigned long (for example, 32-bit implementations cannot support a 4GB
>   * size).
>   */
> -static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
> -		unsigned long size, unsigned long flags, unsigned int pid)
> +static void preptlbcam(int index, unsigned long virt, phys_addr_t phys,
> +		       unsigned long size, unsigned long flags,
> +		       unsigned int pid)
>  {
>  	unsigned int tsize;
>  
> @@ -141,7 +142,13 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
>  	tlbcam_addrs[index].start = virt;
>  	tlbcam_addrs[index].limit = virt + size - 1;
>  	tlbcam_addrs[index].phys = phys;
> +}
>  
> +void settlbcam(int index, unsigned long virt, phys_addr_t phys,


Nit: shouldn't this be left static? Also, now with this bulk TLB1 loading is it still used? Maybe it can be dropped.

---
Best Regards, Laurentiu
