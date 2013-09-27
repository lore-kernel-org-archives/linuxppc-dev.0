Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8D9E02C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 18:05:13 +1000 (EST)
Message-ID: <1380269103.27811.0.camel@pasglop>
Subject: Re: [PATCH] powerpc/kernel/sysfs: disable writing to purr in
 non-powernv
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Fri, 27 Sep 2013 18:05:03 +1000
In-Reply-To: <1380268926-21338-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1380268926-21338-1-git-send-email-maddy@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-27 at 13:32 +0530, Madhavan Srinivasan wrote:
> powerpc/kernel/sysfs.c exports purr with write permission.
> This may be valid for powernv kernel since purr is Hyp resource.
> But writing to the file in PowerVM lpar causes crash.

Testing powernv isn't right, you should test for hypervisor mode.

Cheers,
Ben.

> # echo 0 > purr
> cpu 0x0: Vector: 700 (Program Check) at [c000000000d072b0]
>     pc: c00000000001770c: .write_purr+0x1c/0x40
>     lr: c000000000017708: .write_purr+0x18/0x40
>     sp: c000000000d07530
>    msr: 8000000000049032
>   current = 0xc000000000c53de0
>   paca    = 0xc00000000ec70000	 softe: 0	 irq_happened: 0x01
>     pid   = 0, comm = swapper/0
> enter ? for help
> [c000000000d075b0] c0000000000fba64
> .generic_smp_call_function_single_interrupt+0x104/0x190
> [c000000000d07650] c000000000037748 .smp_ipi_demux+0xa8/0xf0
> [c000000000d076e0] c000000000035314 .doorbell_exception+0x74/0xb0
> [c000000000d07760] c000000000002950 doorbell_super_common+0x150/0x180
> --- Exception: a01 (Doorbell) at c000000000060904
> .plpar_hcall_norets+0x84/0xd4
> [link register   ] c00000000006dbd4 .check_and_cede_processor+0x24/0x40
> [c000000000d07a50] c000000001002558 (unreliable)
> [c000000000d07ac0] c00000000006dd0c .shared_cede_loop+0x2c/0x70
> [c000000000d07b40] c0000000006ae954 .cpuidle_enter_state+0x64/0x150
> [c000000000d07c00] c0000000006aeb30 .cpuidle_idle_call+0xf0/0x300
> [c000000000d07cb0] c000000000062fa0 .pseries_lpar_idle+0x10/0x50
> [c000000000d07d20] c000000000016d14 .arch_cpu_idle+0x64/0x150
> [c000000000d07da0] c0000000000e0060 .cpu_startup_entry+0x1a0/0x2c0
> [c000000000d07e80] c00000000000bca4 .rest_init+0x94/0xb0
> [c000000000d07ef0] c000000000b54530 .start_kernel+0x478/0x494
> [c000000000d07f90] c000000000009be0 .start_here_common+0x20/0x40
> 0:mon>
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/sysfs.c |   19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 27a90b9..d7097c2 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -179,15 +179,27 @@ SYSFS_PMCSETUP(spurr, SPRN_SPURR);
>  SYSFS_PMCSETUP(dscr, SPRN_DSCR);
>  SYSFS_PMCSETUP(pir, SPRN_PIR);
>  
> +/*
> +  Lets only enable Read for Hyp resources and
> +  enable Write when needed with a separate function.
> +  Lets be conservative and default to pseries.
> +*/
>  static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
>  static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
>  static DEVICE_ATTR(dscr, 0600, show_dscr, store_dscr);
> -static DEVICE_ATTR(purr, 0600, show_purr, store_purr);
> +static DEVICE_ATTR(purr, 0400, show_purr, store_purr);
>  static DEVICE_ATTR(pir, 0400, show_pir, NULL);
>  
>  unsigned long dscr_default = 0;
>  EXPORT_SYMBOL(dscr_default);
>  
> +static void add_write_permission_dev_attr(void *ptr)
> +{
> +	struct device_attribute *attr = (struct device_attribute *)ptr;
> +
> +	attr->attr.mode |= (unsigned short) 0200;
> +}
> +
>  static ssize_t show_dscr_default(struct device *dev,
>  		struct device_attribute *attr, char *buf)
>  {
> @@ -394,8 +406,11 @@ static void register_cpu_online(unsigned int cpu)
>  	if (cpu_has_feature(CPU_FTR_MMCRA))
>  		device_create_file(s, &dev_attr_mmcra);
>  
> -	if (cpu_has_feature(CPU_FTR_PURR))
> +	if (cpu_has_feature(CPU_FTR_PURR)) {
> +		if (machine_is(powernv))
> +			add_write_permission_dev_attr((void *)&dev_attr_purr);
>  		device_create_file(s, &dev_attr_purr);
> +	}
>  
>  	if (cpu_has_feature(CPU_FTR_SPURR))
>  		device_create_file(s, &dev_attr_spurr);
