Return-Path: <SRS0=7wTx=7R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA86C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 00:11:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D58F2067B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 00:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCh1Bvui"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D58F2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cmR16VxbzDqc2
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 10:11:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=XCh1Bvui; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cmM35HqtzDqjg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2020 10:07:59 +1000 (AEST)
Received: by mail-pj1-x1041.google.com with SMTP id k2so289692pjs.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2020 17:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=37s08ZuqFcndX7aAAI+JFevMdaZ0bnJEocIhn4/lh78=;
 b=XCh1BvuiQnQ9Zm1oZ2yD4vKaikfXRb54M1szSL15zdmA4Wu3zIleoiijey1ihZJYmu
 yH73ihq2hNe4EPGty0ElAgH+2jO8uB3PwYRbUhMIb4DwZaakWiQkO4TsYbjZ5ZfQwLla
 Dqk8QEEEN5t2OKagg3lhOVoFlGROQAl6R4HBIvKnIpKE18gJTBbEaBog8i2qLQqPs1dN
 gxCOB8YGuOkwR1p5JZYt2ci26kspsM5+IdV/AzGK/7iHdc/Le+ZHHkfGXsx0vT868TpG
 GNtNEkGq5vrpV81Zk9flKNsy1k2xnXdO4yq9GaGhqZJdAhQZsPom222FE/RMcP8kfewk
 hkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=37s08ZuqFcndX7aAAI+JFevMdaZ0bnJEocIhn4/lh78=;
 b=c/MafLVWDxfitXUx02piFD6o4yDusTiW5/sM8ZFRo4KhtQt2LyG5CRib/SSErjsxZH
 2RhsZSMDesmT4C4Ub4mZ0U6A1Abl7BBmXGT7zYOQZw8hCrK4yv432LpjqvqE4llNWrvl
 WqARxZL0mKgYSaxpeaM6PvSAU2HGifRuYRTLYZe8H1jrEm7f94CZ4gKFwT8/6WQTdkks
 //4WUBOniNOCdh1hPnA2f51cV4x4Iu3l6o+Wi6GQvj/h6gFryrrr4TvfzM7xhX6SMIdk
 ZkmEduHFhwsXMfz/N9+xxv/eW6FFANlCWDEHS6wmlc2wi3qJaXJTXtNaKkF64fCJOQZT
 J8Cw==
X-Gm-Message-State: AOAM532YJ2LWmEUik5kYhPuqwLnQeGgeVUQBoPEC8GyeGymOi6Qs1f9W
 8SyInysGjVd7HtbeOqIwdg8=
X-Google-Smtp-Source: ABdhPJyx19haOwN64kw7j8RFpa8HEmcAYpFxgEWl1NTCvbX0UCfPaYbv4AlWn6qfCVsMTOK0HzJ54Q==
X-Received: by 2002:a17:90a:a107:: with SMTP id
 s7mr2777391pjp.199.1591229277291; 
 Wed, 03 Jun 2020 17:07:57 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id b14sm2549035pgb.32.2020.06.03.17.07.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 Jun 2020 17:07:56 -0700 (PDT)
Date: Wed, 3 Jun 2020 17:07:54 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_easrc: Fix "Function parameter not
 described" warnings
Message-ID: <20200604000753.GC17364@Asurada-Nvidia>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
 <d166b868e6d294de47a89857be03758ec82a0a61.1591155860.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d166b868e6d294de47a89857be03758ec82a0a61.1591155860.git.shengjiu.wang@nxp.com>
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

On Wed, Jun 03, 2020 at 11:39:41AM +0800, Shengjiu Wang wrote:
> Obtained with:
> $ make W=1
> 
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'easrc' not described in 'fsl_easrc_normalize_filter'
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'infilter' not described in 'fsl_easrc_normalize_filter'
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'outfilter' not described in 'fsl_easrc_normalize_filter'
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'shift' not described in 'fsl_easrc_normalize_filter'
> 
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
