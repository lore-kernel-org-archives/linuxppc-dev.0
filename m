Return-Path: <o-takashi@sakamocchi.jp>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjB7c2W2KzDrK5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 18:40:27 +1100 (AEDT)
Subject: Re: [PATCH 1/2] ALSA: pcm: add SNDRV_PCM_FORMAT_{S, U}20_4
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
References: <53d527c0-89f6-d501-09e9-1effea8a5bac@maciej.szmigiero.name>
 <ff52e871-fec0-9095-f2c1-9680aedec431@sakamocchi.jp>
 <4d0f43f5-0161-3dfb-1692-e755ad7fe641@maciej.szmigiero.name>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <181cd3a8-cc74-d858-071a-7ae3e465406a@sakamocchi.jp>
Date: Thu, 23 Nov 2017 16:40:21 +0900
MIME-Version: 1.0
In-Reply-To: <4d0f43f5-0161-3dfb-1692-e755ad7fe641@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Nov 23 2017 08:44, Maciej S. Szmigiero wrote:
> On 23.11.2017 00:27, Takashi Sakamoto wrote:
>> On Nov 23 2017 04:17, Maciej S. Szmigiero wrote:
> (..)
>>> --- a/include/uapi/sound/asound.h
>>> +++ b/include/uapi/sound/asound.h
>>> @@ -236,7 +236,11 @@ typedef int __bitwise snd_pcm_format_t;
>>>    #define    SNDRV_PCM_FORMAT_DSD_U32_LE    ((__force snd_pcm_format_t) 50) /* DSD, 4-byte samples DSD (x32), little endian */
>>>    #define    SNDRV_PCM_FORMAT_DSD_U16_BE    ((__force snd_pcm_format_t) 51) /* DSD, 2-byte samples DSD (x16), big endian */
>>>    #define    SNDRV_PCM_FORMAT_DSD_U32_BE    ((__force snd_pcm_format_t) 52) /* DSD, 4-byte samples DSD (x32), big endian */
>>> -#define    SNDRV_PCM_FORMAT_LAST        SNDRV_PCM_FORMAT_DSD_U32_BE
>>> +#define    SNDRV_PCM_FORMAT_S20_4LE    ((__force snd_pcm_format_t) 53)    /* in four bytes */
>>> +#define    SNDRV_PCM_FORMAT_S20_4BE    ((__force snd_pcm_format_t) 54)    /* in four bytes */
>>> +#define    SNDRV_PCM_FORMAT_U20_4LE    ((__force snd_pcm_format_t) 55)    /* in four bytes */
>>> +#define    SNDRV_PCM_FORMAT_U20_4BE    ((__force snd_pcm_format_t) 56)    /* in four bytes */
>>> +#define    SNDRV_PCM_FORMAT_LAST        SNDRV_PCM_FORMAT_U20_4BE
>>
>> In my opinion, for this type of definition, it's better to declare left/right-adjusted or padding side. (Of course, silence definition is already a hint, however the lack of information forces developers to have a careful behaviour to handle entries on the list.
>> (I note that in current ALSA PCM interface there's no way to deliver MSB/LSB-first information about sample format.)
> 
> No other sound format includes this information in its name

You overlook comments in 'SNDRV_PCM_FORMAT_[U|S]24_[LE|BE]'. Let me 
refer to them [1]:

198 #define SNDRV_PCM_FORMAT_S24_LE ((__force snd_pcm_format_t) 6) /* 
low three bytes */
199 #define SNDRV_PCM_FORMAT_S24_BE ((__force snd_pcm_format_t) 7) /* 
low three bytes */
200 #define SNDRV_PCM_FORMAT_U24_LE ((__force snd_pcm_format_t) 8) /* 
low three bytes */
201 #define SNDRV_PCM_FORMAT_U24_BE ((__force snd_pcm_format_t) 9) /* 
low three bytes */

In your way, these types of format can be represented by 
'SNDRV_PCM_FORMAT_[U|S]24_4[LE|BE]', thus for playback direction they
mean:

```
#include <sound/asound.h>
#include <endian.h>

uint32_t *buf;
uint32_t sample;
snd_pcm_format_t format;

sample = generate_a_sample();
(sample & ~0x00ffffff) /* invalid bits as sample */

if (format == SNDRV_PCM_FORMAT_[U|S]24_LE) {
   buf[0] = htole32(sample);
else
   buf[0] = htobe32(sample);

/* transfer content of the buf via ALSA kernel stuffs. */
```

The comments are good enough for application developers in an aspect of 
a position for padding.

In general, studying from the past is preferable behaviour to be genius, 
however accumulated history includes mistakes and defects. Just 
pretending the past is not so genius, without further consideration.

Actually additions of the rest of entries for PCM format were done 
without enough cares of what information they give to application 
developers. Adding new entries is easier than fixing and improving them 
once exposed. It's a reason that they're left what they're.

I wish you had enough care to assist applications developers. Without 
applications, drivers are worthless and just waste of code base.

> so if we name
> these formats SNDRV_PCM_FORMAT_{S, U}20LSB_4 they are going to have it
> inconsistent with every other one
>
> (I assume you meant to include such information in a format name?).
>
> But information about whether this format is MSB or LSB justified can be
> added in a comment so the situation is clear for other developers from
> the definition without needing to read the actual processing code.

For consistency of the other entries, this is not so preferable, in my 
opinion. So I didn't suggest it and just noted.

>> Additionally, alsa-lib includes some codes related to the definition[1]. If you'd like to thing goes well out of ALSA SoC part, it's better to submit changes to the library as well.
>>
>> [1] http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_misc.c;h=5420b1895713a3aec3624a5218794a7b49baf167;hb=HEAD
> 
> I have alsa-lib changes ready for these formats - they were needed to
> test these patches, will post them when this is merged on the kernel
> side (in case some changes are needed which affect both).

Please pay enough care when writing patch comment. Silence means 
nothing, at least for reviewers, even if you have good preparations.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/include/uapi/sound/asound.h?h=sound-4.15-rc1#n198


Regards

Takashi Sakamoto
