Return-Path: <SRS0=cW2d=AM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DEEC433DF
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 07:46:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2377D20722
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 07:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPh75AsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2377D20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49xYFQ4PYfzDqnw
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Jul 2020 17:46:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1043;
 helo=mail-pj1-x1043.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=lPh75AsL; dkim-atps=neutral
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49xXpq2gNczDqjZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jul 2020 17:26:42 +1000 (AEST)
Received: by mail-pj1-x1043.google.com with SMTP id cv18so5074262pjb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2020 00:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=45+p9qFF6DBDwyHUNuh+QjqxoDwCR18zLYMQyIvcnBo=;
 b=lPh75AsLe9G9ybYhjZkjxk6QZlN5KZi2Q8aPMoLW9Ib/96WKvOA7So89gFbDEC3bE5
 JOKqxdj2ALsDZ6EcXBy0GV8uHce1Z4Czt+mgdSXsSqj7fSz1JneQ5uy4AqU3+V16rITM
 ZLb7InkKLW/bcOCCrap2HkSIAyN8eOR+TUS/CjUa5aqqk8jc7LPW0/wcG2/i8EJVXEdB
 45x2gXb9pEnb8/V88ZXNEcV8bB3102hgj55xRN//hJf5Og1dGK9V9aBsf9yzce/mCOSh
 5+EWSa7MP31xaWZoBwNrPqxFoCN4Uz3oq4twHWXYbRAYD5eE275bvRTuyBSE8XK7RX5h
 8zBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=45+p9qFF6DBDwyHUNuh+QjqxoDwCR18zLYMQyIvcnBo=;
 b=Wll+mRRSeUBTwmYoZUla9DpqJJBXq90ue89Nds82pQ62UPQHiCA6TsfDMZ2+2qk42g
 u385Ao97yu4K/pY4ihQbI3ckf2IKzuplfnwtpWw1icu8PDVj35GWKD/M5dhrCHee7bYy
 KEBmMxy9a4t+2iO8YRFEaOboYOMc8UzhR+wpd9NtskwMeNMeakNrHJ1O06O5cImKSgaF
 ECph3GROsxNoYwOHjiUp9IdjpTUKKrux4L75p/OwZABxP+JCV2KrqFVqC1QApVaR3XJQ
 +c61fa5SViZh2LHM6FkjGd048+Sm/4wliMMGiVfvyYE1s7cH1PaM3nOZhUVqTt22/CcO
 zraA==
X-Gm-Message-State: AOAM531MacEGCROTcjGA2XOAU4eFNwPUHWSGni5Kk+ozDuj2RJZJr9Yx
 q7WUMch8MydWPuoOK90h340=
X-Google-Smtp-Source: ABdhPJytyFDyN/TwGZv+qVxhehOYWwLSsXhJW1Lqzbm2SjT/TlbF2UwIIvovKzYRSIAv1g/v1ARpMA==
X-Received: by 2002:a17:90a:d581:: with SMTP id
 v1mr26662363pju.33.1593588399632; 
 Wed, 01 Jul 2020 00:26:39 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
 by smtp.gmail.com with ESMTPSA id
 o12sm5123633pfu.188.2020.07.01.00.26.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Jul 2020 00:26:39 -0700 (PDT)
Date: Wed, 1 Jul 2020 00:26:28 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl_asrc: Add an option to select internal
 ratio mode
Message-ID: <20200701072628.GA9868@Asurada>
References: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593525367-23221-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 30, 2020 at 09:56:07PM +0800, Shengjiu Wang wrote:
> The ASRC not only supports ideal ratio mode, but also supports
> internal ratio mode.
> 
> For internal rato mode, the rate of clock source should be divided
> with no remainder by sample rate, otherwise there is sound
> distortion.
> 
> Add function fsl_asrc_select_clk() to find proper clock source for
> internal ratio mode, if the clock source is available then internal
> ratio mode will be selected.
> 
> With change, the ideal ratio mode is not the only option for user.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
