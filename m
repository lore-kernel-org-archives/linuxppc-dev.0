Return-Path: <festevam@gmail.com>
Received: from mail-la0-x22f.google.com (mail-la0-x22f.google.com
 [IPv6:2a00:1450:4010:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FF601A0FFF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2015 01:20:06 +1000 (AEST)
Received: by laah7 with SMTP id h7so27140359laa.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 08:20:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55BA35A6.5050609@maciej.szmigiero.name>
References: <55BA35A6.5050609@maciej.szmigiero.name>
Date: Thu, 30 Jul 2015 12:20:00 -0300
Message-ID: <CAOMZO5DJhCXr0oxY7q4TKs0AVS4nW6tDq4EHSGQHOZwf95YWWw@mail.gmail.com>
Subject: Re: [PATCH 1/6] ASoC: fsl_ssi: enable IPG clock during AC'97 reg
 access
From: Fabio Estevam <festevam@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Maciej,

On Thu, Jul 30, 2015 at 11:33 AM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

>  static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
> @@ -1151,6 +1160,14 @@ static unsigned short fsl_ssi_ac97_read(struct snd_ac97 *ac97,
>         unsigned short val = -1;
>         u32 reg_val;
>         unsigned int lreg;
> +       int ret;
> +
> +       ret = clk_prepare_enable(fsl_ac97_data->clk);
> +       if (ret) {
> +               pr_err("ac97 read clk_prepare_enable failed: %d\n",
> +                       ret);
> +               return -1;

return ret, please.
