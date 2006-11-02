Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C37FC67D08
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 09:21:59 +1100 (EST)
Subject: Re: [patch 04/16] powerpc: remove dead code in iommu.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: s.hauer@pengutronix.de
In-Reply-To: <20061102125625.428089000@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125625.428089000@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 03 Nov 2006 09:21:53 +1100
Message-Id: <1162506113.10630.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-02 at 13:55 +0100, s.hauer@pengutronix.de wrote:
> plain text document attachment
> (powerpc-include-asm-powerpc-iommu_h-remove-dead-code.diff)
> iommu_setup_pSeries() and iommu_setup_dart() are declared extern but are
> not implemented, so remove them. iommu_free_table() is pSeries specific,
> so #ifdef it with CONFIG_PPC_PSERIES and not CONFIG_PPC_MULTIPLATFORM
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

There is no need to #ifdef an extern declaration. Just remove the
ifdef's and the two obsolete prototypes alltogether

Cheers,
Ben.

> Index: linux-2.6/include/asm-powerpc/iommu.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/iommu.h
> +++ linux-2.6/include/asm-powerpc/iommu.h
> @@ -70,16 +70,12 @@ struct iommu_table {
>  struct scatterlist;
>  struct device_node;
>  
> -#ifdef CONFIG_PPC_MULTIPLATFORM
> -
> -/* Walks all buses and creates iommu tables */
> -extern void iommu_setup_pSeries(void);
> -extern void iommu_setup_dart(void);
> +#ifdef CONFIG_PPC_PSERIES
>  
>  /* Frees table for an individual device node */
>  extern void iommu_free_table(struct device_node *dn);
>  
> -#endif /* CONFIG_PPC_MULTIPLATFORM */
> +#endif /* CONFIG_PPC_PSERIES */
>  
>  /* Initializes an iommu_table based in values set in the passed-in
>   * structure
> 
> --
>  Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
>   Pengutronix - Linux Solutions for Science and Industry
>     Handelsregister: Amtsgericht Hildesheim, HRA 2686
>       Hannoversche Str. 2, 31134 Hildesheim, Germany
>     Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
