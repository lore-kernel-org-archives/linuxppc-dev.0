Return-Path: <linuxppc-dev+bounces-24571-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FC9C44520
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 02:25:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h41Sz6ztxz2xjd;
	Tue, 21 Jul 2026 12:25:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784568969;
	cv=none; b=WGX9xpLu5hYeD0WLWH8oua5wsGNVDoAuU2SOYwfuXfNH4dtkS1qR6w7C6uT0x2jADBj3FRtdOdmkFAKxE9+UgEhr8NiBUG760jrnf1Wq9mX9UpEI28RlQ1V/kmMt8JSS8zTGSmZbzEplC9/IDGKTEGUR3cOCi9nGIpd+dPzn4aRDY4et2X1eMoAJPJ6yppuXsW7uwiiVJ2Qp5bvnYvsz18aU7XVRkS18Yw+aJGoY3pwxCVYcM6Lj8rNgGIQ5IpCuNJgCuwMtXDwKOSa5YLpWbMdj1rD2+XLCEWVyIRfcO1D3mExU1ekHwuxn7ogZQkaHYOb08NuSEXOT81J4xQvT4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784568969; c=relaxed/relaxed;
	bh=bgJoRNuplp6eZlFzlFIl9nminZilm44pZn8iwP92+o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTXe4ij/Y0yvKfuJjGIi2SjabyyL24PE+2AlRgrA6QQ+Cqk7ftYfVbl/uRlbEC9xsABqhA4s/CcVADx/mj+2rjDAsoDmGG4CEAXd/mQlux6D5W7tZrVRKhLkbpuu3ToRTHN/Ppv5PHDys3GWJyrggP6bnH8DpsNqTBaEIHYT8YuVobZB6KHxX/vlxnPdVqCTX8LZ+ZtfAq7veiupWW7eJTINaYYfMo/b5UNsSZn8i8QuJdh3gIXzjskxjYiO2Hxv703HfR2tvLnYGRGLWPGVNzHqUY2ldG3f5qRPdFdHmTRcF2PdUlikIecAveiXExbHBDeSPLuFQ7xBzOKwRzS+KQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to; dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=g4ZoBJzG; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org) smtp.mailfrom=dama.to
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=g4ZoBJzG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=dama.to (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3nk024pYz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 03:36:07 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2cad4170e8eso143799115ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 10:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784568965; x=1785173765; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bgJoRNuplp6eZlFzlFIl9nminZilm44pZn8iwP92+o4=;
        b=g4ZoBJzGsf0pHPoeQ9h0Z5QqSUNLzv2F5OdjBWxaIFBph1JI5zul7AUOV78EPoNXec
         HUYcAQuO+QR4iF3/PSZgxVd8DQEHugLsCP85rBRP8Qptr2gsSdu8C0YUkNd9XnbrrOZd
         JC4wFH8ZHYktXrGO69/QIa3ZLxfOB7PJIrV0jIs8iMxmkiJ0V0tSIY+kxsCvOUdeVPsR
         Ftuai8vmAHDBzvflTpm3E1W+wK4h1XbUONtvXzTC7L8kbgx29Ujvl0ia42iZHNV9WoF9
         +nP0I3cgVMyGEoMfMf1IEHmTXTkX74eBMuIm2d/Wi1rnykLsqlOvUy9LY8PjU5lYy649
         vkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784568965; x=1785173765;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bgJoRNuplp6eZlFzlFIl9nminZilm44pZn8iwP92+o4=;
        b=iZCNmsm5EMFGDDey4uq0iiXmYNBAaiEALAy3pMaSsMZ3XqYFUUQ9XUPIqyC8z1pp6W
         LThm882cXtE7joK8Hn+oM/hS8XuDqMsBfFD7hb8pwwvTMs73HOzynaBK22wE6KlfqJDn
         8XZZDrQd+a8le8y7ge7W5HVK3TBOWA+/5mrSU8Ns0K98PV7S3igAa7t6zhWDz/Dg7cHl
         VyBMXONj2aTI+g+IlTbFQ4+uSQc2cG5yno4PqYSz2zY98iE0ME2TvpsMadBue4yg9W7D
         2vc9UCJiiDdmEaOhYd9jXiXzfvzWaTdgslYfpBpMdihIyZccxyrk2CnuIcAtrpMl3DSm
         B5+w==
X-Forwarded-Encrypted: i=1; AHgh+RoHFG2yt+FUvmBNYJxc/COq5Nc1zd3+4FlRJcK/qPQ7jSlYpvGiOX/6bPx/jkaDV19jC53G3ZU0DPHp06M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwWIeQsE40cUumAmIGVHiKiDgQM2GQUuMctCpO4AM1N8TShBZE4
	A6vCk3vxYUXcnDbIF5HWaeKpgAszINYcT3RkTJ4FrDj9QlVg2AW1hJLmU36eXkiKDcI=
X-Gm-Gg: AR+sD116oG8PKIVmrlzY6sGRxIZrGk5nT4QFHZBiiKZoPeBtoBRdLE+ZONlUdr8zb6k
	KIYRGAFGPQl3Ul+VimdbdRTNtUCi2WTv0DVISTSY7jA+U+c+8WTVPYR+PFzLTslXmVDZbqxwqbn
	RgkZ7srgKQ7N/ynXrUchTqJeKDbL+swMcCFk9d7ruxSwU88JZnUWjaCvVWc7SxDlWOTwy2RSbR6
	TdXsjJyowQKzIEAyBG1CBUAKpfYpqDl1mYbWwEacxgXScXdxZinlRcwOiKepKJ1GPg7TqS0huxP
	vBDUSUzhlKPdbTg7Q443MX/3xjdhQWcpWIXJ3w/6lPXo7N9QheIebAH33pWl3lDwf/6ioKx5V5C
	GV28c7pBlSe89hmrKZdJOEXJ2x7uYbFmHs1ovWomHo3s6shL+6eLTFxXmAeE=
X-Received: by 2002:a17:903:986:b0:2ca:53e9:1277 with SMTP id d9443c01a7336-2cf348193e8mr159265115ad.1.1784568964287;
        Mon, 20 Jul 2026 10:36:04 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:53::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3476f70esm60110235ad.77.2026.07.20.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:36:03 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:36:02 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 13/14] net: enetc: use
 alloc_etherdev_mqs() to create netdev for VF driver
