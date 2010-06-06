Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09345B7D8C
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jun 2010 07:57:35 +1000 (EST)
Subject: Re: [PATCH 1/2] net: ll_temac: fix interrupt bug when interrupt 0
	is used
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Linn <john.linn@xilinx.com>
In-Reply-To: <6f264a7a-e5da-494a-a24d-1578ca422807@VA3EHSMHS016.ehs.local>
References: <6f264a7a-e5da-494a-a24d-1578ca422807@VA3EHSMHS016.ehs.local>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Jun 2010 07:57:25 +1000
Message-ID: <1275861445.1931.2974.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Brian Hill <brian.hill@xilinx.com>, michal.simek@petalogix.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-05-26 at 11:29 -0600, John Linn wrote:
> The code is not checking the interrupt for DMA correctly so that an
> interrupt number of 0 will cause a false error.
> 
> Signed-off-by: Brian Hill <brian.hill@xilinx.com>
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---
>  drivers/net/ll_temac_main.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/ll_temac_main.c b/drivers/net/ll_temac_main.c
> index fa7620e..0615737 100644
> --- a/drivers/net/ll_temac_main.c
> +++ b/drivers/net/ll_temac_main.c
> @@ -950,7 +950,7 @@ temac_of_probe(struct of_device *op, const struct of_device_id *match)
>  
>  	lp->rx_irq = irq_of_parse_and_map(np, 0);
>  	lp->tx_irq = irq_of_parse_and_map(np, 1);
> -	if (!lp->rx_irq || !lp->tx_irq) {
> +	if ((lp->rx_irq == NO_IRQ) || (lp->tx_irq == NO_IRQ)) {
>  		dev_err(&op->dev, "could not determine irqs\n");
>  		rc = -ENOMEM;
>  		goto nodev;

Hasn't NO_IRQ been deprecated ?

Linus made it clear a while back that interrupt 0 was not valid and
that's the way it should be.

We now have an interrupt remapping scheme on powerpc, so we ensure that
0 always mean no interrupt. Other archs might need some fixups. Which
are specifically needs this patch ?

Cheers,
Ben.
