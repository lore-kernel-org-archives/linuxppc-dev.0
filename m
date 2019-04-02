Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD49C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:03:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761E12082C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 20:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esPxa2W/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761E12082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Yg9s5fjPzDqP7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 07:02:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="esPxa2W/"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yg853jxLzDqNS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 07:01:24 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id ck15so5603744plb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Apr 2019 13:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=BZrsfbJnGGHE7yX2nty63WcoORFbVoNY29o2ec/m3sU=;
 b=esPxa2W/ZlYPnHz2bO7xYRKyYfshtm7XsdDfe0mj/Zx1gz4y8OxFw/6gCYTwbuFgZh
 gvHJdoH2bnICkk/vN6dX1fH4ZW4rcx57pL+59Muo+wVAqvUBso2IEPMc829el4j/SAh2
 fMNm3ORYW3z1LdX0jpY9235SiUYaZoKYY9mMeaabCGDhkd/U6jYaX+Jyv84dFcbHuxTZ
 e+HHtjmbL+E/MFfcA+8qWsuY5kw+/F9RS+/1aK75nAy1EjUEH7dySzi++3BaruiJsLQO
 Y8jccx5fS92h4GjC6H5JwNkWx7UUtHtxKrGDBaiakECY6HNEOJgwmV9yCPwml72DaUNN
 TCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BZrsfbJnGGHE7yX2nty63WcoORFbVoNY29o2ec/m3sU=;
 b=ShdsWvDQ+JVHeNlsJHFqaWWL8g7S3PrU6nuEq5dukx6soxEjC9HQ2PrTVuHQqRofJP
 f49TZ52xJRBK+Q5mSd+AqC/Gwv26DBwsPLW+2sHbn5d5CwydTeDXv+fmO7EnoAP5cbSb
 ycqJ7PoTeDmtwaqgDX3sOe8LkesPDOoOoTT8dfmAdflSR80Asqp+NEL2Ggu84RgyVs86
 X5SMG1HuGkySdBZdRmLEdFXhTNNHrdlvBQO6qwkBfw8Yx2n2DP3qD7ENrOCQONaJOKXY
 YVmpsOdNhaIq4tyfpSGN+8HuaNPS024+oHv8WdWgTB6lZ6iPTjr2Pt9nrsi9L6rF0in0
 0GAA==
X-Gm-Message-State: APjAAAV52siAJDzsS3kLl/3tz6ynl2uySjlyO49QTUgytgiKnD3qFHZS
 7TBwzfEer1CSsdjdU5SMtcU=
X-Google-Smtp-Source: APXvYqwcQbY3bu2Uk9w2b6fcoX27CwYjRHl3EXIhUoo5rE8vuzIfAfGRVpOgB6TIoUi/tgtwY8Sh5w==
X-Received: by 2002:a17:902:f83:: with SMTP id
 3mr74994214plz.125.1554235281650; 
 Tue, 02 Apr 2019 13:01:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id r145sm5468687pgr.84.2019.04.02.13.01.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Apr 2019 13:01:21 -0700 (PDT)
Date: Tue, 2 Apr 2019 13:01:16 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Support synchronous mode
Message-ID: <20190402200115.GA22168@Asurada-Nvidia.nvidia.com>
References: <1554118759-2403-1-git-send-email-shengjiu.wang@nxp.com>
 <20190401181742.GA21288@Asurada-Nvidia>
 <VE1PR04MB64799B3261D1F9F63E441769E3560@VE1PR04MB6479.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VE1PR04MB64799B3261D1F9F63E441769E3560@VE1PR04MB6479.eurprd04.prod.outlook.com>
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

