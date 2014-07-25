Return-Path: <guangyu.chen@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 32B0F1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 17:59:14 +1000 (EST)
Date: Fri, 25 Jul 2014 15:57:56 +0800
From: Nicolin Chen <Guangyu.Chen@freescale.com>
To: Varka Bhadram <varkabhadram@gmail.com>
Subject: Re: [PATCH v4 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and
 platform drivers
Message-ID: <20140725075755.GA29564@MrMyself>
References: <cover.1406271541.git.nicoleotsuka@gmail.com>
 <69b75ae4b0335cd3c9bedad67f57aaba13c0048c.1406271541.git.nicoleotsuka@gmail.com>
 <53D208A9.3040903@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <53D208A9.3040903@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, b42378@freescale.com, timur@tabi.org,
 pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de,
 linux-kernel@vger.kernel.org, rdunlap@infradead.org, b02247@freescale.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz,
 Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org,
 galak@codeaurora.org, grant.likely@linaro.org, tklauser@distanz.ch,
 shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Varka,

Thank you for the comments!

On Fri, Jul 25, 2014 at 01:05:05PM +0530, Varka Bhadram wrote:
> On 07/25/2014 12:49 PM, Nicolin Chen wrote:
> (...)
> 
> >+static const struct platform_device_id fsl_asrc_devtype[] = {
> >+	{
> >+		.name = "imx35-asrc",
> >+		.driver_data = IMX35_ASRC,
> >+	}, {
> >+		.name = "imx53-asrc",
> >+		.driver_data = IMX53_ASRC,
> >+	}, {
> >+		/* sentinel */
> >+	}
> >+};
> >+MODULE_DEVICE_TABLE(platform, fsl_asrc_devtype);
> >+
> 
> where are you using fsl_asrc_devtype,,,?
> 
> >+static const struct of_device_id fsl_asrc_ids[] = {
> >+	{
> >+		.compatible = "fsl,imx35-asrc",
> >+		.data = &fsl_asrc_devtype[IMX35_ASRC],
> 
> Ya here ... but what is the use...?

I got your point. I will drop all these and move ids behind probe/remove()
as you suggested at the first place and then use of_device_is_compatible()
inside the probe() instead.

> >+	asrc_priv->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> >+			"mem", regs, &fsl_asrc_regmap_config);
> 
> devm_regmap_init_mmio_clk(&pdev->dev,
> 			  "mem", regs,
> 			  &fsl_asrc_regmap_config);

I'll refine to

 devm_regmap_init_mmio_clk(&pdev->dev, "mem", regs,
                           &fsl_asrc_regmap_config);

> 
> >+	if (IS_ERR(asrc_priv->regmap)) {
> >+		dev_err(&pdev->dev, "failed to init regmap\n");
> >+		return PTR_ERR(asrc_priv->regmap);
> >+	}
> >+
> >+	irq = platform_get_irq(pdev, 0);
> >+	if (irq < 0) {
> >+		dev_err(&pdev->dev, "no irq for node %s\n", np->full_name);
> >+		return irq;
> >+	}
> >+
> >+	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
> >+			       asrc_priv->name, asrc_priv);
>
> same...

Sorry I don't see any problem with this devm_request_irq()...

Thank you,
Nicolin
