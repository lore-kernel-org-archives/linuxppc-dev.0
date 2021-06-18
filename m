Return-Path: <SRS0=hJnm=LM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DC4C48BDF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 13:46:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B9E610A3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 13:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B9E610A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G60Zd11XBz3c5d
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jun 2021 23:46:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=aBPIlY3B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12c;
 helo=mail-lf1-x12c.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=aBPIlY3B; dkim-atps=neutral
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G60Z51wfQz3bvv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 23:46:02 +1000 (AEST)
Received: by mail-lf1-x12c.google.com with SMTP id x24so16766470lfr.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jun 2021 06:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XfNYJ+Xn+C5TMgqTnynW/kGMKelbYeX7G34ZtzwiY5Q=;
 b=aBPIlY3B3I9t/Bb6QizL4BO5Uq5daVIAP8ONYx5ejAWYGtn30nVkpE0OuIVcL86v01
 OEBuLWueTYTM9LFN9UIgL9wNhfbb8ogyeyCqo8cecTttf4aS2yJ3+52ZIidumG6M8Ro4
 93D97EcFwSVRDWL3NPu2KsxpdOerwF9y082vpSCcTehIxCOMzDP3stZ5VMKT4LP4eT4w
 73VGEC+UfPT8whVbC4r4se+RdL+lhSgRu2z7uf5GtLcRfZkRlsIq10lauq8+jOQOUYYT
 dROJmsjNGNRPd0+BwK4JywdLER7UxRZscAl3t90tB7VJoMqLKO3B2Sn60BTbbXA8d6fh
 FDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XfNYJ+Xn+C5TMgqTnynW/kGMKelbYeX7G34ZtzwiY5Q=;
 b=I0ByTwJ5aGJ/S5s1ILoMVYoYXkef5b6ayraJxEsRHl5/b4jMuqTFjWQiOzjkWhZ2+0
 NTiidW+DS0AwascNs6VBjN2s6N++x/TFOtFbMZaaaLMfpw+bKxT7qG5QFrkY2AUh/F9l
 +3KKdNVtAOVsiehsWB35rdDtlUwShgzVCGgGWzdP3dP7wLYeScfpioioQcrfs84szrNg
 6I4YxQHGcWlV0RTky//+ZsZCXVVlc+XH3Zk/TWMWG5Nl1xoSW3okwOFvsw22e8R9TR4x
 w4F8js5zwoXOU691S0nFASAiMjCNriuR3d+SSULNVKdyHC36TM15Nh51IjnC3dOqJxnZ
 QMiA==
X-Gm-Message-State: AOAM5335U2xS3mJY27rXWUIz76X8LY2ipkJBtCFg17MpKerTeoyWofuv
 irHZzUXfxpT7/HAueKaD2MQxY4VY8HU8CZs+jgQ=
X-Google-Smtp-Source: ABdhPJzKUBlUCXaM4pDSgkd4knQq1miSg0a6/u1XLmU7lhiJg2ED3RTISV+7tMeKeWIckVS/fKdebCodLrTRUdeZKXg=
X-Received: by 2002:ac2:4d25:: with SMTP id h5mr3212910lfk.583.1624023952748; 
 Fri, 18 Jun 2021 06:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <1624019913-3380-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1624019913-3380-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 18 Jun 2021 10:45:41 -0300
Message-ID: <CAOMZO5Ao9FipZQQ4oVK=1SFJ=24EPoUfybHMFE7dSpUAR3pLAA@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_xcvr: disable all interrupts when suspend
 happens
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Jun 18, 2021 at 9:57 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> There is an unhandled interrupt after suspend, which cause endless
> interrupt when system resume, so system may hang.
>
> Disable all interrupts in runtime suspend callback to avoid above
> issue.
>
> Fixes: 28564486866f ("ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
> changes in v2:
> - Add Fixes tag
> - Add comments for the change

Reviewed-by: Fabio Estevam <festevam@gmail.com>
