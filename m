Return-Path: <lukma@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmg5r4jH1zDrHr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 18:35:44 +1000 (AEST)
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Message-ID: <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
Date: Tue, 5 Sep 2017 10:35:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170905052031.GB2774@Asurada-CZ80>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/05/2017 07:20 AM, Nicolin Chen wrote:
> On Sun, Sep 03, 2017 at 04:40:21PM +0200, Łukasz Majewski wrote:
>>> /*
>>> * Hardware limitation: The bclk rate must be
>>> * never greater than 1/5 IPG clock rate
>>> */
>>> if (freq * 5 > clk_get_rate(ssi_private->clk)) {
>>> dev_err(cpu_dai->dev, "bitclk > ipgclk/5\n");
>>> return -EINVAL;
>>> }
>>>
>>
>> Unfortunately not.
>>
>> This is the part of fsl_ssi_set_bclk() function which is called after
>> fsl_ssi_set_dai_sysclk() (which sets ssi_private->bitclk_freq = freq;).
>>
>> Before the aforementioned check we do have:
>>
>> 	if (ssi_private->bitclk_freq)
>> 		freq = ssi_private->bitclk_freq;
>> 	else
>> 		freq = params_channels(hw_params) * 32 * 	params_rate(hw_params);
>>
>>
>> Which assigns freq = bitclk_freq (66 MHz)
>>
> [...]
>> And then we break on this particular check:
>> 66MHz * 5 > 66 MHz.
> [...]
> 
> Does the check fail and return an error here, or not?

Yes, this check fails and return error (-EINVAL).

> 
>> The culprit IMHO is the  ssi_private->bitclk_freq = freq; in the
>> fsl_ssi_set_dai_sysclk(), since we _should_ set SSI's IP block clock
>> (ssi_private->clk), not the bit clock (BCLK).
> 
> No. We should not set the IP block clock. That's from IPG bus
> on certain IMX SoCs. Setting it might change IPG bus clocks
> which might break the system.
> 
> And apparently, we shouldn't set bitclk to 66MHz either. Can
> you help to find where this 66MHz comes from?

OK.

The fsi_ssi.c file defines:

ops->set_sysclk() routine:

	.set_sysclk	= fsl_ssi_set_dai_sysclk,

This routine is called in:
int snd_soc_dai_set_sysclk() @ soc-core.c

which is called in two places for my setup:

1. asoc_simple_card_hw_params() @ simple-card.c

and

2. int asoc_simple_card_init_dai() @ simple-card-utils.c

In this function (point 2.) the

simple_dai->sysclk is set and:

snd_soc_dai_set_sysclk(dai, 0, simple_dai->sysclk, 0)

which sets frequency to 66 MHz [*].



The asoc_simple_card_init_dai() is called in

asoc_simple_card_dai_init() @ simple-card.c

which is assigned to dai_link->init

dai_link->init		= asoc_simple_card_dai_init; @ simple_card.c



And the sysclk itself is defined at:
-------------------------------------

dai_props->codec_dai->sysclk, which is used at:

asoc_simple_card_startup(), asoc_simple_card_shutdown() and others 
functions at simple-card.c


It is setup at:

asoc_simple_card_parse_clk() @ simple-card-utils.c from macro:
#define asoc_simple_card_parse_clk_cpu()


And the problem is:
-------------------

At the
asoc_simple_card_parse_clk()
we finally go to dts node:

/soc/aips-bus@02100000/i2c@021a0000/tfa9879@6C

which has clock from I2C (66 MHz).

(So the [*] hack may help here, since it is checked before checking the 
i2c node).


Note:
[*] - I could workaround this problem by setting:

system-clock-frequency = <0> in

			dailink_master: cpu {
			    sound-dai = <&ssi2>;
			};

but this is IMHO even worse hack.... than this patch.

> 
>> This patch just quits early if it detects change, which don't need to be
>> done.
> 
> I kinda see your point is to error out before hw_params(). So
> I feel it would be better to have a similar 5-times-check in
> the set_sysclk() too, if it's really necessary.
> 
> Btw, I don't see simple card calling set_sysclk() function in
> any earlier stage than hw_params(). I am wondering how did you
> encounter the problem?
> 
> Thanks
> Nicolin
> 


-- 
Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
