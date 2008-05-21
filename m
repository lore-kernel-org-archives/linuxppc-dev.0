Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.226])
	by ozlabs.org (Postfix) with ESMTP id C2334DE598
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 02:50:04 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i30so2362898wxd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 09:50:03 -0700 (PDT)
Message-ID: <fa686aa40805210950i2df67158p139770f675ef2032@mail.gmail.com>
Date: Wed, 21 May 2008 10:50:02 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/4] [SPI] spi_mpc83xx: convert to the OF platform driver
In-Reply-To: <20080521154137.GA4566@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154137.GA4566@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Gary Jennejohn <garyj@denx.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 21, 2008 at 9:41 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> This patch converts the driver to speak OF directly. FSL SPI controllers
> do not use internal chip-select machines, so boards must use GPIOs for
> these purposes.
>

Mostly this looks good to me, but I didn't look
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |    1 +
>  drivers/spi/Kconfig                          |    3 +-
>  drivers/spi/spi_mpc83xx.c                    |  279 +++++++++++++++++---------
>  3 files changed, 184 insertions(+), 99 deletions(-)
>
> @@ -536,92 +539,152 @@ static void mpc83xx_spi_cleanup(struct spi_device *spi)
>        kfree(spi->controller_state);
>  }
>
> -static int __init mpc83xx_spi_probe(struct platform_device *dev)
> +static unsigned int of_num_children(struct device_node *parent)
> +{
> +       unsigned int count = 0;
> +       struct device_node *child = NULL;
> +
> +       for_each_child_of_node(parent, child)
> +               count++;
> +
> +       return count;
> +}

This smells like it should be in common of code; but I don't think
this routine is needed at all (see below)

[...]
> -       if (master == NULL) {
> +       bus_num = of_get_property(np, "reg", &size);
> +       if (!bus_num || size < sizeof(*bus_num)) {
> +               dev_err(dev, "unable to get reg property from OF\n");
> +               ret = -EINVAL;
> +               goto err_bus_num;
> +       }
> +       master->bus_num = *bus_num;

Does the driver really need to define its own bus num?  I know your
using it for binding with a board info structure, but I think there
are better ways to do it (I'll elaborate in my reply to your patch
that adds support for boardinfo structures).  It's better to let the
SPI infrastructure assign an SPI bus number.  and use other methods to
ensure that extra data is provided to the driver.  Besides, there is
no guarantee that 'reg' will be unique.

> +
> +       master->num_chipselect = of_num_children(np);

This assumes that there are no gaps in the assigned CS numbers of
child nodes, or that the child nodes are an exhaustive list of
attached devices, neither of which may be true.  num_chipselect should
be calculated from the number of GPIOs specified instead.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
