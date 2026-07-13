Return-Path: <linuxppc-dev+bounces-24092-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB8BC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 04:35:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gz8kW1tsfz2xlv;
	Mon, 13 Jul 2026 14:35:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783917331;
	cv=none; b=ir+KfAuPUbQmrq0g2zJygPnks2r+ja2DaUBp2sdHs4/DmEwGPQPkWFpALa1Sf2YYrJbeJ87Ip3reyZu1+9xapYlR+zIFoGsX5RjWamhEP+eIGNfoJ4SGMzj4QEbX7XL7uAS3giBTr6vQUVP79L/pG5f/NJ+D/lxKruDAMsR7F1NPpiUQwqw4HtISMHJPpjzShenqpzxTsXYzPpPgqP8wAt0Um2XWugS1Yxg3sUiMoWXGb8SxoDjPFCZYtmBR8YmdPm3/JbH/WU1Yx+/QrZ8p9nxMkBc29ZpjCPcpewuz9teoBV8/jBB0t+Ec1YtEtyD1Z0PJqS6OcDe1ZN6r0jR0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783917331; c=relaxed/relaxed;
	bh=Evmcp0cx/ey5p8NBBfV63KEI8AjczaUnGJLsFi1w810=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Nne+jsQxtEDLbD7jco5zso4KS1wa7N0YG6wkgSfKCXAkAe1kRtj1uzGjOaT88c0acCK0c4/M6rM6UXcnVU8AwlcvT754cEDrFnb52i7dVuahLubBEgmhsyl6Lsl5UZmV9/NRdB1HUlA8wgoe9g4+sEF+64REz1isHfFxpSsCn0if6Ri5fnz6bZ9hAoXnwkScdSeKZdHdLuMOCpoqSH5tJVnOMc2Bdlu8/UWAKoOT7rZs0llRa2NjbC6ZmQC15ocnWJQ1jenX9R/LeEnLr+1B2fiLUHW7v++4oYXaRBro3KwPUsd0CP3FzdoU4kwvrSEtDXjiCuvcJi87N9PpM850EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DNuqNPl+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DNuqNPl+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gz8kV1V6Bz2xWY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 14:35:29 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2c7cfa17fedso38333925ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Jul 2026 21:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783917327; x=1784522127; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Evmcp0cx/ey5p8NBBfV63KEI8AjczaUnGJLsFi1w810=;
        b=DNuqNPl+dh5qQfTI0+WOyh2cKVIFqUAeBSn/a45qNmZ7io8VHmsB6WO4FnEcc4FAM2
         RcGFKtDc7koLTAmKAi9hDm1cmPw5s0JsgBD/Ot8KgSWG7YRqcU9Hy28UeOWskbha1vvU
         ZSPbpjJCWC/S5CaricTTUgE/Bt2A4eL0qEaAvHKEiII5FAXIKbAtGMNsCcNLEkf6Vthe
         Q08kHN0PJyUAvhDf9J/w6D3gW/fPjc+DHgAKsluV5VLuuTkfkKsheJMUR9Trz9fj4YQX
         aetNxWNhcyHTKLJYFGJXOlX6tMEbd6/mWol/tJhawsFlss5FM2FNwGSVtpUiTlKBQOdH
         D45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783917327; x=1784522127;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Evmcp0cx/ey5p8NBBfV63KEI8AjczaUnGJLsFi1w810=;
        b=fCr348IPIYPEPqQ7sy+nWgJVDc7lOOf90cE2y3rbc7OaElmGbsnhZCF6QvUDwmTfNN
         KsZKXGuH7OxJq6A4US7+hAwWaB3e2C0ZiXWEbnqRKaUxrn6Bj0C4ICqwQJSh3OYa38LI
         jsxEWGw0ounXVDDmIvxrauQLiDBAq2RHj6Rf0OtO/Hh7MkGDen4XFKO9IdAW8NIcl0u3
         AtBIFGodVJLyc1F9biw7F7xnGin7wVbRBFhRsb0zXmovQK/1JsN0FkHJApo4FKXRPHGX
         iaHKjZqupVYNvajuTdJzjpsB2BzdD9N0t5vhOz4XnnWFpfhKrEPH3iuRG+0kebQW173L
         EtYQ==
