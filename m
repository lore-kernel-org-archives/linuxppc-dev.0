Return-Path: <arnaud.mouiche@invoxia.com>
Received: from mail-wr0-x229.google.com (mail-wr0-x229.google.com
 [IPv6:2a00:1450:400c:c0c::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsYzl6595zDr2L
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 18:02:27 +1000 (AEST)
Received: by mail-wr0-x229.google.com with SMTP id m18so26970428wrm.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 01:02:26 -0700 (PDT)
Subject: Re: [PATCH] ASoC: fsl_ssi: Override bit clock rate based on slot
 number
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 perex@perex.cz, lgirdwood@gmail.com, fabio.estevam@nxp.com, timur@tabi.org,
 lukma@denx.de, caleb@crome.org, max.krummenacher@toradex.com,
 mpa@pengutronix.de, mail@maciej.szmigiero.name
References: <1504848223-3376-1-git-send-email-nicoleotsuka@gmail.com>
 <2020d72a-4517-55d0-59a1-171c71f91c7b@invoxia.com>
 <20170912213233.GA11419@Asurada-Nvidia>
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Message-ID: <fdb71350-0b89-8c5a-9ed0-c744bb6f2118@invoxia.com>
Date: Wed, 13 Sep 2017 10:02:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170912213233.GA11419@Asurada-Nvidia>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 12/09/2017 23:32, Nicolin Chen wrote:
> On Tue, Sep 12, 2017 at 04:35:13PM +0200, Arnaud Mouiche wrote:
>
>>> - * freq: Output BCLK frequency = samplerate * 32 (fixed) * channels
>>> - * dir: SND_SOC_CLOCK_OUT -> TxBCLK, SND_SOC_CLOCK_IN -> RxBCLK.
>>> + * freq: Output BCLK frequency = samplerate * 32 (fixed) * slots (or channels)
>> Slots are not necessarily 32 bits width.
>> Indeed, a simple grep of snd_soc_dai_set_tdm_slot shows 16, 24, 32
>> and 0 bits usage. (don't know the real meaning of 0 BTW...)
>> So, it should be good to also remember the slots width given in
>> snd_soc_dai_set_tdm_slot() call.
> RM says that the word length is fixed to 32 in I2S Master mode.
> So I used it here. But I think using it with the slots could be
> wrong here as you stated. What kind of clock rates (bit and lr)
> does a TDM case have?
>
> The problem of slot width here is handled in the set_tdm_slot()
> at all. So I tried to ignored that. But we probably do need it
> when calculating things with the slot number.
>
> Could you please give me a few set of examples of how you set
> set_sysclk(), set_tdm_slot() with the current driver? The idea
> here is to figure out a way to calculate the bclk in hw_params
> without getting set_sysclk() involved any more.

Here is one, where a bclk = 4*16*fs is expected

    static int imx_hifi_hw_params(struct snd_pcm_substream *substream,
                          struct snd_pcm_hw_params *params)
    {
         struct snd_soc_pcm_runtime *rtd = substream->private_data;
         struct imx_priv *priv = &card_priv;
         struct device *dev = &priv->pdev->dev;

         int ret = 0;
         struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
         unsigned int freq;
         int ch;

         /* configuring cpu_dai
          * - bitclk  (fclk is computed automatically)
          *      16bit * 4 (max) channels * sampling rate
          * - tdm maskto select the active channels
          */

         freq = 4 * 16 * params_rate(params);
         if (freq != priv->current_freq) {
             /* clk_id and direction are not taken in count by fsl_ssi
    driver */
             ret = snd_soc_dai_set_sysclk( cpu_dai, 0, freq, 0 );
             if (ret) {
                 dev_err(dev, "failed to set cpu dai bitclk: %u\n", freq);
                 return ret;
             }
             priv->current_freq = freq;
         }
         ch = params_channels(params);
         if (ch != priv->current_ch) {
             ret = snd_soc_dai_set_tdm_slot( cpu_dai, (1 << ch)-1, (1 <<
    ch)-1, 4, 16 );
             if (ret) {
                 dev_err(dev, "failed to set cpu dai tdm slots:
    ch=%d\n", ch);
                 return ret;
             }
             priv->current_ch = ch;
         }
         return 0;
    }

In another setup, there are 8 x 16 bits slots, whatever the number of 
active channels is.
In this case bclk = 128 * fs
The number of slots is completely arbitrary. Some slots can even be 
reserved for communication between codecs that don't communicate with linux.

>
>> Anyway, there is something wrong in the snd_soc_codec_set_sysclk
>> usage by fsl_ssi
>> Let's get a look again at the description:
>>
>>     /**
>>       * snd_soc_dai_set_sysclk - configure DAI system or master clock.
>>       * @dai: DAI
>>       * @clk_id: DAI specific clock ID
>>       * @freq: new clock frequency in Hz
>>       * @dir: new clock direction - input/output.
>>       *
>>       * Configures the DAI master (MCLK) or system (SYSCLK) clocking.
>>       */
>>     int snd_soc_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>>          unsigned int freq, int dir)
>>
>> So, it can be used to configure 2 different clocks (and more) with
>> different usages.
>>
>> Lukasz complains that simple-card is configuring MCLK incorrectly.
>> but simple-card, only want to configure the SYSCLK, whereas fsl_ssi
>> understand "configure the MCLK..." (fsl_ssi doesn't check the clk_id
>> at all)
> It's more than a clock_id in my opinion. The driver now sets
> the bit clock rate via set_sysclk() other than the MCLK rate
> actually.
>
>> I think the problem is here.
>> I would propose a new clk_id
>>
>>      #define FSL_SSI_SYSCLK_MCLK 1
>>
>> And leave fsl_ssi_set_dai_sysclk(xxx, FSL_SSI_SYSCLK_MCLK, ...)
>> override the computed mlck.
>> This will leave a way for obscure TDM users to specify a specific a
>> random mclk frequency for obscure reasons...
>> Unfortunately, such generic clock_id (sysclk, mclk) were never
>> defined widely.
> Unfortunately, it looks like a work around to me. I understand
> the idea of leaving set_sysclk() out there to override the bit
> clock is convenient, but it is not a standard ALSA design and
> may eventually introduce new problems like today.

I agree. I'm not conservative at all concerning this question.
I don't see a way to remove set_sysclk without breaking current TDM 
users anyway, at least for those who don't have their code upstreamed.


All information provided through snd_soc_dai_set_tdm_slot( cpu_dai, 
mask, mask, slots, width ) should be enough
In this case, for TDM users

    bclk = slots * width * fs   (where slots is != channels)



will manage 99 % of the cases.
And the remaining 1% will concern people who need to hack the kernel so 
widely they don't care about the set_sysclk removal.

Now, looking at the code currently in linus/master:sound/soc/fsl 
concerning TDM
- imx-mc13783.c : the codec is master => OK
- fsl-asoc-card.c : *something will break since snd_soc_dai_set_sysclk 
returned code is checked*
- eukrea-tlv320.c : based on imx-ssi.c, so not affected by changes in 
fsl_ssi.c.  Use set_sysclk() only to setup the clock direction
- wm1133-ev1.c : bclk generated by the codec. set_sysclk() not called 
for cpu_dai

Consequently, we can say that few things is broken in linux upstream if 
set_sysclk is removed, and this can be fixed easily for fsl-asoc-card.c


Arnaud
