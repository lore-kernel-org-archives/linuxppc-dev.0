Return-Path: <SRS0=a/z+=75=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB897C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 05:25:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10182206DB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 05:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM7xYNKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10182206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49mGqR6wxvzDqkq
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jun 2020 15:25:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::541;
 helo=mail-pg1-x541.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=lM7xYNKX; dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49mGnV2M7RzDqgd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2020 15:23:25 +1000 (AEST)
Received: by mail-pg1-x541.google.com with SMTP id t7so8707189pgt.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2020 22:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=F8di4l+s/Ly7rCfnAJCSNumrdSsKS4ibEMc0wr155Lw=;
 b=lM7xYNKXNC3/18xNrWIVK8uekEsB6xz+aF3OvLQ+WQIAjqOxxrV8QNtErcVGyjuFYg
 g2ekGJtibX1TQHLUZjVom/gQ9oi3PiHmEHLFjd3KY7POCjycjtV/31bAAc+1sdmzT3wg
 Cx1zS4qoeLjGbtlpMuEJw+mtrkfV25ndvHW68jWZDEuri/PNWiNlS1GwyOUVSu8H+RDY
 UYtFd2wci0vd0yvpivgutSmG5c70wvCz7AH+y5R5KA6+n/DKwUZ0Qc5blx5dy8Gq7ljM
 9LF9mi16mdnjqFoTQpRlgZXl+AHQOlwBrEXSMqWB0bmXsUN14uYuObilLRMZRY638bir
 nDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=F8di4l+s/Ly7rCfnAJCSNumrdSsKS4ibEMc0wr155Lw=;
 b=fGtUM7Ui00kV1h1a9LedSkK1/syYLfAncPa52P2k2G91AUfGiFj4VKMmGE68YftPRq
 u3oy9A/xcPAMX0Ht0VA25DbkNwvJO+jtU7Boyc4LEKxixtEdViL85jwOg6o6OAiVNx1L
 W7TSNNLpsKYbFjuFO5Ivx1zqUBDwdgfIJ5phn5vpCYwlHbaCNLnhUhLIa+oboFk+KNZ1
 P/XY4dzQ7xu9eXq0zRaDPgCFDru1JuL7kk+Sx49FqzlIgabwVNAgiTuMwlMyfFDIQ6Sh
 PisLvX5+uIsmyJ3Bv6tCryrYLBtMTsKAzkrQ1vkXqpmt8FtzPktitg78exMI16iU9wRt
 KOLA==
X-Gm-Message-State: AOAM5326U6hQ8SCpGEmwGGkz1o3GXxMEHnxEGCM91tiXefPq3Kc5odZn
 v/DGmP2mfA8HmlBPWYLvaA0=
X-Google-Smtp-Source: ABdhPJy/DgyZOR7OSTrsOc0TGFWHgdklAdqqTv+6cq9ydXh1cUOIgbk3cVS/IZxiJP2tDbUJtD47xg==
X-Received: by 2002:a05:6a00:843:: with SMTP id
 q3mr579487pfk.107.1592285003585; 
 Mon, 15 Jun 2020 22:23:23 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id h6sm15684333pfq.214.2020.06.15.22.23.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 15 Jun 2020 22:23:23 -0700 (PDT)
Date: Mon, 15 Jun 2020 22:23:07 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl_ssi: Fix bclk calculation for mono channel
Message-ID: <20200616052304.GA24055@Asurada-Nvidia>
References: <034eff1435ff6ce300b6c781130cefd9db22ab9a.1592276147.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <034eff1435ff6ce300b6c781130cefd9db22ab9a.1592276147.git.shengjiu.wang@nxp.com>
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
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, perex@perex.cz,
 broonie@kernel.org, festevam@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 16, 2020 at 10:53:48AM +0800, Shengjiu Wang wrote:
> For mono channel, SSI will switch to Normal mode.
> 
> In Normal mode and Network mode, the Word Length Control bits
> control the word length divider in clock generator, which is
> different with I2S Master mode (the word length is fixed to
> 32bit), it should be the value of params_width(hw_params).
> 
> The condition "slots == 2" is not good for I2S Master mode,
> because for Network mode and Normal mode, the slots can also
> be 2. Then we need to use (ssi->i2s_net & SSI_SCR_I2S_MODE_MASK)
> to check if it is I2S Master mode.
> 
> So we refine the formula for mono channel, otherwise there
> will be sound issue for S24_LE.
> 
> Fixes: b0a7043d5c2c ("ASoC: fsl_ssi: Caculate bit clock rate using slot number and width")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