Message-ID: <al5cgs6CqVKsy/gh@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-14-wei.fang@oss.nxp.com>
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
In-Reply-To: <20260720014317.1059359-14-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:15AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The VF driver uses alloc_etherdev_mq() with ENETC_MAX_NUM_TXQS as the
> queue count, which forces the TX and RX queue counts to be equal and
> uses a compile-time constant rather than the actual hardware capability.
> 
> After enetc_get_si_caps() is called, si->num_tx_rings and
> si->num_rx_rings reflect the actual number of rings assigned to the VF
> by the PF. For the ENETC VF on LS1028A and the upcoming i.MX95/94, their
> SoCs have no more than 6 CPUs, and the number of TX/RX rings allocated
> to the VF is less than 8.
> 
> Therefore, switch to alloc_etherdev_mqs() so that the TX and RX queue
> counts are set independently, each capped at ENETC_MAX_NUM_TXQS, based
> on the actual number of rings assigned to the VF by the PF.
> 
> Note that if future SoCs have more than 6 CPUs and more than 6 RX rings
> allocated to VFs, the size of the int_vector array in struct
> enetc_ndev_priv will need to be modified. Similarly, if more than 8 TX
> rings are allocated to each int_vector, ENETC_MAX_NUM_TXQS will also
> need to be modified.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_vf.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index 9cdb0a4d6baf..7dcb4a0246f5 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> @@ -317,7 +317,14 @@ static int enetc_vf_probe(struct pci_dev *pdev,
>  
>  	enetc_get_si_caps(si);
>  
> -	ndev = alloc_etherdev_mq(sizeof(*priv), ENETC_MAX_NUM_TXQS);
> +	/* Currently, the supported SoCs have a max of 6 CPUs and the VFs
> +	 * have less than 6 RX/TX rings. So no issues for these supported
> +	 * SoCs, but for future SoCs which have more CPUs or more TX/RX
> +	 * rings, all the related logic needs to be improved.
> +	 */
> +	ndev = alloc_etherdev_mqs(sizeof(*priv),
> +				  min(si->num_tx_rings, ENETC_MAX_NUM_TXQS),
> +				  min(si->num_rx_rings, ENETC_MAX_NUM_TXQS));

Code looks right, but looks almost like a typo. I guess it would read nicer if
ENETC_MAX_NUM_RXQS existed?

That said:

Reviewed-by: Joe Damato <joe@dama.to>

