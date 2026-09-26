Return-Path: <linuxppc-dev+bounces-28283-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC22C98332
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 14:38:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsVYJ6DXVz2y2K;
	Sun, 27 Sep 2026 00:38:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:30::f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790433492;
	cv=none; b=fsVEf4/yrlgwYwKIrpS/bjRfi8WSdroxkdyGzipN7zvxgMeR5vrRQEGd3cIpLH19tOv1FeZO1IpYcTlEbXpT/1cDpJvJlmsFz8byKbGwts/UMMBZgsbaiTn3r8wWtPSOAipxl7iN1joFf33Iv81XGPxHXJsxnlT06XBNd3/xtOnGl+9M+UXhMBnYM7C2KnOcfHHhDAcpv9QbIGzd3meUiNDM3a2tqTRHhy+YX6MxGJ2oVKEJOy2kemhITMXs16E6hhH//7Ejf9z8NY1ifj3+sfXZRMALhRA+FtIIZKNWDKYh0V6mX/VSF3IVEBuFkILpOaT0Nzi+neCmSe/5eGzY3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790433492; c=relaxed/relaxed;
	bh=BoThG4thxlXrTbw7oMamnALAxxBbKFMtz3aQO6xHoEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hi9m8SI+sUeXhF2ppYo8TnTe7y+DQ5BhQdv18O6vwm+woz2Tgy0O5ErlTsYl+UiiSqpW9UsQgWmplZiVRASAdW1xa/V+288oQcLbuCZ3HBiSOEdgQCUV5PpbWRl0MP/hC1zNATNHbTrHScPF+DEIplmH2EHEHz9pbVRg9TSc46Y0vdc1VqZ79ZxEZWyRYc3DNNn44xSTHPAb/lw3mYqOumMqbLrb0AkUbuI0M9XfNOJd1gGPHc3VKEg31yf0bDjFXMICYxq29eB7q3+uTn3r1mgUwIEh3JGIWuMpu6sRNfRgMLFQye5kgA7JgCkShHZQn/I16BMo3tEIWZ1SImj2uw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=clUv9aXr; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::f; helo=mail-wr2-x0f.google.com; envelope-from=error27@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=clUv9aXr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::f; helo=mail-wr2-x0f.google.com; envelope-from=error27@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com [IPv6:2a00:1450:4864:30::f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsVYH0VP4z2y21
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 00:38:09 +1000 (AEST)
Received: by mail-wr2-x0f.google.com with SMTP id ffacd0b85a97d-482f635552aso1344868f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790433481; x=1791038281; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BoThG4thxlXrTbw7oMamnALAxxBbKFMtz3aQO6xHoEQ=;
        b=clUv9aXrECYG3XuuMaXlSr1t2xsJ7SpPR2hPpO491YuQKP2rNkl+DuTUaYMlxPCTHD
         Lm+NbszpfuKzWgQf7EUzWT8sp0DH55UxaqHm7Lk5CgEktMy19b0Ap4WyjtuU6jq9i4nn
         KWf1Z7hKUWn3U07c8byXzxpYsx4HfBtf/vcyMQl8DqYgGQ5A/hEhPJBeNPwaKgo0pD6p
         ojCxEe9+mLvrOR9WpPNWco36UFuQRYteF1nOfW/NhrHz6cQQ9L8hOWHl79zapFi+Yb6Z
         A2uQ9J+fp3w6zBPr5tGT/iKoXLspgv7tHDUYzTJXgDisoC8hiVeu/1aEThEasA5TRlTj
         1DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790433481; x=1791038281;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BoThG4thxlXrTbw7oMamnALAxxBbKFMtz3aQO6xHoEQ=;
        b=hHkNs0u966JrqigW+clTZnxYOH+CRk53cy4Ia9/tHjfPOLmnZ5n0pBDsZLNWGBUamp
         78iY7rx2PpbOnt0DAnAuKxBTaT/GzVxEpORyllh8L5UKDT7wEfBmG0Aoc2Ypvqun2mJA
         rheckdU4CqUWDpsuW5tzYy4KBaJisdzgseCsa22UOlD5QlUMW1peOF5KVuQuoehVE0eP
         V9aPv7k/mr1oeSqdYytgYJUEOBDG2brua0CRmSslkpTWfZ6MMJ3O0J7aAcKYy+MnaUJd
         q9TG1SqSxXexYxP7CagDNUVtVS1GSiqKONBhtnctQdgZIN5f7NLUcOK4QbpmM7humAyl
         44Bw==
X-Forwarded-Encrypted: i=1; AKwUvBzixcycBz+ZnyKmxHR4Jo7Owahssfo6wX+mAYIPBivhJd0VS8er0rk5TC77ivi1VQMH7nIXf/5zfQcJB28=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYICWXZKQ9JCMLE44DYFSoMU0rQcHbvjuDqQvInBcNSreA3TndIa
	HiwzaF6+j8tNyNPY0rEunYfq0/PKMw11waWrJzj6CJGM3g4uF0y0fdOJ
X-Gm-Gg: AYBFou3srF9fWUE6ZH/hvGxsjSzGf7p+4WItE2BN0c7543d5x4+0AzBn3nv2wWcQ0+x
	mafMCwSfTBLXqVBd6cNOBz9RgOLrLZeq7MpjC2SXYDO1lu5GoNgrKcW4YvIxGxhLLYQ+hQHZg0r
	jiAPv69j90YlQ8/H41cpRsgKK/yr1jyfGmkebajzWigRw20MlCD2jJaHjB6AO0XkciffR6LIJb4
	qNdFaRZtBxiYZFoUlUuJPcyuuiEql5bSXoMLFOGWYufd2MrvLdvUTeLjinjVw0LpToIN+I6fvWi
	ooK62Wu0PBCLrdbQwuJdpnvI6YYmNqbpCcIUULyIpF7Fx2YLXKMMX68Y7N6AimyChaaD2fW0y45
	+AzQHxQ3gvSGtUZd+5btQp5GgbQFCRXkCF+jX3/sivDdsYMAvVe/g+CwAxEy2JZqsT1rHwuSx+a
	bS/xM6sRKJlZhr9OJkrxNPJ/bMMOK1mEDFzTKoVkftJilk6DzFqOXuzIY7NwpaHbmvTJRpxOxum
	UxjuQ==
X-Received: by 2002:a05:6000:25f7:b0:488:54ff:67c9 with SMTP id ffacd0b85a97d-48872ac7587mr14732310f8f.46.1790433480936;
        Sat, 26 Sep 2026 07:38:00 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349a0esm20798420f8f.10.2026.09.26.07.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:38:00 -0700 (PDT)
Date: Sat, 26 Sep 2026 17:37:56 +0300
From: Dan Carpenter <error27@gmail.com>
To: Slavin Liu <bolin.liu@seu.edu.cn>
Cc: shengjiu.wang@gmail.com, xiubo.lee@gmail.com, lgirdwood@gmail.com,
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	festevam@gmail.com, nicoleotsuka@gmail.com,
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_asrc: check the second front-end DMA channel
Message-ID: <arfYxD95RJRcKCbZ@stanley.mountain>
References: <20260913125147.109920-1-bolin.liu@seu.edu.cn>
 <arfGajXmMUeew0fr@stanley.mountain>
 <20260926141011.451552-1-bolin.liu@seu.edu.cn>
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
In-Reply-To: <20260926141011.451552-1-bolin.liu@seu.edu.cn>

On Sat, Sep 26, 2026 at 10:10:11PM +0800, Slavin Liu wrote:
> Hi Dan,
> 
> On Sat, Sep 26, 2026 at 04:19:38PM +0300, Dan Carpenter wrote:
> > The ->get_dma_channel() function pointer returns error pointers not
> > NULL.
> >
> >     sound/soc/fsl/fsl_asrc_dma.c:254 fsl_asrc_dma_hw_params()
> >     warn: 'tmp_chan' is an error pointer or valid
> >
> > sound/soc/fsl/fsl_easrc.c | (struct fsl_asrc)->get_dma_channel | fsl_easrc_get_dma_channel | 1
> > sound/soc/fsl/fsl_asrc.c | (struct fsl_asrc)->get_dma_channel | fsl_asrc_get_dma_channel | 1
> 
> Is this a false positive?: both implementations return
> dma_request_slave_channel().

Ah, you're looking at old code.  It changed from NULL to error pointers
last week.  The dma_request_slave_channel() function was deleted entirely
since there are no more callers in the kernel.

https://lore.kernel.org/all/20260918113727.1898998-6-andriy.shevchenko@linux.intel.com/

regards,
dan carpenter


