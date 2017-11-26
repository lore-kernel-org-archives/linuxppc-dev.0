Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ylQj63zVlzDqlF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Nov 2017 10:13:46 +1100 (AEDT)
Subject: Re: [PATCH v2 1/2] ALSA: pcm: add SNDRV_PCM_FORMAT_{S, U}20
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown
 <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>,
 linuxppc-dev@lists.ozlabs.org
References: <a54e6905-6124-9a59-b7ca-97cc650a8f99@maciej.szmigiero.name>
 <c9310a8f-d16d-ee8f-fe86-8316e71cf7fc@sakamocchi.jp>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <618daa73-dfd4-6e88-617f-10478b45ad64@maciej.szmigiero.name>
Date: Mon, 27 Nov 2017 00:13:39 +0100
MIME-Version: 1.0
In-Reply-To: <c9310a8f-d16d-ee8f-fe86-8316e71cf7fc@sakamocchi.jp>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 26.11.2017 10:27, Takashi Sakamoto wrote:
> Hi,
> 
(..)
> Before applying this patch:
> 166         /* FIXME: the following three formats are not defined properly yet */
> 167         [SNDRV_PCM_FORMAT_MPEG] = {
> 168                 .le = -1, .signd = -1,
> 169         },
> 170         [SNDRV_PCM_FORMAT_GSM] = {
> 171                 .le = -1, .signd = -1,
> 172         },
> 173         [SNDRV_PCM_FORMAT_SPECIAL] = {
> 174                 .le = -1, .signd = -1,
> 175         },
> 
> After applying this patch:
> 
> 166         /* FIXME: the following three formats are not defined properly yet */
> 167         [SNDRV_PCM_FORMAT_MPEG] = {
> 168                 .le = -1, .signd = -1,
> 169         },
> 170         [SNDRV_PCM_FORMAT_GSM] = {
> 171                 .le = -1, .signd = -1,
> 172         },
> 173         [SNDRV_PCM_FORMAT_S20_LE] = {
(..)> 
> I think it good to add an alternative comment for each of entry which is not defined yet, like:
> 
> -> 166         /* FIXME: this format is not defined properly yet */
> 167         [SNDRV_PCM_FORMAT_MPEG] = {
> 168                 .le = -1, .signd = -1,
> 169         },
> -> 170         /* FIXME: this format is not defined properly yet */
> 171         [SNDRV_PCM_FORMAT_GSM] = {
> 172                 .le = -1, .signd = -1,
> 173         },
> 174         [SNDRV_PCM_FORMAT_S20_LE] = {
> 175                 .width = 20, .phys = 32, .le = 1, .signd = 1,
> 176                 .silence = {},
> 177         },
> 178         [SNDRV_PCM_FORMAT_S20_BE] = {
> 179                 .width = 20, .phys = 32, .le = 0, .signd = 1,
> 180                 .silence = {},
> 181         },
> 182         [SNDRV_PCM_FORMAT_U20_LE] = {
> 183                 .width = 20, .phys = 32, .le = 1, .signd = 0,
> 184                 .silence = { 0x00, 0x00, 0x08, 0x00 },
> 185         },
> 186         [SNDRV_PCM_FORMAT_U20_BE] = {
> 187                 .width = 20, .phys = 32, .le = 0, .signd = 0,
> 188                 .silence = { 0x00, 0x08, 0x00, 0x00 },
> 189         },
> -> 190         /* FIXME: this format is not defined properly yet */
> 191         [SNDRV_PCM_FORMAT_SPECIAL] = {
> 192                 .le = -1, .signd = -1,
> 193         },
> 

Thanks, fixed now in v3.

> Regards
> 
> Takashi Sakamoto

Best regards,
Maciej Szmigiero
