Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0187.outbound.protection.outlook.com [207.46.163.187])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7AEA1A039D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jun 2014 02:19:41 +1000 (EST)
Message-ID: <1403281165.12851.186.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/2] flexcan: add err_irq handler for flexcan
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Fri, 20 Jun 2014 11:19:25 -0500
In-Reply-To: <1403229664-33912-1-git-send-email-B45475@freescale.com>
References: <1403229664-33912-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: B07421@freescale.com, mkl@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 wg@grandegger.com, linux-can@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-06-20 at 10:01 +0800, Zhao Qiang wrote:
> when flexcan is not physically linked, command 'cantest' will
> trigger an err_irq, add err_irq handler for it.
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> Changes for v2:
> 	- use a space instead of tab
> 	- use flexcan_poll_state instead of print
> 
>  drivers/net/can/flexcan.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index f425ec2..7432ba4 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -208,6 +208,7 @@ struct flexcan_priv {
>  	void __iomem *base;
>  	u32 reg_esr;
>  	u32 reg_ctrl_default;
> +	unsigned int err_irq;

Why unsigned?

> +static irqreturn_t flexcan_err_irq(int irq, void *dev_id)
> +{
> +	struct net_device *dev = dev_id;
> +	struct flexcan_priv *priv = netdev_priv(dev);
> +	struct flexcan_regs __iomem *regs = priv->base;
> +	u32 reg_ctrl, reg_esr;
> +
> +	reg_esr = flexcan_read(&regs->esr);
> +	reg_ctrl = flexcan_read(&regs->ctrl);
> +	if (reg_esr & FLEXCAN_ESR_TX_WRN) {
> +		flexcan_write(reg_esr & ~FLEXCAN_ESR_TX_WRN, &regs->esr);
> +		flexcan_write(reg_ctrl & ~FLEXCAN_CTRL_ERR_MSK, &regs->ctrl);
> +		flexcan_poll_state(dev, reg_esr);
> +	}
> +	return IRQ_HANDLED;
> +}

You should only return IRQ_HANDLED if there was something to handle.

> @@ -944,6 +962,12 @@ static int flexcan_open(struct net_device *dev)
>  	if (err)
>  		goto out_close;
>  
> +	if (priv->err_irq)
> +		err = request_irq(priv->err_irq, flexcan_err_irq, IRQF_SHARED,
> +				  dev->name, dev);
> +	if (err)
> +		goto out_close;

Is this really a fatal error?  And why do you check err outside the "if
(priv->err_irq)" block?  What if some previous code left err non-zero
(either now or after some future code change)?

> @@ -1126,6 +1150,10 @@ static int flexcan_probe(struct platform_device *pdev)
>  	if (irq <= 0)
>  		return -ENODEV;
>  
> +	err_irq = platform_get_irq(pdev, 1);
> +	if (err_irq <= 0)
> +		err_irq = 0;
> +

Why is this <= 0 check needed?

-Scott