X-Forwarded-Encrypted: i=1; AHgh+RqFzKuMWihhBDdg5VXtWCtZ54c8u3EKL/GISoqOzckQBSZvKUXOTV1bbO+Od7U8G0oeUMQE2q0kA+Xu7Jc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz11LWw2eWDU/i6w+j1e9B0n0euxlt3KA38Qonu+poqO3Z+cnaQ
	guHuNpZ9zRpssYKnSyI9jmvZkVnvpHN/jTeRSrTSwLC/tFnjK/4ePoRF
X-Gm-Gg: AfdE7cnevtLjntmPeKJXEuI6e5x97IYEpFBlp0cKG2h592WZPv4cZJoyLAn4lnYLeJJ
	cpDo8vn8HKz0k8R4a6b9s3Ag6/jQhySnQ/Ib8DdR3Tm6hD6AyDaA8NyRShvpr0vc0CdsxsB5H9h
	UrVA34E4AvaBv3AFgBUG79NxDc1JyOfm6ANsSsebCaOavD57GRPDeus+IaWERFyhk5cWTw9G+jC
	PwoF0BDIeEUxECR48t5IxnFbMPakdnSpaAayarocCySPQQtDnz2PSsotiPmzxaEOW7FghOytvLF
	daKt1Dac7J/hRBdRj8v3XS/Hawr9k4RTfb9Sw7AloGUs4diK0dNrIbQFSmCG3PMFrT80ToOCf//
	9+ATet2C2TmmRweZLiGhO4sgp9OCVOETaJ5I2TEJ56a0A7251I4GNbJE1KWqSdG5jCfDZY9lpaD
	m/nHE+xED4dV8=
X-Received: by 2002:a05:6a21:398e:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3c11018d907mr8510137637.21.1783917327122;
        Sun, 12 Jul 2026 21:35:27 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm14989693c88.0.2026.07.12.21.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 21:35:26 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] powerpc/pseries: Handle and log pseries-wdt registration failures
In-Reply-To: <20260713035954.1559605-3-sourabhjain@linux.ibm.com>
Date: Mon, 13 Jul 2026 09:59:58 +0530
Message-ID: <qzl7v7eh.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com> <20260713035954.1559605-3-sourabhjain@linux.ibm.com>
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

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> The pseries watchdog initialization registers the pseries-wdt platform
> device using platform_device_register_simple(), but currently ignores
> its return value.
>
> Check the returned pointer for errors, log a descriptive error message
> when registration fails, and propagate the failure code to the caller.
> This avoids silently ignoring platform device registration failures.
>

Fair enough.

> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/setup.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 1223dc961242..bbb2813f8ede 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -191,8 +191,18 @@ static void __init fwnmi_init(void)
>   */
>  static __init int pseries_wdt_init(void)
>  {
> -	if (firmware_has_feature(FW_FEATURE_WATCHDOG))
> -		platform_device_register_simple("pseries-wdt", 0, NULL, 0);
> +	struct platform_device *pseries_wdt_dev;

minor nit: we should rename this to pdev, since it is already under
pseries_wdt_init(). That is generally how all platform drivers use it
unless it requires more than one platform device.

But either ways the patch looks good to me:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

> +
> +	if (!firmware_has_feature(FW_FEATURE_WATCHDOG))
> +		return 0;
> +
> +	pseries_wdt_dev = platform_device_register_simple("pseries-wdt", 0, NULL, 0);
> +
> +	if (IS_ERR(pseries_wdt_dev)) {
> +		pr_err("Failed to register pseries-wdt platform device\n");
> +		return PTR_ERR(pseries_wdt_dev);
> +	}
> +
>  	return 0;
>  }
>  machine_subsys_initcall(pseries, pseries_wdt_init);
> -- 
> 2.52.0

