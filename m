Return-Path: <linuxppc-dev+bounces-20049-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091F6FB44CA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 08:15:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g25P44sTkz2xwH;
	Fri, 24 Apr 2026 18:15:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b131" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777018520;
	cv=pass; b=aH1Kn+t+/JaMUrjqw5xLHTJbve/39+v1T/AXID4WVDCe0F8eu6EwmYpivbsJpKD/s8QzuByzT7cK+96RClco5BEhO/XG2i5jDM09BFD/oH4L4CUekuJoRIekoHapNimp3mPSZBb40IKbzhUfcqpXG/nQ0FOE2HrHMJcffCIYafbGGjiV4Kw21hDddo35fYYk4eYxYoNbOj/pyog2RFo0GszD+sPPfNlUlykO2dEFULOpIF4ZslAjYw0OS/Ge6X0cxXR0xuQ178vJsoj6lBxuGwqVCMUILqiZ7RwTuleG9nFE1+YHPLYuX4exVdkxuQ74ALt2HTv46XD/j6gYGms55Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777018520; c=relaxed/relaxed;
	bh=XoTQ4s/qNuwga1dSku+5JUJ8IacqDxrPAbEtqeudZ8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9/W7KqkGbx7RMLgMagiZVubcnVl8MRUQVJmh6llJw7y4hbg2rvLaUk7O1i60sa/6byzx8ifz3tO/Ux1u+Eo145FlpXJb9YLnC6dWGm42YwX+GmjmNqfXIfEP8f1zHkfeVWHZDxoxCBpTClkibiKHtHkQDNgsUE+fqaE0UhOLpkobp3xlGK/tw4Bckg63QSMMWD6nztAMiQHdErb7C+JIZfufbRHCqxZ83/VfNCaWoFE5Z8yR3WsX//EoWJZPRTC1pD+0bN7yrNb7z/YM9/CBuU8jtYcTSn/zhfwfVsgNtDOivhAPz2bUXKbrSyTz/CllZUcY5Z1Qfikqrbs5+/TZQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NApUXd2r; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NApUXd2r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com [IPv6:2607:f8b0:4864:20::b131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g25Nx6J8Pz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 18:15:13 +1000 (AEST)
Received: by mail-yx1-xb131.google.com with SMTP id 956f58d0204a3-651b4d09141so10204790d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 01:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777018511; cv=none;
        d=google.com; s=arc-20240605;
        b=JXQnkMWrSZy4GME0p3LBD1/AAtvEZycnXhqvWW1plPZDdAsoMbvYCeVRXT4Wat484Y
         iKCn9ZgYReh6aI2S436a6wy6/7ULsOA4YIgt64tsSgNxTz3zv1SxVNMs8gPIQgZEt1iB
         8GMT00DyvAXUDLqE8v74QAdesB+9uJoZvlqhnzvfccjsAH3bO+SSgB/nBkDePmJxJfgq
         hteJVh9GfsQ1FWFJJaI4QZB0ZXDX2a3phN9azxszMjc3dGL5RlTwfFipOv6GrfSz1j9+
         tah83gAOR/HzI2ikGbwli7vpA+6zc4bLyagf+xLDm4caVae6m95b3833vE4JPWL2yQ1X
         x6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XoTQ4s/qNuwga1dSku+5JUJ8IacqDxrPAbEtqeudZ8E=;
        fh=5+XltSyDGWNj6OF8HXrDD+zIqHHS09zgcRlbGGJF1eU=;
        b=gPlEfUntZb3+mQt8IXKFvfA/6kc7e+Pt1KO2eUi3fs0DfqyvMfhJHkeYRHNHtxQUhp
         KHnv79utN9UrLVmJ0OtTpn1cSne7HeQboFHRN2zVxu4otfMA0LKxwcuxBMNAIeNMoeP0
         Rq2V5ebrcTPx4QjsVRsymuug20v+W3m9CuDYsz3nZ9soKTzgFX5YKN5JimlOFM9eUSZK
         4QlrHvjQ7iUyjLBDSVZ0blfqTntN4/iY6C+dz3PrfY1bB5GqXAs2qxoC8c5XNBVivQGk
         C5wBl36wuLugaXp5TdlrWYcVlrVlmxsI587Mc1ncEQlHT02qAklNAxGHGyeTPHazBgQm
         zgfg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018511; x=1777623311; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XoTQ4s/qNuwga1dSku+5JUJ8IacqDxrPAbEtqeudZ8E=;
        b=NApUXd2rhM6k7sTGFUxkYhIZw/ktop0DGXp1xBiKYi5boZ1vk8S3BuLQRvwOXrPjdh
         wWU62vG9Z8EZHVE4p4ZRgKqmQTCLRicoycMd8zobLGvCgZnPohSAprGbeFE4RThfq1EA
         Pzhc9SwP5gjC7nMuOdrDTk07kGOBAZFmCW4qDrgoDGPOXg9cncnA8sDO3ZU5u7/LNf5O
         EKZVAE17DWBnWkCr9OlGHcikdKbpEcUoflih4nskYiyI5+xXYSUVPKfXq+NRpJOff/Kl
         psNw/xlfWYXNKM+UE3vpNw6mwE9awoWo0C7Z5xaxQrx4WvKScs47vtHLsvBNGMXTBhe7
         Dl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018511; x=1777623311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XoTQ4s/qNuwga1dSku+5JUJ8IacqDxrPAbEtqeudZ8E=;
        b=DzvoKqldrxJ+4NgeXaBYuD2CCcAps2zJNEj01QtdE9u8nGU4sIP43qKVARQJxKR7je
         ivsmV3MSPjXYBr3iEdk0yqGz/KxmZhw2E1MnkMuNO9rzjglkF8OEzMVEYG1TLPtOmx1g
         IJdoYTnb3Qwo3/jJKbL59QV492F9eMf0xzAv+rhOr+OBvXLzMAx7lFJRLrj6O7cI8H7r
         S63fHCNrObYgZ241azq+K2edjHN6fh9icP3jl+LFOe0NUtJB3upFQSm3DqhlZbA0AqUg
         h+jF9DJIu/HnI8Wf+CivLKFm6qX84mV1lJhyC9tCM+agbzJ8/PtzDt5IirkVhArn7CxU
         L1rA==
