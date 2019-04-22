Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3983C10F14
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:10:36 +0000 (UTC)
Received: from lists.ozlabs.org (unknown [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE31A20859
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 01:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DyCW48L0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE31A20859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nT611NvxzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 11:10:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="DyCW48L0"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nT4B4zhVzDqNg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 11:08:58 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id 8so4927447pfr.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 18:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=XaoaARy9E92KPIsK7OPHAPD9rRmm+5Hg1tDM+cIDRGE=;
 b=DyCW48L0mFL6JzmBGpzEJdJZdDZhG9y04ThGxRQuzAbbR6MW0vldd/jqVYYWDmiD18
 BcsnxVdsZl6TcLgQCnYvTYt23+kZ04a+NCXaJCHpB9FW4fwpXy52Ts1q9ERK3+L9jKGU
 +GZUiLqvD2F4ToXS3bDxt5XHxmcJq0raMGu7c58N9QFX6fCfxllGuXyEpLuUxKDetGyO
 vtukzTGQEpmJFE0NdfQbe5u/fdIBS758QFkJ9e5qdNxxwGxpGRFRrwgVF1LGOe7mx4do
 DACDsE+R+YEAMpw74QI4TFlEa18tUVh0WbcNj81sk5/IstgV7NvisdVuQteBoTRnOf8l
 Oiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=XaoaARy9E92KPIsK7OPHAPD9rRmm+5Hg1tDM+cIDRGE=;
 b=NtegXVcQZ3QSPpdfuVK08yeVZ3pw6VpiXWLbHMdY7XnP6Zc3HkIzH4oF2xthFr1ggK
 drH7yk6RcCnEqoiwoe3jT47QflskJreB+xpUaYcppbj9PHZmg+R4gqnkz8rx0e/NsMLJ
 zvW2Xb58E5WWZgAPcqCYzeNiJ0w622lrJ6phAclJhbKdCMR+KUFk+5l86LXyYT+x4p6a
 WOO6dst7hCJ1Hi64OfkH0Pa4L/l2gx5ZwtLA54loCLmzi9b9i9tohg2kCUbGfJjIr/Ko
 Xm3YRRXl/D8Fjtyq38I67zqUaIE4NNz3uWMYLiIcIaZwSPMW12EZzIrZBQXpjanMEnP/
 wnJQ==
X-Gm-Message-State: APjAAAU2Ars1s87pn1ilyHPnKafHT/qoIMIqw6lePov9i/ZJwF8GxfyO
 yJujDyQnQeA3RcI0l37ptcY=
X-Google-Smtp-Source: APXvYqzUB/tfzIUVnitaIU68cStO0NeEu7VySpo/Aq+/u3y1qihjbpc4H+vv43BGBoHxO28sKski1w==
X-Received: by 2002:a62:12d0:: with SMTP id 77mr17825872pfs.15.1555895335454; 
 Sun, 21 Apr 2019 18:08:55 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 y3sm13791248pge.7.2019.04.21.18.08.54
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Apr 2019 18:08:54 -0700 (PDT)
Date: Sun, 21 Apr 2019 18:08:47 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 1/3 v2] ASoC: fsl_sai: Update is_slave_mode with correct
 value
Message-ID: <20190422010846.GA8364@Asurada>
References: <20190421193853.10188-1-daniel.baluta@nxp.com>
 <20190421193853.10188-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421193853.10188-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Apr 21, 2019 at 07:39:08PM +0000, Daniel Baluta wrote:
> is_slave_mode defaults to false because sai structure
> that contains it is kzalloc'ed.
> 
> Anyhow, if we decide to set the following configuration
> SAI slave -> SAI master, is_slave_mode will remain set on true
> although SAI being master it should be set to false.
> 
> Fix this by updating is_slave_mode for each call of
> fsl_sai_set_dai_fmt.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks

> ---
>  sound/soc/fsl/fsl_sai.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index b563004fb89f..d9df98975cf8 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -268,12 +268,14 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
>  	case SND_SOC_DAIFMT_CBS_CFS:
>  		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
>  		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
> +		sai->is_slave_mode = false;
>  		break;
>  	case SND_SOC_DAIFMT_CBM_CFM:
>  		sai->is_slave_mode = true;
>  		break;
>  	case SND_SOC_DAIFMT_CBS_CFM:
>  		val_cr2 |= FSL_SAI_CR2_BCD_MSTR;
> +		sai->is_slave_mode = false;
>  		break;
>  	case SND_SOC_DAIFMT_CBM_CFS:
>  		val_cr4 |= FSL_SAI_CR4_FSD_MSTR;
> -- 
> 2.17.1
> 
