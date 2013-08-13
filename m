Return-Path: <festevam@gmail.com>
Received: from mail-vc0-x233.google.com (mail-vc0-x233.google.com
 [IPv6:2607:f8b0:400c:c03::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EE49D2C0104
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Aug 2013 03:58:31 +1000 (EST)
Received: by mail-vc0-f179.google.com with SMTP id ht10so4181641vcb.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 10:58:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1376308870-14232-2-git-send-email-b42378@freescale.com>
References: <1376308870-14232-1-git-send-email-b42378@freescale.com>
 <1376308870-14232-2-git-send-email-b42378@freescale.com>
Date: Tue, 13 Aug 2013 14:58:26 -0300
Message-ID: <CAOMZO5A7noEb98yuCPY6o2mf-FikFcMYiDLpg3huPKHMO7Fwdw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v4 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
From: Fabio Estevam <festevam@gmail.com>
To: Nicolin Chen <b42378@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de,
 timur@tabi.org, rob.herring@calxeda.com, broonie@kernel.org,
 p.zabel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 12, 2013 at 9:01 AM, Nicolin Chen <b42378@freescale.com> wrote:
> +Required properties:
> +
> +  - compatible : Compatible list, contains "fsl,<chip>-spdif". Using general

Can't we just use "fsl,fsl-spdif" instead?

> +  "fsl,fsl-spdif" will get the default SoC type -- imx6q-spdif.
> +

I think this is not the usual approach we do with dt.

> +static const struct of_device_id fsl_spdif_dt_ids[] = {
> +       { .compatible = "fsl,fsl-spdif", },

Isn't only the first entry enough here?

> +       { .compatible = "fsl,imx6q-spdif", },
> +       { .compatible = "fsl,imx6sl-spdif", },
> +       { .compatible = "fsl,imx53-spdif", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, fsl_spdif_dt_ids);
> +
> +static struct platform_driver fsl_spdif_driver = {
> +       .driver = {
> +               .name = "fsl-spdif-dai",
> +               .owner = THIS_MODULE,
> +               .of_match_table = fsl_spdif_dt_ids,
> +       },
> +       .probe = fsl_spdif_probe,
> +       .remove = fsl_spdif_remove,
> +};
> +
> +module_platform_driver(fsl_spdif_driver);
> +
> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
> +MODULE_DESCRIPTION("Freescale S/PDIF CPU DAI Driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:fsl_spdif");

This MODULE_ALIAS name does not match the name you provided earlier:

.name = "fsl-spdif-dai"
