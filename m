Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ACDEA2C0112
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Aug 2013 01:48:53 +1000 (EST)
Message-ID: <52138FDE.3080007@wwwdotorg.org>
Date: Tue, 20 Aug 2013 09:48:46 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 2/2] ASoC: fsl: Add S/PDIF machine driver
References: <cover.1376912873.git.b42378@freescale.com>
 <ca3061d70ab8bf59afc59031fa7befcfaed26d51.1376912873.git.b42378@freescale.com>
 <5212908E.6050104@wwwdotorg.org> <20130820001858.GF30073@sirena.org.uk>
In-Reply-To: <20130820001858.GF30073@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com,
 s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org,
 rob.herring@calxeda.com, tomasz.figa@gmail.com, p.zabel@pengutronix.de,
 R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/19/2013 06:18 PM, Mark Brown wrote:
> On Mon, Aug 19, 2013 at 03:39:26PM -0600, Stephen Warren wrote:
>> On 08/19/2013 06:08 AM, Nicolin Chen wrote:
>>> This patch implements a device-tree-only machine driver for
>>> Freescale i.MX series Soc. It works with
>>> spdif_transmitter/spdif_receiver and fsl_spdif.c drivers.
>> 
>>> diff --git
>>> a/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
>>> b/Documentation/devicetree/bindings/sound/imx-audio-spdif.txt
> 
>>> +Optional properties:
> 
>>> +  - spdif-transmitter : The phandle of the spdif-transmitter
>>> dummy codec +  - spdif-receiver : The phandle of the
>>> spdif-receiver dummy codec
> 
>>> +* Note: At least one of these two properties should be set in
>>> the DT binding.
> 
>> Those object truly don't exist in HW and only exist due to
>> internal details of Linux's ASoC subsystem.
> 
> They will physically exist if they're usefully present on the board
> (in the sense that they're there and can be pointed at) - there
> will be either a TOSLINK optical connector or (less commonly) an
> electrical connector breaking the signal out to go elsewhere though
> they don't have any interaction with software usually which is more
> what you mean here.

Sure, the S/PDIF signal is connected to something, but it is not a
"dummy CODEC"; a "dummy CODEC" is purely something internal to ASoC
and absolutely nothing to do with HW.

>> Or, to map the properties more directly to HW, perhaps name the
>> property "spdif-tx-jack-exists", or even "spdif-tx-jack" and make
>> it a phandle to a node that represents the actual S/PDIF
>> connector?
> 
> S/PDIF is also sometimes used as an interconnect between devices -
> some CODECs have S/PDIF I/O (more normally used as an external
> connector on the box).  This is most frequently seen as a way to
> plumb HDMI in since some HDMI devices seem to provide this as a
> legacy interconnect, though it can get used just for regular CODECs
> as well.  Using this machine driver would probably be a bit of an
> abuse for some applications, though with things like the HDMI one
> the goal of the hardware is to be dropped into a driver like this
> so perhaps it makes sense and is useful anyway.
> 
> Equally well it'd be good to get this stuff actually merged, it
> seems to have been surprisingly time consuming thus far...

That's not a good argument for an incorrect binding.
