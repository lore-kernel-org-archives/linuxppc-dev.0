Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 302DE1400EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2014 05:56:38 +1000 (EST)
Message-ID: <5361556D.7080805@suse.de>
Date: Wed, 30 Apr 2014 21:56:29 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Stuart Yoder <stuart.yoder@freescale.com>, benh@kernel.crashing.org,
 scottwood@freescale.com
Subject: Re: [PATCH] powerpc: move epapr paravirt init of power_save to an
 initcall
References: <1398887641-20705-1-git-send-email-stuart.yoder@freescale.com>
In-Reply-To: <1398887641-20705-1-git-send-email-stuart.yoder@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 30.04.14 21:54, Stuart Yoder wrote:
> From: Stuart Yoder <stuart.yoder@freescale.com>
>
> some restructuring of epapr paravirt init resulted in
> ppc_md.power_save being set, and then overwritten to
> NULL during machine_init.  This patch splits the
> initialization of ppc_md.power_save out into a postcore
> init call.
>
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
>   arch/powerpc/kernel/epapr_paravirt.c |   25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
> index 6300c13..c49b69c 100644
> --- a/arch/powerpc/kernel/epapr_paravirt.c
> +++ b/arch/powerpc/kernel/epapr_paravirt.c
> @@ -52,11 +52,6 @@ static int __init early_init_dt_scan_epapr(unsigned long node,
>   #endif
>   	}
>   
> -#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
> -	if (of_get_flat_dt_prop(node, "has-idle", NULL))
> -		ppc_md.power_save = epapr_ev_idle;
> -#endif
> -
>   	epapr_paravirt_enabled = true;
>   
>   	return 1;
> @@ -69,3 +64,23 @@ int __init epapr_paravirt_early_init(void)
>   	return 0;
>   }
>   
> +static int __init epapr_idle_init_dt_scan(unsigned long node,
> +					   const char *uname,
> +					   int depth, void *data)
> +{
> +#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
> +	if (of_get_flat_dt_prop(node, "has-idle", NULL))
> +		ppc_md.power_save = epapr_ev_idle;
> +#endif
> +	return 0;
> +}
> +
> +static int __init epapr_idle_init(void)
> +{
> +	if (epapr_paravirt_enabled)
> +		of_scan_flat_dt(epapr_idle_init_dt_scan, NULL);

Doesn't this scan all nodes? We only want to match on 
/hypervisor/has-idle, no?


Alex
