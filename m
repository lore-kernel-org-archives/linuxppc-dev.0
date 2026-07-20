Return-Path: <linuxppc-dev+bounces-24569-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41786C4452D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 02:22:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h41Pc2ftPz2xqJ;
	Tue, 21 Jul 2026 12:22:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784561216;
	cv=none; b=e3aSIZEk61fA1FZ6glFDk5t/sZ9TipCB6WnaGxphA0sjzi5vLAnTjHDXhjzUKYmD4EoDWTxDXsVRlK9m2kMLi/KkzRkPYix/8X4MO4EUY2/EVxmvSZMbXWidE87naXY7VtNt/AYG/rkQGxRp3Rg/EsB7CufCQ5KUgGeemCzkzMpIi7uveGGPcfjUgyn5XNxXslNfoST2iYknhKsMoL0yxSp1FWC2YCVuLedW/tdWN/+CorHSgSHem/OpP/EvhYIEZY0p3+72OjFYW3Gp7RxcV2nfFVJ+BCVndaFTU/hsdK4Y/PcsrXZ9OkdF/8ysxeRQKvDAAmZUU/ukLU5mhZrGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784561216; c=relaxed/relaxed;
	bh=3VTZ9zHl9OoQneFVX7eJwf/WovVc3pD60nK1eidpzDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmuecIj7XN3H2zb6YtZGb7gfz08rG71LeQh5/xFBKwsTCM1ae3vnMcMI1xPEYdVDzp9wW2DjcN5M7+NZhwg2QHldm7kT3+PpXN5GCYS26x8CQb+DH459p1qC5JFk+NENxpG2iVAYSmYwiKCN78GT7pLvwGHvQ0zArU24XS/QJVMuAL94a6ynCgFEY6KK6cJ59G1gzS7+qMbqeK0yh3k8xlSuiW/hST7c7AAhqa7rIj4jntaVrdnw+TlBALZPxqPH4BJrpieaZiN1xzMZCxaFmvyTs3O7B/w9YHEWL5V2AG+y8NWve3PiDKbJuacG9wy9zXu6BAJHcrShOJ6O5Pa5ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to; dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=UJGU1Ikj; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org) smtp.mailfrom=dama.to
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=UJGU1Ikj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=dama.to (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3krt28mmz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:26:53 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-38e071ed6aeso6345509a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784561210; x=1785166010; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3VTZ9zHl9OoQneFVX7eJwf/WovVc3pD60nK1eidpzDA=;
        b=UJGU1IkjjIVbPNImRKxy8GAmnUnq+IcBDZMq8hH4BnW171tct43e7Qi5nX9RAYgVrW
         DUP5Y/Idf66X1+zEIVf6n8y3dMLbVBiRwOp92e/WtRR1wqPPVG+okdRgtB7yWGlnN1wC
         aZJrCYhbRwvWg2EHBw/ECpXdHrAto/t2l9ntZJ/7UMknGXR9Xd8by/XVwEhKyWnpoggp
         GDElmKScSNtDLwz5RyokorlBSVFp2SralFsH00pN4sQJlHhvv2zmHSe+A1mhI4fDKQEV
         8iR0suwHp7s4waBzguqg3JyVo/5JFfgWPhAP0i4cpJzXgpFviO0u5pB/cyTVcoxidZ1c
         i1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784561210; x=1785166010;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3VTZ9zHl9OoQneFVX7eJwf/WovVc3pD60nK1eidpzDA=;
        b=FLaC5mD7icdQCKQGh/nndYUvKKQh80uJYFNdcEVD8+zc32CQA+d2aPAizBxEXWdc6k
         pxTXxPWF0VLFd4dNuxmQaBzunXYulGWlU28nztutlbWUajhj1ZJ6DsAoWc+9Q/Llimt4
         RUffDYk0RtaaVPL0XgQAfapSqWG99jyvlJNQUSL9NnWLxow6OL5Zcr8rl/BD5LHm4ouw
         l0B6RO7B1Zn3O7ye59l+ckeJHx9rSESFYtv2T+p3fZOUup7+IvO6fM+5JtowYyBWy6Qm
         QIv4GpVGdNEvDnEJu2k4gTNBniAxs8EasQDbEZTbCtxQjkUOLGcMJgF75BxJz7jhW9yy
         Z5gQ==
X-Forwarded-Encrypted: i=1; AHgh+RqSMYI4rX4Ku8SE4TIn64H1A1q+Xp1E+06SKcIlPagXv9mDdL4LulJJ3zt4ncg2r6bZl+igMo3K4l111/I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx6v9L/5Vb68XEtGSc7Sin1RzbLGlEUta6ZgYm/EeXzmg4HQoAY
	kUt2koziM/bSgcn6+FRp5LHzB5tw0Z6wgPzOzBxWCrNBKI0epYmrc3kn7TOgSS30t8U=
X-Gm-Gg: AR+sD12GvQ/0W7LcbS6IQQ/bhuVX1rCoUVoPeoUmTfvFQP21JO2u9XO+jvJUDC1kon8
	0KyCw9nAWuKaOkYczKspXTOBMVsXBdfX5dzbHfwXSSP99mWPzNVXNW2sW598TMMPoJ2hb/rdVBX
	ujjHThQ8+ia+x2KPS29i1qzoJZ2dFq23o7YcGUnAs8s1bHsNAwAD7YII5vyKhKsRb7x9fBl4m5q
	Mwf0+02QNTelF91UhNtnAqotzEKyN3jE4kDc7I+f6VKePuIWNYLaxoNEbV3L0lpoNJXKAWc8ptN
	neBx+uNY2FsdopOcYJd8QDrqUUfN0AcpI8himYSJ/x7yNoHYxOCGhNDZBz+tUweUcyPpabXNED5
	mcvdDdn4TjJzb14BgT63MyoDwEmfJsP3+e5Y2sOjAX4c2yMl6z133oKza2Fs=
X-Received: by 2002:a17:90b:58b0:b0:38e:7239:b945 with SMTP id 98e67ed59e1d1-38e7239ba36mr4798636a91.21.1784561210391;
        Mon, 20 Jul 2026 08:26:50 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:55::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afcd3fesm6080875a91.2.2026.07.20.08.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:26:49 -0700 (PDT)
Date: Mon, 20 Jul 2026 08:26:49 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 09/14] net: enetc: open-code
 enetc4_set_default_si_vlan_promisc()
