Return-Path: <B42378@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 29C742C0106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 19:35:03 +1000 (EST)
Date: Mon, 19 Aug 2013 17:34:24 +0800
From: Nicolin Chen <b42378@freescale.com>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130819093423.GB10950@MrMyself>
References: <cover.1376901081.git.b42378@freescale.com>
 <43416f3617951161b6e779277b4719438f844e49.1376901081.git.b42378@freescale.com>
 <20130819091809.GD3719@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130819091809.GD3719@e106331-lin.cambridge.arm.com>
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

Hi Mark,

   Thank you for the commenst. I'll Fix them in v8.

   Here are some remaining question:

On Mon, Aug 19, 2013 at 10:18:09AM +0100, Mark Rutland wrote:
> > +Required properties:
> > +
> > +  - compatible : Compatible list, contains "fsl,<chip>-spdif".
> 
> What are valid values for <chip>? The binding should mention this. There
> are bindings that don't, but they need to be fixed. Undocumented ABIs
> are a bad idea.

I see, so 'Compatible list, must contains "fsl,imx35-spdif"' would be okay?

> > +  - interrupts : Contains spdif interrupt.
> 
> Is that the only interrupt the device generates?

Yes, how could I improve this description?


> > +       "core"          The core clock of spdif controller
> > +       "rxtx<0-7>"     Clock source list for tx and rx clock.
> > +                       This clock list should be identical to
> > +                       the source list connecting to the spdif
> > +                       clock mux in "SPDIF Transceiver Clock
> > +                       Diagram" of SoC reference manual. It
> > +                       can also be referred to TxClk_Source
> > +                       bit of register SPDIF_STC.
> 
> Could you elaborate on the last sentence? I'm not sure exactly what you
> meant.

The list is also identical to the TxClk_Source bit value list of
register SPDIF_STC.

> 
> > +
> > +Example:
> > +
> > +spdif: spdif@02004000 {
> > +       compatible = "fsl,imx6q-spdif",
> > +               "fsl,imx35-spdif";
> 
> Is "fsl,imx35-spdif" necessary in the list, or is it not the case all
> "fsl,<chip>-spdif" variants are compatible with it?
> 
> That should be mentioned along with the list of valid compatible
> strings.

I guess it's better to drop the 'imx6q-spdif' here?


Thank you,
Nicolin
