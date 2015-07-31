Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 83F781A17B0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 01:13:22 +1000 (AEST)
Message-ID: <55BB9082.4030206@maciej.szmigiero.name>
Date: Fri, 31 Jul 2015 17:13:06 +0200
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
Subject: Re: [PATCH 6/6] ASoC: fsl_ssi: adjust set DAI format in AC'97 mode
References: <55BA364E.1000803@maciej.szmigiero.name>
 <20150731055843.GX30895@pengutronix.de>
In-Reply-To: <20150731055843.GX30895@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 31.07.2015 07:58, Markus Pargmann wrote:
> On Thu, Jul 30, 2015 at 04:35:58PM +0200, Maciej S. Szmigiero wrote:
>> Adjust set DAI format function in fsl_ssi driver so it
>> doesn't fail and clears RXDIR in AC'97 mode.
>>
>> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
>> ---
>>  sound/soc/fsl/fsl_ssi.c |    8 +++++---
>>  1 files changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
>> index 8e5ff5e..37aabe3 100644
>> --- a/sound/soc/fsl/fsl_ssi.c
>> +++ b/sound/soc/fsl/fsl_ssi.c
>> @@ -900,14 +900,16 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
>>  		scr &= ~CCSR_SSI_SCR_SYS_CLK_EN;
>>  		break;
>>  	default:
>> -		return -EINVAL;
>> +		if (!fsl_ssi_is_ac97(ssi_private))
>> +			return -EINVAL;
> 
> I think it would be better to add another case for the other mode which
> is supported (AC97) instead of using the default case.

This is a switch of DAI clock masters and AC'97 is none of them:
while "case 0:" can be added this would be very similar to the current code.

Alternatively, the whole switch statement could be wrapped inside
"if (!fsl_ssi_is_ac97(ssi_private))" if that would be better
with regards to code style.

>>  	}
>>  
>>  	stcr |= strcr;
>>  	srcr |= strcr;
>>  
>> -	if (ssi_private->cpu_dai_drv.symmetric_rates) {
>> -		/* Need to clear RXDIR when using SYNC mode */
>> +	if (ssi_private->cpu_dai_drv.symmetric_rates
>> +		|| fsl_ssi_is_ac97(ssi_private)) {
> 
> Please fix this indention. Most of the driver is written with 2 tab
> indention after a line break and the new policy seems to be to indent on
> the opening bracket.

Will reindent this.

> 
> Regards,
> 
> Markus

Best regards,
Maciej Szmigiero
