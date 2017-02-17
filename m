Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPcnS4zvhzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 13:45:00 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id v184so3562448pgv.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 18:45:00 -0800 (PST)
Message-ID: <1487299492.2288.11.camel@gmail.com>
Subject: Re: [PATCH] powerpc: Detect POWER9 architected mode
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org
Date: Fri, 17 Feb 2017 13:44:52 +1100
In-Reply-To: <20170216235900.15629-1-ruscur@russell.cc>
References: <20170216235900.15629-1-ruscur@russell.cc>
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

On Fri, 2017-02-17 at 10:59 +1100, Russell Currey wrote:
> Signed-off-by: Russell Currey <ruscur@russell.cc>
Tested-in-QEMU-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> ---
>  arch/powerpc/kernel/cputable.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/cputable.c
> b/arch/powerpc/kernel/cputable.c
> index 6a82ef039c50..d23a54b09436 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -386,6 +386,25 @@ static struct cpu_spec __initdata cpu_specs[] =
> {
>  		.machine_check_early	=
> __machine_check_early_realmode_p8,
>  		.platform		= "power8",
>  	},
> +	{	/* 3.00-compliant processor, i.e. Power9
> "architected" mode */
> +		.pvr_mask		= 0xffffffff,
> +		.pvr_value		= 0x0f000005,
> +		.cpu_name		= "POWER9 (architected)",
> +		.cpu_features		= CPU_FTRS_POWER9,
> +		.cpu_user_features	= COMMON_USER_POWER9,
> +		.cpu_user_features2	= COMMON_USER2_POWER9,
> +		.mmu_features		= MMU_FTRS_POWER9,
> +		.icache_bsize		= 128,
> +		.dcache_bsize		= 128,
> +		.num_pmcs		= 6,
> +		.pmc_type		= PPC_PMC_IBM,
> +		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
> +		.oprofile_type		=
> PPC_OPROFILE_INVALID,
> +		.cpu_setup		= __setup_cpu_power9,
> +		.cpu_restore		= __restore_cpu_power9,
> +		.flush_tlb		= __flush_tlb_power9,
> +		.platform		= "power9",
> +	},
>  	{	/* Power7 */
>  		.pvr_mask		= 0xffff0000,
>  		.pvr_value		= 0x003f0000,
