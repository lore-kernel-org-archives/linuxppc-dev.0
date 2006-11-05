Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0334B67D63
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 17:47:07 +1100 (EST)
Subject: Re: [patch 04/16] powerpc: remove dead code in iommu.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
In-Reply-To: <20061103084730.GB22478@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125625.428089000@localhost.localdomain>
	<1162506113.10630.35.camel@localhost.localdomain>
	<20061103084730.GB22478@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 17:47:03 +1100
Message-Id: <1162709223.28571.213.camel@localhost.localdomain>
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

On Fri, 2006-11-03 at 09:47 +0100, Sascha Hauer wrote:
> On Fri, Nov 03, 2006 at 09:21:53AM +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2006-11-02 at 13:55 +0100, s.hauer@pengutronix.de wrote:
> > > plain text document attachment
> > > (powerpc-include-asm-powerpc-iommu_h-remove-dead-code.diff)
> > > iommu_setup_pSeries() and iommu_setup_dart() are declared extern but are
> > > not implemented, so remove them. iommu_free_table() is pSeries specific,
> > > so #ifdef it with CONFIG_PPC_PSERIES and not CONFIG_PPC_MULTIPLATFORM
> > > 
> > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > There is no need to #ifdef an extern declaration. Just remove the
> > ifdef's and the two obsolete prototypes alltogether
> > 
> 
> Here we go:
> 
> iommu_setup_pSeries() and iommu_setup_dart() are declared extern but are
> not implemented, so remove them. iommu_free_table() is pSeries specific,
> so #ifdef it with CONFIG_PPC_PSERIES and not CONFIG_PPC_MULTIPLATFORM

Same here :-)

Ben.

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Index: include/asm-powerpc/iommu.h
> ===================================================================
> --- a/include/asm-powerpc/iommu.h.orig
> +++ b/include/asm-powerpc/iommu.h
> @@ -70,17 +70,9 @@ struct iommu_table {
>  struct scatterlist;
>  struct device_node;
>  
> -#ifdef CONFIG_PPC_MULTIPLATFORM
> -
> -/* Walks all buses and creates iommu tables */
> -extern void iommu_setup_pSeries(void);
> -extern void iommu_setup_dart(void);
> -
>  /* Frees table for an individual device node */
>  extern void iommu_free_table(struct device_node *dn);
>  
> -#endif /* CONFIG_PPC_MULTIPLATFORM */
> -
>  /* Initializes an iommu_table based in values set in the passed-in
>   * structure
>   */
> 
