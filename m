Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B33EC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 08:09:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCBF2087E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 08:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaEB4AhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCBF2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449hst3DcVzDqS2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 19:09:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="PaEB4AhE"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449hr70R2yzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 19:08:22 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id y10so11140100plp.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Mar 2019 00:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=H51ZIwlcPTZp6fBaY1Yn1eqNsCFkGAysb6nk9zVf1T8=;
 b=PaEB4AhEuXpub+hOxrwy/abXTUJLhYhfndm4XIYkB8XsikqMrO3FVZaFOmp+bBKnGM
 zrPOcn8Dq9KrlvdCwYMniih4QzirAnaxys3ctJSmGFkgMAlI9KW5M2J/HGw9ssmCH1uR
 k18mU8BY0DyYSERrCzDvHH4W2JhMMf/KQyiqrlzF3debIZTTD2TjmTbicxIFQfvvsWd9
 AzQBS7ASsDDN16jsliHQaDc7+f7+fPuKfXuuq/E8X6G/o6HDlUwYFf/jZrO4KLkmPxgK
 spEn05hTDjMqP0VKiTNelEGn7K2p/NF92V43SfT6JpjEWMYhU77Wny7xmT06Rs1/RALI
 8f7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=H51ZIwlcPTZp6fBaY1Yn1eqNsCFkGAysb6nk9zVf1T8=;
 b=cA1oOccSpmEkAGUJRG9FdQtAm/cfGwdY9vHgKRUfx7tUL7ePnG13nOupdQCJFdIyCR
 Cj9JdUVz1F8GqhC8fwtPKS26+WOiJ9IKo73aoiTCZSgOYVBjI3db3wpfbxQN7rVvepjd
 bqCVuh1vSINfdgqSCCDjjQC0FYgRG+zOt/w7yFD7CypYNJZx8PQ1ToiBA9jAeaG9L2px
 ZfvMVHh64HBOrduJmpW2SfBBmeJFAoKHhyb0ICXnLul0tgT1H+ngMffjxpEw2BVhsJhh
 RL07KgpW2tzWEpdSICuWxi4BMH5HfJR0Ea9o1uvOaPYH4DCPIRlJrz4tDnK7HcBn2rs8
 5eqw==
X-Gm-Message-State: APjAAAVtjXEI9xugqxrkz4vLZIfbSSMYK9uhLhXJsCs7qVwCjLJ8DN37
 /agiUTpfQDIMmh04NiLFE4Q=
X-Google-Smtp-Source: APXvYqzHuEDeOOB0TWV0/Srv8eyR0pu8Omzc/VU1ixRpU7356vtVYXf885e4thot3if0NKg9dPyWCQ==
X-Received: by 2002:a17:902:5ac9:: with SMTP id
 g9mr4160593plm.205.1551427699310; 
 Fri, 01 Mar 2019 00:08:19 -0800 (PST)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 l7sm56369011pfj.162.2019.03.01.00.08.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Mar 2019 00:08:19 -0800 (PST)
Date: Fri, 1 Mar 2019 00:08:12 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: add protection for the asrc of older
 version
Message-ID: <20190301080812.GA5244@Asurada>
References: <1551407560-29950-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301025356.GA1371@Asurada-Nvidia.nvidia.com>
 <VI1PR0402MB339254C31997242633511D12E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB339254C31997242633511D12E3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
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
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 01, 2019 at 06:55:25AM +0000, S.j. Wang wrote:

> > Alternatively, I feel instead of error-out at here, should we add a HW
> > constraint or at least fence it off at the beginning of the hw_params()? This
> > is actually nothing specific to the pair-request function but a hardware
> > constraint.
> 
> How about add constraint in startup?
> static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
>                                struct snd_soc_dai *dai)
> {
>        struct fsl_asrc *asrc_priv = snd_soc_dai_get_drvdata(dai);
> 
>        if (asrc_priv->channel_bits == 3) {
>                snd_pcm_hw_constraint_step(substream->runtime, 0,
>                                           SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>        }
> 
>        return 0;
> }

Yea, that looks good to me. Better to have a line of comments
to tell that "bits==3" means older version -- maybe we should
have something much more clear than using channel_bits but it
is fine for now since they only differ here.
