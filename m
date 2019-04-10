Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463A0C10F14
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 04:31:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8CE320854
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 04:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5zH16cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8CE320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fB6x5k8WzDqGb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:31:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="d5zH16cO"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fB4p4W78zDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 14:29:14 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id y6so591048plt.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 21:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hg+vFG8Wc2AnyBt417MjCD1cA4puKAPw8Dp8WcpXUwY=;
 b=d5zH16cOgagXTRWao1Drpafdr5F1jPtn68THcAdHmYphnhHH79uNFPAY2NdyJwx5+E
 c1Iu6AMmt3ebhcifAkhbTrUKVs6Y6na26WReQL22HaC5JHKSRy9OaYU3+fsYXMZl9EE3
 AZ+WB9LXKyHpuc5ScrufnXJNq0s2Eq1jJ4V6QtzAW7K7FrS+na0Ab6pT1hqsZiPexr/B
 VyHePZRDiAi2SRZwkGGR4pD2zqtvoKlRcSkfiIY4s4MBc/HAD68MeAcsZxRNO3MBFIsV
 vgsECk6ATQJYKcbbSIxiYwI1OFFeIKVZMZFHwKI8xa1od8EccsKNNwXELaQksrwpkSn5
 rMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hg+vFG8Wc2AnyBt417MjCD1cA4puKAPw8Dp8WcpXUwY=;
 b=kSfl0IpdVeUmJkmIi0ciCijQMOeDak9jSf/96Ldh4kWSOXu1kvTitrEk8H9xUz/oNV
 GhacJjM7O5j+auYNQgaKfTUyj6ui57/LsKXgG3P6nFyx4t6OV0+HO7XUlX1ig0/hbHT+
 4n5fQqRELGct1EBgSvve2zgkmWVzs38NRowTCBhMQa1VZmKxQFlXL6cOcWQaejO/gTP3
 oiVsOn0Ral0m/mKR07jIXCbMvI9r9eXEiEfXQs20lOsb+HzWuX3nqT4n6+n8A+YglMYt
 NyLyykHjxNXBNQSBXM8bwNfjFt8Zlxgg1L4w/97Xwf74Hv2gsI5wL47CVA3DPZpRl0Zk
 RACw==
X-Gm-Message-State: APjAAAUtttTEUum+F2CDizf+G4BFuglNOXswYFm1pSDZtzbeoNUvmxuM
 +JzMWM8/ZLE6/wvYBUdZzsM=
X-Google-Smtp-Source: APXvYqzTIZZiXzM02bx8TqtJKxpOHo+96RkG1lcMyQ+na5eSpfNRZeMjXs0lIfKgMzjDbuFr2Ssmxw==
X-Received: by 2002:a17:902:a583:: with SMTP id
 az3mr41728742plb.205.1554870550774; 
 Tue, 09 Apr 2019 21:29:10 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 y23sm49258200pfn.25.2019.04.09.21.29.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Apr 2019 21:29:10 -0700 (PDT)
Date: Tue, 9 Apr 2019 21:29:07 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v2 1/3] ASoC: fsl_audmix: remove "model" attribute
Message-ID: <20190410042906.GC3032@Asurada>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554809242-27475-2-git-send-email-viorel.suman@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Viorel Suman <viorel.suman@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
 Mark Brown <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Apr 09, 2019 at 11:27:39AM +0000, Viorel Suman wrote:
> Use "of_device_id.data" to specify the machine driver
> instead of "model" DTS attribute.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_audmix.c | 43 +++++++++++++++++++++++--------------------
>  1 file changed, 23 insertions(+), 20 deletions(-)

> +	priv->pdev = platform_device_register_data(&pdev->dev, mdrv, 0, NULL,
> +						   0);

Would you please send a separate patch to replace "pdev->dev"?
