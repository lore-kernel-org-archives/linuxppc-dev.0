Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4980DDDDF7
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 20:11:19 +1000 (EST)
Date: Sat, 15 Sep 2007 03:04:34 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Message-ID: <20070915100434.GA4978@gate.ebshome.net>
References: <200709151108.01849.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200709151108.01849.sr@denx.de>
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 15, 2007 at 11:08:01AM +0200, Stefan Roese wrote:
> This patch reworks existing ibm-iic driver to an of_platform_device
> and enables it to talk to device tree directly. The ocp quirks are
> completely removed by this patch.
> 
> This is done to enable I2C support for the PPC4xx platforms now
> being moved from arch/ppc (ocp) to arch/powerpc (of). The first board
> using this driver will be the AMCC Sequoia (PPC440EPx).
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> 
> +	/* clckdiv is the same for *all* IIC interfaces,
> +	 * but I'd rather make a copy than introduce another global. --ebs
> +	 */
> +	/* Parent bus should have frequency filled */
> +	prop = of_get_property(of_get_parent(np), "clock-frequency", &len);
> +	if (prop == NULL) {
> +		printk(KERN_ERR
> +			"ibm-iic(%s):no clock-frequency prop on parent bus!\n",
> +			dev->np->full_name);
> +		goto fail;
> +	}
> +
> +	DBG("%s: clckdiv = %d\n", dev->np->full_name, dev->clckdiv);
> +

Where is dev->clkdiv initialized? 

My original version used iic_clkdiv() to calculate correct devider 
based on OPB frequency. Did you even test this code?

-- 
Eugene
