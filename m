Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC61FDDE1D
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 13:37:58 +1100 (EST)
Message-Id: <BFCCA52A-85B7-4DD5-ACF4-2F3E65CFD7FD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080114162935.GA27862@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] fsl_soc: Fix get_immrbase() to use ranges,
	rather than reg.
Date: Mon, 14 Jan 2008 20:37:27 -0600
References: <20080114162935.GA27862@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 14, 2008, at 10:29 AM, Scott Wood wrote:

> The reg property in fsl soc nodes should be removed.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/sysdev/fsl_soc.c |   14 +++++++++++---
> 1 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> fsl_soc.c
> index 3ace747..7502e03 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -54,10 +54,18 @@ phys_addr_t get_immrbase(void)
> 	soc = of_find_node_by_type(NULL, "soc");
> 	if (soc) {
> 		int size;
> -		const void *prop = of_get_property(soc, "reg", &size);
> +		u32 naddr;
> +		const u32 *prop = of_get_property(soc, "#address-cells", &size);
> +
> +		if (prop && size == 4)
> +			naddr = *prop;
> +		else
> +			naddr = 2;

Why default to two?

>
> +
> +		prop = of_get_property(soc, "ranges", &size);
> +		if (prop && size == 12)
> +			immrbase = of_translate_address(soc, prop + naddr);
>
> -		if (prop)
> -			immrbase = of_translate_address(soc, prop);

why not make your code an else case if we don't have reg?

>
> 		of_node_put(soc);
> 	}

or something like, than we don't have to worry about adjust anything,  
and if you don't have any children its kinda a pointless device tree :)

	if (soc) {
		struct device_node *child = of_get_next_child(soc, NULL);
		if (child) {
			const void *prop = of_get_property(soc, "ranges", NULL);
			if (prop)
				immrbase = of_translate_address(child, prop);
			of_node_put(child);
		}
		of_node_put(soc);
	}

- k
