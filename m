Return-Path: <shawn.guo@linaro.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9069E2C0137
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 15:19:19 +1000 (EST)
Date: Tue, 20 Aug 2013 13:19:49 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Message-ID: <20130820051947.GB29114@S2101-09.ap.freescale.net>
References: <cover.1376901081.git.b42378@freescale.com>
 <43416f3617951161b6e779277b4719438f844e49.1376901081.git.b42378@freescale.com>
 <20130819091809.GD3719@e106331-lin.cambridge.arm.com>
 <20130819093423.GB10950@MrMyself>
 <20130819095433.GG3719@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130819095433.GG3719@e106331-lin.cambridge.arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 Nicolin Chen <b42378@freescale.com>, "timur@tabi.org" <timur@tabi.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "R65777@freescale.com" <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 19, 2013 at 10:54:33AM +0100, Mark Rutland wrote:
> > I guess it's better to drop the 'imx6q-spdif' here?
> 
> That depends:
> 
> * If the two IP blocks are identical, only the "imx35-spdif" name is
>   necessary, and we can forget about "fsl,imx6q-spdif".
> 
> * If "fsl,imx6q-spdif" is a strict superset of "fsl,imx35-spdif", having
>   both names documented and in a compatible list for a "fsl,imx6q-spdif"
>   device makes sense.

Practically, I found it's very useful to have "fsl,<soc>-<ip>" in the
device compatible property in <soc>.dtsi, even when device driver does
not match it right now.  For this example, I still prefer to have the
following line for spdif device in imx6q.dtsi.

	compatible = "fsl,imx6q-spdif", "fsl,imx35-spdif";

The reason for that is we usually do not see all the differences of an
IP block from one SoC to another when we firstly define the bindings
for the device by looking at hardware reference manual.  Some
programming model differences are only identified when we're actually
programming.  That said, if some day we find there is difference between
imx6q-spdif and imx35-spdif to be handled when we add something new to
the driver, we only need to add "fsl,imx6q-spdif" as a new compatible
into device driver and bindings document.  The existing device tree
would need no update to work with the new kernel driver.

Shawn

> 
> * If "fsl,imx6q-spdif" is a variation of "fsl,imx35-spdif", and the
>   "fsl,imx6q-spdif" cannot always be treated identically to a
>   "fsl,imx35-spdif", then it makes sense to have separate compatible
>   strings, with a device being listed as either "fsl,imx6q-spdif" or
>   "fsl,imx35-spdif".
