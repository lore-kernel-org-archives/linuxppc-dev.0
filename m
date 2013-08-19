Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 0B7EA2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 19:18:25 +1000 (EST)
Date: Mon, 19 Aug 2013 10:18:09 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v7 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130819091809.GD3719@e106331-lin.cambridge.arm.com>
References: <cover.1376901081.git.b42378@freescale.com>
 <43416f3617951161b6e779277b4719438f844e49.1376901081.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43416f3617951161b6e779277b4719438f844e49.1376901081.git.b42378@freescale.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "timur@tabi.org" <timur@tabi.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "R65777@freescale.com" <R65777@freescale.com>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 19, 2013 at 09:35:21AM +0100, Nicolin Chen wrote:
> This patch implements a device-tree-only CPU DAI driver for Freescale
> S/PDIF controller that supports stereo playback and record feature.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
>  .../devicetree/bindings/sound/fsl,spdif.txt        |   56 +
>  sound/soc/fsl/Kconfig                              |    3 +
>  sound/soc/fsl/Makefile                             |    2 +
>  sound/soc/fsl/fsl_spdif.c                          | 1277 ++++++++++++++++++++
>  sound/soc/fsl/fsl_spdif.h                          |  224 ++++
>  5 files changed, 1562 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,spdif.txt
>  create mode 100644 sound/soc/fsl/fsl_spdif.c
>  create mode 100644 sound/soc/fsl/fsl_spdif.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> new file mode 100644
> index 0000000..e9caf1c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
> @@ -0,0 +1,56 @@
> +Freescale Sony/Philips Digital Interface Format (S/PDIF) Controller
> +
> +The Freescale S/PDIF audio block is a stereo transceiver that allows the
> +processor to receive and transmit digital audio via an coaxial cable or
> +a fibre cable.
> +
> +Required properties:
> +
> +  - compatible : Compatible list, contains "fsl,<chip>-spdif".

What are valid values for <chip>? The binding should mention this. There
are bindings that don't, but they need to be fixed. Undocumented ABIs
are a bad idea.

> +
> +  - reg : Offset and length of the register set for the device.
> +
> +  - interrupts : Contains spdif interrupt.

Is that the only interrupt the device generates?

> +
> +  - dmas : Generic dma devicetree binding as described in
> +  Documentation/devicetree/bindings/dma/dma.txt.
> +
> +  - dma-names : Two dmas have to be defined, "tx" and "rx".
> +
> +  - clocks : Contains an entry for each entry in clock-names.
> +
> +  - clock-names : Includes the following entries:
> +       name            description

I don't think you need this line, it's obvious enough without it.

> +       "core"          The core clock of spdif controller
> +       "rxtx<0-7>"     Clock source list for tx and rx clock.
> +                       This clock list should be identical to
> +                       the source list connecting to the spdif
> +                       clock mux in "SPDIF Transceiver Clock
> +                       Diagram" of SoC reference manual. It
> +                       can also be referred to TxClk_Source
> +                       bit of register SPDIF_STC.

Could you elaborate on the last sentence? I'm not sure exactly what you
meant.

> +
> +Example:
> +
> +spdif: spdif@02004000 {
> +       compatible = "fsl,imx6q-spdif",
> +               "fsl,imx35-spdif";

Is "fsl,imx35-spdif" necessary in the list, or is it not the case all
"fsl,<chip>-spdif" variants are compatible with it?

That should be mentioned along with the list of valid compatible
strings.

> +       reg = <0x02004000 0x4000>;
> +       interrupts = <0 52 0x04>;
> +       dmas = <&sdma 14 18 0>,
> +              <&sdma 15 18 0>;
> +       dma-names = "rx", "tx";
> +
> +       clocks = <&clks 197>, <&clks 3>,
> +              <&clks 197>, <&clks 107>,
> +              <&clks 0>, <&clks 118>,
> +              <&clks 62>, <&clks 139>,
> +              <&clks 0>;
> +       clock-names = "core", "rxtx0",
> +               "rxtx1", "rxtx2",
> +               "rxtx3", "rxtx4",
> +               "rxtx5", "rxtx6",
> +               "rxtx7";
> +
> +       status = "okay";
> +};

[...]

> +static int spdif_clk_set_rate(struct clk *clk, unsigned long rate)
> +{
> +       unsigned long rate_actual;
> +
> +       rate_actual = clk_round_rate(clk, rate);
> +       clk_set_rate(clk, rate_actual);
> +
> +       return 0;
> +}

Can't clk_set_rate fail?

[...]

> +       /* Select clock source for rx/tx clock */
> +       spdif_priv->rxclk = devm_clk_get(&pdev->dev, "rxtx1");
> +       if (IS_ERR(spdif_priv->rxclk)) {
> +               dev_err(&pdev->dev, "no rxtx1 property in devicetree\n");

Saying "no rxtx1 clock in devicetree" would be clearer.

[...]

> +static const struct of_device_id fsl_spdif_dt_ids[] = {
> +       { .compatible = "fsl,imx35-spdif", },
> +       {}
> +};

So "fsl,imx35-spdif" *must* be in the compatible list. The binding
should mention this.

Thanks,
Mark.