X-Forwarded-Encrypted: i=1; AFNElJ9hREmxJ5nXVSnWBYL41Qj22xMQjTDniYA+mwYNfmX0Weuv80q+dBzKwyeIg4RA8hu1yX1cymFaggGUa1o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxJ38cT2nQrxAugJPh3VVh+RZq6VcNvR+XmYLWEx//u6Z+4Slde
	WJ5R3hBWtKYv+VQMRQb8qZ6d+RA4uP7Yy7SO8UqkrO922W0p4UGzjWp6PdqdL6uARHnttnK3NXN
	gKMffbJj1iSDtIPPfKoH4NgQKNfGrU/Zfcxzp/ZY=
X-Gm-Gg: AeBDieunITEa+5eWP3MJ5iKVd5HvYocMmdqA6O3+7MqNT4L58dZXik78+CaNwqHQhGQ
	kJ3nnC40HWXJQFeSOadH6iFNb5hFASo8Gwx8V1ggYOnH9pcl8nHOFUurp9LCbJMIoR79dQKBZ8G
	sJj287JAvg1nPgI++qK+/BCL0gpxroela+/s6CN9kzlt7Sq1j0hOGmMP1iRxNIY/I3ltefelrGV
	o74/Vti5ywiTb7zyt/H1fC5GlI9QggZEyt7ski1hHqiDn40x27nqLXPy7TbpJ7AupdcsADbNk2n
	3h0UZqB7u6abMF8lNwOa
X-Received: by 2002:a05:690e:2486:b0:654:3fca:3515 with SMTP id
 956f58d0204a3-6543fca3bcdmr7674478d50.30.1777018511504; Fri, 24 Apr 2026
 01:15:11 -0700 (PDT)
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
References: <20260415144635.3318697-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415144635.3318697-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:14:56 +0800
X-Gm-Features: AQROBzAFZKMpsNmPGDIOC_UCfbe-Rxj_nU9Bws4LOoucZmHnDsWY6cx-wzEa2m8
Message-ID: <CANUHTR-CH=rfsfm5ezNBHW__4d+TU-EVOC7M-vDkf=nB-N_mkg@mail.gmail.com>
Subject: Re: [PATCH] macintosh: windfarm_core: fix reference leak on failed
 device registration
To: Guangshuo Li <lgs201920130244@gmail.com>, Paul Mackerras <paulus@ozlabs.org>, 
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please disregard this patch.

On Wed, 15 Apr 2026 at 22:46, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in windfarm_core_init(), the
> embedded struct device in wf_platform_device has already been
> initialized by device_initialize(), but the failure path does not drop
> the device reference for the current platform device:
>
>   windfarm_core_init()
>     platform_device_register(&wf_platform_device)
>       device_initialize(&wf_platform_device.dev)
>       setup_pdev_dma_masks(&wf_platform_device)
>       return platform_device_add(&wf_platform_device)
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by checking the return value and calling platform_device_put().
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: 75722d3992f57 ("[PATCH] ppc64: Thermal control for SMU based machines")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/macintosh/windfarm_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/macintosh/windfarm_core.c b/drivers/macintosh/windfarm_core.c
> index 5307b1e34261..4003e72f3a57 100644
> --- a/drivers/macintosh/windfarm_core.c
> +++ b/drivers/macintosh/windfarm_core.c
> @@ -436,9 +436,14 @@ EXPORT_SYMBOL_GPL(wf_clear_overtemp);
>
>  static int __init windfarm_core_init(void)
>  {
> +       int err;
> +
>         DBG("wf: core loaded\n");
>
> -       platform_device_register(&wf_platform_device);
> +       err = platform_device_register(&wf_platform_device);
> +       if (err)
> +               platform_device_put(&wf_platform_device);
> +
>         return 0;
>  }
>
> --
> 2.43.0
>

After re-checking it, wf_platform_device is a static platform_device and
it does not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li

