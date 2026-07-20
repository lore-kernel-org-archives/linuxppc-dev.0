Return-Path: <linuxppc-dev+bounces-24568-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C47AC44520
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 02:18:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h41Js3Hwxz2xqJ;
	Tue, 21 Jul 2026 12:18:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784556150;
	cv=none; b=AAmF+dnQDdR1kYnuIODPmhf0UXCNzoYF7ONJXGZLmwTGFIxuGzAF+DcCHOcIjo/WfOikrT51QUxQss16GVIQSpklN0GWYxyyLxImTL4DDD3YeMBFwvOlti2A+e/F1kYeiuKvmyNDOCWKSXgRsstdxDHSMKIhz5qTrBfMdIUT/6UDLguAnzIiXfNkz4ROgJ/63TJtJ1dYcNyPxu8SFsj5LQW+ACDPOesvwqStyYZicqs9+SAsSRd/UKPICh3SlCoW8kMgE4oxHbZoLsu5I7yEEYMyBmgUGPYGzhbMVnPLGFALpR+gMSyVM1U2frE4sI26kGNPk17ubS/5gkuBABFMKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784556150; c=relaxed/relaxed;
	bh=jjgcDbEk+UwGPrm8p3ddZGJiNEptTi23fs+y3mGJy60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkfqC5Z7qgkKCcd+RBvX3uelZR2eNh61YbJNX/f8XIkibmiImWuRe6Kxo+CuiSiFPz2swDOm1ixEXShS3CuUWMvW1UwmRq3ZYoc8ppK8BGAF44WuVonm1G7/OhQSzEABwUjPq7+jJF8GWj1oh6/0rUC+qTFa8F+ZK2aiYe+0A3FxL4B3JxOWPnP7JyFcjdrh73Eiarb6Mm3g4xq7JO5m0Eyb/vxqpJg+NV7maLB6k6qV+duH7NFL0eZfrrLQDyJepGq8uxD8rSNCyymT4GXSzSBT8sFcPpFw3GGDRpxHbRelxFNlREsAHzsgtS8kQNCs22ZcVdLYqPn+ilaqfS7xkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to; dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RDYuq0Ay; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org) smtp.mailfrom=dama.to
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=RDYuq0Ay;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=dama.to (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3hzS5CCdz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 00:02:27 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2cce6a0c9c3so91236445ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784556146; x=1785160946; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jjgcDbEk+UwGPrm8p3ddZGJiNEptTi23fs+y3mGJy60=;
        b=RDYuq0AyF2GhOPLz634qzBb4ojKeXz3MUWmg5Z6r8oovg6GcTsd32m3xb88q6N2wRv
         fzP6KDW+8ujX/3KtXgRFtsnQvEPiJLKRUHtzDxEskgkLH7H6FjCpn8WWjfdR0KJhzONr
         8JKjbqET4jTinXmXlq2O5PRmVAzFBcfMQsVwnxsaLi+rvyqMgTASrFVxUn1q4feLx5SF
         9DakQanuetulYExiUof5kKl6HJkkgYJjZTLJgBxfkXH3VSvtVSdIogO62FK/6IzoYdSJ
         ak1GQ6ROpSgC5voV68rWdvdtbZmcvOuCZL7bKVo/BpGGMWwgbT15XkuXux2dD2VCEq1Q
         FUgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784556146; x=1785160946;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jjgcDbEk+UwGPrm8p3ddZGJiNEptTi23fs+y3mGJy60=;
        b=A3DqMtxkGSlmJWGYSvgaTrKY4iRqzSeHfv8Pj5hTXX+n+uWVxyJKTQJlPEZjO2LOud
         d18D3Tu9r9G4S1DsTS7UuSLQYspGSfXbWVBhz1BbO0zp1bYQhNMfuBglYIjAgcPUrqvJ
         aXp8Fg20FT3wgRhdRGFdnmgLPAB453wmFM365+vXxKFF5sUe5ZEyJbLJwaiG0JMSfNep
         Lp+Cw8irf5QiIKH227I+WGtiWenHUfQqV3vGB+1zZxXEmhBHbnEpraekPS1TAkNIkkd/
         LCIkIt7DKSFeZXoYBhLfFyMF8xrzFHovPlMcKYXHwyzGacT5MH+UjTzR5tQSwpWfcjnA
         3/zg==
X-Forwarded-Encrypted: i=1; AHgh+RrrhHIgc6LMmslvq2UT8TkCwCUmPkEJSyzY/TpR88kfxagX95yJU3GWqWyciLlQw4I1d/NmD4myCVcgvH8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzxo0jLSyUiOdrQnLeSRaTdW1YKRfDPOaPRunqSqCLxUiFixVmz
	48H43dRQYhBNuz0qKXBysn41KJ8Osw30rgqZVE2Ei5EmWrvC2R5EZceQIwm6M+eFYDE=
X-Gm-Gg: AR+sD13zVhtti9Hf9QIxdWsF7PZjciL7IBKvOQKLs5iK1tVIakn/awAtEDAosa8W59k
	GcCirViu2F1NcGoZChJ4uekEYfD3AzRxEb03UwVxdpRKYOoLhtFpF9dHottZi03RxuUvWJ6IJ8i
	8fdWDtbHn2AnfkF9JyffSfeooRE9T2F/76daw5WbuBWhjrFW5tvKYGAhzxQ2Lg2snyju/LvNDz/
	/mc04/KZBpIo/pgMxe6QpVFiQu0KBlur16kWyBeauS4HfMt9wSbNoE65mnjgSz/X9Xlgn+J5SZu
	3JsxMHtSMDO6D+Wh/B4bIcZzsR7OxipYscoKz+DWCFj0ndWHJwkGizf04oT4Vm97yBmQ/PgvjPa
	04HYWipB6PjANI/DtIzIHmiO2iWgkbWZw1vQaf0x+14uscrC+w9QpeL8ZFQJ4CR1Nl38y0A==
X-Received: by 2002:a17:902:f78c:b0:2cb:3f5b:6663 with SMTP id d9443c01a7336-2cf348bee75mr154491725ad.11.1784556145405;
        Mon, 20 Jul 2026 07:02:25 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346db113sm56870065ad.39.2026.07.20.07.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 07:02:22 -0700 (PDT)
Date: Mon, 20 Jul 2026 07:02:21 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 01/14] net: enetc: extract common
 helpers for MAC promiscuous mode setting
