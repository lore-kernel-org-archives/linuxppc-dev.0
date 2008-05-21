Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.237])
	by ozlabs.org (Postfix) with ESMTP id A91F7DEB2C
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 03:30:57 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i30so2388814wxd.15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 May 2008 10:30:56 -0700 (PDT)
Message-ID: <fa686aa40805211030p1ada86b5gf3e2f4b1b5aca754@mail.gmail.com>
Date: Wed, 21 May 2008 11:30:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/4] [OF] spi_of: add support for dedicated SPI
	constructors
In-Reply-To: <20080521154139.GB4566@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080521154103.GA32577@polina.dev.rtsoft.ru>
	<20080521154139.GB4566@polina.dev.rtsoft.ru>
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
> Dedicated (usually the ones that need to fill platform data) constructors
> will create board info, so SPI core will probe them as normal SPI devices.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/spi/spi_of.c       |   67 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/spi/spi_of.h |    5 +++
>  2 files changed, 72 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/spi/spi_of.c b/drivers/spi/spi_of.c
> index b5ae434..2e1a11f 100644
> --- a/drivers/spi/spi_of.c
> +++ b/drivers/spi/spi_of.c
> @@ -11,6 +11,66 @@
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spi_of.h>
>
> +/*
> + * Caller have no idea who is master, i.e. this function does not
> + * accept pointer to the master, instead we use board infos.
> + */
> +int of_spi_device_probe_common(struct device_node *np,
> +                              struct spi_board_info *spi_binfo,
> +                              const char *modalias)
> +{
> +       struct device_node *parent;
> +       const u32 *bus_num;
> +       const u32 *chip_select;
> +       const u32 *max_speed;
> +       int size;
> +
> +       parent = of_get_parent(np);
> +       if (!parent) {
> +               pr_err("%s: no parent\n", np->full_name);
> +               return -EINVAL;
> +       }
> +
> +       bus_num = of_get_property(parent, "reg", &size);
> +       if (!bus_num || size < sizeof(*bus_num)) {
> +               pr_err("%s: no reg specified for parent\n", np->full_name);
> +               of_node_put(parent);
> +               return -EINVAL;
> +       }
> +       spi_binfo->bus_num = *bus_num;
> +       of_node_put(parent);
> +
> +       chip_select = of_get_property(np, "reg", &size);
> +       if (!chip_select || size < sizeof(*chip_select)) {
> +               pr_err("%s: no reg (chip-select) specified\n", np->full_name);
> +               return -EINVAL;
> +       }
> +       spi_binfo->chip_select = *chip_select;
> +
> +       max_speed = of_get_property(np, "max-speed", &size);
> +       if (!max_speed || size < sizeof(*max_speed))
> +               spi_binfo->max_speed_hz = 100000;
> +       else
> +               spi_binfo->max_speed_hz = *max_speed;
> +
> +       strcpy(spi_binfo->modalias, modalias);
> +
> +       /*
> +        * spi_of_register_devices() should not probe this device, it will
> +        * be managed by the dedicated driver.
> +        */
> +       np->data = spi_binfo;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(of_spi_device_probe_common);

This is mostly a duplication of stuff in spi_of_register_devices() and
it short circuits that path.  While I'm not hugely fond of boardinfo
in general, I'd much rather see it passed via spi_of_register_devices
instead of using a different path.  I know we've discussed this before
and I resisted settling on a solution (like adding a specific
platform_data pointer instead of using device_node->data) mostly
because I'm being cautious.  I still don't know if it would be better
to use a device_node value or to have some form of callback into the
boards platform code.  But, either method would be better than having
multiple paths for registering SPI devices which are described in the
device tree.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
