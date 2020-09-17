Return-Path: <SRS0=KYNf=C2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D681C43461
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 09:42:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D022076D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 09:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pay5Fvcd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D022076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BsX7K1m3qzDqMg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Sep 2020 19:42:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::141;
 helo=mail-lf1-x141.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=pay5Fvcd; dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BsX500b43zDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 19:40:19 +1000 (AEST)
Received: by mail-lf1-x141.google.com with SMTP id y11so1460184lfl.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Sep 2020 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7R+wox6CHCxosACtHi4H1wYbWsO0Eq4eZaw9Hzhzclg=;
 b=pay5FvcdkjLjlD4+XXh86WlhyTEwUPXqLQSr9VtABpDbJMoZi10xIQLQI6zjdzR/Kk
 Ys/dm72mWYzINIumOKDsxaHTQIuV992DsU9G7CQ+SvoPopIpDFtoeJpBT22Xox/W5C85
 yR+bHF2A4o0WWJi3ueUdtbTaLiU61/IaUs6eCmh3+UiXsZyL4/GZboMzUk+p5N8gsP0O
 altaRY9ZgMQI/HvWBFTAdk8GWM+fPhoP3eC8obl5t0+qaZKAGS+1fP0S0u4JjbsKXbm7
 niMd1MspC645gCv8jvRhZi10CFnX9/DiVaScyU4Osu08XO1m+z3sxqPNJXZBiU0YQ1iI
 gFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7R+wox6CHCxosACtHi4H1wYbWsO0Eq4eZaw9Hzhzclg=;
 b=keteNxTj/SIJV43XgsJF6vQXIeOicsucxyUKs1bZo9TvB8DuS1iJAVEe17GB+fL84D
 DsK7zEbuugeksHGbsup3xLOWbZxePGcHu+JJmcLh+9A5y7YYBjJsGM1AKfAhLDF2ZxXe
 kx1LzIz+90ysjOG7gyepnGbiKdmxSNwU7ETaVCslvF9GXpjK+Wlf7+UwhQkOz6PBBr4t
 FP/AtGowlrFi+ycCyxEHZ8wy7TilH0K8mANA3qxUfffCHkt4O7XMayulSzOKIy7F4WAl
 JCWC8XwgN2fzzL3X8+KndNmrkJXbPmMucMxTTEbZlo4VxwXdcezKao590mFkqe0+4CNb
 aAnw==
X-Gm-Message-State: AOAM531Wdf/PjxcJIRd0pQgWS7lWdWmGLetZcHXp/SkpI6PecnlU+hHF
 1+awtWLJ5nip63wo4dQxYMlnsZcP9iGowsdKdWQ=
X-Google-Smtp-Source: ABdhPJyI0q2mqx62JEKBMhksq1G60Cikhwy9zmdA6w9fOw8tz48KUx2OY8Bnclq4Mcoyjfvk32HeD2eZW8sBy4MAfxE=
X-Received: by 2002:a19:6419:: with SMTP id y25mr8825139lfb.333.1600335615060; 
 Thu, 17 Sep 2020 02:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <1600323079-5317-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1600323079-5317-1-git-send-email-shengjiu.wang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Sep 2020 06:40:05 -0300
Message-ID: <CAOMZO5AxhrU4=gcUfKL3rU-790k_xE6SzVbdZqYr7JCdUZqGWw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ASoC: fsl_sai: update the register list
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
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Shengjiu,

On Thu, Sep 17, 2020 at 3:18 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
>
> As sai ip is upgraded, so update sai register list.
>
> Shengjiu Wang (3):
>   ASoC: fsl_sai: Add new added registers and new bit definition
>   ASoC: fsl_sai: Add fsl_sai_check_version function
>   ASoC: fsl_sai: Set MCLK input or output direction
>
> changes in v2:
> - update commit message for first commit
> - Add acked-by Nicolin

For the whole series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
