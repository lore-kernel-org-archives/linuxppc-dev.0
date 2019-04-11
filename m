Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51FBC10F14
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 20:24:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95782146F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 20:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9/pFtSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95782146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44gCF16TNZzDqSV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Apr 2019 06:24:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="W9/pFtSS"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44gC915q6tzDqSP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2019 06:21:25 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id y3so4020347pgk.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Xp9AgRoZndC7bkDV//vOOG9+Mf8ePglt50CAM+1RJMI=;
 b=W9/pFtSSQ6NWmfFVCpZVS5nKewRIFCLJ9VgQ7IZ/urSc8yRQqsfmU6ezvX8SS8hfY6
 Cj1trB06YklVEmLtdaCw5Mz1eWLAYp5tWB9vXmhZ45+oLn+E+MtIVW0ohQ9n28GKMjWF
 Q2/A1P0uRjbZkvlLxsYWXIY5DpIXKSi0A+IRrBACED5X3St0UnIBspxPX6bZlT1as1qj
 33tERJDrBEwIoIT2lWlarBqNEI/EebBUPE+bN+w/Yd5Pyy+KTqrzJMct8KdcVQJfcsxk
 t4OEyZpp5Ny1eqE1DhVbHg70j3KdaXfMTulUbwOatmADjpsiC5yOPCGBHCsbJQPGD/8U
 xiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Xp9AgRoZndC7bkDV//vOOG9+Mf8ePglt50CAM+1RJMI=;
 b=UKnuH05al+CCKvZhmyYyeyV/s7pSyJmX7gx2NXOPCMXPQOPPvD56Q9jNW6IGq5DpY3
 wFA+Mlbd8MFrUDsPC6vNB4W8hlxsbPzK7jtePPdK6whjg8VKrs5GAW4g2WH2ZV4R/EWb
 IFQ7Q26z+Gdc//ZDvIeXZjrOQ58v0TtbG+VVaOjvV+008C3BPifm/c9aRyTjpdCi5B0C
 7jwIzwpEFkfuxz7vvzbrJC+BzomkryjPv2L6+j/w4rUBVsxlGE2b5utmqG0dsDztGY6D
 iISj02YTM4m2PH5rWjHuMXp0K5nq3hbizdsonjvqBVrd0FY0RT7nIkw6PRpSeLxGPdDJ
 zDmw==
X-Gm-Message-State: APjAAAXbSeV9PmEP3wEZJWkL+VeAquOz/9y+SxsbI1dVWMqqJANDQeQW
 E9/qpoN4p4LRhUkP9vXWjv4=
X-Google-Smtp-Source: APXvYqy4LjSsy9ejijyKGtdcWG/rQY1lFzAVMVk1df/xdr5tnsQ2cfx2YR6A/D8qgX4oi0eesa3RFg==
X-Received: by 2002:a65:4802:: with SMTP id h2mr45613207pgs.98.1555014081510; 
 Thu, 11 Apr 2019 13:21:21 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 19sm44641413pga.88.2019.04.11.13.21.20
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 11 Apr 2019 13:21:20 -0700 (PDT)
Date: Thu, 11 Apr 2019 13:21:18 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v4 4/4] ASoC: fsl_audmix: cache pdev->dev pointer
Message-ID: <20190411202117.GC13170@Asurada-Nvidia.nvidia.com>
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
 <1554894380-25153-5-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554894380-25153-5-git-send-email-viorel.suman@nxp.com>
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

On Wed, Apr 10, 2019 at 11:06:39AM +0000, Viorel Suman wrote:
> There should be no trouble to understand dev = pdev->dev.
> This can save some space to have more print info or save
> some wrapped lines.

Change looks fine. Ack.

> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>

I think usually Suggested-by comes above Signed-off-by.

This was originally in your change already, so you can replace:
-Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>
-Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Just a chance for it to get resent without being a noise :)
