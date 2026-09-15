Return-Path: <linuxppc-dev+bounces-27429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6DFC88E75
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 14:22:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkkjj4v09z2y2f;
	Wed, 16 Sep 2026 00:22:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789481775;
	cv=none; b=ldY/Do7BBlgEvEefMeMaYTNIb3OMx1qTj1NWPdCI7HUzA5Y1dOfZCB+AKgI9YZTG9km8IVderzgpq0zruMt81pdOL5mpJNWnczXS332eD1MZv/CAdAlTgIITVO9WhfAEo+Sy+OCh2RDNfydK9nNtAzQVLdWRvjLSyFuyiLwjzT8E6hHL+S88KNvZYbjo3cCoymUQK47wA9XoiMDZd+HOEDWd68KgRHI7r995XuIgRyCyAnWeQ8BSvfN2a9Mlb8vQLSIW+ocl5wtgoCLQx8NwfGXtGaWi3wb9x1XFkgE9ln3GlN6p0q8XoaMw9WDoMdhkg03hHRdgsK+RJUKx73UPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789481775; c=relaxed/relaxed;
	bh=c6nXn9QszvDuxbC4bOSKyL0/hzlZ75yA+JSfjiylQcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBlaU1JYfslTKNTp95qQX+njqOUFK3NNfohamhZJYdSGXADYrSB99VRp0+Yw+z9NoF1j+rlqKga8j51P4FaOTh7Q3hrwadxd8hdcFvncL0Lvh5mBagf77wkLNXhBMS3ZSCJuCueoiVpeVQn+/MTdRNhTBD7hEUEKuBM9//Np2smiLWpAoRswX1TSbu2zry0at5rtKrw0bSA/jNjgzjgHhRAXe8gLKTTHeUqQ3TRc/d7kJujqfFrb8njvCRsxDQXmbp/NTABhr2ilccCipPq0cMWeAWehONlpGKFNWkRhkN+51LiBMLvqhHyCeuZgqs7gqTdaeqxB1HleAjBTVTyiew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dfhdu4JU; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=dpenkler@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Dfhdu4JU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=dpenkler@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkkb16Dq5z2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 00:16:12 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49d1ca5b0d6so2667045e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2026 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481768; x=1790086568; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c6nXn9QszvDuxbC4bOSKyL0/hzlZ75yA+JSfjiylQcQ=;
        b=Dfhdu4JU6B4vpoz9OJNkLaTMVqciANlQunWXezpbr2iqcABJsLudNDkSv9HrRjNLii
         Wadc4N+D//ZId/ieY4KghRgY/6l3YPsVoDp0nPHYzseH4529r3t8XyNXtH41C+ElDvOq
         C5V39uhzwSYlOTVs52pwg4sHo8gQKVTwOta/Z0VclYSCRjGGsiPhp1o1GCsJn+q3FFMV
         F1hNFta2VFtbzCyhvmuUrYdc+5tRKyAVYxEJW1H2Pz7aIQtD8yNefSFuzKovOxZPpFYE
         DOTy5bWY+kzaZpz4IHoOjJ25GfOXYkERbRJny40s7EMvj2lxH8+DZcTc2BbpaED92mDL
         xBIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481768; x=1790086568;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c6nXn9QszvDuxbC4bOSKyL0/hzlZ75yA+JSfjiylQcQ=;
        b=haQpStvicrfZ614FmpUVykaVWv9VUQgdTn+y09iJXY1jQUqmYYxmdr9WQRn2Fixt/f
         vvl9gjT4tcYu8iWvpw5NlZ2ST0+kLX2yF6DiSdIozIX7e3fEEzwXRvou99uV1nltjUd/
         8iK7Tc/TbHLcKZEGLiwd9uRIAghig3m/wfSeA0bJPwmW1zU0PtlzPo06ncUTvk2UTv5Z
         YKo1jdwrY8JjE9rSfiVLsL/b2IeocdnLDyDxg7eJQIXIll8qIUTqW+Iwv7I20Hj8V4/U
         kzB+bJQ4IcLUN0TjjzJc7U8JaUg0/pQFktPkofjJmS+uiuYjST1lUrfpagt5UqAph09y
         heWA==
