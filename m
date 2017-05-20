Return-Path: <k.kozlowski.k@gmail.com>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wVXqZ64BPzDqbC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 04:04:10 +1000 (AEST)
Received: by mail-wm0-f65.google.com with SMTP id k15so22596699wmh.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 May 2017 11:04:10 -0700 (PDT)
Date: Sat, 20 May 2017 20:04:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Fabio Estevam <fabio.estevam@nxp.com>,
 patches@opensource.wolfsonmicro.com, Sangbeom Kim <sbkim73@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>,
 Support Opensource <support.opensource@diasemi.com>,
 linux-kernel@vger.kernel.org, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: remove NULL pointer check for clk_disable_unprepare
Message-ID: <20170520180403.mqwfrcjsyukv3phr@kozik-lap>
References: <1495302158-30951-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1495302158-30951-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, May 21, 2017 at 02:42:38AM +0900, Masahiro Yamada wrote:
> After long term efforts of fixing non-common clock implementations,
> clk_disable() is a no-op for a NULL pointer input, and this is now
> tree-wide consistent.
> 
> All clock consumers can safely call clk_disable(_unprepare) without
> NULL pointer check.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  sound/soc/codecs/adau17x1.c                | 3 +--
>  sound/soc/codecs/da7213.c                  | 3 +--
>  sound/soc/codecs/da7218.c                  | 3 +--
>  sound/soc/codecs/da7219-aad.c              | 5 ++---
>  sound/soc/codecs/da7219.c                  | 3 +--
>  sound/soc/codecs/es8328.c                  | 3 +--
>  sound/soc/codecs/wm8731.c                  | 3 +--
>  sound/soc/davinci/davinci-evm.c            | 3 +--
>  sound/soc/fsl/imx-audmux.c                 | 6 ++----
>  sound/soc/intel/boards/bytcr_rt5640.c      | 2 +-
>  sound/soc/intel/boards/cht_bsw_rt5645.c    | 3 +--
>  sound/soc/mediatek/mt8173/mt8173-afe-pcm.c | 6 ++----
>  sound/soc/samsung/i2s.c                    | 3 +--
>  13 files changed, 16 insertions(+), 30 deletions(-)
> 

(...)

> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index af3ba4d..3a06acd 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1122,8 +1122,7 @@ static int i2s_runtime_suspend(struct device *dev)
>  	i2s->suspend_i2scon = readl(i2s->addr + I2SCON);
>  	i2s->suspend_i2spsr = readl(i2s->addr + I2SPSR);
>  
> -	if (i2s->op_clk)
> -		clk_disable_unprepare(i2s->op_clk);
> +	clk_disable_unprepare(i2s->op_clk);
>  	clk_disable_unprepare(i2s->clk);

I think the check in i2s_runtime_resume() should be removed then as well
to keep it symmetrical. Otherwise it looks suspicious.

Best regards,
Krzysztof
