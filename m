Return-Path: <festevam@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DC951A08A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 00:08:48 +1100 (AEDT)
Received: by mail-io0-x243.google.com with SMTP id f81so15151539iof.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 05:08:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1452622411-16674-3-git-send-email-LW@KARO-electronics.de>
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
 <1452622411-16674-3-git-send-email-LW@KARO-electronics.de>
Date: Wed, 13 Jan 2016 11:08:46 -0200
Message-ID: <CAOMZO5BifUkzSkPCf08TSQ3B8AHiXuVhBzy+tMsnMtA8t-AvJg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: fsl: select SND_SOC_FSL_SAI or
 SND_SOC_FSL_SSI depending on SoC type
From: Fabio Estevam <festevam@gmail.com>
To: =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 12, 2016 at 4:13 PM, Lothar Wa=C3=9Fmann <LW@karo-electronics.d=
e> wrote:

> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 14dfdee..c128823 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -258,7 +258,8 @@ config SND_SOC_IMX_SGTL5000
>         select SND_SOC_SGTL5000
>         select SND_SOC_IMX_PCM_DMA
>         select SND_SOC_IMX_AUDMUX
> -       select SND_SOC_FSL_SSI
> +       select SND_SOC_FSL_SAI if SOC_IMX6UL
> +       select SND_SOC_FSL_SSI if SOC_IMX6Q || SOC_IMX6SL || SOC_IMX6SX

MX6SX has SSI and SAI interfaces.
