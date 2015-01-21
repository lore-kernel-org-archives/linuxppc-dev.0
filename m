Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pd0-x236.google.com (mail-pd0-x236.google.com
 [IPv6:2607:f8b0:400e:c02::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23AEB1A0E36
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 05:08:11 +1100 (AEDT)
Received: by mail-pd0-f182.google.com with SMTP id z10so11733924pdj.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 10:08:09 -0800 (PST)
Date: Wed, 21 Jan 2015 10:08:03 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [alsa-devel][PATCH 2/3] ASoC: fsl_sai: Add support for tdm slots
 operation
Message-ID: <20150121180801.GA3361@Alpha>
References: <1421756480-7055-1-git-send-email-zidan.wang@freescale.com>
 <1421756480-7055-3-git-send-email-zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421756480-7055-3-git-send-email-zidan.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com,
 tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 20, 2015 at 08:21:19PM +0800, Zidan Wang wrote:
> @@ -369,10 +380,25 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
>  	u32 word_width = snd_pcm_format_width(params_format(params));
>  	u32 val_cr4 = 0, val_cr5 = 0;
>  	int ret;
> +	u32 bclk;
> +
> +	if (channels == 1)
> +		channels = 2;
> +
> +	if (!sai->slots || sai->slots % channels)
> +		sai->slots = channels;
> +
> +	sai->slots = sai->slots / channels;
> +
> +	if (sai->slot_width < word_width || sai->is_dsp_mode)
> +		sai->slot_width = word_width;

Could you pls explain a bit what's this overriding for?
Or it might be better to put into a comment.

Nicolin
