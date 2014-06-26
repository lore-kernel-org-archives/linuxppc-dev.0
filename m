Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by lists.ozlabs.org (Postfix) with ESMTP id 2F3A21A0012
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 21:04:04 +1000 (EST)
Date: Thu, 26 Jun 2014 12:03:51 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Subject: Re: [RFC PATCH v2 4/6] mmc: sdhci: host: add new f_sdh30
Message-ID: <20140626110351.GN15240@leverpostej>
References: <1403763812-5495-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1403763812-5495-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403763812-5495-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "andy.green@linaro.org" <andy.green@linaro.org>,
 "patches@linaro.org" <patches@linaro.org>,
 "anton@enomsg.org" <anton@enomsg.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "chris@printf.net" <chris@printf.net>,
 "Vincent.Yang@tw.fujitsu.com" <Vincent.Yang@tw.fujitsu.com>,
 "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2014 at 07:23:30AM +0100, Vincent Yang wrote:
> This patch adds new host controller driver for
> Fujitsu SDHCI controller f_sdh30.
>
> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-fujitsu.txt      |  35 +++
>  drivers/mmc/host/Kconfig                           |   7 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci_f_sdh30.c                   | 346 +++++++++++++++++++++
>  drivers/mmc/host/sdhci_f_sdh30.h                   |  40 +++
>  5 files changed, 429 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.c
>  create mode 100644 drivers/mmc/host/sdhci_f_sdh30.h
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> new file mode 100644
> index 0000000..40add438
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
> @@ -0,0 +1,35 @@
> +* Fujitsu SDHCI controller
> +
> +This file documents differences between the core properties in mmc.txt
> +and the properties used by the sdhci_f_sdh30 driver.
> +
> +Required properties:
> +- compatible: "fujitsu,f_sdh30"

Please use '-' rather than '_' in compatible strings.

This seems to be the name of the driver. What is the precise name of the
IP block?

> +- voltage-ranges : two cells are required, first cell specifies minimum
> +  slot voltage (mV), second cell specifies maximum slot voltage (mV).
> +  Several ranges could be specified.

Describe this as a list of pairs, it's confusing otherwise.

I'm not sure I follow what having multiple pairs implies.

> +Optional properties:
> +- gpios: This is one optional gpio for controlling a power mux which
> +  switches between two power supplies. 3.3V is selected when gpio is high,
> +  and 1.8V is selected when gpio is low. This voltage is used for signal
> +  level.

Give this a more descriptive name, like power-mux-gpios. That will match
up with the style of cd-gpios and wp-gpios.

> +- clocks: Must contain an entry for each entry in clock-names. It is a
> +  list of phandles and clock-specifier pairs.
> +  See ../clocks/clock-bindings.txt for details.
> +- clock-names: Should contain the following two entries:
> +       "sd_sd4clk" - clock primarily used for tuning process
> +       "sd_bclk"   - base clock for sdhci controller
> +
> +Example:
> +
> +       sdhci1: sdio@36600000 {
> +               compatible = "fujitsu,f_sdh30";
> +               reg = <0 0x36600000 0x1000>;
> +               interrupts = <0 172 0x4>,
> +                            <0 173 0x4>;
> +               voltage-ranges = <1800 1800 3300 3300>;

Place brackets around each pair to make this clearer:

	voltage-ranges = <1800 1800>, <3300 3300>;

[...]

> +       if (!of_property_read_u32(pdev->dev.of_node, "vendor-hs200",
> +                                 &priv->vendor_hs200))
> +               dev_info(dev, "Applying vendor-hs200 setting\n");
> +       else
> +               priv->vendor_hs200 = 0;

This wasn't in the binding document, and a grep for "vendor-hs200" in a
v3.16-rc2 tree found me nothing.

Please document this.

> +
> +       if (!of_property_read_u32(pdev->dev.of_node, "bus-width", &bus_width)) {
> +               if (bus_width == 8) {
> +                       dev_info(dev, "Applying 8 bit bus width\n");
> +                       host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> +               }
> +       }

What if bus-width is not 8, or is not present?

> +
> +       ret = mmc_of_parse_voltage(pdev->dev.of_node, &host->ocr_mask);
> +       if (ret) {
> +               dev_err(dev, "%s: parse voltage error\n", __func__);
> +               goto err_voltage;
> +       }
> +
> +       host->hw_name = DRIVER_NAME;
> +       host->ops = &sdhci_f_sdh30_ops;
> +       host->irq = irq;
> +
> +       host->ioaddr = of_iomap(pdev->dev.of_node, 0);
> +       if (!host->ioaddr) {
> +               dev_err(dev, "%s: failed to remap registers\n", __func__);
> +               ret = -ENXIO;
> +               goto err_remap;
> +       }
> +
> +       priv->clk_sd4 = of_clk_get(pdev->dev.of_node, 0);
> +       if (!IS_ERR(priv->clk_sd4)) {
> +               ret = clk_prepare_enable(priv->clk_sd4);
> +               if (ret < 0) {
> +                       dev_err(dev, "Failed to enable sd4 clock: %d\n", ret);
> +                       goto err_clk1;
> +               }
> +       }
> +       priv->clk_b = of_clk_get(pdev->dev.of_node, 1);
> +       if (!IS_ERR(priv->clk_b)) {
> +               ret = clk_prepare_enable(priv->clk_b);
> +               if (ret < 0) {
> +                       dev_err(dev, "Failed to enable clk_b clock: %d\n", ret);
> +                       goto err_clk2;
> +               }
> +       }

Given you gave these names, get these by name rather than index. It's
less surprising and more flexible.

Thanks,
Mark.
