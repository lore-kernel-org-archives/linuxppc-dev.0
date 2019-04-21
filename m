Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C38C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 08:06:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BBF320869
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 08:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIjf/1px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BBF320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44n2NJ2G1ZzDqS1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 18:06:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SIjf/1px"; 
 dkim-atps=neutral
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44n2LX6QZkzDqRK
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 18:04:52 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id b3so4344634pfd.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Apr 2019 01:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=WqmW3jhJQbbtDKoqaBLxUuj42y/qNfwTdD7pV2EaF9o=;
 b=SIjf/1pxKngViAfyvKmJt8tPOgmdzVEDD1CCq/ygMSg49AA/NMyPCX1szEe6qNmnc6
 vV8aR5+SvefgFQNPxxsEoGRVfxkIn8U7Q/wwvLhUlRrVc4vjtZdl3Ymw5HpugKqVfpCn
 L2dfx4R5331GQ1t7jbDN92uTJo4nkMXWFnGxsQzAnnJO7nt0yPw8C3j2M/m+ukZcc8Tn
 BwLBdjnvbCiz6NFrRVFEps1EaBIM+AtCnw6rMQEEJnZJUDYVz/lo5/d7c3kxEgEoM+S5
 mB2OEZh5kEAQFeD2F3G0oC/q9aBAcL5XNT6DXP9T3zNTDw/6gbPRBX+oEcm9sKvaJUpE
 waVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=WqmW3jhJQbbtDKoqaBLxUuj42y/qNfwTdD7pV2EaF9o=;
 b=ozc6NeA37A8zY6yDoFP7OPogV3lmmdCf9L8kUESs7QggR1O8Fbvb9sg63ifhbvgzWV
 ZJiwh8r7EpfEiZmGszG9ZbuZYDfkhjM7CqH47RQ13P0b1/FlQSdyxjj2S6hMzt8jcan9
 8HJmqAN0b9znXW5szAaygFzqboE3o3UvYVV8TmuhXLhQ+AM1OVHg41jjLrv6SZh6cKk8
 UlE3boevVtV5KFpXpPyB8f3FcN13ygRJUswJEz69kgQpPqRbvKkTHe07lDKY2nk/XQsG
 JCbw30r/TnCVqbAR/kE1yI4nW3rjeLjLwVvmh3RNzipKJg627S2GfsHsXg5LxAnRubEY
 FgCQ==
X-Gm-Message-State: APjAAAVNJd+5qAbkaHUpa8dvOV5XvGor8Np7YV4Vzucbw9ayh64pL892
 vZYr9geO11iTLMheJKL1iaM=
X-Google-Smtp-Source: APXvYqybW5n0u+5qpusipCUjI3sMOrwQQFo1uaLffNrUsfWApb5P1IWNr0t98L/j5XDQ2j7BdmHINw==
X-Received: by 2002:a63:5059:: with SMTP id q25mr6094546pgl.314.1555833887143; 
 Sun, 21 Apr 2019 01:04:47 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id
 w3sm15640299pfn.179.2019.04.21.01.04.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 21 Apr 2019 01:04:46 -0700 (PDT)
Date: Sun, 21 Apr 2019 01:04:40 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl: sai: Fix clock source for mclk0
Message-ID: <20190421080439.GA8784@Asurada>
References: <20190420154038.14576-1-daniel.baluta@nxp.com>
 <20190421053749.GA5552@Asurada>
 <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEnQRZDs_gnS8ehjM2M_y+Yw0Ge-Sq=A2c9BV-g=P_d0+O40hQ@mail.gmail.com>
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
 Daniel Baluta <daniel.baluta@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Apr 21, 2019 at 10:26:40AM +0300, Daniel Baluta wrote:
> > Firstly, according to your commit message, neither imx8qm nor
> > imx6sx has an "mclk0" clock in the clock list. Either of them
> > starts with "mclk1". So, before you change the driver, I don't
> > think it's even a right thing to define an "mclk0" in the DT.
> 
> From what I understand mclk0 means option 00b of MSEL bits which is:
> * busclk for i.MX8
> * mclk1 for i.MX6/7.

MSEL bit is used for an internal clock MUX to select four clock
inputs. However,  these four clock inputs aren't exactly 1:1 of
SAI's inputs. As fas as I can tell, SAI only has one bus clock
and three MCLK[1-3]; the internal clock MUX maps the bus clock
or MCLK1 to its input0, and then linearly maps MCLK[1-3] to its
inputs[1-3]. So it doesn't sound right to me that you define an
"MCLK0" in the DT, as it's supposed to describe input clocks of
SAI block, other than its internal clock MUX's.

> Adding a mclk0 in the DT and making it point to the correct option
> (busclk or mclk1) does no harm as the driver doesn't yet parse mclk0.

I know it's making driver easier, but unfortunately it's not a
right thing to do from my point of view.

> >
> > >               sai->mclk_clk[i] = devm_clk_get(&pdev->dev, tmp);
> > >               if (IS_ERR(sai->mclk_clk[i])) {
> >
> > Secondly, this would break existing DT bindings of imx6sx and
> > imx7 platforms as they both have clock-names defined in DTB:
> >         clock-names = "bus", "mclk1", "mclk2", "mclk3";
> > Since there's no "mclk0", the entire probe() would error-out.
> 
> Not exactly. The probe won't error-out. It will just print a warning message

You're right about this part. I didn't look further as the patch
ends at the IS_ERR, so made a wrong assumption. Sorry.

> In my opinion, the current implementation of fsl_sai has a bug for imx6/7.
> 
> Currently, fsl_sai.c driver does:
> 
>        sai->mclk_clk[0] = sai->bus_clk;
> 
> is wrong, because on imx6/7 mclk_clk[0] should point to the same clk
> as mclk_clk[1]

You are right. It should be fixed, but not by this approach IMHO.

Thanks
