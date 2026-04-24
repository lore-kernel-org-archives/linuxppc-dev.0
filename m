Return-Path: <linuxppc-dev+bounces-20048-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7D7FB44CA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 08:12:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g25KZ14pLz2xwH;
	Fri, 24 Apr 2026 18:12:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b133" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777018338;
	cv=pass; b=ek4pQ6dRaLhilfd/NHniKcBPBH0YX7piQ1GRuWxZ/3IcCf8fDXUaSTLVzQKgqKuiirJuBq8UWyO3zy/7ljNW0z0W0d/HJCASq6mxM6Q6VHsrWv4I4ypxV6cauPXqZzUt1kuv0FM4vFJVnXsxEWu+DBR5invOQukAcJc8Pxl5Jfy7vxa5BWksr5DpS52VjxRTX15NILBZopUl9EFVi1Oi09MD3FUgrx1atmb3qEwH275frvtp+YVrk9E8bq+qPQkPf/9lojD1OdYuv6QctB98lGQ7InepO+hOcldHmSeuTngo0QrmmaFjhGAv+jKGNT2JTbauphZB3bpObfTn8kyICw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777018338; c=relaxed/relaxed;
	bh=PghHXsaUvPB2FGmxVpPAYNm3E4Qd+tT/tA4p8BC2Akg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dK7LGaUhAk3ZqwQwEqKOjDOrZZyivzXgjIZqkZyjMw1n+e5iSUklj95JTNaenFvzA1QJzrmOoN0gSot/gRXteF3Jlt2YkhnlKYNSjJ7eVDtxD3s/7hcC0sMuTSujeD7mQ8wEs4+pDHwkLzx9aMxFSqbYuD3LAV9l6nYrQFfF+Z59s7YVFeUWZ+Aqvfk2vhAmn0pfAqlAO6UiDyybcQ3hUGEDYf9HQgu1DnXsIfgTnTvR3gPpfNk9r7IRFcuGtL+qUhj1ku+iCHxDJQPGETRv8pCVFRDW3QZ7R6g8/wRwTBr+bLFhfh98KoYaCisTsb2LNTCQVEOlriTrwGCUZtYQcg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S7xDWJfb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S7xDWJfb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b133; helo=mail-yx1-xb133.google.com; envelope-from=lgs201920130244@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com [IPv6:2607:f8b0:4864:20::b133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g25KS5RYSz2xly
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 18:12:11 +1000 (AEST)
Received: by mail-yx1-xb133.google.com with SMTP id 956f58d0204a3-65075c2ba66so5814152d50.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 01:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777018329; cv=none;
        d=google.com; s=arc-20240605;
        b=JdtOaJBBMCy1i2lU854nwsUKQ1g0ajw9UIeTgm02rZJhVIQ+ieQ35XfputuOvmFwrR
         hX43i82Z3RjSfBPKfz773dby20xWcsu+5Z1q7er9tZ2XgWo8YU9Ue191TnGoMuSJeg+y
         oaYHfwCGqXpxQBeH03kcJF6y5XOMdZbucUDd0ykn6DA3DWPZRGEeDxeTsVfUXDT1ADZ3
         7E2lh7hSN5/S/ETQcEZVWAatR2MZbrgpxxMUfzTL1RppM/Kk/Yv/x8DnsEp+BKD74pGe
         /xWq9sqwQBVkE1RXaplQvZ0HtHnRrv1/pgeIOc+KVoxzHiLaA8jqJ6PS/eWPuzxc0ArY
         aPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PghHXsaUvPB2FGmxVpPAYNm3E4Qd+tT/tA4p8BC2Akg=;
        fh=2s4zQS0jQ/gn5Nc4JPtQyVwpfjhq+tZ5FMD4poHFgmM=;
        b=LRmyVDckRx8tRS9LIhnNObk960E8B9gR85un3pkwqVhxx3yPXh09jwknmlWfZn6grH
         rlFhjfJXkRTwfng6f2OD0XddQ1aYHo27GAD8ZvVXIT8uB7C8uXLDpHSosVKFKK84hoSp
         mDFMGOQg3lgGt8/+SPlydYPKESIo8LrLkyKVbi5XigQbQ1cD9XpZ/uINFlmk++331dgA
         39cdGTzUXMyJ128BZ4qGUVVKVaj9ALCkTWTNHPvpvS4jVd4Z6nhDAeAny/w2k1Kn+I7o
         00LBwRi9hfL13xaXZSHkk+0f5TPrGIpkSBqFRY1emQNwA5/Vbk9Ny6qcm/FxUFX57bGk
         ySng==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018329; x=1777623129; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PghHXsaUvPB2FGmxVpPAYNm3E4Qd+tT/tA4p8BC2Akg=;
        b=S7xDWJfboeUWRK7+TBzTKvgBSxkD782c+3pLputvy0fp8Sc2svdVLXV2C0hPYxcIpG
         FgU/Q5ijkdiH3pmN8uOCViQvBFJU2QchqZ39hQpKoIXC5Mm+V2YRiX0T5Q8EL6pj9+yE
         dPQ/QwBId2NTbFRwUZeD1NAwsig7TZ7Yj8BwbNlxiBwU5c1Jhcai+viIvAnMa621obu4
         GGBzkkh/w9q7EGwTU6q6HX67cH5cAbZS0t+5cmpUkQ50+YB+CZumrR7Ye4l7BDGpUTkL
         WYYKHKkBk44kuXytZXfSyO08iqq44QCDWV2gyRvxcR1oAg12Ksgh3WSMOcMUgF82x1sq
         cbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018329; x=1777623129;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PghHXsaUvPB2FGmxVpPAYNm3E4Qd+tT/tA4p8BC2Akg=;
        b=ULyGbScNTFuVkXDL6Soy5SuzUowsZPrp09+wUFk9IhLP1XErdSt8amhpSP6hovsUHG
         BiRr1vfgXQJjr9fUmk3PCaJuSX1qpPtGZ9URD5EBp9GGNCZaEq8UqDhWozg98DF0o2Yv
         6n3w2BED5l+SinbkisES/hUHbZLXNFC8HzD2y0VNVMeCs88OG1CI31ZLGPA/Ie31MCE+
         Vh/bP+p3oBmjdNmu8jufzJL4qaaiH/NNLg+TkFpIbr2Ubc1uH2VRsb6wpH77WPgdsOuP
         bB0NsUK7q7xjLHOuyPL3JrSaFpe+fskj63rgmMssXTxdnVrorNNFufr3JjY3xhcbAG3I
         FTGw==
X-Forwarded-Encrypted: i=1; AFNElJ8QUKKTTZ1DlXd3Oj1RksFtfuQq9kvQcvqwYFK6d83d9TOksLq9gIzAHij3y4pcJht9LtO7yiI3FHtitEs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzrPxp4UievKxRNjkAyi+OYoo0CyFAKfYv3glpSxbrjy+/sW7Cy
	VBJ8V+cXcaR4ScwMWiNYwnQX0LTIlUPKTP3cDOnLhC3VwxSmxQaJyY3ZRRBFcpX+zeCiY4flLUS
	vQKg1ISci+kAKFtkoXTcFGoMV/8w6gsQ=
X-Gm-Gg: AeBDiesJ1dIkCzZJfJiHmYts4GsaLfm5rwcj/wgn5Q7x34I7SrckZNPmVA5Qhx8hFqR
	L2BdtPpKKBQhWtp6qHD0B2v47eeDduIkzx6o+gHWJCVQP8aP/ab1K8HIfC86jq8MkCwGHsJeYp+
	tFtc8HgqYuYwT4/x/uyIPU+CIC2cKGhRvUWkwiD/N4P1lUzwQ9EfaiYDFWvC0KoYJa2+JKGQbt6
	vr2ziAARlClq9+IG1UAPIzq05tShuBFl+cZGODnyaH4qFaWmCOIb33aths8x7yh0Ig3W5CledVj
	H3Z6c0c8i236INnDnEl8
X-Received: by 2002:a05:690e:4199:b0:64c:a0c6:da93 with SMTP id
 956f58d0204a3-6531089af70mr25686233d50.28.1777018329042; Fri, 24 Apr 2026
 01:12:09 -0700 (PDT)
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
References: <20260415143701.3309681-1-lgs201920130244@gmail.com>
In-Reply-To: <20260415143701.3309681-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:11:55 +0800
X-Gm-Features: AQROBzBc5qXvUTrDC5JalkEZi1O-Zxl9G-jCas25GxZKqJns4L1d-RV9sUSyvKw
Message-ID: <CANUHTR-YL+ZBWA13vYgOfs-YjKRyG_60ZjFbpPa-Dh8P8Mixmw@mail.gmail.com>
Subject: Re: [PATCH] macintosh: adb: fix reference leak on failed platform
 device registration
To: Guangshuo Li <lgs201920130244@gmail.com>, Kees Cook <kees@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Paul Mackerras <paulus@ozlabs.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Please disregard this patch.

On Wed, 15 Apr 2026 at 22:37, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> When platform_device_register() fails in adbdev_init(), the embedded
> struct device in adb_pfdev has already been initialized by
> device_initialize(), but the failure path does not drop the device
> reference for the current platform device:
>
>   adbdev_init()
>     platform_device_register(&adb_pfdev)
>       device_initialize(&adb_pfdev.dev)
>       setup_pdev_dma_masks(&adb_pfdev)
>       return platform_device_add(&adb_pfdev)
>
> As documented in platform_device_register(), the caller must use
> platform_device_put() to give up the reference initialized in this
> function when registration fails.
>
> This leads to a reference leak when platform_device_register() fails.
> Fix this by checking the return value and calling platform_device_put().
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fixes: c9f6d3d5c6d4f ("[POWERPC] adb: Replace sleep notifier with platform driver suspend/resume hooks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/macintosh/adb.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
> index fe150125e099..eff06f78aa80 100644
> --- a/drivers/macintosh/adb.c
> +++ b/drivers/macintosh/adb.c
> @@ -883,6 +883,8 @@ adb_dummy_probe(struct platform_device *dev)
>  static void __init
>  adbdev_init(void)
>  {
> +       int err;
> +
>         if (register_chrdev(ADB_MAJOR, "adb", &adb_fops)) {
>                 pr_err("adb: unable to get major %d\n", ADB_MAJOR);
>                 return;
> @@ -893,6 +895,9 @@ adbdev_init(void)
>
>         device_create(&adb_dev_class, NULL, MKDEV(ADB_MAJOR, 0), NULL, "adb");
>
> -       platform_device_register(&adb_pfdev);
> +       err = platform_device_register(&adb_pfdev);
> +       if (err)
> +               platform_device_put(&adb_pfdev);
> +
>         platform_driver_probe(&adb_pfdrv, adb_dummy_probe);
>  }
> --
> 2.43.0
>

After re-checking it, adb_pfdev is a static platform_device and it does
not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback
warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li

