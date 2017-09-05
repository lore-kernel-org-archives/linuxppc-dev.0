Return-Path: <lukma@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmfkp40qWzDqZ8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 18:19:13 +1000 (AEST)
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <20170905050602.GA2774@Asurada-CZ80>
 <bbcb123b-8700-501f-e6d9-cab9e212de40@denx.de>
 <20170905075247.GA6112@Asurada>
From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Message-ID: <deb40031-9db0-d667-7314-352cf548c295@denx.de>
Date: Tue, 5 Sep 2017 10:19:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170905075247.GA6112@Asurada>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/05/2017 09:52 AM, Nicolin Chen wrote:
> On Tue, Sep 05, 2017 at 09:37:43AM +0200, Łukasz Majewski wrote:
> 
>>>> The last call is changing the bit clock (BCLK) frequency to SSI's IP
>>>> block clock (ipg = 66 MHz) [1].
>>>
>>> I think a bigger question here is why the routine sets BCLK to 66MHz.
>>
>> Yes, exactly.
>>
>> In my case the bclk is set to ipg clock, which is the SSI IP block clock
>> (ipg).
> 
> Can you elaborate why you set ipg clock as bclk? I don't remember SSI could
> derive bitclock from ipg clock.

Just to be clear:

What clock shall be set with:

struct snd_soc_dai_ops {

	int (*set_sysclk)(struct snd_soc_dai *dai,
		int clk_id, unsigned int freq, int dir);
}

callback?

The SSI IP block or BCLK ?


> 
>>>> This is wrong, since IMX SSI block requires the I2S BCLK to be less
>>>> than 1/5 of [1].
>>>>
>>>> As a result the driver initialization passes without any errors, but the
>>>> speaker-test test case breaks.
>>>>
>>>> This commit checks if the fsl_ssi_set_dai_sysclk() frequency passed is
>>>> not equal to [1].
>>>
>>> I don't feel it's quite comprehensive...what if it's being set to 67MHz.
>>
>> I think that this clock is not changing for the SoC. It should be 66 MHz
>> fixed.
> 
> What I mean is that we cannot just look at this SoC. Today is 66MHz for this
> SoC. Tomorrow could be 133MHz for another one. We should put a check that none
> of these shall pass -- the 1/5 limit.
> 

Ok. Good point.


-- 
Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
