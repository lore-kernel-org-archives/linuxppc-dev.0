Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAB8C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 05:55:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFAC20869
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 05:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAaOxD+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFAC20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mzTW1ksyzDqRd
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:55:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="LAaOxD+Z"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mzRp5wCHzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 15:54:12 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id 188so4253455pfd.8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 22:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LxIFaDAjG3Mf4CKCOKCnEJN+OeV4ScqkIERFngckI4A=;
 b=LAaOxD+ZJIu2q9HJbL0xcuvhgWihpdORRIC21ARI/HGLnJetPMuLI6ZxTpxnHrS/VR
 c0Iki61GRuw3bpWHygxkXOyqF1bWI7cfXSfAtAGAw/w/iinqw9MCzKAhAJ+LIv9STLAG
 KRNccylvtUNwDoVMN8aKn1sQF/DH0UW2u/JHVQgIqrenfR21YaZLgU8fCnSvtiSfahL+
 TbEstC5k5OUrbT3aUcTwbAYUsr11xseqDGOXZOqO4dsbWQ1bBCHatPZmc5xoAaWsMI/n
 3zHT/rIWtqd1kYedbtCmpYHzlXxvpLxP7qxjQG9pdtHQrxaYKBV4tvBlF3XMDNeTt+9G
 +4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LxIFaDAjG3Mf4CKCOKCnEJN+OeV4ScqkIERFngckI4A=;
 b=HNj/ACypJocvFYCpboK47qNke6fLLgUM862x6K34KGrcaFa7NekL6MW0FeTwkoaA9I
 DEv7PWJY4JCPttudNYqSBpE6Y+cYVbvta8gTAFqLdRwt2P4q5zZ47L9QfIeZ/5gfzCzL
 ng9ldJodhv4TttEz2ZnW0L7MIQac8jdcJ0NX+6yzSntMyVMxkYcjrGxfgdJu5ENaLZ3K
 egKkVKy+OvxRW4LIPrtv3bnTWnhMdpHh7XiDhGbXd7tm21qh00qcDQFJ2xxSJJEUbSqc
 2v9/DKJagYyPiuXbHY7wuXjnMzDHvBDMVHlEHVxZV2JdKNQp78tiCJPIpDtXFo476wCi
 fmLw==
X-Gm-Message-State: APjAAAWRLK5sfhPhIISHSVKJU3o8WwONs7lea8L9nw0wlRdLGa6GoRHU
 F8f7VqGX5D0qGIEROD8cWP0=
X-Google-Smtp-Source: APXvYqzvbB4cv40Daen5ODJbcKQMVnlU8GPhyobIcmISAHn5oXEuPiQyIM89BWQ1yX5ByHEY7Cna7w==
X-Received: by 2002:a62:1647:: with SMTP id 68mr13561107pfw.113.1555826050829; 
 Sat, 20 Apr 2019 22:54:10 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id v15sm12187074pff.105.2019.04.20.22.54.09
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 20 Apr 2019 22:54:10 -0700 (PDT)
Date: Sat, 20 Apr 2019 22:54:07 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 2/2] ASoC: fsl: Move clock operation to PM runtime
Message-ID: <20190421055406.GC683@Asurada-Nvidia.nvidia.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
 <20190420155846.10027-3-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420155846.10027-3-daniel.baluta@nxp.com>
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
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "S.j. Wang" <shengjiu.wang@nxp.com>, "tiwai@suse.com" <tiwai@suse.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Apr 20, 2019 at 03:59:05PM +0000, Daniel Baluta wrote:
> Turn off/on clocks when device enters suspend/resume. This
> helps saving power.

> @@ -934,6 +933,25 @@ static int fsl_sai_runtime_suspend(struct device *dev)
>  static int fsl_sai_runtime_resume(struct device *dev)
>  {
>  	struct fsl_sai *sai = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(sai->bus_clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable bus clock: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK)) {
> +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[1]]);
> +		if (ret)
> +			goto disable_bus_clk;
> +	}
> +
> +	if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE)) {
> +		ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[0]]);
> +		if (ret)
> +			goto disable_tx_clk;
> +	}

The driver only enables mclk_clks for I2S master mode. But this
change enables them for I2S slave mode also. It doesn't sound a
right thing to me since we are supposed to save power?
