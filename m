Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE971C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 05:43:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2E920869
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 05:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ve3DLFov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2E920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44mzCk0nzqzDqJK
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 15:43:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ve3DLFov"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44mzB83dYlzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 15:42:23 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id j26so4399125pgl.5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Apr 2019 22:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=JOTJduBw8Kbj981+gHoyU+cGs+zjrK7BpE6zdFadBbo=;
 b=Ve3DLFovFLk4u62BN4fu71K6Y+OXozDMijEJmJYIjPBvKv66ZAvBQ9B59e+9gMWJ8c
 f2jeRq6/IVPrssctq3keciot6uVpfrB8CYCkHD+cwzOerADkvPsW+sIwm9azGWFNHOfh
 z+F9VOPxsZ2+Xlv5v26s+ylgsQSzlh5yRLFko9qE6i9Txtlru78akKt+FHrmgWguHikx
 e6DaR9/XLB0PeZ4QK+m3aCe0gqbA5JZ4RKex2SKsxGYKVSxg66tRwTuS5zqJ9Rs25dRh
 UW39rWLriQS1lXeSWf15LfO1lwqww/VkpQ7A9uoFR61dk6DP0z1tE2/V0cbdwiNGdFkc
 eRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=JOTJduBw8Kbj981+gHoyU+cGs+zjrK7BpE6zdFadBbo=;
 b=pTkoEZXm7SEcPyKeciie9VUJ3EVV/b8kNBrfgrDQU/sTvIs9iA+i6XKQ49VnrIVM6w
 rukGfUia3EFpOVZ2DGjG/arawoYXOj1uPa+HH8M/6/z6yAHnMw51Wjv72/QU+kE0XimD
 BMvsSRaHo7BDIhc25U2AX23BpjMzj9pvDf2v17tOCaRD7MkwMnSkAQC9iRHLADuHxPlb
 3FzZQ+KKCq/gNzSG4facrWcV4iEDog6WNNgg07WLMTc5lvDnMn9xiCc3wc4MO4zrBJ9D
 3Y4F8yK0dOmpW7zXEX25d44LMXJI5sWwLowSzNZJzrhzo1HFm4JFMk3pdOttFfWp++eb
 zuSw==
X-Gm-Message-State: APjAAAUfE8XXMqIwvZyT062iG8uV0+jqDWOJ/mmO+0e/3l0XH000booV
 Z6ZWatMM1xBtLJGkh3mvfTA=
X-Google-Smtp-Source: APXvYqxN39rpPzoz2ICYNYsd/xJ1W5HMYxuCAYUiE7h9p14Wmi4kCZyxQv+G6fjWwnI6683IGakemg==
X-Received: by 2002:a65:6091:: with SMTP id t17mr12473447pgu.328.1555825340556; 
 Sat, 20 Apr 2019 22:42:20 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com.
 [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id a6sm12491699pfn.181.2019.04.20.22.42.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 20 Apr 2019 22:42:20 -0700 (PDT)
Date: Sat, 20 Apr 2019 22:42:15 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH 0/2] Add runtime PM for SAI digital audio interface
Message-ID: <20190421054214.GA683@Asurada-Nvidia.nvidia.com>
References: <20190420155846.10027-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420155846.10027-1-daniel.baluta@nxp.com>
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

On Sat, Apr 20, 2019 at 03:59:03PM +0000, Daniel Baluta wrote:
> First patch uses system PM handlers to implement runtime PM. While
> the second patch moves clock handling from startup/shutdown to runtime
> PM handlers.
> 
>   ASoC: fsl: sai: Add support for runtime pm
>   ASoC: fsl: Move clock operation to PM runtime

Both patches should use the prefix:
ASoC: fsl_sai: Xxxxx yyyy

Thanks
