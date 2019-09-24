Return-Path: <SRS0=kV/c=XT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1C6C432C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Sep 2019 21:56:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0864A2064A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Sep 2019 21:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0ptLuEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0864A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46dFPn5KC8zDqNx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 07:56:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0ptLuEY"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46dFKR1lPfzDqgD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2019 07:52:26 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id y5so2123455pfo.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2019 14:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=E1xMc24hYDUgJip/G3+nSaUWwisuKmB+ZHuc94zHHzk=;
 b=d0ptLuEYVEam1DP6UXz3ufvlKv0Rh2f7QGWIYd0pimxpen92m1nCjH63Y3oUmfgXdM
 e9vRofKj6tTXOAtvr+g2/9a4OV7tQDiVwVV3Kh3Sve7pqmIzmgRUghHnaZynH67SHnHW
 rIgf7ruRl3rhqnhyBHw02V8XZZKblWPDyB8D3/iet4MIZpE4iw5EZtcTjUztACEmkZLL
 1qjjugP3Ww2u7zIQkdavyfSi2BMnClZMrdlHfrmnhP4EwsJZcIS9b6CNLzqrxxbn7x7b
 fO0hIcWTRFU/XT3rix7PftJL6Pji5+QETeii4ZwTtvNk/+xxeGBV169AGXUu6Hlki8Xd
 onNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=E1xMc24hYDUgJip/G3+nSaUWwisuKmB+ZHuc94zHHzk=;
 b=uCZDsHREU7BfKyP40qqOhwlXjsH2d6y/4vqaSyW4atG8uYUlWJ4ZyAFmhVqEYco9sq
 4BlmxEqjdxDBznqd55NE+pi2Cueje4u0eoiNvNSFqJpR1bAeAGqBlfsbml8iXAAXP0/h
 tD5p0Y2QDNZ1KUMy3Eje9uhPAGTK/pVL2tAyhnQ3P0OEgAUxNmavIhNJMRotHJt3AKCX
 T0ko7TX4CMDf2GxZnqkKi59EMQNsgiXQH0byCns9a3bSwjyVGnrE9eqt2DzWirBdNEG6
 ZehXRtFySiVwoleIbg4dPXAU7/ebyg3GvUlUl1BqI142epoZf/w9UV0y9jKs0CxDSzMq
 XpOA==
X-Gm-Message-State: APjAAAXpESUz2pjWu96N0FnRK5bNtTKiYRDs0O7krUlE7nE4snIyh+yx
 r0gP3hLrt2QtmEJ7Sk6oWkI=
X-Google-Smtp-Source: APXvYqxe9O60bRaCPe/n2UFtUr8or3Vyc6C0TkkVo5BRee9PILbNcSSLNYNYmW98WrHaMtrjV5ZrRw==
X-Received: by 2002:a63:20d:: with SMTP id 13mr5329837pgc.253.1569361943377;
 Tue, 24 Sep 2019 14:52:23 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id h2sm6197465pfq.108.2019.09.24.14.52.22
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 24 Sep 2019 14:52:23 -0700 (PDT)
Date: Tue, 24 Sep 2019 14:51:35 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V4 3/4] ASoC: pcm_dmaengine: Extract
 snd_dmaengine_pcm_refine_runtime_hwparams
Message-ID: <20190924215135.GA2277@Asurada-Nvidia.nvidia.com>
References: <cover.1569296075.git.shengjiu.wang@nxp.com>
 <4d9aab898650c68ea57c10067830dac884eb7439.1569296075.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d9aab898650c68ea57c10067830dac884eb7439.1569296075.git.shengjiu.wang@nxp.com>
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

On Tue, Sep 24, 2019 at 06:52:34PM +0800, Shengjiu Wang wrote:
> When set the runtime hardware parameters, we may need to query
> the capability of DMA to complete the parameters.
> 
> This patch is to Extract this operation from
> dmaengine_pcm_set_runtime_hwparams function to a separate function
> snd_dmaengine_pcm_refine_runtime_hwparams, that other components
> which need this feature can call this function.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Looks good to me.

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
