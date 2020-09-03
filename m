Return-Path: <SRS0=NZKl=CM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBAAC433E7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 03:33:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761D32072A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 03:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh3AakFc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761D32072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bhmc35JdmzDr4D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 13:33:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::443;
 helo=mail-pf1-x443.google.com; envelope-from=nicoleotsuka@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Lh3AakFc; dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BhmZ957SDzDqw8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2020 13:31:45 +1000 (AEST)
Received: by mail-pf1-x443.google.com with SMTP id u128so1097500pfb.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2020 20:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=jVbQJV7FQRWnjXc4WFRtSyL4necLOFwK41hOpTt0Y3c=;
 b=Lh3AakFc2ktTayAXJ3pnozs/7S5cR9pjcLsMH65p4Oypa4yVlDrB9sxuRsvs1ZqnJf
 m4Q0T8KEeVSiLJk58AEEWBzSDM22WlwCsu4r4uQ95h9GjGMNX3XSWrqAFEsSskncgFZM
 ZThvCDfsFIa0zcXzx+ihAjyoiDVREI78q1NU113ynXd6tHcph1oO0oWBDRxpkBAdG/Ed
 5wvVArnBumGOdJcZFzgCNkqry+qjE/zQjZv0i8Sk4f7qiZfT39t+qUXyf/Dcy/UONlin
 L/2zLZHpqboem355bgN5gcnEYmbfmbqBCBe+GU/vMmSTFIbKgsK/Nl4Z+5Utskgx5iic
 D6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=jVbQJV7FQRWnjXc4WFRtSyL4necLOFwK41hOpTt0Y3c=;
 b=e7wI40iknUyQOCQ4VjrfX1e2yLKIYL3cu0jZEFfTZR8TNvz5M+7pqkd7nKgLKdS397
 8vL3nnTofevDPECD1t8Kudmj+PNJZPpwJ81Odg2auH0g0XuQNdPjPQqgQv9G/qLvIY6C
 zNWex0algNs1dYAF0kVsooaARYimnm4crvo35BzsDZXkVzy0KMIHl4kPgLZaaw2DHiXO
 smBPg8U6SCUBAzntRRItbnQERCGq3wevIFBaPEmOY+zf1KQVIi6sIxddgLLXN+YSKZSW
 djYWpPBqmoGPiBEg/MMsGWhkpZq7mDN04hnHuuSqZgGu+2OR8Gllql8OZnhFQLsS21MN
 xGgw==
X-Gm-Message-State: AOAM530fSUXtSBzTu83BX/yY4G3q9R0HiorVqrcZ0w5XXnPxwtvQ6ocg
 YOQxu1hYgdCYpxM3q1Hz+wg=
X-Google-Smtp-Source: ABdhPJyeeNghFiK0krO7HS3KViJMyxOmRd6O6x+am6iTWrNYXrgGQ1ZUoP1V6uOaTIiWadIkyIrllw==
X-Received: by 2002:a62:ea01:: with SMTP id t1mr1699823pfh.125.1599103901928; 
 Wed, 02 Sep 2020 20:31:41 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id x22sm1047250pfn.41.2020.09.02.20.31.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 02 Sep 2020 20:31:41 -0700 (PDT)
Date: Wed, 2 Sep 2020 20:30:57 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Support multiple data channel enable bits
Message-ID: <20200903033057.GB4517@Asurada-Nvidia>
References: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
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
 lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 perex@perex.cz, broonie@kernel.org, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 01, 2020 at 07:01:08PM +0800, Shengjiu Wang wrote:
> One data channel is one data line. From imx7ulp, the SAI IP is
> enhanced to support multiple data channels.
> 
> If there is only two channels input and slots is 2, then enable one
> data channel is enough for data transfer. So enable the TCE/RCE and
> transmit/receive mask register according to the input channels and
> slots configuration.
> 
> Move the data channel enablement from startup() to hw_params().
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
