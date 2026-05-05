Return-Path: <linuxppc-dev+bounces-20454-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB7ACD3430
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 May 2026 08:59:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8srt4Nmmz2xMV;
	Tue, 05 May 2026 18:59:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777971566;
	cv=none; b=AQJCYZAEX7PsRj74GeMN2mp1cu17kuU4YZfU2yTeeljBCu8PGwna1OEk3m0wGLXoHa5+R+nHeMka3yTpi2iKTEPvWvVsYcqcS/RUdQ7KduGUozVpD5bQyY9KsQGI+Jk0GKqW7XuA5BgcurXcaRuoW2dZPrkRXu5toYFXktWnrikACGv9vVNABTSG9kbCLdQslFK2frNFg4XuUvLhsEodOPqv7ZohCmRFSWjwIZN6d3Ih+R1h5jnR3eQGKggn1QtH3kAIs09+pL6QVjL48SRXhl1ZfL1OMSIGWzw3F3C6saCwdph404lX0eBDje7CCdRrnpq5cgoybjTeaySzkpG+ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777971566; c=relaxed/relaxed;
	bh=F0r85uYEBvFZwjw3nY1w+QDsZrIZzp0BkVyYOYWi2dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvqNpxIYnm/Uu26N1y5hcGeARrwx7NC6WExdTeo3ZWsFirUddc4LY5MhFIiCdYgXJidp+kfZdpTAq8TrkzaI3ihwIa1fiv9mngY7Nn8lAqFTKNbk/qEt3RiZRjatmEZKI3fzLiFbvXk+RG9QFbZTG2NvwHuhx8h4S4FDZp85B8jsHqyEwc/ouZs0kZ58kbaFRiC8oZOw/n+l3TpVeSmF4L2+g5lKT+DEUT+CAzBEUT8VRRvqUeCa2yGMvpuBX/j9KLsl31PrYmopv7eugO27XHYE2Kgf84SPV/C8QliqIxgSCLEm5gK25/YttN3Fqv8j/nQxFoKYFgFabrE2gw3Bsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gAd/ep8C; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gAd/ep8C; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gAd/ep8C;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gAd/ep8C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=pabeni@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8srs1SPmz2xGc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 18:59:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777971558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0r85uYEBvFZwjw3nY1w+QDsZrIZzp0BkVyYOYWi2dY=;
	b=gAd/ep8CUNH7HQwq8zUjoU7MeyNPlL6R4xPaaiV3HAQq8fi/pAHNW7rhwHYc+jGxovA+uF
	giaTaxTFHFFks0NPoyadeXRkM5t3Z8png268IMxGRzWwHfZDDadJePFDaN8zzdCI9bwSiC
	O53+kdG7zTrA0dGBT9QwLROC9OzBrTo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777971558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F0r85uYEBvFZwjw3nY1w+QDsZrIZzp0BkVyYOYWi2dY=;
	b=gAd/ep8CUNH7HQwq8zUjoU7MeyNPlL6R4xPaaiV3HAQq8fi/pAHNW7rhwHYc+jGxovA+uF
	giaTaxTFHFFks0NPoyadeXRkM5t3Z8png268IMxGRzWwHfZDDadJePFDaN8zzdCI9bwSiC
	O53+kdG7zTrA0dGBT9QwLROC9OzBrTo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-N0NG1Zn0Nc67zT5QV5uHdg-1; Tue, 05 May 2026 04:59:17 -0400
X-MC-Unique: N0NG1Zn0Nc67zT5QV5uHdg-1
X-Mimecast-MFC-AGG-ID: N0NG1Zn0Nc67zT5QV5uHdg_1777971556
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so26184265e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 01:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777971555; x=1778576355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F0r85uYEBvFZwjw3nY1w+QDsZrIZzp0BkVyYOYWi2dY=;
        b=PDg9HaawmUPkWf3gMJ20qWVFmmj4ezcVCb4SFmZLl45kQ3+Otd2/11oaQP8lcFKLbj
         YK5HQFy7qxCT9tu1s1FC7rq6RH+k63Z3roWXx3uiZl8sYRThEuOPA913aZtdqyzxBUl/
         SJO3xK7uGQBnFoplkd5PMFP984Rp7ycPAvYjia9XUcIgXMh/uDv1W2D5uVCROzATfWNm
         lVqGtjtNb+6bUBzXyCvztF6faq1qZGwIwsGo48uVwrqTHlC0noLrAjVXZtIbfX+Bcp5t
         YH/eSffTvCaI8rYHVdDDo3pajJKGLzoBhJ/J+YB3eTyt1Pg09DTf+Y3AfNyTOTajijyV
         Y0xg==
X-Forwarded-Encrypted: i=1; AFNElJ95fHGVLIi0FtOmszFZ7t2aQdbTA3hhvHbXjt+u5jUA1tlI+pdSkcBmHrnMzDZhSSKjpLtUADrpoQKKRQE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YywOhO4KDc7dNPx5M0KntfIePIFxtkIjPrHIkXvqtFUD/EZk8mi
	VnsP6DT83lZFOY7E7tAwH/L9Ky9e96wN1W+K0HYfJa8MyF3UxIH/dGw4R8E1upzzC+OQPME3T+S
	0+gWaVD5Buy6wI/xyh1VJcwjV/dmAn3VS6pQ+IzjT1pdZSE1Vv5d+c7hgQWRUtaCCGr8=
