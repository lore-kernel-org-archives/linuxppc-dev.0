Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjJTm5SHDzDrN5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 23:26:34 +1100 (AEDT)
Subject: Re: [PATCH 1/2] ALSA: pcm: add SNDRV_PCM_FORMAT_{S,U}20_4
To: Takashi Iwai <tiwai@suse.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Timur Tabi <timur@tabi.org>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Fabio Estevam <fabio.estevam@nxp.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <53d527c0-89f6-d501-09e9-1effea8a5bac@maciej.szmigiero.name>
 <s5hwp2h4dto.wl-tiwai@suse.de>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <38602575-acc5-2106-38ef-3a71076de398@maciej.szmigiero.name>
Date: Thu, 23 Nov 2017 13:26:25 +0100
MIME-Version: 1.0
In-Reply-To: <s5hwp2h4dto.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23.11.2017 09:08, Takashi Iwai wrote:
> On Wed, 22 Nov 2017 20:17:34 +0100,
>  Maciej S. Szmigiero  wrote:
>>
>> This format is similar to existing SNDRV_PCM_FORMAT_{S,U}20_3 that keep
>> 20-bit PCM samples in 3 bytes, however i.MX6 platform SSI FIFO does not
>> allow 3-byte accesses (including DMA) so a 4-byte format is needed for it.
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> ---
>>  include/sound/pcm.h         |  8 ++++++++
>>  include/sound/soc-dai.h     |  2 ++
>>  include/uapi/sound/asound.h | 10 +++++++++-
>>  sound/core/pcm_misc.c       | 16 ++++++++++++++++
>>  4 files changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
>> index 24febf9e177c..7ad2d3f0934f 100644
>> --- a/include/sound/pcm.h
>> +++ b/include/sound/pcm.h
>> @@ -191,6 +191,10 @@ struct snd_pcm_ops {
>>  #define SNDRV_PCM_FMTBIT_DSD_U32_LE	_SNDRV_PCM_FMTBIT(DSD_U32_LE)
>>  #define SNDRV_PCM_FMTBIT_DSD_U16_BE	_SNDRV_PCM_FMTBIT(DSD_U16_BE)
>>  #define SNDRV_PCM_FMTBIT_DSD_U32_BE	_SNDRV_PCM_FMTBIT(DSD_U32_BE)
>> +#define SNDRV_PCM_FMTBIT_S20_4LE	_SNDRV_PCM_FMTBIT(S20_4LE)
>> +#define SNDRV_PCM_FMTBIT_U20_4LE	_SNDRV_PCM_FMTBIT(U20_4LE)
>> +#define SNDRV_PCM_FMTBIT_S20_4BE	_SNDRV_PCM_FMTBIT(S20_4BE)
>> +#define SNDRV_PCM_FMTBIT_U20_4BE	_SNDRV_PCM_FMTBIT(U20_4BE)
> 
> The conventional names aren't with "4" suffix,
> e.g. SNDRV_PCM_FMTBIT_S20_LE.

Will rename it in a respin.
> Also, there are still empty slots under 32, e.g. start from 25.
> The formats over 31 were used for 3 bytes or other unusual formats
> (although nowadays it makes little sense), and the slots < 32 would
> fit for 4 bytes linear format.

Will renumber these formats to start from 25 in a respin.

> It's still an open question whether we should increase the protocol
> number when we add a new PCM format definition.  I guess it's not, as
> the ABI behavior itself doesn't change, but I might have overlooked
> some possible breakage.

This isn't an incompatible, application-breaking, ABI change (it is
rather kind of an additional "ABI"), so I think an ALSA protocol number
should not be increased for it.

> thanks,
> 
> Takashi
> 

Thanks,
Maciej
