Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 790E91A3FAB
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 00:38:42 +1000 (AEST)
Message-ID: <55BB885C.3040305@maciej.szmigiero.name>
Date: Fri, 31 Jul 2015 16:38:20 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: Markus Pargmann <mpa@pengutronix.de>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 3/6] ASoC: fsl_ssi: enable AC'97 asymmetric rates
References: <55BA35EB.6020901@maciej.szmigiero.name>
 <20150731052719.GU30895@pengutronix.de>
 <20150731055357.GW30895@pengutronix.de>
In-Reply-To: <20150731055357.GW30895@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Markus,

Thanks for looking into the changes.

On 31.07.2015 07:53, Markus Pargmann wrote:
> On Fri, Jul 31, 2015 at 07:27:19AM +0200, Markus Pargmann wrote:
>> Hi,
>>
>> On Thu, Jul 30, 2015 at 04:34:19PM +0200, Maciej S. Szmigiero wrote:
>>> AC'97 bus can support asymmetric playback/capture rates
>>> so enable them in this case in fsl_ssi driver.
>>>
>>> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
>>> ---
>>>  sound/soc/fsl/fsl_ssi.c |    4 +++-
>>>  1 files changed, 3 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
>>> index a83b900..7f4f0b9 100644
>>> --- a/sound/soc/fsl/fsl_ssi.c
>>> +++ b/sound/soc/fsl/fsl_ssi.c
>>> @@ -1377,7 +1377,9 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>>>  
>>>  	/* Are the RX and the TX clocks locked? */
>>>  	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
>>> -		ssi_private->cpu_dai_drv.symmetric_rates = 1;
>>> +		if (!fsl_ssi_is_ac97(ssi_private))
>>> +			ssi_private->cpu_dai_drv.symmetric_rates = 1;
>>> +
>>
>> Why don't you use the DT property that is parsed here to enable
>> asymmetric rates?

Because in the AC'97 mode the driver supports only one channel config and one sample format
anyway the remaining settings controlled by this property don't do anything.

Since it should be safe to enable asymmetric rates with any AC'97 CODEC I think it is good
to do it in driver than to add "fsl,ssi-asynchronous" to every AC'97 DT node.

Also the description of this property in fsl,ssi.txt looks like that it only makes sense in
non-AC'97 mode.

> Just found the last version of this series. Please use v2 and describe
> changes for a new iteration of a series.

This is just a resubmission, there are no functional differences since
it was originally submitted a month ago. 

> There is also a different setup with AC97 which does not use DMA. See
> the long comment at the top of the file about how ac97 is already used.

I understand that the problem with FIQ handler described in comment
on top of fsl_ssi.c only pertains incoming data, that is capture.

This patch effectively does not touch capture rates as they are already
limited to 48kHz only since this is the only capture rate defined in
fsl_ssi AC'97 DAI driver capture capabilities.

> Regards,
> 
> Markus

Best regards,
Maciej Szmigiero
