Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2DF38DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 20:45:44 +1100 (EST)
Subject: Re: [PATCH] Do not skip PCI Express to PCI bridge when scanning OF
	node
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1173292541.23776.125.camel@ld0161-tx32>
References: <1173292541.23776.125.camel@ld0161-tx32>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 10:45:32 +0100
Message-Id: <1173347132.8635.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-07 at 12:35 -0600, Jon Loeliger wrote:
> From: Haiying Wang <haiying.wang@freescale.com>
> 
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Signed-off-by: Haiying Wang <haiying.wang@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
>  arch/powerpc/kernel/prom_parse.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
> index ea6fd55..0809977 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -267,7 +267,7 @@ int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
>  		ppdev = pdev->bus->self;
>  
>  		/* Ouch, it's a host bridge... */
> -		if (ppdev == NULL) {
> +		if (ppdev == NULL || ppdev->devfn == 0) {

No way. There is nothing "special" per spec with devfn == 0.

What exactly is that supposed to do ?

Ben.
