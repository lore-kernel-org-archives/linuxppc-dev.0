Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1199A2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 04:31:05 +1000 (EST)
Message-ID: <52150763.8020707@wwwdotorg.org>
Date: Wed, 21 Aug 2013 12:30:59 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v10 2/2] ASoC: fsl: Add S/PDIF machine driver
References: <cover.1377054540.git.b42378@freescale.com>
 <e9cf5e37f858dea78319720f007f66c8c063885f.1377054540.git.b42378@freescale.com>
In-Reply-To: <e9cf5e37f858dea78319720f007f66c8c063885f.1377054540.git.b42378@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com,
 s.hauer@pengutronix.de, timur@tabi.org, rob.herring@calxeda.com,
 tomasz.figa@gmail.com, broonie@kernel.org, p.zabel@pengutronix.de,
 R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/20/2013 09:13 PM, Nicolin Chen wrote:
> This patch implements a device-tree-only machine driver for Freescale
> i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> fsl_spdif.c drivers.

> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt

> +Optional properties:
> +
> +  - spdif-transmitter : The phandle of the spdif-transmitter codec
> +
> +  - spdif-receiver : The phandle of the spdif-receiver codec
> +
> +* Note: At least one of these two properties should be set in the DT binding.

I still don't think those two properties are correct.

Exactly what node will those phandles point at?

There definitely should not be a DT node for any "dummy CODEC",
irrespective of whether this binding calls the other node a "CODEC" or a
"dummy CODEC".

If these properties are to contain phandles, it would be acceptable for
the referenced node to be:

* A node representing the physical connector/jack on the board.

* A node representing some other IP block on the board, such as an HDMI
encoder/display-controller

I think those options are unlikely in general, so I think instead these
properties should just be Boolean indicating that "something" is
connector to the S/PDIF RX/TX, without specifying what that "something"
is. It doesn't matter what at least in the connector/jack case, although
perhaps it does in the HDMI encoder/display-controller?
