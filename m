Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttRQ02X86zDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 08:08:56 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id 3so43147281oih.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 13:08:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483467777-8651-1-git-send-email-caleb@signalessence.com>
References: <1483467777-8651-1-git-send-email-caleb@signalessence.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 3 Jan 2017 19:08:53 -0200
Message-ID: <CAOMZO5AS7TPu1PmdNUZuSEJQO2C7L+7Kn2wpetoxHCzwHiyokg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] fsl_ssi: set fifo watermark to more reliable
 value
To: Caleb Crome <ccrome@gmail.com>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Caleb Crome <caleb@crome.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 3, 2017 at 4:22 PM, Caleb Crome <ccrome@gmail.com> wrote:
> From: Caleb Crome <caleb@crome.org>
>
> The fsl_ssi fifo watermark is by default set to 2 free spaces (i.e.
> activate DMA on FIFO when only 2 spaces are left.)  This means the
> DMA must service the fifo within 2 audio samples, which is just not
> enough time  for many use cases with high data rate.  In many
> configurations the audio channel slips (causing l/r swap in stereo
> configurations, or channel slipping in multi-channel configurations).
>
> This patch gives more breathing room and allows the SSI to operate
> reliably by changing the fifio refill watermark to 8.
>
> There is no change in behavior for older chips (with an 8-deep fifo).
> Only the newer chips with a 15-deep fifo get the new behavior. I
> suspect a new fifo depth setting could be optimized on the older
> chips too, but I have not tested.
>
> Signed-off-by: Caleb Crome <caleb@crome.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
