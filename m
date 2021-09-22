Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DCCC433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 00:50:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE5761107
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 00:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AE5761107
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDfq045YBz3069
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 10:50:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=gvliHsAG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::130;
 helo=mail-lf1-x130.google.com; envelope-from=festevam@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=gvliHsAG; dkim-atps=neutral
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDfpG0510z2yKF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Sep 2021 10:49:57 +1000 (AEST)
Received: by mail-lf1-x130.google.com with SMTP id i4so4927308lfv.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2021 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tv5fKXYIZFS6wZNDvLpQ/fgZXC/CC1mUDyy/EpfS2IQ=;
 b=gvliHsAGaamg2kIqxz+iSvyn3KlgExNAnhHohYx+L+9g0NRuaER4y6/FG6Ryd0OcvT
 eWRLv1FZg58RO3I1T7nFEzpnS/gJugOCEnvjc1Db8eZf4hh4a0LwmU0bbdodoHHEe2a1
 QlJoJYqHHT2x+NFvZA1Ym+grW0NXCb7gNEzbHjdNlYtbaM2Ui9JStiFyAmhmkeQ9Ldfm
 uKD0UwM6CNCY3IC4xH25sZgUiTO+ybw/3vOW/9+lz1jwtf1e4rub1M+UZ0/tJwkuYh+K
 R2W+1W1i+2MI10K5wX0btzuWdceTtoZqZNW+aqxyVpHvCVMjbR43CcoK1WZKcmb/M112
 9eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tv5fKXYIZFS6wZNDvLpQ/fgZXC/CC1mUDyy/EpfS2IQ=;
 b=1fKcFIBTyjI/91PWsmB2pJQv7qd8KjeQwFVlfSED/H2GsliWb3SgKxw+xHukNljn0z
 Zm1I2qrf8qcRED7Vm3Y1NrEjrORlVZKo2kDHxRA6D5eG6MLE4fuP3Od16eI8hyrVPAJs
 8R5wP88/zwC5lUIy47UBtGa06HSEXthtMmvBMMCm8HtFySIZel7ltByyTp0fN+ZLfZ/8
 1pFZKNyer9ZYw/8Fy9bfyBn90gNSzEA+yLMrpOpGP6f/mORDNKzrKJoj2YTJxftCgX9Y
 QslWvRdBp4nk0mzzxONkzviZQBz8cKHbJhjicWtrohiE8AEdbd+FokXjw/TDUqxaUj/b
 D09Q==
X-Gm-Message-State: AOAM531RMLWIgfCj8gGCqClGxqiiR7eDsOTjmJEdFGEPLM26B1qwK7YQ
 LRyHWo9OYtsYJDQ+ABzJXEZ67zruvzcNCDQ7t9w=
X-Google-Smtp-Source: ABdhPJxxU59HXs6mR34sthMZMwwR1+DZTFwjJbrtlJqcbZfLIISBVBHlBwKlvYbIqKio5zDNru+hyKtg4SrW9ETSnEQ=
X-Received: by 2002:ac2:514e:: with SMTP id q14mr25636935lfd.154.1632271794190; 
 Tue, 21 Sep 2021 17:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210921213542.31688-1-broonie@kernel.org>
In-Reply-To: <20210921213542.31688-1-broonie@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 21 Sep 2021 21:49:43 -0300
Message-ID: <CAOMZO5Cu+dMSTioN7-16BDKE3g-mcs+hERJ-sbG23PaT-EEhxQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] ASoC: eureka-tlv320: Update to modern clocking
 terminology
To: Mark Brown <broonie@kernel.org>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Sep 21, 2021 at 6:36 PM Mark Brown <broonie@kernel.org> wrote:
>
> As part of moving to remove the old style defines for the bus clocks update
> the eureka-tlv320 driver to use more modern terminology for clocking.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

For the whole series:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
