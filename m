Return-Path: <lukma@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmdq83JDQzDrFq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 17:37:53 +1000 (AEST)
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
From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <lukma@denx.de>
Message-ID: <bbcb123b-8700-501f-e6d9-cab9e212de40@denx.de>
Date: Tue, 5 Sep 2017 09:37:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170905050602.GA2774@Asurada-CZ80>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/05/2017 07:06 AM, Nicolin Chen wrote:
> On Sun, Sep 03, 2017 at 01:05:01PM +0200, Lukasz Majewski wrote:
>> The problem is visible in the following setup (on the imx6q):
>> "simple-audio-card" -> ssi2 -> I2S + I2C -> codec
>>
>> The function call log (simple-card probe -> CONFIG_SND_SIMPLE_CARD):
>>
>> asoc_simple_card_init_dai() @ sound/soc/generic/simple-card-utils.c
>> snd_soc_dai_set_sysclk()
>> fsl_ssi_set_dai_sysclk() @ sound/soc/fsl/fsl_ssi.c
>>
>> The last call is changing the bit clock (BCLK) frequency to SSI's IP
>> block clock (ipg = 66 MHz) [1].
> 
> I think a bigger question here is why the routine sets BCLK to 66MHz.

Yes, exactly.

In my case the bclk is set to ipg clock, which is the SSI IP block clock 
(ipg).

> 
>> This is wrong, since IMX SSI block requires the I2S BCLK to be less
>> than 1/5 of [1].
>>
>> As a result the driver initialization passes without any errors, but the
>> speaker-test test case breaks.
>>
>> This commit checks if the fsl_ssi_set_dai_sysclk() frequency passed is
>> not equal to [1].
> 
> I don't feel it's quite comprehensive...what if it's being set to 67MHz.

I think that this clock is not changing for the SoC. It should be 66 MHz 
fixed.

> 
> Thanks
> Nicolin
> 
>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>> ---
>>   sound/soc/fsl/fsl_ssi.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
>> index 173cb84..1186fa9 100644
>> --- a/sound/soc/fsl/fsl_ssi.c
>> +++ b/sound/soc/fsl/fsl_ssi.c
>> @@ -809,6 +809,8 @@ static int fsl_ssi_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
>>   		int clk_id, unsigned int freq, int dir)
>>   {
>>   	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
>> +	if (clk_get_rate(ssi_private->clk) == freq)
>> +		return 0;
>>   
>>   	ssi_private->bitclk_freq = freq;
>>   
>> -- 
>> 2.1.4
>>
> 


-- 
Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
