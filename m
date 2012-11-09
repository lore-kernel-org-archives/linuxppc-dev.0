Return-Path: <paubert@iram.es>
Received: from torres.puc.rediris.es (unknown [IPv6:2001:720:418:ca00::9])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6CF732C022F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2012 20:06:45 +1100 (EST)
Date: Fri, 9 Nov 2012 09:47:08 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: Add POWER8 architected mode to cputable
Message-ID: <20121109084708.GA13221@visitor2.iram.es>
References: <1351661656-6986-1-git-send-email-mikey@neuling.org>
 <1351661656-6986-4-git-send-email-mikey@neuling.org>
 <30282.1352442402@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <30282.1352442402@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 09, 2012 at 05:26:42PM +1100, Michael Neuling wrote:
> A PVR of 0x0F000004 means we are arch v2.07 complicate ie, POWER8.

Huh? 

s/complicate/compliant/ ?

Also ie has to be written with dots (i.e.).

	Gabriel

>     
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 216ff84..75a3d71 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -435,6 +435,21 @@ static struct cpu_spec __initdata cpu_specs[] = {
>  		.cpu_restore		= __restore_cpu_power7,
>  		.platform		= "power7",
>  	},
> +	{	/* 2.07-compliant processor, i.e. Power8 "architected" mode */
> +		.pvr_mask		= 0xffffffff,
> +		.pvr_value		= 0x0f000004,
> +		.cpu_name		= "POWER8 (architected)",
> +		.cpu_features		= CPU_FTRS_POWER8,
> +		.cpu_user_features	= COMMON_USER_POWER8,
> +		.mmu_features		= MMU_FTRS_POWER8,
> +		.icache_bsize		= 128,
> +		.dcache_bsize		= 128,
> +		.oprofile_type		= PPC_OPROFILE_POWER4,
> +		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
> +		.cpu_setup		= __setup_cpu_power8,
> +		.cpu_restore		= __restore_cpu_power8,
> +		.platform		= "power8",
> +	},
>  	{	/* Power7 */
>  		.pvr_mask		= 0xffff0000,
>  		.pvr_value		= 0x003f0000,
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
