Return-Path: <o-takashi@sakamocchi.jp>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylvGL6GZJzDqyG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 04:40:41 +1100 (AEDT)
Subject: Re: [PATCH v3 1/2] ALSA: pcm: add SNDRV_PCM_FORMAT_{S, U}20
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
References: <c0667b29-661d-2b48-d5c2-75291f97d55a@maciej.szmigiero.name>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <cd3bc8b1-612b-7e9d-fa67-7b88b1a6f251@sakamocchi.jp>
Date: Tue, 28 Nov 2017 02:40:37 +0900
MIME-Version: 1.0
In-Reply-To: <c0667b29-661d-2b48-d5c2-75291f97d55a@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Nov 27 2017 08:09, Maciej S. Szmigiero wrote:
> This format is similar to existing SNDRV_PCM_FORMAT_{S,U}20_3 that keep
> 20-bit PCM samples in 3 bytes, however i.MX6 platform SSI FIFO does not
> allow 3-byte accesses (including DMA) so a 4-byte (more conventional)
> format is needed for it.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
> Changes from v1: Drop "_4" suffix from these formats since they aren't
> non-standard ones, use empty format slots starting from format number 25
> for them, add information that they are LSB justified formats.
> 
> Changes from v2: Adapt a comment in sound/core/pcm_misc.c so it still
> refers to the same sample formats as before.
> 
> Corresponding alsa-lib changes will be posted as soon as this patch is
> merged on the kernel side, to keep alsa-lib and kernel synchronized.
> 
>   include/sound/pcm.h         |  8 ++++++++
>   include/sound/soc-dai.h     |  2 ++
>   include/uapi/sound/asound.h |  9 +++++++++
>   sound/core/pcm_misc.c       | 19 ++++++++++++++++++-
>   4 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index 24febf9e177c..e054c583d3b3 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -169,6 +169,10 @@ struct snd_pcm_ops {
>   #define SNDRV_PCM_FMTBIT_IMA_ADPCM	_SNDRV_PCM_FMTBIT(IMA_ADPCM)
>   #define SNDRV_PCM_FMTBIT_MPEG		_SNDRV_PCM_FMTBIT(MPEG)
>   #define SNDRV_PCM_FMTBIT_GSM		_SNDRV_PCM_FMTBIT(GSM)
> +#define SNDRV_PCM_FMTBIT_S20_LE	_SNDRV_PCM_FMTBIT(S20_LE)
> +#define SNDRV_PCM_FMTBIT_U20_LE	_SNDRV_PCM_FMTBIT(U20_LE)
> +#define SNDRV_PCM_FMTBIT_S20_BE	_SNDRV_PCM_FMTBIT(S20_BE)
> +#define SNDRV_PCM_FMTBIT_U20_BE	_SNDRV_PCM_FMTBIT(U20_BE)
>   #define SNDRV_PCM_FMTBIT_SPECIAL	_SNDRV_PCM_FMTBIT(SPECIAL)
>   #define SNDRV_PCM_FMTBIT_S24_3LE	_SNDRV_PCM_FMTBIT(S24_3LE)
>   #define SNDRV_PCM_FMTBIT_U24_3LE	_SNDRV_PCM_FMTBIT(U24_3LE)
> @@ -202,6 +206,8 @@ struct snd_pcm_ops {
>   #define SNDRV_PCM_FMTBIT_FLOAT		SNDRV_PCM_FMTBIT_FLOAT_LE
>   #define SNDRV_PCM_FMTBIT_FLOAT64	SNDRV_PCM_FMTBIT_FLOAT64_LE
>   #define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE
> +#define SNDRV_PCM_FMTBIT_S20		SNDRV_PCM_FMTBIT_S20_LE
> +#define SNDRV_PCM_FMTBIT_U20		SNDRV_PCM_FMTBIT_U20_LE
>   #endif
>   #ifdef SNDRV_BIG_ENDIAN
>   #define SNDRV_PCM_FMTBIT_S16		SNDRV_PCM_FMTBIT_S16_BE
> @@ -213,6 +219,8 @@ struct snd_pcm_ops {
>   #define SNDRV_PCM_FMTBIT_FLOAT		SNDRV_PCM_FMTBIT_FLOAT_BE
>   #define SNDRV_PCM_FMTBIT_FLOAT64	SNDRV_PCM_FMTBIT_FLOAT64_BE
>   #define SNDRV_PCM_FMTBIT_IEC958_SUBFRAME SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_BE
> +#define SNDRV_PCM_FMTBIT_S20		SNDRV_PCM_FMTBIT_S20_BE
> +#define SNDRV_PCM_FMTBIT_U20		SNDRV_PCM_FMTBIT_U20_BE
>   #endif
>   
>   struct snd_pcm_file {
> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
> index 58acd00cae19..d970879944fc 100644
> --- a/include/sound/soc-dai.h
> +++ b/include/sound/soc-dai.h
> @@ -102,6 +102,8 @@ struct snd_compr_stream;
>   			       SNDRV_PCM_FMTBIT_S16_BE |\
>   			       SNDRV_PCM_FMTBIT_S20_3LE |\
>   			       SNDRV_PCM_FMTBIT_S20_3BE |\
> +			       SNDRV_PCM_FMTBIT_S20_LE |\
> +			       SNDRV_PCM_FMTBIT_S20_BE |\
>   			       SNDRV_PCM_FMTBIT_S24_3LE |\
>   			       SNDRV_PCM_FMTBIT_S24_3BE |\
>                                  SNDRV_PCM_FMTBIT_S32_LE |\
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index c227ccba60ae..7385024041d2 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -214,6 +214,11 @@ typedef int __bitwise snd_pcm_format_t;
>   #define	SNDRV_PCM_FORMAT_IMA_ADPCM	((__force snd_pcm_format_t) 22)
>   #define	SNDRV_PCM_FORMAT_MPEG		((__force snd_pcm_format_t) 23)
>   #define	SNDRV_PCM_FORMAT_GSM		((__force snd_pcm_format_t) 24)
> +#define	SNDRV_PCM_FORMAT_S20_LE	((__force snd_pcm_format_t) 25) /* \ 			*/
> +#define	SNDRV_PCM_FORMAT_S20_BE	((__force snd_pcm_format_t) 26) /* | 			*/
> +#define	SNDRV_PCM_FORMAT_U20_LE	((__force snd_pcm_format_t) 27) /* | in four bytes,	*/
> +#define	SNDRV_PCM_FORMAT_U20_BE	((__force snd_pcm_format_t) 28) /* / LSB justified	*/
> +/* gap in the numbering for a future standard linear format */
>   #define	SNDRV_PCM_FORMAT_SPECIAL	((__force snd_pcm_format_t) 31)
>   #define	SNDRV_PCM_FORMAT_S24_3LE	((__force snd_pcm_format_t) 32)	/* in three bytes */
>   #define	SNDRV_PCM_FORMAT_S24_3BE	((__force snd_pcm_format_t) 33)	/* in three bytes */
> @@ -248,6 +253,8 @@ typedef int __bitwise snd_pcm_format_t;
>   #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_LE
>   #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_LE
>   #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_LE
> +#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_LE
> +#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_LE
>   #endif
>   #ifdef SNDRV_BIG_ENDIAN
>   #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_BE
> @@ -259,6 +266,8 @@ typedef int __bitwise snd_pcm_format_t;
>   #define	SNDRV_PCM_FORMAT_FLOAT		SNDRV_PCM_FORMAT_FLOAT_BE
>   #define	SNDRV_PCM_FORMAT_FLOAT64	SNDRV_PCM_FORMAT_FLOAT64_BE
>   #define	SNDRV_PCM_FORMAT_IEC958_SUBFRAME SNDRV_PCM_FORMAT_IEC958_SUBFRAME_BE
> +#define	SNDRV_PCM_FORMAT_S20		SNDRV_PCM_FORMAT_S20_BE
> +#define	SNDRV_PCM_FORMAT_U20		SNDRV_PCM_FORMAT_U20_BE
>   #endif
>   
>   typedef int __bitwise snd_pcm_subformat_t;
> diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
> index 9be81025372f..c4eb561d2008 100644
> --- a/sound/core/pcm_misc.c
> +++ b/sound/core/pcm_misc.c
> @@ -163,13 +163,30 @@ static struct pcm_format_data pcm_formats[(INT)SNDRV_PCM_FORMAT_LAST+1] = {
>   		.width = 32, .phys = 32, .le = 0, .signd = 0,
>   		.silence = { 0x69, 0x69, 0x69, 0x69 },
>   	},
> -	/* FIXME: the following three formats are not defined properly yet */
> +	/* FIXME: the following two formats are not defined properly yet */
>   	[SNDRV_PCM_FORMAT_MPEG] = {
>   		.le = -1, .signd = -1,
>   	},
>   	[SNDRV_PCM_FORMAT_GSM] = {
>   		.le = -1, .signd = -1,
>   	},
> +	[SNDRV_PCM_FORMAT_S20_LE] = {
> +		.width = 20, .phys = 32, .le = 1, .signd = 1,
> +		.silence = {},
> +	},
> +	[SNDRV_PCM_FORMAT_S20_BE] = {
> +		.width = 20, .phys = 32, .le = 0, .signd = 1,
> +		.silence = {},
> +	},
> +	[SNDRV_PCM_FORMAT_U20_LE] = {
> +		.width = 20, .phys = 32, .le = 1, .signd = 0,
> +		.silence = { 0x00, 0x00, 0x08, 0x00 },
> +	},
> +	[SNDRV_PCM_FORMAT_U20_BE] = {
> +		.width = 20, .phys = 32, .le = 0, .signd = 0,
> +		.silence = { 0x00, 0x08, 0x00, 0x00 },
> +	},
> +	/* FIXME: the following format is not defined properly yet */
>   	[SNDRV_PCM_FORMAT_SPECIAL] = {
>   		.le = -1, .signd = -1,
>   	},

Looks good to me.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

In next time to post any of your v2 patchset, it's better to add 
commenters of v1 patchset to CC list, so that your patch reaches the 
person who has practical interests in it.

I'm waiting for your another patch to alsa-lib.


Thanks

Takashi Sakamoto
