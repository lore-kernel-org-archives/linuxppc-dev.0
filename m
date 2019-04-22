Return-Path: <SRS0=+Gyc=SY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609AFC10F11
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 18:17:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBFFD214AE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 18:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtUVNGWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBFFD214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nvtl06RMzDqLx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Apr 2019 04:17:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="XtUVNGWB"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nvs20wVpzDqJj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2019 04:15:49 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id k19so6226337pgh.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=rCa/9yPbubYEgQtxdxweEsDxXAxrOMXLbp7pFOiMKJQ=;
 b=XtUVNGWBjgKORtdbQmjprX3pnJLCAy6L+jDj4Q6qttCPmE+YEgCWN9jVtM1OW/r3yD
 1oDNw39CZ/BqWeq9V29jHHJURCk9kAc1LYLZulgJwaJefyyGQbHfmCl5ZVUmg8/6VLFU
 B7YcbsaexSui+nD+5mQupDJEKB6w3htTcyjCgBZrpILiv4HWNjfo106VZVHUfZTbi06F
 x6huHRpMijaPkZeIsu5nfAsKJS9Yi2ajJlMc6f0NfW3R8XKTesLp2JkSRCkLR9BWMLPH
 hUoGjcl1Cc15XfXCd9Rju0d9cwbgMGFf1QU9bp+z8jsel9eAr1r4937Ii4baV8t5XreV
 5OPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=rCa/9yPbubYEgQtxdxweEsDxXAxrOMXLbp7pFOiMKJQ=;
 b=tN99KU6OXA9sKKI6FVqsA9rI3OErZh0uZzoThC+fsFidv1wKQHQ6PnL/crzpYdxLZJ
 7s/npUsrdCKAbJTraPyy6apb07tnblcteBSDPPdZH05k6K5GAuxA7RcDSh2QKiw3bL8R
 mlFACelmvKJdE5iQBK7T4todOJ8ZRAfTZ4zZBejkaSeguqj9j98MYzXZr19Z0Q7CPjVx
 J8LHbN5PHhoAkgYBLC47zLaWeo7MXxF2yKbRPGGfoVRoJ/dnitdUx21MPrNOuF3c/7l7
 fZ/RpJYtE7q2LJkDGPDFoEEWJ2Tina19NFKgofHfEh8I2tIYmyIvbHM8ieKCr0CgkGXr
 ptNg==
X-Gm-Message-State: APjAAAUrqRWsALS72OSGgi2t/JBonlc1YvxqfWoL/e5ZJEWy5d9vhh8D
 fJIx34IK/K5QijDb+Ge/ACE=
X-Google-Smtp-Source: APXvYqy4i1a9gd2vMvwuBw/wREp8ceq+ck+H5HAXZwW37YzcNaQFJ5Fawooa4zZHDJ/6zPF+oWWWJg==
X-Received: by 2002:a65:6105:: with SMTP id z5mr20426581pgu.378.1555956945915; 
 Mon, 22 Apr 2019 11:15:45 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id u5sm19690143pfm.121.2019.04.22.11.15.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 22 Apr 2019 11:15:45 -0700 (PDT)
Date: Mon, 22 Apr 2019 11:15:40 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: Move clock operation to PM runtime
Message-ID: <20190422181539.GA30867@Asurada-Nvidia.nvidia.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
 <20190420155846.10027-3-daniel.baluta@nxp.com>
 <20190421055406.GC683@Asurada-Nvidia.nvidia.com>
 <1555930942.31656.4.camel@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1555930942.31656.4.camel@nxp.com>
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
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>, "broonie@kernel.org" <broonie@kernel.org>,
 dl-linux-imx <linux-imx@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "perex@perex.cz" <perex@perex.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Apr 22, 2019 at 11:02:22AM +0000, Viorel Suman wrote:
> Hi Nicolin,
> 
> On Sb, 2019-04-20 at 22:54 -0700, Nicolin Chen wrote:
> > On Sat, Apr 20, 2019 at 03:59:05PM +0000, Daniel Baluta wrote:
> > > 
> > > Turn off/on clocks when device enters suspend/resume. This
> > > helps saving power.
> > > 
> > > @@ -934,6 +933,25 @@ static int fsl_sai_runtime_suspend(struct device *dev)
> > >  static int fsl_sai_runtime_resume(struct device *dev)
> > >  {
> > >  	struct fsl_sai *sai = dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	ret = clk_prepare_enable(sai->bus_clk);
> > > +	if (ret) {
> > > +		dev_err(dev, "failed to enable bus clock: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK)) {
> > > +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[1]]);
> > > +		if (ret)
> > > +			goto disable_bus_clk;
> > > +	}
> > > +
> > > +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE)) {
> > > +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[0]]);
> > > +		if (ret)
> > > +			goto disable_tx_clk;
> > > +	}
> > The driver only enables mclk_clks for I2S master mode. But this
> > change enables them for I2S slave mode also. It doesn't sound a
> > right thing to me since we are supposed to save power?
> 
> This change does not enable them for I2S slave mode, please check "fsl_sai_hw_params"
> and "fsl_sai_hw_free" functions: the field "sai->mclk_streams" is modified only for
> the case when "if (!sai->is_slave_mode)";

Thanks for the input. This should be fine then.

Nicolin
