Return-Path: <linuxppc-dev+bounces-24567-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4165CC44515
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 02:16:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h41Gd2XvWz2xjd;
	Tue, 21 Jul 2026 12:16:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784555337;
	cv=none; b=JeCd6mXh7nYXgvhdgOqvZdLK7Ymxl4j6/mTiWhgux/SADqSB4Ar6MG7NZIzPpym+lk48bt9RqY9v4CTH60dB1MVRLE4wiqTWGK41riiJsIVngZMAn6q/UjngMiT3HWbRsxnciSS8jGs6RmGFw9o4sQumDZu9VMHUb/eFrWWpwmnJgRqe626H8YBuxIPFNWsd6fbZ1rrX8QZydAZyG9E7r9pDKLCIA/16dcPVlXakl2DeN1M7xWNKvzK696SVTa6VGzlleFzzsfUxtBAYi1Bx6gFz9m3NEDC2GnzPOAcMxNVoLZ/isIS2W9AQlcQxJjYMBUcnT2r6Oq0q7xKnEooisw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784555337; c=relaxed/relaxed;
	bh=exgSZUy4mQ+gBayEGCoSCzUgfoiRVrcGM1wITQ8aelo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ik1IJk70P9cxYsGF8h6PInKbi4lmgupQ3k2nhNegcOnfwFY5pOMAU8XcSV8x6Yhkadb/n7S1FquU/YyqDL5glShW86cUqcVsHrkBf2t/nG/s0Mc1otKvisqs2U+j5oYZ4z1gZNTocoUfnm4BjxDEjGeFZ424pNB6rnimjRMyTy3qYnB9inLrGeG1LqvmKl17st3i4Kzc870Sz1EobjQVheF0u5FVF2l3WENma6J6kV/NNwfgoKq5GZIPVwlZ+GRWKvJcgA8EMSkBCC7kZQlP73JDxaMse7DzMP0Y70w2N1kMvsxgDNDODm0JXiAxKFf16HPM6GPC2ih5lrtXqwOFsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to; dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=l0bqs4qi; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org) smtp.mailfrom=dama.to
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=l0bqs4qi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=dama.to (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3hgr5ThZz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 23:48:56 +1000 (AEST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso6509210b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784555334; x=1785160134; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=exgSZUy4mQ+gBayEGCoSCzUgfoiRVrcGM1wITQ8aelo=;
        b=l0bqs4qim/v6IEZC+Y0Rz2sH1vFsGVJyt+BUbT3N/YDyDvFseIEgpn6ffKuXXbDL0b
         n+i1JYHvUNU1C9hKKINO3dpiDlTzVXRRXgvwTEVAFtmKlnPQqQzLD6AVIJIn+4WQ0h2h
         nQM1lAhMFaIJQFyj+qLc4LA9BnYXyVi4XFpQB4MA12OyrSI6Pq/7jLAKBjq8yH2TM9zS
         GWCG9aAh9SSNOw4ZpSA+417tL/ybdRwuQFnNrJphVAcLcfuto9Ar3JXdk/EK/lOLBExC
         DUwQwmBLnu+hNs+oQcZ2szLH5ncq7zIT0rmREkvo12hoL85YDO7Xf/58AbKDuV2EwTtw
         sU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784555334; x=1785160134;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=exgSZUy4mQ+gBayEGCoSCzUgfoiRVrcGM1wITQ8aelo=;
        b=Wq6UuUJ5z+EVPBg0Y9C1Sel0UF+/QoAQ75KaDCMKbeI07cmqS0bLc6BSjoaeWKmn/S
         As/wNofYwkeVcA7c33rvMmtELG1Cr/oVZutA0VIsXLpDDcZ39oykQ780qfpCibkHcODY
         0LYqxv5o2mdD+xnIsejgqoGnx56GaA3QkEuczi5bTv8ir/frWX+g8KOOPVJyyUJCr8oR
         ueBIz0NnqZrzTZ46ki4PNDQZaN/OEMYBP9dyb+YqFvVaT6B+2ZMcSuA8BzJKzJr5nncJ
         RtOdlaO91TLju1J0KlrXT/Ux9OiRTksd3VmWEhpaWU5vfblHe1+rlG6ABhh1OdnQbLFz
         NXbQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0EdLpQK+NGydtQetX3Zz7ZK1IJa36CW+LvxiAEA5c56mEhl2e+6IIv6XJAy/uqXRArThEyAgJ7bY83qg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzRaxP22Gl6Xe98Q/0L7d+OyulwjyawoQ8XpgNOg0Ym/2b1yrJs
	8yJFqmHSfrP9uvxNChujcvYuDrRDc9pbbjnWljcrv+5OW8PzHKYqtIQQyzIUB/TQpMA=
X-Gm-Gg: AfdE7cnmcSwLOX1fR5SMwNutsOLhK5/ASp1RfiB0ECQpcUuEUQ8PpCMBzCYwgc3ccZY
	8PugvQWITtQxDaZiu7MLfg0aSfN1KBkpK8vZk3Aioy3wFBtFqVyzToHhjJyudAwTJpXThAp9B+l
	eg17D49KtXiWTYYnNlpkEWB9/ZZRYhzh4rTRJitoHk/goJRN2KG5zsejJ/WkoHiiNWDxw+cwvE+
	UeaLnkxJzQJjDlWyKvAIV97O9ZfD7SJ89rY4oqhs92d5MENz7ClLCL7xBEbVRDfaN7fPeTN6Hk9
	/6IbZwtzDwnjlY4FLPxJxLIdxgoogt9gI8k01tbwzog52CrT9uRLzZ1vEht53+oiaXEUD1pGBpK
	H8y6DbuJ1EEHuf4VGoaeE2pIha2eYGJgfLEr78MpfKlloZsHkAftIcCg=
X-Received: by 2002:a05:6a00:998:b0:845:eb73:411c with SMTP id d2e1a72fcca58-84c2946f027mr14586475b3a.45.1784555334640;
        Mon, 20 Jul 2026 06:48:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2adc3466sm5844378b3a.15.2026.07.20.06.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:48:53 -0700 (PDT)
Date: Mon, 20 Jul 2026 06:48:53 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 14/14] net: enetc: use kzalloc_flex()
 for enetc_psfp_gate allocation
Message-ID: <al4nRS6hB8siUx3f@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-15-wei.fang@oss.nxp.com>
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
In-Reply-To: <20260720014317.1059359-15-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:16AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> Replace the open-coded struct_size() + kzalloc() pattern with the
> kzalloc_flex() helper when allocating struct enetc_psfp_gate. This
> removes the intermediate entries_size local variable and makes the
> allocation site more concise.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_qos.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_qos.c b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
> index 7b17bca24f26..2aa0fcaafcd2 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_qos.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_qos.c
> @@ -1135,7 +1135,6 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
>  	struct flow_action_entry *entry;
>  	struct action_gate_entry *e;
>  	u8 sfi_overwrite = 0;
> -	int entries_size;
>  	int i, err;
>  
>  	if (f->common.chain_index >= priv->psfp_cap.max_streamid) {
> @@ -1242,8 +1241,7 @@ static int enetc_psfp_parse_clsflower(struct enetc_ndev_priv *priv,
>  		goto free_filter;
>  	}
>  
> -	entries_size = struct_size(sgi, entries, entryg->gate.num_entries);
> -	sgi = kzalloc(entries_size, GFP_KERNEL);
> +	sgi = kzalloc_flex(*sgi, entries, entryg->gate.num_entries);
>  	if (!sgi) {
>  		err = -ENOMEM;
>  		goto free_filter;

Reviewed-by: Joe Damato <joe@dama.to>