Message-ID: <al4+OXBo7rVJiLb0@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-10-wei.fang@oss.nxp.com>
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
In-Reply-To: <20260720014317.1059359-10-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:11AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The function enetc4_set_default_si_vlan_promisc() is only called once,
> from enetc4_configure_port_si(). Open-code the loop at the call site
> and remove the single-use wrapper.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc4_pf.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 859b02f5170a..505e4abf6c37 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> @@ -307,17 +307,6 @@ static void enetc4_pf_set_si_vlan_promisc(struct enetc_hw *hw, int si, bool en)
>  	enetc_port_wr(hw, ENETC4_PSIPVMR, val);
>  }
>  
> -static void enetc4_set_default_si_vlan_promisc(struct enetc_pf *pf)
> -{
> -	struct enetc_hw *hw = &pf->si->hw;
> -	int num_si = pf->caps.num_vsi + 1;
> -	int i;
> -
> -	/* enforce VLAN promiscuous mode for all SIs */
> -	for (i = 0; i < num_si; i++)
> -		enetc4_pf_set_si_vlan_promisc(hw, i, true);
> -}
> -
>  /* Allocate the number of MSI-X vectors for per SI. */
>  static void enetc4_set_si_msix_num(struct enetc_pf *pf)
>  {
> @@ -361,7 +350,9 @@ static void enetc4_configure_port_si(struct enetc_pf *pf)
>  	/* Outer VLAN tag will be used for VLAN filtering */
>  	enetc_port_wr(hw, ENETC4_PSIVLANFMR, PSIVLANFMR_VS);
>  
> -	enetc4_set_default_si_vlan_promisc(pf);
> +	/* Enforce VLAN promiscuous mode for all SIs */
> +	for (int i = 0; i < pf->caps.num_vsi + 1; i++)
> +		enetc4_pf_set_si_vlan_promisc(hw, i, true);
>  
>  	/* Disable SI MAC multicast & unicast promiscuous */
>  	enetc_port_wr(hw, ENETC4_PSIPMMR, 0);

Reviewed-by: Joe Damato <joe@dama.to>

