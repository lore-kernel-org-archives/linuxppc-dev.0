Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D357C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:30:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA2320880
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 10:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olFm+e9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA2320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444rN35p2yzDqMg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 21:30:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::343; helo=mail-ot1-x343.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="olFm+e9p"; 
 dkim-atps=neutral
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444rLP0ctCzDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 21:29:15 +1100 (AEDT)
Received: by mail-ot1-x343.google.com with SMTP id n71so44433169ota.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 02:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bhCe24l3A4F59mW3RK21YuUiBMI4gqihwyAACFuP6V0=;
 b=olFm+e9pZw66NSlPn3o1stsKPVf+DUnkKdxeGXALygAhjx7r9WrxExabB6dLGHWoEw
 ZGMl+WMXw3nl9gVGt/wrwOUwrCgJbl7Asi9qhy3s5HaP4EtZ9kwVNL8PLB97qsgYu8nY
 MZ18k6EVPWhRwGnX8lou140jAghhNTH8nIZz+cDI3wpTfm+1SLtM5tIsdy9yXkmcCT70
 mYZHAKjs+IJ0GizvwFJdJiyyyrrdcfhwR0DxsiJj5SL9ziiC8bitaGO4hHsaNXkeFpqS
 4aM9or6Ufli7pC5k+mMFUBPM+ys+6ejTiX0FPHq1rVkarf8XP5A+X90ZLkHQ+j2HN82K
 nSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bhCe24l3A4F59mW3RK21YuUiBMI4gqihwyAACFuP6V0=;
 b=b+GN83BUrK3EiF0qDaNRdS96bZ3wm6REUTahLQk8gKqJjY66fJ4PmG6VwN7gh9R69g
 L93XaEyv7MEMTXUXk1UPXXBSGDLFYjk6uk99Lz/TQlr/8PF4v/dOjiwQA/E+Fb3Q4J2q
 nMLrrnjKTNxvdrFsXISENsPtO0ZZqxsCnZW2c36ExMHtY4VINS+9FBXBUXL7N1TvSGB7
 LfjiZ0aGW5IYvff4iSJ1diooYrAQ+VYbjf8jn/iutdhRF0BX1oD+rXWyax3GHYJTfZIo
 vDLyAEeOV8da9xFbPRmfj+7ZB9C2Rdk+BZoMEa9shybc3wiWXiaobwKvGW9rMgbL/RCB
 Q5jQ==
X-Gm-Message-State: AHQUAuZTMmvCeMX4H5uJslGD9XpKHr+YgiJo41qgQGdMvJp9tx6LZTXN
 2p7RewPVO8vsJKmn4QCzou042kfL46hrehx9Jko=
X-Google-Smtp-Source: AHgI3IbAZppAdkAm8jj9J/PKYEAg0RYcahTawPA9fPiINapeqtdrB8yyPjQyJisPAk2baHkkYsOMlSBwr6uk3ajoW8g=
X-Received: by 2002:a05:6830:1547:: with SMTP id
 l7mr21031895otp.196.1550744953162; 
 Thu, 21 Feb 2019 02:29:13 -0800 (PST)
MIME-Version: 1.0
References: <1550742787-3268-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1550742787-3268-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 21 Feb 2019 07:29:05 -0300
Message-ID: <CAOMZO5A-XCxtNmO5+JM+9R34oh-dYUD8ZHynCUE_p_Q-kjvR0w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: fix channel swap issue when stream starts
To: "S.j. Wang" <shengjiu.wang@nxp.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu.

On Thu, Feb 21, 2019 at 6:53 AM S.j. Wang <shengjiu.wang@nxp.com> wrote:
>
> From: Shengjiu Wang <shengjiu.wang@freescale.com>

Better use your nxp.com address as the freescale.com domain is gone
for a long time.

> There is very low possibility ( < 0.1% ) that channel swap happened
> in beginning when multi output/input pin is enabled. The issue is
> that hardware can't send data to correct pin in the begginning with

s/begginning/beginning

> the normal enable flow.
>
> This is hardware issue, the workaround flow is that: Each time

Is there an erratum reference for this issue? If so, please add it here.

> playback/recording, firstly clear the xSMA/xSMB, then enable TE/RE,
> then enable xSMB and xSMA (xSMB must be enabled before xSMA).
> Which is to use the xSMA as the trigger start register, previously
> the xCR_TE or xCR_RE is the bit for starting

Please add a Fixes tag and Cc stable.

> Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
