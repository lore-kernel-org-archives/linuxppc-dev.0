Return-Path: <SRS0=ex+5=VV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE00EC76186
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 23:23:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A552189F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 23:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9aT+H8z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A552189F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45vBGh5DprzDqLq
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jul 2019 09:23:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="B9aT+H8z"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45vBDn0V5TzDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2019 09:21:28 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id i2so22611689plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2019 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=kcok0LgBsyc/okZx1Ol3rmWhL5MLbD+99FlIboC+ndY=;
 b=B9aT+H8zZb0fNl2vjxmEtT81BPo37zTt5g98LCfuxuy01ddORWh/CB7Q3hnuQ/AX+s
 vowRpzcr6WtyMgKF69p7p/q6KxV83JR231xFia1doXz5wITR+X1KThH8F/31CZ+kYWE7
 H/PfmqrHNBQrYD7eylgT/EsKd/qOanXXwpV+mGeWJdiMWG3eAhPZNNuqg+EP1BZPuqk/
 jRpvuLLnnUf+/O56aqMvbYEjIfEDAOqr/mR56+/imvtR2yMv8sIexbWJd2q9bwB+m9Oa
 HYZ3T5czjU5hRe7Nuw3H73T5+nl9tG6oU29R3sPZm/zfGJZw0xYUb6mVuS2R8nRAG3U7
 8RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=kcok0LgBsyc/okZx1Ol3rmWhL5MLbD+99FlIboC+ndY=;
 b=p2E2Rp8P93ZK8KWlzVk8dAms9y+cXUuG9hkvOazKSF80C9l1DUJxLqJDnNYt9fBgAI
 h3f1GoUEmBL578BaoTTOfUufZ54L6UA07C6I14nMKSSyVgsKCLQWvXykFWlbACHrHm04
 4+t8zRghjJtj/SrXGUK+weogGfleB+SwCg3x3GX9RqSNrE7ekMNzddCSSCCnRkfMZ4O9
 oLdM6IBX/WipPoqEUUePfFd9RQ8PqrfcnuSfFd7wt3FNSw9VvG9f/NAhMobDIxrQ6buw
 /KxCKci3kv6KG1bmiImz4IUaxZN73LNsq9gwPckTHQJuX6mNUnXbz9cDjiWRbXDfJIzV
 2Cbw==
X-Gm-Message-State: APjAAAW1thWKFb+pZA8aLnJyroO+z2rsPDhjlzo8YoAlgVK4y+vVl+mP
 tChCoKX/jMyJzBQisPrfYHs=
X-Google-Smtp-Source: APXvYqxwiudUxvu/coz792oUMUsi+3uSVa3zbEp1vcSY5LXXHGd7MfPYmIfYNlhGJTdsJVApfFFF4g==
X-Received: by 2002:a17:902:29c3:: with SMTP id
 h61mr44698653plb.37.1564010485328; 
 Wed, 24 Jul 2019 16:21:25 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id g2sm61762399pfb.95.2019.07.24.16.21.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 24 Jul 2019 16:21:25 -0700 (PDT)
Date: Wed, 24 Jul 2019 16:22:09 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 08/10] ASoC: dt-bindings: Document fcomb_mode property
Message-ID: <20190724232209.GC6859@Asurada-Nvidia.nvidia.com>
References: <20190722124833.28757-1-daniel.baluta@nxp.com>
 <20190722124833.28757-9-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722124833.28757-9-daniel.baluta@nxp.com>
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
Cc: alsa-devel@alsa-project.org, viorel.suman@nxp.com, timur@kernel.org,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, shengjiu.wang@nxp.com,
 angus@akkea.ca, tiwai@suse.com, perex@perex.cz, broonie@kernel.org,
 linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
 linux-kernel@vger.kernel.org, l.stach@pengutronix.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 22, 2019 at 03:48:31PM +0300, Daniel Baluta wrote:
> This allows combining multiple-data-line FIFOs into a
> single-data-line FIFO.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 4 ++++

This should be sent to devicetree mail-list also.

>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> index 59f4d965a5fb..ca27afd840ba 100644
> --- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
> +++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
> @@ -54,6 +54,10 @@ Optional properties:
>  			  represents first data line, bit 1 represents second
>  			  data line and so on. Data line is enabled if
>  			  corresponding bit is set to 1.
> +  - fsl,fcomb_mode	: list of two integers (first for RX, second for TX)
> +			  representing FIFO combine mode. Possible values for
> +			  combined mode are: 0 - disabled, 1 - Rx/Tx from shift
> +			  registers, 2 - Rx/Tx by software, 3 - both.

Looks like a software configuration to me, instead of a device
property. Is this configurable by user case, or hard-coded by
SoC/hardware design?
