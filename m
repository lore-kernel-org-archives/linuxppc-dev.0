Return-Path: <SRS0=7wTx=7R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEB6C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 00:07:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CCF42067B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 00:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NASVovjh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CCF42067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49cmLp1z1HzDqjJ
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2020 10:07:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=NASVovjh; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49cmJl6G7HzDqSv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2020 10:05:59 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id 64so2519116pfg.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2020 17:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=uF2n/gB3gDDP2hMwoQuaaueDJkaKtOoysRJtoTkMSDw=;
 b=NASVovjhwK7+HIO80yPXssp+od2Hj2d9eiKlapTw++P1bMpxgSBWmZWUJ0Js8p1fiB
 COH3UNC0JBHTjqVioC60wuQYj1RX8kglcJJOKWvyGdoUdYxhDo7lgrJJsnWmmwEOOnls
 GcWCSPxRy9zAbMJ7nMRszUCbpYU4qAb/KhOH8/Np8lUaDK8+qUddDyBu0T7i9cK2Q/z0
 IDedlFEsLhmXp3TpSpDuCorOYb8vG5doQsgNwk0P5CfjW5HuC7i51dX2b/EN0xJTER0u
 zGGYodiltvH/TmC9ebxBfVpybt4NFF6aebkphUU9nfM6Eqs+npjtS7j88HNdrymau7A8
 fObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=uF2n/gB3gDDP2hMwoQuaaueDJkaKtOoysRJtoTkMSDw=;
 b=AE03eV1xvGDyaSRjLpIQdbpoHFBuXroR56rz/RSJqq+252KLTddv9SQlp8Mvj21BUQ
 HYqMOVgoPVz9aElPOeuWy1mj1pR1InhAOnQ8OhtbnldKl1uyhbW6KH6s9LoZMW7+G1zT
 8vaNzUmRny0KFRJllt1yFBSA6Zl/0f+oh8Se8aFw4inoAZVyjM5FfYVcjJnWDPFkUeD/
 7EMLnnT57sXlbeUZna4tpob7Q0N6c65yOfRiUlCiOm5+SgOLPxPhLpDrkYkO/lEET2Li
 wv7mdGaiFHNbUcrWBR82Dx29InmY4mRqwj/b+d+LaA9pbV6bcbfFIxMo4EMTanGsXT1z
 gPfg==
X-Gm-Message-State: AOAM533ZEtmIoaB4+QY+tnIYgetlXRMCMQAr8NeKBQ/nR2gXMIwjp3gf
 vJ0WCvT0iL6yqbzHzmRyWZM=
X-Google-Smtp-Source: ABdhPJz9ZYK9jizQG8WXYX8Y04FQk4jgCjJhaM7jL6RxuPb2xp3UDdovwx057LKm/fMposyBvBJGzg==
X-Received: by 2002:a05:6a00:ce:: with SMTP id
 e14mr1523090pfj.44.1591229157170; 
 Wed, 03 Jun 2020 17:05:57 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id f11sm2767786pfa.32.2020.06.03.17.05.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 Jun 2020 17:05:56 -0700 (PDT)
Date: Wed, 3 Jun 2020 17:05:52 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 1/3] ASoC: fsl_easrc: Fix -Wmissing-prototypes warning
Message-ID: <20200604000551.GA17364@Asurada-Nvidia>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
 <ab1b83a56c71f4159a98e6da5602c2c36fe59f4d.1591155860.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1b83a56c71f4159a98e6da5602c2c36fe59f4d.1591155860.git.shengjiu.wang@nxp.com>
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

On Wed, Jun 03, 2020 at 11:39:39AM +0800, Shengjiu Wang wrote:
> Obtained with:
> $ make W=1
> 
> sound/soc/fsl/fsl_easrc.c:967:5: warning: no previous prototype for function 'fsl_easrc_config_context' [-Wmissing-prototypes]
> int fsl_easrc_config_context(struct fsl_asrc *easrc, unsigned int ctx_id)
>     ^
> sound/soc/fsl/fsl_easrc.c:967:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_config_context(struct fsl_asrc *easrc, unsigned int ctx_id)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1128:5: warning: no previous prototype for function 'fsl_easrc_set_ctx_format' [-Wmissing-prototypes]
> int fsl_easrc_set_ctx_format(struct fsl_asrc_pair *ctx,
>     ^
> sound/soc/fsl/fsl_easrc.c:1128:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_set_ctx_format(struct fsl_asrc_pair *ctx,
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1201:5: warning: no previous prototype for function 'fsl_easrc_set_ctx_organziation' [-Wmissing-prototypes]
> int fsl_easrc_set_ctx_organziation(struct fsl_asrc_pair *ctx)
>     ^
> sound/soc/fsl/fsl_easrc.c:1201:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_set_ctx_organziation(struct fsl_asrc_pair *ctx)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1245:5: warning: no previous prototype for function 'fsl_easrc_request_context' [-Wmissing-prototypes]
> int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
>     ^
> sound/soc/fsl/fsl_easrc.c:1245:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1290:6: warning: no previous prototype for function 'fsl_easrc_release_context' [-Wmissing-prototypes]
> void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
>      ^
> sound/soc/fsl/fsl_easrc.c:1290:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1317:5: warning: no previous prototype for function 'fsl_easrc_start_context' [-Wmissing-prototypes]
> int fsl_easrc_start_context(struct fsl_asrc_pair *ctx)
>     ^
> sound/soc/fsl/fsl_easrc.c:1317:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_start_context(struct fsl_asrc_pair *ctx)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1335:5: warning: no previous prototype for function 'fsl_easrc_stop_context' [-Wmissing-prototypes]
> int fsl_easrc_stop_context(struct fsl_asrc_pair *ctx)
>     ^
> sound/soc/fsl/fsl_easrc.c:1335:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_stop_context(struct fsl_asrc_pair *ctx)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1382:18: warning: no previous prototype for function 'fsl_easrc_get_dma_channel' [-Wmissing-prototypes]
> struct dma_chan *fsl_easrc_get_dma_channel(struct fsl_asrc_pair *ctx,
>                  ^
> sound/soc/fsl/fsl_easrc.c:1382:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> struct dma_chan *fsl_easrc_get_dma_channel(struct fsl_asrc_pair *ctx,
> ^
> static
> 
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
