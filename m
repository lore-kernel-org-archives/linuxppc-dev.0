Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 94F8EDE010
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 04:54:57 +1100 (EST)
Message-ID: <4981ED3E.9050602@freescale.com>
Date: Thu, 29 Jan 2009 11:54:06 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/example] powerpc: add the mpic global timer support
References: <Pine.LNX.4.64.0901062200550.19321@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0901062200550.19321@blarg.am.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, regis.odeye@kontron.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> +		timer@41100 {
> +			compatible = "fsl,mpic-global-timer";
> +			reg = <0x41100 0x204>;
> +			interrupts = <0xf7 0x2>;
> +			interrupt-parent = <&mpic>;
> +		};

Why is this a separate node from the MPIC?  Seems like it should at 
least be a child node, if not just implied by one of the compatibles on 
the mpic node.

> +static ssize_t mpic_tm_timeout_store(struct device *dev,
> +				struct device_attribute *attr,
> +				const char *buf, size_t count)
> +{
> +	struct mpic_tm_priv *priv = dev_get_drvdata(dev);
> +	unsigned long interval = simple_strtoul(buf, NULL, 0);
> +	unsigned long temp;
> +
> +	if (interval > 0x7fffffff) {
> +		dev_dbg(dev, "mpic_tm: interval %lu (in ns) too long\n", interval);
> +		return -EINVAL;
> +	}
> +
> +	interval *= priv->ticks_per_sec;

In nanoseconds, or seconds?

> +static DEVICE_ATTR(timeout, 0660, mpic_tm_timeout_show, mpic_tm_timeout_store);
> +
> +static int __devinit mpic_tm_probe(struct of_device *dev,
> +				const struct of_device_id *match)
> +{
> +	struct device_node *np = dev->node;
> +	struct resource res;
> +	struct mpic_tm_priv *priv;
> +	struct mpic_type *type = match->data;
> +	int has_tcr = type->has_tcr;
> +	u32 busfreq = fsl_get_sys_freq();
> +	int ret = 0;
> +
> +	if (busfreq == 0) {
> +		dev_err(&dev->dev, "mpic_tm: No bus frequency in device tree.\n");
> +		return -ENODEV;
> +	}

Maybe put clock-frequency in the timer (or mpic) node itself?

This seems to try to support non-FSL MPIC timers, but fsl_get_sys_freq() 
wouldn't be appropriate in such a case.

> +	priv = kmalloc(sizeof(struct mpic_tm_priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&priv->lock);
> +	dev_set_drvdata(&dev->dev, priv);
> +
> +	ret = of_address_to_resource(np, 0, &res);
> +	if (ret)
> +		goto out;

of_iomap()?

> +	ret = request_irq(priv->irq, mpic_tm_isr, 0, "mpic timer 0", priv);
> +	if (ret)
> +		goto out;

Hardcoded zero in string?

> +	printk("MPIC global timer init done.\n");

KERN_DEBUG?

-Scott
