Return-Path: <SRS0=X5Ay=AE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAD8C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 05:36:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CF8420723
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 05:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkvvS8tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CF8420723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49rZl046mDzDqQ1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Jun 2020 15:36:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=kkvvS8tA; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49rZjD2chczDqBg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2020 15:34:38 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id a127so9539056pfa.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2020 22:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=yw0cFZLgC9JersHygrJb/SoVH5zyPcZOPd+eIbg7N9A=;
 b=kkvvS8tA2dHGIqkqWVaFEbyD/nNUcyhtytbI92XDvjh1EWLg63eW6ZygliZfyJf6XN
 VgkjmEX+uV7WJ0k5QMy8yMfCbspbNu8riS8kQ5Ozfe0EQ32v+MWp8p06G4tQJHIv9NSN
 enVw/l57/iL1HzpcDMpHWv7y0lFBxEnLAa+lCssxe6ugKpeuvr1rkcDOdKXjBi1TSN3f
 TvrekhC9W8CrfG/LOWuypaNCmK+7SKcYrFhLaLW4rg8zH5RMQAFXySUCUWBUh9K2/ufF
 TO7OV4XuoX45rNFxXjbK+8qfmERsz3A/rJ/sZFxe3VL0NzBNifco3K9BpPz/a5Gz6beM
 di8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=yw0cFZLgC9JersHygrJb/SoVH5zyPcZOPd+eIbg7N9A=;
 b=X2imSkrzB5cOLNSY3u9i+GtobCEaM9Ob5bB2KlwZEr7PssgnhsRJBIKfkZ7FT7qqQY
 Owo+4GMlJTBdjWcvHH2EZKuW23rmTjSukUss9xaRkhnQcAUm6kLVhGrbkv22VcY+sp+I
 g8Um/N08iUu3HWeY54yNYL4TPdjOlMO+n6025A2S/KQ/Lm2lzJVZJkJxdzu2MgCpknH5
 SpZsKuoQDNT89Zhk0454jNUaUIF+raDx/Tqv1LGwhnuZhJwPDqQVTS8dgHiWQ16YsJXy
 L6/hZQ8vUEbm+YsZlMiF7TslQ1dyBo5VW3IWbN5+KdtE/rl6gz7v7HglVDsD7/QEPuRg
 yT0w==
X-Gm-Message-State: AOAM5314MkudLBB9UmObOOKs5gEZzTh+0u4fy/jCPHS9/x2aJIi6Mi5T
 Wd9xKIJoikZMaSV/nMLWSlA=
X-Google-Smtp-Source: ABdhPJw1nFeLEWTr0Aixs6TirejroBAE2/O59QCNX1jBOTew5i1D81DQ/Sy2Lv436Bu4/2+08CPyhA==
X-Received: by 2002:a62:ea0b:: with SMTP id t11mr10457134pfh.276.1592890474504; 
 Mon, 22 Jun 2020 22:34:34 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id i125sm12458923pgd.21.2020.06.22.22.34.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Jun 2020 22:34:34 -0700 (PDT)
Date: Mon, 22 Jun 2020 22:34:08 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_easrc: Fix uninitialized scalar variable in
 fsl_easrc_set_ctx_format
Message-ID: <20200623053405.GA9039@Asurada-Nvidia>
References: <1592816611-16297-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592816611-16297-1-git-send-email-shengjiu.wang@nxp.com>
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

On Mon, Jun 22, 2020 at 05:03:31PM +0800, Shengjiu Wang wrote:
> The "ret" in fsl_easrc_set_ctx_format is not initialized, then
> the unknown value maybe returned by this function.
> 
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
