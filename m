Return-Path: <SRS0=10v2=SU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C8BC10F0E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:02:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2566C206B6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 09:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d45XVkiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2566C206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44lClr4yjSzDqR7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Apr 2019 19:02:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::543; helo=mail-pg1-x543.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="d45XVkiB"; 
 dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44lCk0081jzDqQP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 19:00:23 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id 85so899836pgc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2019 02:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=AR1RP7f6kZifZ7FeB0P9Q2kh0p04YoT/2fg9i6FFRjE=;
 b=d45XVkiBIHj4d50vGS6UL25afAP+GwNkW1AT4uquixx64Bkbkxtg+qchQxRY0yfcib
 WnEQAf+YRh2PP/StgKkC++L2w3Dn8uzkN6tpKKlE44ZQk6gDmg22ebPBEWl47M/wkVMd
 R926WMDAUrwrJTGVNGcevasOORF6WfPbThgZ0SmKYVqIiY5eW78q718X7woBxj+Xc/J0
 rdDEvFYgsKdymHxppa9sncmUU3lvXXP2XqfM+FuYr1IQS0RiR5LGUE+kHA+lRB5QGV1b
 BGwqPU2TGLcr8QSdWBl1562TJkl+sxaD77CZXH/Uqwu29q/+/6cZ43e2zb7v0p8Zka9w
 rvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=AR1RP7f6kZifZ7FeB0P9Q2kh0p04YoT/2fg9i6FFRjE=;
 b=mjP1pYrX0hVxvM8cr5tas0DFQ5PDhYUB0ZpEC0jdv+12kj5HNpMgQdU+XbiE92EN9p
 L71RnTOn1z1QauczjO8ND7WEhB2DSKKeY+nwQkGqHdRuIXMY6vs7WKCe2FTrlAAwD+t5
 38wLv2Z+UIMgA1/KJYNccADM15ljI4mKAjLzyAEX/eamPKnzQqKBnZize02KGXpJMa+1
 7DIYX//+vCnwX++59ETSDWtp6eT9GR/1OZq/0VDgsDa+LmFYcjBpC19RKu4HKTUial1a
 Cy/TnNOmG9b6cX3U5UQehGmkb8gHuJllhFj+InBA4culyQQcZBJePUQxcyGbNPFBwNEO
 3i0g==
X-Gm-Message-State: APjAAAWkGUW+d/nOOxT95GFtBnMyRCm7t487aEwR76p7zZVBjJYEHAZB
 gGLRmELZ7864rQW0oudi82g=
X-Google-Smtp-Source: APXvYqzNMmtMyDebuNNZgKECpUn3goSspWHCCs8OulR0f1awwQxvw5m0sIpcxmT/6vQQhlyE43um0Q==
X-Received: by 2002:a63:c104:: with SMTP id w4mr88228953pgf.409.1555578020180; 
 Thu, 18 Apr 2019 02:00:20 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 y8sm2377070pgk.20.2019.04.18.02.00.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Apr 2019 02:00:19 -0700 (PDT)
Date: Thu, 18 Apr 2019 02:00:12 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Add pm runtime function
Message-ID: <20190418090011.GA4028@Asurada>
References: <1555558152-32196-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555558152-32196-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 18, 2019 at 03:29:09AM +0000, S.j. Wang wrote:
> In imx8 when systerm enter suspend state, the power of subsystem will
> be off, the clock enable state will be lost and register configuration

Just for curiosity, we had similar situation on imx6sx, so we
added suspend/resume with regcache. Why will the clock enable
state be lost too? Does CCM on imx8 (might not be called CCM
though) have any difference? What about clock rate settings?

> will be lost. So the driver need to enter runtime suspend state in
> suspend.

> With this implementation the suspend function almost same as runtime
> suspend function, so remove the suspend function, just use
> pm_runtime_force_suspend instead, and same for the resume function.
> 
> And also need to move clock enablement to runtime resume and clock
> disablement to runtime suspend.


> -static int fsl_esai_suspend(struct device *dev)
> -	regcache_cache_only(esai->regmap, true);
> -	regcache_mark_dirty(esai->regmap);

> +static int fsl_esai_runtime_resume(struct device *dev)
>  	regcache_cache_only(esai->regmap, false);
> +	regcache_mark_dirty(esai->regmap);

Why move the regcache_mark_dirty from suspend to resume?
(I am not saying it's wrong but wondering if this is the
 preferable way.)
