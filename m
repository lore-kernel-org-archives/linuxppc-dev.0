Return-Path: <l.stach@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6DA852C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 21:08:06 +1100 (EST)
Message-ID: <1382003190.4093.38.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCHv1 8/8] Documentation: Add device tree bindings for
 Freescale VF610 sound.
From: Lucas Stach <l.stach@pengutronix.de>
To: Xiubo Li <Li.Xiubo@freescale.com>
Date: Thu, 17 Oct 2013 11:46:30 +0200
In-Reply-To: <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-9-git-send-email-Li.Xiubo@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org,
 linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, timur@tabi.org,
 perex@perex.cz, r65073@freescale.com, LW@KARO-electronics.de,
 linux@arm.linux.org.uk, b42378@freescale.com, oskar@scara.com,
 grant.likely@linaro.org, devicetree@vger.kernel.org, ian.campbell@citrix.com,
 pawel.moll@arm.com, swarren@wwwdotorg.org, rob.herring@calxeda.com,
 broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
 fabio.estevam@freescale.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 rob@landley.net, r64188@freescale.com, shawn.guo@linaro.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, den 17.10.2013, 17:01 +0800 schrieb Xiubo Li:
> This adds the Document for Freescale VF610 sound driver under
> Documentation/devicetree/bindings/sound/.
> 
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> ---
>  .../devicetree/bindings/sound/fsl-sgtl5000.txt     | 52 ++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt b/Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt
> new file mode 100644
> index 0000000..43e350f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl-sgtl5000.txt

This document name is overly generic, there are more than one FSL
platforms with SGTL5000 codecs. Please include the vf610 here.

> @@ -0,0 +1,52 @@
> +Freescale VF610 audio complex with SGTL5000 codec
> +
> +Required properties:
> +- compatible: "fsl,vf610-sgtl5000"
> +- model: The user-visible name of this sound complex.
> +- saif-controllers: The phandle list of the SAI controller.
> +- audio-codec: The phandle of the SGTL5000 audio codec.
> +- audio-routing : A list of the connections between audio components.
> +  Each entry is a pair of strings, the first being the connection's sink,
> +  the second being the connection's source. Valid names could be power
> +  supplies, SGTL5000 pins, and the jacks on the board:
> +
> +  -- Power supplies:
> +     * Mic Bias
> +
> +  -- SGTL5000 pins:
> +     * MIC_IN
> +     * LINE_IN
> +     * HP_OUT
> +     * LINE_OUT
> +
> +  -- Board connectors:
> +     * Mic Jack
> +     * Line In Jack
> +     * Headphone Jack
> +     * Line Out Jack
> +     * Ext Spk
> +
> +Example:
> +
> +sound {
> +	compatible = "fsl,vf610-sgtl5000";
> +	model = "vf610-sgtl5000";
> +	saif-controller = <&sai2>;
> +	audio-codec = <&codec>;
> +	audio-routing =
> +		"MIC_IN", "Mic Jack",
> +		"Mic Jack", "Mic Bias",
> +		"LINE_IN", "Line In Jack",
> +		"Headphone Jack", "HP_OUT",
> +		"Ext Spk", "LINE_OUT";
> +};
> +
> +&i2c0 {
> +	...
> +
> +	codec: sgtl5000@0a {
> +	       compatible = "fsl,sgtl5000";
> +	       reg = <0x0a>;
> +	       clocks = <&clks VF610_CLK_SAI2>;
> +       };
> +};

-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
