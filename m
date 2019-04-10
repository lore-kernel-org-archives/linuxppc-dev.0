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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC9BC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 04:34:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96712133D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 04:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXyxBPU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E96712133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fBBc6QjdzDqMv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 14:34:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="qXyxBPU7"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fB6J0229zDqM9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 14:30:31 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id y6so554148pll.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Apr 2019 21:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=1qlgnPrUH7CcuLuQLu7vBTzEUvbkD9aeMWyD3vveT+4=;
 b=qXyxBPU7BHhilFmVEbZfMkvsD6Xk0iNcscnlDbOunNg6fvIdP+x8DKtkP/950QXqJ1
 b7Q0iRPWfbajK3XwuaPBCFzWHBFD3+rZ5pgUl2dEEUtOlhImeFqQkQ0PvYMegyPYLeFD
 RP3NVqLrtLxQlKDoWxC5JaAKncIAxyRiuTyhwHIqYchF5Wts8nPw1eY6m4WviT4P1AVw
 cF3cZfKffe+KHonaySuCHZkSEV4f5LuW8GnCRkWjC2UQN5JvRIj9c/HybgoQbYqpCB/d
 NdO65vqlCs9hqqDYdcO97q9bK0IcRT/PJ3E5CIPnFRY8W+DnBQPnhV4/hnOFOFplBgNk
 M2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=1qlgnPrUH7CcuLuQLu7vBTzEUvbkD9aeMWyD3vveT+4=;
 b=ASIVy7Iv5WfcRpeg+y2Y6XVC1SuQ48aGwpax67GtzDYTdQ1XVw8sH0BZw1kJ0pDKSc
 02/YXjVTVVmPWwMtd08XasRVVcBVK3vzJo26ARuYHyE3FITlFnWoVHv4Utfe747l7QWW
 s37kWMyBdKLgIcc/sypSKXtn9iuYvnj4Gjc6vYHEEM9rNBEhNA1qtr1sn+3bdaZZaABw
 qHvLSpi8l3JicrfdMbr4hxHyPM/CjtzeAUif1wywxwbu+g9GB+LdKZI24au0E5krrm7J
 79+NLU2jcBkA87MiGPNxDHbxYd1DAIVtX4IoWa33w+rYYqm7lxAglI/V6o4QIEFlUopB
 Hv6A==
X-Gm-Message-State: APjAAAXa8WWxjI9nmHUtS/dHwaHfmSZqw+cYzKv2KPCvg9uNQgiF0PSw
 qriEMZcUBu1aMtALQafujns=
X-Google-Smtp-Source: APXvYqwH20ZmJQ2gaiJXYjc0Iq3X29OvYiq+lfIZnE1lCDPYOKhCvZBnluXA+60IMJlj9bR6XoDP2A==
X-Received: by 2002:a17:902:9881:: with SMTP id
 s1mr39581544plp.99.1554870630020; 
 Tue, 09 Apr 2019 21:30:30 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 g4sm121025pfc.75.2019.04.09.21.30.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Apr 2019 21:30:29 -0700 (PDT)
Date: Tue, 9 Apr 2019 21:30:26 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Viorel Suman <viorel.suman@nxp.com>
Subject: Re: [PATCH v2 3/3] ASoC: imx-audmix: fix object reference leaks in
 probe
Message-ID: <20190410043025.GE3032@Asurada>
References: <1554809242-27475-1-git-send-email-viorel.suman@nxp.com>
 <1554809242-27475-4-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554809242-27475-4-git-send-email-viorel.suman@nxp.com>
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

On Tue, Apr 09, 2019 at 11:27:42AM +0000, Viorel Suman wrote:
> Release the reference to the underlying device taken
> by of_find_device_by_node() call.
> 
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Reported-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
