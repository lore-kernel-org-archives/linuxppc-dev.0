Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4845FC10F00
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 02:34:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE3721848
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 02:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlhS7dt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE3721848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447jZQ1tSczDqL9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 13:34:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="YlhS7dt+"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447jXj3FySzDqJS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 13:33:09 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id y5so5443630plk.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 18:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=wK90E4VYVucljaGrXvbfs/RZ2oprYElYReoQx3vVC78=;
 b=YlhS7dt+0gK8RPccPBM7+HNFkCR1Cck4S9P9/3ZSkyu08TIKJEPTHQjpr9YqofwEGO
 Bs8+2D8AlEiutsrdNZx6wrcgd2OPJ7fDXxo2bt0X1bQsKmQBC0KvoY1TW1f0ivYc9Osj
 IlZWvxAyL+svDIHqHiGfvwJHzNunAp30mhsluyenhxMwRX0IjCIv0NSfewJJPRIsLOAI
 Hu+AA/4uVHGic4XoRfo9kpMF1nq7D9eW5gJVSK1UwEZXy0s0RIr1sEsAyw58FN4231Jv
 /yNofqYTrlHJKlMWwrdEPfP5qlRuCWdOym8D2WV+Y2Qhtu1sRdapag/mSVZmOJUgbDB3
 /DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=wK90E4VYVucljaGrXvbfs/RZ2oprYElYReoQx3vVC78=;
 b=o0lrsBbpxS/gYQjuicvl37asWoU8Js1+DQ+gKq5w54NhnK71AWA8DU7k0XEcn+WFOA
 5lDDlQbPFG84uWS1Vabv/J4dING0HqTM1r8oGxdvHPwYBSqOUzgV6F46gOKgq/GfTC5z
 Coo1idzNW0Ip3qwYa03QvTPxps9hvNQUIezWLaAOWOu6+81Zaj6grCJDkIdIioTD7t9X
 S4sxh1Mx3WjN/5NuQ6tYaCKwkwMeedY1izaxcO4ZR1dggax1TeWi6uyI7LPoP7vPl6vJ
 cHyOQfzvjVuAkJ/dMrLZEJLbuJSbvM7jp8LRyGR987wiAzxruzJHZZ8C3HNaND5kHtCo
 HE+g==
X-Gm-Message-State: AHQUAuYAHu9FjNikFVZsgLTkzkMaU0uvEi/vnwN9c+O8TiN4AFpJlS2Q
 O+UnfeKAgDPkdByYT7UUJN4=
X-Google-Smtp-Source: AHgI3Ibe+te1aJVI+eUKwWl6Nxxego5m7G6ZBe4XLAgMCLWObB0OKr9B18uFq1dOTHaZRRACiSmagA==
X-Received: by 2002:a17:902:4545:: with SMTP id
 m63mr23174095pld.71.1551148385417; 
 Mon, 25 Feb 2019 18:33:05 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id e63sm31014429pfc.47.2019.02.25.18.33.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 18:33:04 -0800 (PST)
Date: Mon, 25 Feb 2019 18:33:00 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2] ASoC: fsl_esai: fix channel swap issue when stream
 starts
Message-ID: <20190226023259.GA18857@Asurada-Nvidia.nvidia.com>
References: <e31c31acb3c62d16e6b32682e8226c7dbc05f147.1551062751.git.shengjiu.wang@nxp.com>
 <20190225211440.GA20734@Asurada-Nvidia.nvidia.com>
 <VI1PR0402MB3392A0477A1C8CE66C47960EE37B0@VI1PR0402MB3392.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB3392A0477A1C8CE66C47960EE37B0@VI1PR0402MB3392.eurprd04.prod.outlook.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 26, 2019 at 02:01:14AM +0000, S.j. Wang wrote:
> > > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> > > afe67c865330..23bd0ad4ac31 100644
> > > --- a/sound/soc/fsl/fsl_esai.c
> > > +++ b/sound/soc/fsl/fsl_esai.c
> > > @@ -54,6 +54,8 @@ struct fsl_esai {
> > >  	u32 fifo_depth;
> > >  	u32 slot_width;
> > >  	u32 slots;
> > > +	u32 tx_mask;
> > > +	u32 rx_mask;

> > >  	esai_priv->slot_width = slot_width;
> > >  	esai_priv->slots = slots;
> > > +	esai_priv->tx_mask    = tx_mask;
> > > +	esai_priv->rx_mask    = rx_mask;
> > 
> > The two masks only got values here. If a machine driver doesn't have a
> > set_dai_tdm_slot() call, they will be remained as 0 and then will seemly
> > clean those four registers.
> > 
> Then I think we need to add default value for tx_mask and rx_mask, that is
> In the probe function to add:
> esai_priv->tx_mask    =  0xFFFFFFFF;
> esai_priv->rx_mask    =  0xFFFFFFFF;

Yea:) Please include them in v3.
