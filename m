Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0EBB67B29
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 00:15:18 +1000 (EST)
In-Reply-To: <E1Frjei-0004Oq-Ot@jdl.com>
References: <E1Frjei-0004Oq-Ot@jdl.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <67B94EA4-3B30-4037-86E8-38D1BAA03FE1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/9 v3] Add 8641 CPU table entry.
Date: Sun, 18 Jun 2006 09:16:05 -0500
To: Jon Loeliger <jdl@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 17, 2006, at 5:52 PM, Jon Loeliger wrote:

> Signed-off-by: Wei Zhang <Wei.Zhang@freescale.com>
> Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
>
> ---
>
>  arch/powerpc/kernel/cputable.c |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/ 
> cputable.c
> index abf7d42..1c11488 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -722,6 +722,18 @@ #if CLASSIC_PPC
>  		.oprofile_type		= PPC_OPROFILE_G4,
>  		.platform		= "ppc7450",
>  	},
> +        {       /* 8641 */
> +               .pvr_mask               = 0xffffffff,
> +               .pvr_value              = 0x80040010,
> +               .cpu_name               = "8641",
> +               .cpu_features           = CPU_FTRS_7447A,
> +               .cpu_user_features      = COMMON_USER |  
> PPC_FEATURE_HAS_ALTIVEC_COMP,
> +               .icache_bsize           = 32,
> +               .dcache_bsize           = 32,
> +               .num_pmcs               = 6,
> +               .cpu_setup              = __setup_cpu_745x
> +        },
> +

is this really needed?  Based on the PVR you'd match the 7448 entry  
which seems identical (beyond the name, which is irrelevant)?  [also  
your missing oprofile & platform info]

>  	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
>  		.pvr_mask		= 0x7fff0000,
>  		.pvr_value		= 0x00810000,
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
