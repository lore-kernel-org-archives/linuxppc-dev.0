Return-Path: <SRS0=LYYN=BU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE615C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 23:16:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68EF8206C3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2020 23:16:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxfbcYL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EF8206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQWzp4xcdzDqSZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 09:16:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::442;
 helo=mail-pf1-x442.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=DxfbcYL8; dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQWwf19QczDqJm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2020 09:13:21 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id y206so6565443pfb.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2020 16:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=b5OYueSLJAlabAdhrq7Fym2M2F+FohXn8TYzF7kdpcA=;
 b=DxfbcYL83VI2tavwmTPi4J7eMSAsVh5SiXRXgr7w6VpnDWom8eqTPeZM8kNx8aL71a
 YNZoipg4ai47uUfLCO0TnZ91g/QuIs8WREnZk/H0YzF7U0oi4AVYSpa0/AhTDktapZMm
 +cqkDu7gKDDEZg/oD43W+K3+eGJVqa6jxoEdOXuiHP6AMTsB/rnpkSev/8TXRtRBlLNJ
 w+SE3h9I5KCD64mEmOANa/VzYKCKJc9fdAP5BwCZnjSMApRtpocutZiNjy9jEeV/kyDK
 uwQQaxAS9KK+svH70uw9w6/i3VlM0a7nFuMa42dpeHI4vYLfebLjf9P60kMHU7i6p/hq
 rl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=b5OYueSLJAlabAdhrq7Fym2M2F+FohXn8TYzF7kdpcA=;
 b=En8kBVPdGpdPHffWw9y11ytepcQKKEReQYeJOiUkjT6Qf6NeMWhcwQh1y9KAwGXQQu
 Y+d6WoJkzleNjPmPyIDHYAWyehu+JKFZ1bD5VIZxOS2UsPspPVqZh9uZbobfQ5fQieZA
 tqQMbOAq89KaseCFMjIAmi4qFDHmlidhpWib3PBukBVS6DhX0UiwlvhpSUvepKJ4tZ2A
 7b0k8EWYD/5nWK91gCwUt1d/hEt6Nc9ykgK4YYg2ZB5PZJT7nJDLQAiTMvZhDtXTleAR
 d5ETgxQ3Lwlv2WN9ucENlkWOoMau7ItEomFhXL7rnrLVHy//jwjJekT65VSS/HeD1nNF
 g+zg==
X-Gm-Message-State: AOAM533BRcnEzvMF/ijiSHHAZByd2oaAtNWxEV81GL14kpFkCBegl8p6
 NRfsWCqB7/irog0GtlnOCVs=
X-Google-Smtp-Source: ABdhPJxv/TJg5AlqUpTIn9TvhqOmpz9wa9cBMbF4+XxBG2Uvfkj7gl65QPxHpEMaYIt+NDJjbmpUrQ==
X-Received: by 2002:a63:3850:: with SMTP id h16mr23683492pgn.218.1597101198635; 
 Mon, 10 Aug 2020 16:13:18 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
 by smtp.gmail.com with ESMTPSA id 193sm22875595pfu.169.2020.08.10.16.13.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 10 Aug 2020 16:13:18 -0700 (PDT)
Date: Mon, 10 Aug 2020 16:13:15 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Get "extal" clock rate by
 clk_get_rate
Message-ID: <20200810231314.GB16645@Asurada-Nvidia>
References: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
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
 linuxppc-dev@lists.ozlabs.org, tiwai@suse.com, lgirdwood@gmail.com,
 perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 10, 2020 at 04:11:43PM +0800, Shengjiu Wang wrote:
> On some platform(.e.g. i.MX8QM MEK), the "extal" clock is different
> with the mclk of codec, then the clock rate is also different.
> So it is better to get clock rate of "extal" rate by clk_get_rate,
> don't reuse the clock rate of mclk.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
