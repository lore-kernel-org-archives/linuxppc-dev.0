Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) by ozlabs.org (Postfix) with ESMTP id A70F2B6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Aug 2010 23:29:20 +1000 (EST)
Received: by eyd9 with SMTP id 9so3079761eyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Aug 2010 06:29:17 -0700 (PDT)
Date: Mon, 30 Aug 2010 17:29:14 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Esben Haabendal <esbenhaabendal@gmail.com>
Subject: Re: [PATCH] of_mmc_spi: add card detect irq support
Message-ID: <20100830132914.GA32266@oksana.dev.rtsoft.ru>
References: <AANLkTikH+H6+sXN_hcfm_guvUwgM-NKQ83nCwgAk-23G@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTikH+H6+sXN_hcfm_guvUwgM-NKQ83nCwgAk-23G@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

The patch looks mostly good. A few cosmetic issues down below.

On Mon, Aug 30, 2010 at 02:04:59PM +0200, Esben Haabendal wrote:

Please add some change log, a couple of sentences would work.

> Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
> ---

>  drivers/mmc/host/of_mmc_spi.c |   25 +++++++++++++++++++++++--
>  1 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
> index 1247e5d..e872b61 100644
> --- a/drivers/mmc/host/of_mmc_spi.c
> +++ b/drivers/mmc/host/of_mmc_spi.c
> @@ -34,6 +34,7 @@ enum {
>  struct of_mmc_spi {
>         int gpios[NUM_GPIOS];
>         bool alow_gpios[NUM_GPIOS];
> +       int detect_irq;
>         struct mmc_spi_platform_data pdata;
>  };
> 
> @@ -61,6 +62,20 @@ static int of_mmc_spi_get_ro(struct device *dev)
>         return of_mmc_spi_read_gpio(dev, WP_GPIO);
>  }
> 
> +static int of_mmc_spi_init(struct device *dev,
> +                          irqreturn_t (*irqhandler)(int, void *), void *mmc)
> +{
> +       struct of_mmc_spi *oms = to_of_mmc_spi(dev);

Please add an empty line here.

> +       return request_threaded_irq(
> +               oms->detect_irq, NULL, irqhandler, 0, dev_name(dev), mmc);

I'd write it this way:

return request_threaded_irq(oms->detect_irq, NULL, irqhandler,
			    0, dev_name(dev), mmc);

But that's a matter of taste.

> +}
> +
> +static void of_mmc_spi_exit(struct device *dev, void *mmc)
> +{
> +       struct of_mmc_spi *oms = to_of_mmc_spi(dev);

Empty line.

> +       free_irq(oms->detect_irq, mmc);
> +}
> +
>  struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
>  {
>         struct device *dev = &spi->dev;
> @@ -121,8 +136,14 @@ struct mmc_spi_platform_data
> *mmc_spi_get_pdata(struct spi_device *spi)
>         if (gpio_is_valid(oms->gpios[WP_GPIO]))
>                 oms->pdata.get_ro = of_mmc_spi_get_ro;
> 
> -       /* We don't support interrupts yet, let's poll. */
> -       oms->pdata.caps |= MMC_CAP_NEEDS_POLL;
> +       oms->detect_irq = irq_of_parse_and_map(np, 0);
> +       if (oms->detect_irq != NO_IRQ) {

I'd write "if (oms->detect_irq)", which is a bit more natural
(and still correct, 0 is the only invalid VIRQ number).

> +               oms->pdata.init = of_mmc_spi_init;
> +               oms->pdata.exit = of_mmc_spi_exit;
> +       }
> +       else {

} else {


Plus, please add an appropriate interrupts = <> bindings into
Documentation/powerpc/dts-bindings/mmc-spi-slot.txt.

And on the next resend, be sure to add Andrew Morton
<akpm@linux-foundation.org>, David Brownell
<dbrownell@users.sourceforge.net>, and linux-mmc@vger.kernel.org
the Cc list.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
