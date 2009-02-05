Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE2FBDDECF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 16:56:29 +1100 (EST)
Message-Id: <360B601C-FDC4-4F36-A716-6AD33FC0CD8B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Madhulika Madishetty <mmadishetty@amcc.com>
In-Reply-To: <AC5E1C3367E37D44970B81A6ADD1DA2C06D09DB5@SDCEXCHANGE01.ad.amcc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/1 v3] AMCC PPC 460SX redwood SoC platform initial
	framework
Date: Wed, 4 Feb 2009 23:56:16 -0600
References: <AC5E1C3367E37D44970B81A6ADD1DA2C06D09DB5@SDCEXCHANGE01.ad.amcc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 4, 2009, at 5:45 PM, Madhulika Madishetty wrote:

> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/ 
> cputable.c
> index 923f87a..5c40da4 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -43,6 +43,7 @@ extern void __setup_cpu_440spe(unsigned long  
> offset, struct cpu_spec* spec);
> extern void __setup_cpu_440x5(unsigned long offset, struct cpu_spec*  
> spec);
> extern void __setup_cpu_460ex(unsigned long offset, struct cpu_spec*  
> spec);
> extern void __setup_cpu_460gt(unsigned long offset, struct cpu_spec*  
> spec);
> +extern void __setup_cpu_460sx(unsigned long offset, struct cpu_spec  
> *spec);
> extern void __setup_cpu_603(unsigned long offset, struct cpu_spec*  
> spec);
> extern void __setup_cpu_604(unsigned long offset, struct cpu_spec*  
> spec);
> extern void __setup_cpu_750(unsigned long offset, struct cpu_spec*  
> spec);
> @@ -1634,6 +1635,18 @@ static struct cpu_spec __initdata cpu_specs[]  
> = {
> 		.machine_check		= machine_check_440A,
> 		.platform		= "ppc440",
> 	},
> +	{ /* 460SX */
> +		.pvr_mask		= 0xffffff00,
> +		.pvr_value		= 0x13541800,
> +		.cpu_name		= "460SX",
> +		.cpu_features		= CPU_FTRS_44X,
> +		.cpu_user_features	= COMMON_USER_BOOKE,
> +		.icache_bsize		= 32,
> +		.dcache_bsize		= 32,
> +		.cpu_setup		= __setup_cpu_460sx,
> +		.machine_check		= machine_check_440A,
> +		.platform		= "ppc440",
> +	},

This needs to be updated to include the new mmu_features field.

- k
