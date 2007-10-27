Return-Path: <cbou@mail.ru>
Received: from mx38.mail.ru (mx38.mail.ru [194.67.23.16])
	by ozlabs.org (Postfix) with ESMTP id C6846DDE41
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 20:47:51 +1000 (EST)
Date: Sat, 27 Oct 2007 14:46:07 +0400
From: Anton Vorontsov <cbou@mail.ru>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/7] mpc83xx: timer driver for PM wakeup
Message-ID: <20071027104607.GA2303@zarina>
References: <20071023212404.GA30942@loki.buserror.net>
	<20071023212502.GE30959@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071023212502.GE30959@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: cbou@mail.ru
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Scott,

On Tue, Oct 23, 2007 at 04:25:02PM -0500, Scott Wood wrote:
> This is a driver for the mpc83xx's GTM4 timer.  It's functionality
> is limited to providing a wakeup source for suspend-to-RAM.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

I think you can use dev_err(&dev->dev

> +static int __devinit gtm_probe(struct of_device *dev,
> +                               const struct of_device_id *match)
> +{
> +	struct device_node *np = dev->node;
> +	struct resource res;
> +	int ret = 0;
> +	u32 busfreq = fsl_get_sys_freq();
> +	struct gtm_priv *priv;
> +
> +	if (busfreq == 0) {
> +		printk(KERN_ERR "gtm: No bus frequency in device tree.\n");

here

> +		return -ENODEV;
> +	}
> +
> +	priv = kmalloc(sizeof(struct gtm_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&priv->lock);
> +	dev_set_drvdata(&dev->dev, priv);
> +
> +	ret = of_address_to_resource(np, 0, &res);
> +	if (ret)
> +		goto out;
> +
> +	priv->irq = irq_of_parse_and_map(np, 0);
> +	if (priv->irq == NO_IRQ) {
> +		printk(KERN_ERR "mpc83xx-gtm exists in device tree "
> +		                "without an IRQ.\n");

and here.

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
