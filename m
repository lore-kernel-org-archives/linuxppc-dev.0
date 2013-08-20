Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 54C182C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 02:28:41 +1000 (EST)
Message-ID: <52139932.2050402@wwwdotorg.org>
Date: Tue, 20 Aug 2013 10:28:34 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v7 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
References: <cover.1376901081.git.b42378@freescale.com>
 <43416f3617951161b6e779277b4719438f844e49.1376901081.git.b42378@freescale.com>
 <20130819091809.GD3719@e106331-lin.cambridge.arm.com>
 <20130819093423.GB10950@MrMyself>
 <20130819095433.GG3719@e106331-lin.cambridge.arm.com>
 <20130820051947.GB29114@S2101-09.ap.freescale.net>
In-Reply-To: <20130820051947.GB29114@S2101-09.ap.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>, "festevam@gmail.com" <festevam@gmail.com>,
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

On 08/19/2013 11:19 PM, Shawn Guo wrote:
> On Mon, Aug 19, 2013 at 10:54:33AM +0100, Mark Rutland wrote:
>>> I guess it's better to drop the 'imx6q-spdif' here?
>>
>> That depends:
>>
>> * If the two IP blocks are identical, only the "imx35-spdif" name is
>>   necessary, and we can forget about "fsl,imx6q-spdif".
>>
>> * If "fsl,imx6q-spdif" is a strict superset of "fsl,imx35-spdif", having
>>   both names documented and in a compatible list for a "fsl,imx6q-spdif"
>>   device makes sense.
> 
> Practically, I found it's very useful to have "fsl,<soc>-<ip>" in the
> device compatible property in <soc>.dtsi, even when device driver does
> not match it right now.  For this example, I still prefer to have the
> following line for spdif device in imx6q.dtsi.
> 
> 	compatible = "fsl,imx6q-spdif", "fsl,imx35-spdif";
> 
> The reason for that is we usually do not see all the differences of an
> IP block from one SoC to another when we firstly define the bindings
> for the device by looking at hardware reference manual.  Some
> programming model differences are only identified when we're actually
> programming.  That said, if some day we find there is difference between
> imx6q-spdif and imx35-spdif to be handled when we add something new to
> the driver, we only need to add "fsl,imx6q-spdif" as a new compatible
> into device driver and bindings document.  The existing device tree
> would need no update to work with the new kernel driver.

Yes, we should definitely include the specific SoC model in the
compatible property even in the case where we've done exhaustive
research and validated that the two IP blocks are indeed 100% identical.

This enables us to retro-actively enable and bug workarounds or quirks
which are required for one SoC but not the other. If the compatible
value is already there in DT, we just need a code-change. If the
compatible value isn't already there in DT, we need to change the DT as
well, which means only new DTs will work correctly with new kernels.
