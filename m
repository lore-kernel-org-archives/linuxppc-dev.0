Return-Path: <SRS0=LYYN=BU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF18AC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 08:39:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43ABB2065C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 08:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pLBGxBmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43ABB2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQ8X42k7lzDqRk
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 18:39:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1044;
 helo=mail-pj1-x1044.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=pLBGxBmA; dkim-atps=neutral
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQ8VD2V4mzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2020 18:37:37 +1000 (AEST)
Received: by mail-pj1-x1044.google.com with SMTP id kr4so4424319pjb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2020 01:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Scg7QrQFHhZ2Uk5vL9dJtfSBTf93pMWkHX0hTYM3Wac=;
 b=pLBGxBmA28+kasChedisfkm5yQ00pLLat8cogyaXTpLiExGsBIVYBEBCu2hz/OBRjq
 JEnJ8UbRvkBLpVgWe9F5OiPBNu9NN1vD5FcFk390ldPJaV9NbI3L8f1/o6dj2SD8uDG8
 X8HCnYYdZ3mdBTreaxYiqxn/AEPh962sa6zkhkddCa28cl6ei0EUjktXDaKZ9mZmleMu
 nqxvzdp70e+sqykKT3MdZqiju2Xs3elZPFUcEiKx0QWPDUgZjzniVgfUlThWTWdT/teq
 vMOIcg2BEPu5qgUkPzOaHU7y3Q68EobH75g7jKMfAkHKVMdl3PONxv3/GLP39z2Lr56w
 5CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Scg7QrQFHhZ2Uk5vL9dJtfSBTf93pMWkHX0hTYM3Wac=;
 b=QgywLa67xRprIpZe8RvtsX7J3ZSmOP9BxY/6fqlSxI5vk4MteTMezbSvoiukqznz09
 ZKKCsRMilw5n6+lY1OhIxMDdWdg7AiFEj/oY0MiPhbpA3kcRzrGUtgwZiU4xrcNctR6v
 Gw50kwFr9Au9oOA4pgACLHbdsp/JlTjxazpElFGRYPtloXM8Uz1Hr/wHlfdfslH0M4Ee
 UpSBm8DSRlFRb69f52kHi8n6p5EAtep4gBuSh7cOFgQLARCq1nP0NsRKqtklVoHZYHlH
 pUYwCSt9zupKUAn4M6pEaz5Fsbr7edXyz7DbJd8dLijNv1+1BcYfHAgzSQUaYCny7lnT
 MZ6w==
X-Gm-Message-State: AOAM533yywg8ntOaux9ta9SQB+1LLguuqunu09edMjVnjtEjTjtSBE4D
 3ZvQXrkztys0lDo7mBxFxI4=
X-Google-Smtp-Source: ABdhPJzjuMOIL1DAbcFHuOnCIOgipzZg0qAzo4rznqU2sir2vCh9nY2ksofTJnj2XfUNc1XE1vk4bw==
X-Received: by 2002:a17:90a:b386:: with SMTP id
 e6mr26337780pjr.57.1597048654505; 
 Mon, 10 Aug 2020 01:37:34 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id 13sm22135713pfp.3.2020.08.10.01.37.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Aug 2020 01:37:34 -0700 (PDT)
Date: Mon, 10 Aug 2020 01:37:29 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Get "extal" clock rate by
 clk_get_rate
Message-ID: <20200810083728.GA7560@Asurada-Nvidia>
References: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 10, 2020 at 04:11:43PM +0800, Shengjiu Wang wrote:
> On some platform(.e.g. i.MX8QM MEK), the "extal" clock is different
> with the mclk of codec, then the clock rate is also different.
> So it is better to get clock rate of "extal" rate by clk_get_rate,
> don't reuse the clock rate of mclk.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2
> - add defer probe handler
> 
>  sound/soc/fsl/fsl-asoc-card.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index 52adedc03245..32f8f756e6bb 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -696,6 +696,17 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  			goto asrc_fail;
>  		}
>  	} else if (of_node_name_eq(cpu_np, "esai")) {
> +		struct clk *esai_clk = clk_get(&cpu_pdev->dev, "extal");
> +
> +		if (!IS_ERR(esai_clk)) {
> +			priv->cpu_priv.sysclk_freq[TX] = clk_get_rate(esai_clk);
> +			priv->cpu_priv.sysclk_freq[RX] = clk_get_rate(esai_clk);

Will it break existing imx-audio-cs42888 on older i.MX platforms?
'cause it overwrites cpu_priv.sysclk_freq[] that are set in "card
configurations" section.
