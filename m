Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id A28902C0123
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 19:25:12 +1000 (EST)
Date: Mon, 19 Aug 2013 10:24:58 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v7 2/2] ASoC: fsl: Add S/PDIF machine driver
Message-ID: <20130819092458.GE3719@e106331-lin.cambridge.arm.com>
References: <cover.1376901081.git.b42378@freescale.com>
 <e7ceef74714bb4ead624b333ee3969225b4c5cb5.1376901081.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e7ceef74714bb4ead624b333ee3969225b4c5cb5.1376901081.git.b42378@freescale.com>
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

On Mon, Aug 19, 2013 at 09:35:22AM +0100, Nicolin Chen wrote:
> This patch implements a device-tree-only machine driver for Freescale
> i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> fsl_spdif.c drivers.
> 
> Signed-off-by: Nicolin Chen <b42378@freescale.com>
> ---
>  .../devicetree/bindings/sound/imx-audio-spdif.txt  |   29 +++++
>  sound/soc/fsl/Kconfig                              |   11 ++
>  sound/soc/fsl/Makefile                             |    2 +
>  sound/soc/fsl/imx-spdif.c                          |  134 ++++++++++++++++++++
>  4 files changed, 176 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
>  create mode 100644 sound/soc/fsl/imx-spdif.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
> new file mode 100644
> index 0000000..9a3fa26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
> @@ -0,0 +1,29 @@
> +Freescale i.MX audio complex with S/PDIF transceiver
> +
> +Required properties:
> +
> +  - compatible : "fsl,imx-audio-spdif"
> +
> +  - model : The user-visible name of this sound complex

Is this used semantically, or is it a completely arbitrary string?  In
either case I don't see why the compatible string doesn't give the
driver enough to have a sensible value.

I'm confused as to why we need this. The phrase "user-visible" in a
device description seems very odd.

> +
> +  - spdif-controller : The phandle of the i.MX S/PDIF controller
> +
> +
> +Optional properties:
> +
> +  - spdif-transmitter : The phandle of the spdif-transmitter dummy codec
> +
> +  - spdif-receiver : The phandle of the spdif-receiver dummy codec
> +
> +* Note: At least one of these two properties should be set in the DT binding.

Are all four units (comlpex,controller,transmitter,receiver) really
separate blocks?

Thanks,
Mark.
