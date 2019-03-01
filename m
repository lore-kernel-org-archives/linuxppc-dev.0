Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93CDC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 18:29:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3230420857
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 18:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQ2UJX4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3230420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449yck0rc6zDqV7
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 05:29:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="vQ2UJX4J"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449yZz2rVyzDqTR
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 05:27:53 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id j3so11792407pgm.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Mar 2019 10:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=MaAeRcZq3uOp8KcFqNkFHxl6pI7pzK8ddtzv2fAb55s=;
 b=vQ2UJX4Jt7yj11ptw2lh7/47U7J4CfXXo+SAExdlMnUTZRNNxA5h1rgNBqUmvEceKP
 F8Bzk4Abmq2pDMR4cnxTuSfak62qb66W2eDi9ju2Lw0St3nAmo/sBS0yqiz5T3s22vUB
 x4zOyHY3wzRcZ07/BMVVROXjOhmqudqjVDvL2zbitT97ZkLAVCl92QR4xABCWmfTB8Oi
 U1GtTWx6NKLyFHR8+9XihHFU8r6cbpcDSs5ZR9mRwmAy8Hx1I4REkSmzkb7W5Fi59JU6
 34AcDfmIUe8yp0TZ7XfvK1gAdzzSkPqnc/cozaIL3XDWUkoKeork3MVjV1tEph5mEmV2
 5A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=MaAeRcZq3uOp8KcFqNkFHxl6pI7pzK8ddtzv2fAb55s=;
 b=MJ7gbzfKlPx4cssTnR852/JpbgcAG1wcASfg2vvQqF9qdnqklkiC1xd5hE4USxN+nK
 nejZ1OormC9juZPFE7kOwaz8jPta3H3tzqyrQuBy9QUZ7m2053gZxFHeVsp7cEBfurT7
 IS4gJiSNfI4Y4Thj+4UKvcxT1bx5ej/e1cscgAUwYX/6wbM9H/cstBMTurpu5owSiKJf
 58bHHhySs9QLmGaS/coa0e86lVojbuPLbz6D3VJQBXoRLhbVcyIneLRUOoQ+VTT+6eZ7
 LejmH4eP7VlPsymYLfiwwIoNjhKG86OySvp9B47knYPYm2lNEiRxDvtClKY/xuzQOheX
 GVSA==
X-Gm-Message-State: AHQUAuZD3xS7ZC9JVBblY5GiGIkxUVR3EBHI1RqMGAnRXLcv3aIp6edD
 W6haktRagAoo4PJ9yuAQUZ8=
X-Google-Smtp-Source: APXvYqxCcQJrNJeXn8Qd/XXS5dvOEM/h7F2+TU9ocEuhRCqoWd5xtG+UHVVbwE56JLa0Yg18v3oZow==
X-Received: by 2002:a62:a113:: with SMTP id b19mr6822181pff.227.1551464869794; 
 Fri, 01 Mar 2019 10:27:49 -0800 (PST)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id e131sm15067181pfc.62.2019.03.01.10.27.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 Mar 2019 10:27:49 -0800 (PST)
Date: Fri, 1 Mar 2019 10:27:44 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH V2] ASoC: fsl_asrc: add constraint for the asrc of older
 version
Message-ID: <20190301182743.GA6305@Asurada-Nvidia.nvidia.com>
References: <24ebf5b610cc69f18c05e4aefa1874ae23861943.1551429264.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24ebf5b610cc69f18c05e4aefa1874ae23861943.1551429264.git.shengjiu.wang@nxp.com>
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

On Fri, Mar 01, 2019 at 08:37:08AM +0000, S.j. Wang wrote:
> There is constraint for the channel number setting on the

nit: "a constraint"

> asrc of older version (e.g. imx35), the channel number should
> be even, odd number isn't valid.

> +static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
> +				struct snd_soc_dai *dai)
> +{
> +	struct fsl_asrc *asrc_priv = snd_soc_dai_get_drvdata(dai);
> +
> +	/* channel_bits = 3 means older version on imx35*/

Space between '5' and '*'. And better to make it clear:

	/* Odd channel number is not valid for older ASRC (channel_bits==3) */

> +	if (asrc_priv->channel_bits == 3)
> +		snd_pcm_hw_constraint_step(substream->runtime, 0,
> +					   SNDRV_PCM_HW_PARAM_CHANNELS, 2);

For your next version,

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Cheers