X-Gm-Gg: AeBDiesMZ9CVupRbRLnWTunO4bNdTe/LcD6VVM1NURdetOxbaOLGuEgho42I1dfqcoE
	QHS+c9AeJ7pYcQwrn1z/+gYgEBVwuL/HyNOhyj3M7yPHfb03k+oiM+QyXk0owcjF3tb9SNd7rkW
	aDSie25Q6CEhx9UCT/+U1JlidN3c1EbyhFRBFQya/nq/gBNntuXgZqVGxzqVzFAHPkUDxVd46C/
	sAhPyRgB1sj/Wt7TXBbYOLuUXql1k39Kkw2yK1SAi6P/z8mQ+46bEb+sWx2VxFc7eIu1poOLQsu
	P/QKmIPEjAtKVFf+SfAg2xuIIn+qE3KJwftSRtp0ExPDWQxIPTq1g+ZiMZGoo96LnicqQcvFFtn
	rRHya7mdkhAvd0EXhKefI9b5QX4bSKJnul4QuXUStEiTPd5FTLl1LWKBZoGO4AbPsS/U=
X-Received: by 2002:a05:600c:5308:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48d03b401f5mr161071345e9.22.1777971555629;
        Tue, 05 May 2026 01:59:15 -0700 (PDT)
X-Received: by 2002:a05:600c:5308:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-48d03b401f5mr161070775e9.22.1777971555194;
        Tue, 05 May 2026 01:59:15 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d184ed3b0sm12329145e9.34.2026.05.05.01.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 01:59:14 -0700 (PDT)
Message-ID: <6324783e-b5c8-462d-8cf7-f6cc9c01ea89@redhat.com>
Date: Tue, 5 May 2026 10:59:12 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 04/15] net: enetc: add basic operations to the
 FDB table
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, f.fainelli@gmail.com,
 frank.li@nxp.com, chleroy@kernel.org, horms@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-5-wei.fang@nxp.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260430024945.3413973-5-wei.fang@nxp.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y5dJrPifcioEBYi6bDtsc4iJHELdTnVGjc3-wwccDFo_1777971556
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/26 4:49 AM, Wei Fang wrote:
> The FDB table is used for MAC learning lookups and MAC forwarding lookups.
> Each table entry includes information such as a FID and MAC address that
> may be unicast or multicast and a forwarding destination field containing
> a port bitmap identifying the associated port(s) with the MAC address.
> FDB table entries can be static or dynamic. Static entries are added from
> software whereby dynamic entries are added either by software or by the
> hardware as MAC addresses are learned in the datapath.
> 
> The FDB table can only be managed by the command BD ring using table
> management protocol version 2.0. Table management command operations Add,
> Delete, Update and Query are supported. And the FDB table supports three
> access methods: Entry ID, Exact Match Key Element and Search. This patch
> adds the following basic supports to the FDB table.
> 
> ntmp_fdbt_update_entry() - update the configuration element data of a
> specified FDB entry
> 
> ntmp_fdbt_delete_entry() - delete a specified FDB entry
> 
> ntmp_fdbt_add_entry() - add an entry into the FDB table
> 
> ntmp_fdbt_search_port_entry() - Search the FDB entry on the specified
> port based on RESUME_ENTRY_ID.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/ntmp.c   | 203 +++++++++++++++++-
>  .../ethernet/freescale/enetc/ntmp_private.h   |  61 +++++-
>  include/linux/fsl/ntmp.h                      |  44 +++-
>  3 files changed, 305 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/ntmp.c b/drivers/net/ethernet/freescale/enetc/ntmp.c
> index c94a928622fd..4ed8d783a9a2 100644
> --- a/drivers/net/ethernet/freescale/enetc/ntmp.c
> +++ b/drivers/net/ethernet/freescale/enetc/ntmp.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>  /*
>   * NETC NTMP (NETC Table Management Protocol) 2.0 Library
> - * Copyright 2025 NXP
> + * Copyright 2025-2026 NXP
>   */
>  
>  #include <linux/dma-mapping.h>
> @@ -21,11 +21,15 @@
>  /* Define NTMP Table ID */
>  #define NTMP_MAFT_ID			1
>  #define NTMP_RSST_ID			3
> +#define NTMP_FDBT_ID			15
>  
>  /* Generic Update Actions for most tables */
>  #define NTMP_GEN_UA_CFGEU		BIT(0)
>  #define NTMP_GEN_UA_STSEU		BIT(1)
>  
> +/* Query Action: 0: Full query, 1: Only query entry ID */
> +#define NTMP_QA_ENTRY_ID		1

Sashiko noted that the above comments looks inconsistent with the update
code, where NTMP_QA_ENTRY_ID apparently uses a full query, and 0 just
the entry ID.

If you have to repost for other reasons, please fix this. Note that you
should reply on the ML to sashiko reviews ruling out invalid comments.

Thanks,

Paolo