Message-ID: <al4qbRV8h1a5nZCd@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-2-wei.fang@oss.nxp.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720014317.1059359-2-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:03AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The PSIPMMR (Port Station Interface Promiscuous MAC Mode Register) in
> ENETC v4 has the same bit layout as the PSIPMR register in ENETC v1: bit
> n controls unicast promiscuous mode for SI n, and bit (n + 16) controls
> multicast promiscuous mode for SI n. The only difference between the two
> hardware generations is the register address offset.
> 
> Since the register functionality is identical, the MAC promiscuous mode
> setting code can be shared between ENETC v1 and v4 drivers.
> 
> Rename ENETC_PSIPMR to ENETC_PSIPMMR in enetc_hw.h to match the actual
> register name used in the reference manual, and extract two new common
> helper functions, enetc_set_si_uc_promisc() and
> enetc_set_si_mc_promisc(), into enetc_pf_common.c. These helpers select
> the correct register offset based on the hardware revision via
> is_enetc_rev1().
> 
> Remove the v4-specific enetc4_pf_set_si_mac_promisc() function from
> enetc4_pf.c and the duplicate PSIPMMR_SI_MAC_UP/MP macro definitions
> from enetc4_hw.h, as they are now superseded by the shared code.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../net/ethernet/freescale/enetc/enetc4_hw.h  |  2 -
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  | 21 +--------
>  .../ethernet/freescale/enetc/enetc_ethtool.c  |  2 +-
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |  7 +--
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 11 ++---
>  .../freescale/enetc/enetc_pf_common.c         | 44 +++++++++++++++++++
>  .../freescale/enetc/enetc_pf_common.h         |  2 +
>  7 files changed, 56 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> index f18437556a0e..6a8f2ed56017 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> @@ -69,8 +69,6 @@
>  
>  /* Port Station interface promiscuous MAC mode register */
>  #define ENETC4_PSIPMMR			0x200
> -#define  PSIPMMR_SI_MAC_UP(a)		BIT(a) /* a = SI index */
> -#define  PSIPMMR_SI_MAC_MP(a)		BIT((a) + 16)

[...]
  
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index bf99b65d7598..66bfda60da9c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -180,9 +180,10 @@ enum enetc_bdr_type {TX, RX};
>  #define ENETC_PMR_PSPEED_1000M	BIT(9)
>  #define ENETC_PMR_PSPEED_2500M	BIT(10)
>  #define ENETC_PSR		0x0004 /* RO */
> -#define ENETC_PSIPMR		0x0018
> -#define ENETC_PSIPMR_SET_UP(n)	BIT(n) /* n = SI index */
> -#define ENETC_PSIPMR_SET_MP(n)	BIT((n) + 16)
> +#define ENETC_PSIPMMR		0x0018
> +#define  PSIPMMR_SI_MAC_UP(n)	BIT(n) /* n = SI index */
> +#define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)

I probably would have fixed the leading spaces when copying/pasting the macro,
but that seems like a nit.

I read the rest of the code a few times and it looks right to me.

Reviewed-by: Joe Damato <joe@dama.to>