X-Forwarded-Encrypted: i=1; AKwUvBxhwxe77Vl/fLtai5O5wXxPPPn4A93SiCWxncRcjxGPdomqhutdsI7nidRsnpgJGaErgqNRf/ymsH5Nz70=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mzRanRvY+Qyzzaj5HMm/3nRely5SWVVgHvJsK5IDNlK5JfJEZ1
	raOlV5wfIps5UGP8oEJgNftPruD70aPaT9l70B1S6Iz2/L4Vo2y8W/h9
X-Gm-Gg: AYBFou1Dq4qSKYANEcowWWE7F1vyXC98bVAxG8A1XDQBB8mRomW4iPVezf6N5/XorXO
	FkJwFkV0McuYKu1WLqk8G+J7oj4Lq3S8F+Z9mRqRU91fh+7NCpTBTtCHKWmVIMjPsLnjmFdamsJ
	htGEBZy8WkPbd7GO30DCVXYKunraBRSFUYk9Y8KtYyNaDzBifp+j7lmqbVlVOmLT9Ad+p/Yoyx7
	hz/9UGtAtxD20oU+Xv+Rkok6YXq7RKpjZDyYSrjMtDOOnvQTc9LoE4DLdmaB3cb4Fed3uh0baym
	Ri9nqBu0rM4GTVJ480p5FwzImrllvfR6XGffVloExEZXUoSXlsK/BkaLHkCnTrofjMbzHRBgll9
	Sko4vjMkdpk6Se+soa1tU+lpTssAVh9v2XirIyzq99zXSS/c2lYU5X6ZGcbbbwfMtkIiyWLaDDh
	GUhL2utLKeWpaQEhV+i/QZ+wSsEhaNnyy3c22ETTLym0XzETvQLfgc4WP198yrQO77ZMx95bvo0
	GrQFktZ3YsGJrTe8IXlLm4L
X-Received: by 2002:a05:6000:188b:b0:487:73c:3f9 with SMTP id ffacd0b85a97d-4870a99c862mr1258242f8f.22.1789481767808;
        Tue, 15 Sep 2026 07:16:07 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb357288sm35209776f8f.29.2026.09.15.07.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:16:07 -0700 (PDT)
Date: Tue, 15 Sep 2026 16:16:05 +0200
From: Dave Penkler <dpenkler@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Tianchu Chen <flynnnchen@tencent.com>, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: Re: [PATCH v1 6/7] gpib: fmh_gpib: Replace
 dma_request_slave_channel() by dma_request_chan()
Message-ID: <aqlTJcVHi5CXTyjy@egonzo>
References: <20260915100931.3593242-1-andriy.shevchenko@linux.intel.com>
 <20260915100931.3593242-7-andriy.shevchenko@linux.intel.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915100931.3593242-7-andriy.shevchenko@linux.intel.com>

On Tue, Sep 15, 2026 at 12:04:27PM +0200, Andy Shevchenko wrote:
> Replace dma_request_slave_channel() by dma_request_chan() as suggested
> since the former is deprecated.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpib/fmh_gpib/fmh_gpib.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpib/fmh_gpib/fmh_gpib.c b/drivers/gpib/fmh_gpib/fmh_gpib.c
> index 5e10e9353fed..3fdcc673ec8b 100644
> --- a/drivers/gpib/fmh_gpib/fmh_gpib.c
> +++ b/drivers/gpib/fmh_gpib/fmh_gpib.c
> @@ -1458,10 +1458,11 @@ static int fmh_gpib_attach_impl(struct gpib_board *board, const struct gpib_boar
>  	e_priv->irq = irq;
>  
>  	if (acquire_dma) {
> -		e_priv->dma_channel = dma_request_slave_channel(board->dev, "rxtx");
> -		if (!e_priv->dma_channel) {
> +		e_priv->dma_channel = dma_request_chan(board->dev, "rxtx");
> +		retval = PTR_ERR_OR_ZERO(e_priv->dma_channel);
> +		if (retval) {
>  			dev_err(board->dev, "failed to acquire dma channel \"rxtx\".\n");
> -			return -EIO;
> +			return retval;
>  		}
>  	}

Reviewed-by: Dave Penkler <dpenkler@gmail.com>

