Return-Path: <SRS0=i/4Y=5W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878BBC2BA1A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 23:50:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE29A206F8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2020 23:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sK5Znhf+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE29A206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48x6jH0yTpzDqvY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2020 09:50:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=sK5Znhf+; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48x6g604kSzDqg8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2020 09:48:17 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id c5so823330pgi.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2020 16:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=psBSxuaBNWcdi2NVQndMbrRmw2QOSVTd4FihS4xTMPs=;
 b=sK5Znhf+DEGRMW9PNI6HsCghnazO3u7g0hr51W9/9isojiLKRVchov7ujMhuvk+wjA
 2UyAa7bidTy3ebHar7q9lCb9K5hfBqjbxwVu6RJYJNWCEYs998KAA/ccwQ5lHpvU9xK5
 n8zLnby7TbdOYK+kGmjyvzNUzF37cU2662HTXRFUFxmJY4FWhvofVewvcxT9zi1XLBit
 AoK40mxzLSXI+Pa94R3MmYxpgzvdOGOO+oPmq4oPveWUO3JlgG4EaM3ONIlVwKEfFLXC
 ol9xSkdhfYueNFiVAA+F0MijH0o4r0IPUsTuks1Ij43xYY/g8N1GEpXc2tTcDoG6U2Yp
 Ox6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=psBSxuaBNWcdi2NVQndMbrRmw2QOSVTd4FihS4xTMPs=;
 b=qa2ZzNEzZZplxVbuDvIBvLSzyX4XKK6dSkKeAvsSV/KHM2XKLciFLwBMMftNWTDmtS
 Afm3nJBzu99PaLtVLPPXboZIiAxrqPnB+UmwyLLa30vo9USGs7SdTaup055W5tzY0w/Y
 GPmefRrwdnwXK2uKqbnDR2mSBwLsflm+wSDRkxmJkZbZpt5RCnUsNifk4rkAPUj4ztb8
 mEw5VgL4KBQlXC7JIexu+3zl98naR4/CjxB1DtLKs7fJL+MVdHhVuu6VLiNsy1cdI5xg
 wdeD16CyJoORNsYq74yYH7vjOe/TzXuKjdh6CO4qBAs274eI360h38FvFekUcci0i4ez
 ozEw==
X-Gm-Message-State: AGi0PuYebajAWx4c23pC4iBoHkjec9+mJDq6LoLoHKufK8H5gGVh8lhT
 IWyWmv81VpuJBDhn2JInJwo=
X-Google-Smtp-Source: APiQypI465/ioBR3iYY/5HiEHM/tdrYAyoPeHWSHEtbZTA997lCuyYZm02hTkj/dL+M8Q+EoyZFZdA==
X-Received: by 2002:a62:7b84:: with SMTP id w126mr1923173pfc.202.1586216895626; 
 Mon, 06 Apr 2020 16:48:15 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id w27sm12479257pfq.211.2020.04.06.16.48.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 06 Apr 2020 16:48:15 -0700 (PDT)
Date: Mon, 6 Apr 2020 16:48:20 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v6 5/7] ASoC: fsl_asrc: Move common definition to
 fsl_asrc_common
Message-ID: <20200406234819.GB20945@Asurada-Nvidia.nvidia.com>
References: <cover.1585726761.git.shengjiu.wang@nxp.com>
 <93531963f028aabf9176173de3c6038a200acb89.1585726761.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93531963f028aabf9176173de3c6038a200acb89.1585726761.git.shengjiu.wang@nxp.com>
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
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 robh+dt@kernel.org, perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 01, 2020 at 04:45:38PM +0800, Shengjiu Wang wrote:

>  static int fsl_asrc_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
>  	struct fsl_asrc *asrc;
> +	struct fsl_asrc_priv *asrc_priv;

Could we move it before "struct fsl_asrc *asrc;"?

> diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h
> new file mode 100644
> index 000000000000..5c93ccdfc30a
> --- /dev/null
> +++ b/sound/soc/fsl/fsl_asrc_common.h

> +#define PAIR_CTX_NUM  0x4
> +#define PAIR_PRIVAT_SIZE 0x400

"PRIVAT_" => "PRIVATE_"

> +/**
> + * fsl_asrc_pair: ASRC common data

"fsl_asrc_pair" => "fsl_asrc"

> + */
> +struct fsl_asrc {

> diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
> index b15946e03380..5cf0468ce6e3 100644
> --- a/sound/soc/fsl/fsl_asrc_dma.c
> +++ b/sound/soc/fsl/fsl_asrc_dma.c

> @@ -311,11 +311,12 @@ static int fsl_asrc_dma_startup(struct snd_soc_component *component,
>  		return ret;
>  	}
>  
> -	pair = kzalloc(sizeof(struct fsl_asrc_pair), GFP_KERNEL);
> +	pair = kzalloc(sizeof(struct fsl_asrc_pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);

If we only use the PAIR_PRIVATE_SIZE here, maybe we can put the
define in this file too, rather than in the header file.

And could fit 80 characters:

+	pair = kzalloc(sizeof(*pair) + PAIR_PRIVAT_SIZE, GFP_KERNEL);
