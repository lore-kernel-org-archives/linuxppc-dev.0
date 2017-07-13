Return-Path: <garsilva@embeddedor.com>
Received: from gateway36.websitewelcome.com (gateway36.websitewelcome.com
 [192.185.187.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7SvP71f9zDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 18:01:37 +1000 (AEST)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
 by gateway36.websitewelcome.com (Postfix) with ESMTP id 9807540408688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 02:36:38 -0500 (CDT)
Date: Thu, 13 Jul 2017 02:36:38 -0500
Message-ID: <20170713023638.Horde.0_LUC9FWsp9URj4mt2AqTT6@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_asrc: constify snd_soc_dai_ops
 structure
References: <20170713072351.GA1485@embeddedgus> <s5hlgnsiyg6.wl-tiwai@suse.de>
In-Reply-To: <s5hlgnsiyg6.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Takashi,

Quoting Takashi Iwai <tiwai@suse.de>:

> Gustavo,
>
> please stop posting in this style.  It's really annoying to see
> spontaneously popping-up almost same patch for more than two hours
> long.
>
> If you have a series of the same fix patches, send them as a patch
> set in a shot with a thread.  git-send-email does it right.
>

I will do that.

Thanks for the suggestion.
--
Gustavo A. R. Silva

> I don't mind a couple of patches posted separately, but this is over
> the limit.
>
>
> thanks,
>
> Takashi
>
> On Thu, 13 Jul 2017 09:23:51 +0200,
> Gustavo A. R. Silva wrote:
>>
>> This structure is only stored in the ops field of a snd_soc_dai_driver
>> structure. That field is declared const, so snd_soc_dai_ops structures
>> that have this property can be declared as const also.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>  sound/soc/fsl/fsl_asrc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
>> index 8cfffa7..806d399 100644
>> --- a/sound/soc/fsl/fsl_asrc.c
>> +++ b/sound/soc/fsl/fsl_asrc.c
>> @@ -542,7 +542,7 @@ static int fsl_asrc_dai_trigger(struct  
>> snd_pcm_substream *substream, int cmd,
>>  	return 0;
>>  }
>>
>> -static struct snd_soc_dai_ops fsl_asrc_dai_ops = {
>> +static const struct snd_soc_dai_ops fsl_asrc_dai_ops = {
>>  	.hw_params    = fsl_asrc_dai_hw_params,
>>  	.hw_free      = fsl_asrc_dai_hw_free,
>>  	.trigger      = fsl_asrc_dai_trigger,
>> --
>> 2.5.0
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
