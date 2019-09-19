Return-Path: <SRS0=y999=XO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B151C3A5A6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 23:52:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF30721907
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Sep 2019 23:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNWSnXv4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF30721907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ZDCk4GR8zF58q
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Sep 2019 09:52:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="kNWSnXv4"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ZD9K3WWGzDqP1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2019 09:49:54 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id y5so3308889pfo.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2019 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DO8lDkgH/09igYhmGE97oh8+8ahZBIflCShVrR9OrmU=;
 b=kNWSnXv4Q9H2UbWOSwbkFDyDYqrw5V5FmU8EqdV7tUgMVaqW5UnRoGaPbLRxAC+hEd
 3daoRlbwjVz6K32Az6qna8OmyjDaxJuCA2WvshtxpT7DkMnbifHYEJ0BsKiMtLFSyUv3
 xDtTO+b/VsYw08fNK30ntWhKO+BaL7AAi/8AlX1aHtOMrqbJ8T1WEIQpq9f5s4SWLwhz
 bMbeKs2DUZAbkByeqfxDZXfHVfm4ozWqy8uoRaFUJ9B0hw9MOXly7hJRc2nommYb7OBW
 jiKWP5+nLvTY4Ez/l9sDmXVwjP0y2WNKAAcZZMFAx8o/6PkqGygW6BcO7SHlaOPWr9Vk
 I92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=DO8lDkgH/09igYhmGE97oh8+8ahZBIflCShVrR9OrmU=;
 b=WeiNWXgEISvrvuC6nXvxdcePNrDaTx36SkldWyZvMy3ppiHXfvq3yFG1dgInh8HMum
 +w/b+Cpauyl+1H2gm58gITPBcuwuJGXlRtZbmhQ+DDdGlNXcDfJj0ZnaQyZOi3kRHR5R
 psXQJRauQskuKaGp/jDBZZfymqflEj5rRgtNUzQNHFOYmkWrJskdOcXchd2AjcAWr0PM
 QwNOA8OgnL1ableN5SOJdRmm/rcXFCsY8qAPqq92Ha8axnvRMhMZ+9JjBszdtH7pbomF
 ugOeVk6FTOSB4962wwstNqhV6tZHbig9HvHxq3t64OQOhLH9C2ehHMff7EGlO106srCG
 9Rzw==
X-Gm-Message-State: APjAAAXkFyLmDlaB41AANKBUWC1xapEBJgGmffOWrV73KBbtlaZjRH/E
 PqfF2vDmpb9SH45uBy55lrg=
X-Google-Smtp-Source: APXvYqxicFF4tS7Mcj+VMjT1qOkc2frSVMWmjKYUyhpoVLCZd7f7tLUEHubAzMDOxlG+EHV+svcZtA==
X-Received: by 2002:a62:1c16:: with SMTP id c22mr13829974pfc.10.1568936990878; 
 Thu, 19 Sep 2019 16:49:50 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id e21sm30169pgr.43.2019.09.19.16.49.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 19 Sep 2019 16:49:50 -0700 (PDT)
Date: Thu, 19 Sep 2019 16:48:58 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V3 2/4] ASoC: fsl_asrc: update supported sample format
Message-ID: <20190919234857.GA14287@Asurada-Nvidia.nvidia.com>
References: <cover.1568861098.git.shengjiu.wang@nxp.com>
 <5811f393692a7668564fd4b9ef5708c1e3db8dc0.1568861098.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5811f393692a7668564fd4b9ef5708c1e3db8dc0.1568861098.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, timur@kernel.org,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 lgirdwood@gmail.com, robh+dt@kernel.org, perex@perex.cz, broonie@kernel.org,
 festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 19, 2019 at 08:11:40PM +0800, Shengjiu Wang wrote:
> The ASRC support 24bit/16bit/8bit input width, which is
> data width, not slot width.
> 
> For the S20_3LE format, the data with is 20bit, slot width
> is 24bit, if we set ASRMCR1n.IWD to be 24bits, the result
> is the volume is lower than expected, it likes 24bit data
> right shift 4 bits
> 
> So replace S20_3LE with S24_3LE in supported list and add S8
> format in TX supported list
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_asrc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
> index 4d3804a1ea55..584badf956d2 100644
> --- a/sound/soc/fsl/fsl_asrc.c
> +++ b/sound/soc/fsl/fsl_asrc.c
> @@ -624,7 +624,7 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
>  
>  #define FSL_ASRC_FORMATS	(SNDRV_PCM_FMTBIT_S24_LE | \
>  				 SNDRV_PCM_FMTBIT_S16_LE | \
> -				 SNDRV_PCM_FMTBIT_S20_3LE)
> +				 SNDRV_PCM_FMTBIT_S24_3LE)
>  
>  static struct snd_soc_dai_driver fsl_asrc_dai = {
>  	.probe = fsl_asrc_dai_probe,
> @@ -635,7 +635,8 @@ static struct snd_soc_dai_driver fsl_asrc_dai = {
>  		.rate_min = 5512,
>  		.rate_max = 192000,
>  		.rates = SNDRV_PCM_RATE_KNOT,
> -		.formats = FSL_ASRC_FORMATS,
> +		.formats = FSL_ASRC_FORMATS |
> +			   SNDRV_PCM_FMTBIT_S8,
>  	},
>  	.capture = {
>  		.stream_name = "ASRC-Capture",
> -- 
> 2.21.0
> 