> > On Mon, Apr 01, 2019 at 11:39:10AM +0000, S.j. Wang wrote:
> > > In ESAI synchronous mode, the clock is generated by Tx, So we should
> > > always set registers of Tx which relate with the bit clock and frame
> > > clock generation (TCCR, TCR, ECR), even there is only Rx is working.
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  sound/soc/fsl/fsl_esai.c | 28 +++++++++++++++++++++++++++-
> > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c index
> > > 3623aa9a6f2e..d9fcddd55c02 100644
> > > --- a/sound/soc/fsl/fsl_esai.c
> > > +++ b/sound/soc/fsl/fsl_esai.c
> > > @@ -230,6 +230,21 @@ static int fsl_esai_set_dai_sysclk(struct
> > snd_soc_dai *dai, int clk_id,
> > >  		return -EINVAL;
> > >  	}
> > >
> > > +	if (esai_priv->synchronous && !tx) {
> > > +		switch (clk_id) {
> > > +		case ESAI_HCKR_FSYS:
> > > +			fsl_esai_set_dai_sysclk(dai, ESAI_HCKT_FSYS,
> > > +								freq, dir);
> > > +			break;
> > > +		case ESAI_HCKR_EXTAL:
> > > +			fsl_esai_set_dai_sysclk(dai, ESAI_HCKT_EXTAL,
> > > +								freq, dir);
> > 
> > Not sure why you call set_dai_sysclk inside set_dai_sysclk again. It feels very
> > confusing to do so, especially without a comments.
> 
> For sync mode, only RX is enabled,  the register of tx should be set, so call the
> Set_dai_sysclk again.

Yea, I understood that. But why not just replace RX with TX on the
register-writing level? Do we need to set both TCCR and RCCR? Your
change in hw_params() only sets TCCR inside fsl_esai_set_bclk(), so
we probably only need to change TCCR for recordings running in sync
mode, right?

From the commit message, it feels like that only the clock-related
fields in the TX registers need to be set. Things like calculation
and setting the direction of HCKx pin don't need to run again.

> > > @@ -537,10 +552,21 @@ static int fsl_esai_hw_params(struct
> > > snd_pcm_substream *substream,
> > >
> > >  	bclk = params_rate(params) * slot_width * esai_priv->slots;
> > >
> > > -	ret = fsl_esai_set_bclk(dai, tx, bclk);
> > > +	ret = fsl_esai_set_bclk(dai, esai_priv->synchronous ? true : tx,
> > > +bclk);
> > >  	if (ret)
> > >  		return ret;
> > >
> > > +	if (esai_priv->synchronous && !tx) {
> > > +		/* Use Normal mode to support monaural audio */
> > > +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > > +			   ESAI_xCR_xMOD_MASK,
> > params_channels(params) > 1 ?
> > > +			   ESAI_xCR_xMOD_NETWORK : 0);
> > > +
> > > +		mask = ESAI_xCR_xSWS_MASK | ESAI_xCR_PADC;
> > > +		val = ESAI_xCR_xSWS(slot_width, width) | ESAI_xCR_PADC;
> > > +		regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
> > mask, val);
> > > +	}
> > 
> > Does synchronous mode require to set both TCR and RCR? or just TCR?

> Both TCR and RCR.  RCR will be set in normal flow.

OK. Settings both xCRs makes sense. Would you please try this:

===============
@@ -537,14 +552,20 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,

        bclk = params_rate(params) * slot_width * esai_priv->slots;

-       ret = fsl_esai_set_bclk(dai, tx, bclk);
+       /* Synchronous mode uses TX clock generator */
+       ret = fsl_esai_set_bclk(dai, esai_priv->synchronous || tx, bclk);
        if (ret)
                return ret;

+       mask = ESAI_xCR_xMOD_MASK | ESAI_xCR_xSWS_MASK;
+       val = ESAI_xCR_xSWS(slot_width, width);
        /* Use Normal mode to support monaural audio */
-       regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx),
-                          ESAI_xCR_xMOD_MASK, params_channels(params) > 1 ?
-                          ESAI_xCR_xMOD_NETWORK : 0);
+       val |= params_channels(params) > 1 ? ESAI_xCR_xMOD_NETWORK : 0;
+
+       regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val);
+       /* Recording in synchronous mode needs to set TCR also */
+       if (!tx && esai_priv->synchronous)
+               regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR, mask, val);

        regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx),
                           ESAI_xFCR_xFR_MASK, ESAI_xFCR_xFR);
@@ -556,10 +577,10 @@ static int fsl_esai_hw_params(struct snd_pcm_substream *substream,

        regmap_update_bits(esai_priv->regmap, REG_ESAI_xFCR(tx), mask, val);

-       mask = ESAI_xCR_xSWS_MASK | (tx ? ESAI_xCR_PADC : 0);
-       val = ESAI_xCR_xSWS(slot_width, width) | (tx ? ESAI_xCR_PADC : 0);
-
-       regmap_update_bits(esai_priv->regmap, REG_ESAI_xCR(tx), mask, val);
+       /* Only TCR has padding bit and needs to be set for synchronous mode */
+       if (tx || esai_priv->synchronous)
+               regmap_update_bits(esai_priv->regmap, REG_ESAI_TCR,
+                                  ESAI_xCR_PADC, ESAI_xCR_PADC);

        /* Remove ESAI personal reset by configuring ESAI_PCRC and ESAI_PRRC */
        regmap_update_bits(esai_priv->regmap, REG_ESAI_PRRC,
===============

It merges those plain settings so we won't need to change both
sides if there's a modification of xCR settings in the future.
