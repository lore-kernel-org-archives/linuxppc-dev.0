Return-Path: <o-takashi@sakamocchi.jp>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yl4NN5yhFzDrKJ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Nov 2017 20:28:01 +1100 (AEDT)
Subject: Re: [PATCH v2 1/2] ALSA: pcm: add SNDRV_PCM_FORMAT_{S, U}20
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
References: <a54e6905-6124-9a59-b7ca-97cc650a8f99@maciej.szmigiero.name>
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Message-ID: <c9310a8f-d16d-ee8f-fe86-8316e71cf7fc@sakamocchi.jp>
Date: Sun, 26 Nov 2017 18:27:51 +0900
MIME-Version: 1.0
In-Reply-To: <a54e6905-6124-9a59-b7ca-97cc650a8f99@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Nov 24 2017 08:31, Maciej S. Szmigiero wrote:
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
> Corresponding alsa-lib changes will be posted as soon as this patch is
> merged on the kernel side, to keep alsa-lib and kernel synchronized.
> 
>   include/sound/pcm.h         |  8 ++++++++
>   include/sound/soc-dai.h     |  2 ++
>   include/uapi/sound/asound.h |  9 +++++++++
>   sound/core/pcm_misc.c       | 16 ++++++++++++++++
>   4 files changed, 35 insertions(+)
> ...
> diff --git a/sound/core/pcm_misc.c b/sound/core/pcm_misc.c
> index 9be81025372f..c62bfe27106f 100644
> --- a/sound/core/pcm_misc.c
> +++ b/sound/core/pcm_misc.c
> @@ -170,6 +170,22 @@ static struct pcm_format_data pcm_formats[(INT)SNDRV_PCM_FORMAT_LAST+1] = {
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
>   	[SNDRV_PCM_FORMAT_SPECIAL] = {
>   		.le = -1, .signd = -1,
>   	},

Before applying this patch:
166         /* FIXME: the following three formats are not defined 
properly yet */
167         [SNDRV_PCM_FORMAT_MPEG] = {
168                 .le = -1, .signd = -1,
169         },
170         [SNDRV_PCM_FORMAT_GSM] = {
171                 .le = -1, .signd = -1,
172         },
173         [SNDRV_PCM_FORMAT_SPECIAL] = {
174                 .le = -1, .signd = -1,
175         },

After applying this patch:

166         /* FIXME: the following three formats are not defined 
properly yet */
167         [SNDRV_PCM_FORMAT_MPEG] = {
168                 .le = -1, .signd = -1,
169         },
170         [SNDRV_PCM_FORMAT_GSM] = {
171                 .le = -1, .signd = -1,
172         },
173         [SNDRV_PCM_FORMAT_S20_LE] = {
174                 .width = 20, .phys = 32, .le = 1, .signd = 1,
175                 .silence = {},
176         },
177         [SNDRV_PCM_FORMAT_S20_BE] = {
178                 .width = 20, .phys = 32, .le = 0, .signd = 1,
179                 .silence = {},
180         },
181         [SNDRV_PCM_FORMAT_U20_LE] = {
182                 .width = 20, .phys = 32, .le = 1, .signd = 0,
183                 .silence = { 0x00, 0x00, 0x08, 0x00 },
184         },
185         [SNDRV_PCM_FORMAT_U20_BE] = {
186                 .width = 20, .phys = 32, .le = 0, .signd = 0,
187                 .silence = { 0x00, 0x08, 0x00, 0x00 },
188         },
189         [SNDRV_PCM_FORMAT_SPECIAL] = {
190                 .le = -1, .signd = -1,
191         },

I think it good to add an alternative comment for each of entry which is 
not defined yet, like:

-> 166         /* FIXME: this format is not defined properly yet */
167         [SNDRV_PCM_FORMAT_MPEG] = {
168                 .le = -1, .signd = -1,
169         },
-> 170         /* FIXME: this format is not defined properly yet */
171         [SNDRV_PCM_FORMAT_GSM] = {
172                 .le = -1, .signd = -1,
173         },
174         [SNDRV_PCM_FORMAT_S20_LE] = {
175                 .width = 20, .phys = 32, .le = 1, .signd = 1,
176                 .silence = {},
177         },
178         [SNDRV_PCM_FORMAT_S20_BE] = {
179                 .width = 20, .phys = 32, .le = 0, .signd = 1,
180                 .silence = {},
181         },
182         [SNDRV_PCM_FORMAT_U20_LE] = {
183                 .width = 20, .phys = 32, .le = 1, .signd = 0,
184                 .silence = { 0x00, 0x00, 0x08, 0x00 },
185         },
186         [SNDRV_PCM_FORMAT_U20_BE] = {
187                 .width = 20, .phys = 32, .le = 0, .signd = 0,
188                 .silence = { 0x00, 0x08, 0x00, 0x00 },
189         },
-> 190         /* FIXME: this format is not defined properly yet */
191         [SNDRV_PCM_FORMAT_SPECIAL] = {
192                 .le = -1, .signd = -1,
193         },


Regards

Takashi Sakamoto
