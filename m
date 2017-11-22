Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhzZR5J72zDr4p
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 10:44:29 +1100 (AEDT)
Subject: Re: [PATCH 1/2] ALSA: pcm: add SNDRV_PCM_FORMAT_{S, U}20_4
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
References: <53d527c0-89f6-d501-09e9-1effea8a5bac@maciej.szmigiero.name>
 <ff52e871-fec0-9095-f2c1-9680aedec431@sakamocchi.jp>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <4d0f43f5-0161-3dfb-1692-e755ad7fe641@maciej.szmigiero.name>
Date: Thu, 23 Nov 2017 00:44:19 +0100
MIME-Version: 1.0
In-Reply-To: <ff52e871-fec0-9095-f2c1-9680aedec431@sakamocchi.jp>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 23.11.2017 00:27, Takashi Sakamoto wrote:
> On Nov 23 2017 04:17, Maciej S. Szmigiero wrote:
(..)
>> --- a/include/uapi/sound/asound.h
>> +++ b/include/uapi/sound/asound.h
>> @@ -236,7 +236,11 @@ typedef int __bitwise snd_pcm_format_t;
>>   #define    SNDRV_PCM_FORMAT_DSD_U32_LE    ((__force snd_pcm_format_t) 50) /* DSD, 4-byte samples DSD (x32), little endian */
>>   #define    SNDRV_PCM_FORMAT_DSD_U16_BE    ((__force snd_pcm_format_t) 51) /* DSD, 2-byte samples DSD (x16), big endian */
>>   #define    SNDRV_PCM_FORMAT_DSD_U32_BE    ((__force snd_pcm_format_t) 52) /* DSD, 4-byte samples DSD (x32), big endian */
>> -#define    SNDRV_PCM_FORMAT_LAST        SNDRV_PCM_FORMAT_DSD_U32_BE
>> +#define    SNDRV_PCM_FORMAT_S20_4LE    ((__force snd_pcm_format_t) 53)    /* in four bytes */
>> +#define    SNDRV_PCM_FORMAT_S20_4BE    ((__force snd_pcm_format_t) 54)    /* in four bytes */
>> +#define    SNDRV_PCM_FORMAT_U20_4LE    ((__force snd_pcm_format_t) 55)    /* in four bytes */
>> +#define    SNDRV_PCM_FORMAT_U20_4BE    ((__force snd_pcm_format_t) 56)    /* in four bytes */
>> +#define    SNDRV_PCM_FORMAT_LAST        SNDRV_PCM_FORMAT_U20_4BE
> 
> In my opinion, for this type of definition, it's better to declare left/right-adjusted or padding side. (Of course, silence definition is already a hint, however the lack of information forces developers to have a careful behaviour to handle entries on the list.> (I note that in current ALSA PCM interface there's no way to deliver MSB/LSB-first information about sample format.)

No other sound format includes this information in its name so if we name
these formats SNDRV_PCM_FORMAT_{S, U}20LSB_4 they are going to have it
inconsistent with every other one (I assume you meant to include such
information in a format name?).

But information about whether this format is MSB or LSB justified can be
added in a comment so the situation is clear for other developers from
the definition without needing to read the actual processing code.

> Additionally, alsa-lib includes some codes related to the definition[1]. If you'd like to thing goes well out of ALSA SoC part, it's better to submit changes to the library as well.
> 
> [1] http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_misc.c;h=5420b1895713a3aec3624a5218794a7b49baf167;hb=HEAD

I have alsa-lib changes ready for these formats - they were needed to
test these patches, will post them when this is merged on the kernel
side (in case some changes are needed which affect both).

> Regards
> 
> Takashi Sakamoto

Best regards,
Maciej Szmigiero
