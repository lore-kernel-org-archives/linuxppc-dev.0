Return-Path: <SRS0=HG9l=EZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6782EC2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 05:03:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726F5246EB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 05:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duj4eOFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726F5246EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cc6yn1mBszDqkg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 16:03:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::543;
 helo=mail-pg1-x543.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=duj4eOFR; dkim-atps=neutral
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cc6wd5wn0zDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2020 16:01:52 +1100 (AEDT)
Received: by mail-pg1-x543.google.com with SMTP id q34so3113855pgb.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2020 21:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8cz3enAL5Z5Hmb2tunw3mWVvo6ZiOq4lJnWnZV2/xu4=;
 b=duj4eOFRuuoRo/k2/GT7E5UP1NTqvVMJONO2EmKQx4JwzYhwNLBCLf2SokW5rrlgFI
 uhWxiVtmj9lqv35g4VinjX6jszgACQbXZN7duEVfuwdwZKKl4uV/B3IciP51RklxnBkG
 e9vDOnA4/0ctUOpISUygUux++JCmtPQi4KmCa4b8Ucr2SZw0XB6gshJRf1C+VCQtg5aD
 UOS1W+1wNa3L3RfyXaZhipBSoGV8Esfye1CRoe8MoySnHt8lvt7BmCT3nGmkSI21Uqf1
 s1HrD0GFOsedFunmHzmHcxOR9WA0mqTKLxXl+766u2ircarXMerAhy0XM0VrIG9CmxbF
 ZTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8cz3enAL5Z5Hmb2tunw3mWVvo6ZiOq4lJnWnZV2/xu4=;
 b=DNNeIis5EgiRNHPYyjsEDztn4x52yNGBQzdt42qLCPgy64OZU8d0PVz47n3OAE+78M
 cRD3miCjosbpGzyAc/eVNKzUk8pJErbOOZOww5pUNo/s6W11GcvTwaLQcAPNJm7hE0xp
 wxwLqgH4dZImQxj06EtCE8NsAs2w8pZpJ3HOxiS9QwFQGG1Gh5n2OBqZ8/ScAc2TuJAc
 svrraV3yun+wqmHC2iYmCMTmxtNqEqmZsVLLUdUpBzLzvrFFkvTUdmRAt0K1w24yLQ+2
 J5VyR217kuqpv4R/9Eih2WD30Yc0gsLJGuSxKwEYKw3g4dtdc+piprDPYcoY6m4HWulS
 okiA==
X-Gm-Message-State: AOAM532uzLsx2oDzLwJZpKg9VOh94GGlWYMV6/yLhUt6+I6kaooCiE8z
 5ysWW1ZkeY/OIjS1QZ/6c/s=
X-Google-Smtp-Source: ABdhPJwQdNXkT3Phmm+Z7AT/H+skvgWBxS2LYjl6sXgqQqAOZ7omgkkvUkEcBl/cAAspL+sft1r/UQ==
X-Received: by 2002:a63:380d:: with SMTP id f13mr11633900pga.105.1605762108046; 
 Wed, 18 Nov 2020 21:01:48 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id k8sm27722420pfh.6.2020.11.18.21.01.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 18 Nov 2020 21:01:47 -0800 (PST)
Date: Wed, 18 Nov 2020 21:01:21 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Correct the clock source for mclk0
Message-ID: <20201119050120.GA7124@Asurada-Nvidia>
References: <1605752956-17397-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605752956-17397-1-git-send-email-shengjiu.wang@nxp.com>
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

On Thu, Nov 19, 2020 at 10:29:16AM +0800, Shengjiu Wang wrote:
> On VF610, mclk0 = bus_clk;
> On i.MX6SX/6UL/6ULL/7D, mclk0 = mclk1;
> On i.MX7ULP, mclk0 = bus_clk;
> On i.MX8QM/8QXP, mclk0 = bus_clk;
> On i.MX8MQ/8MN/8MM/8MP, mclk0 = bus_clk;
> 
> So add variable mclk0_mclk1_match in fsl_sai_soc_data To

Not in favor of "mclk0_mclk1_match" as it doesn't sound explicit
to me. Instead, "mclk0_is_bus_clk" or "mclk0_is_mclk1" might be
better. Or in case that you foresee some other implementation:

enum {
	MCLK0_IS_BUS_CLK,
	MCLK0_IS_MCLK1,
};

static const struct fsl_sai_soc_data fsl_sai_vf610_data = {
+	.mclk0_alias = MCLK0_IS_BUS_CLK,
};
