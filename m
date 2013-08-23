Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E98B12C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 05:08:34 +1000 (EST)
Message-ID: <5217B32C.5070300@wwwdotorg.org>
Date: Fri, 23 Aug 2013 13:08:28 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v11] ASoC: fsl: Add S/PDIF machine driver
References: <fac39ed91818630e03f81a5f0cf9ddde0e6a3c3a.1377244995.git.b42378@freescale.com>
In-Reply-To: <fac39ed91818630e03f81a5f0cf9ddde0e6a3c3a.1377244995.git.b42378@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, s.hauer@pengutronix.de,
 tomasz.figa@gmail.com, rob.herring@calxeda.com, broonie@kernel.org,
 p.zabel@pengutronix.de, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/23/2013 02:04 AM, Nicolin Chen wrote:
> This patch implements a device-tree-only machine driver for Freescale
> i.MX series Soc. It works with spdif_transmitter/spdif_receiver and
> fsl_spdif.c drivers.

The binding looks reasonable to me now. Thanks.

> diff --git a/sound/soc/fsl/imx-spdif.c b/sound/soc/fsl/imx-spdif.c

> +	if (of_property_read_bool(np, "spdif-out")) {

I'd be tempted to safe those property values into a variable so that ...

> +	data->txdev = platform_device_register_simple("spdif-dit", -1, NULL, 0);
...
> +	data->rxdev = platform_device_register_simple("spdif-dir", -1, NULL, 0);

... those two statements could be conditional upon whether TX/RX were
required too.

However, this isn't a big deal, and could be cleaned up later.
