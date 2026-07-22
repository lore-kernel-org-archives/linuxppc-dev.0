Return-Path: <linuxppc-dev+bounces-24645-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B208C44539
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 13:25:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4w3b5G32z2y8p;
	Wed, 22 Jul 2026 23:25:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::436"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784726715;
	cv=none; b=GNhphMmKj3RO8Uwl00/svQ9cRnkfcArIVDbFf649K8uM7QW4+QvXctJ9ruk9CTEMs6PAYSQxsZ/v4VPoycZqPkgd7F0unrzlyaS3ne/gR2lxnrqZeV40HEYOpFpbAnu8BYXQIrudIWsZjaeFqUGTRFS3s+LAeUTi1UmbkQOU6yGUylX9xdm/0GB+EOGIgcF/VauUiHe3TCIDsp+aqBKVSg1jbzYqpdCyub+1lnn/fBpnt89+8P1Rcne2CEur+lzEJPnKr1hcwhX74Pie71jSsowYslp83IDI+Bj3ECL/XsYs8bSX+bmc15AzeXLAX+Ha7B9kNt+2LnSXwVXt2whvaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784726715; c=relaxed/relaxed;
	bh=1m9B3TqTXQp52+cm2Y/AlOog6dUAN0pTGZwsxsnFWrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDD2weJ6dXCALAhiT6s9zepI2v7ManHmebZGpGY8ltP1IAF56chTYlrEd4Z5QRUdW0ZBwpfKORdJJcUNHQnjvooAE4qvsSbX92HSryAPJ0tWrIcjYdkpLoWD6zbMSybHfEqUGRi0qKnVAJxl3pX5wmDW5bcQnF1y4YL9zkWBeXv4xCoDGBQc86BYHk3ZlJ8+FCexh8/8NbpmcavTjk35s5q3aK+e6gZlZ1skX7qjzx6O+/tGPmPbLxrZls9j0136feLRycZNSVb3qeLmklO+KLR8CKYC5a9JLOngJorxii120XJSNOwUTWSpXhxwNEnSQO1j8VVaIZQJFwUkrvPEag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to; dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Ikc5kTHT; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org) smtp.mailfrom=dama.to
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Ikc5kTHT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=dama.to (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4w3Y6Qh7z2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 23:25:12 +1000 (AEST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-84a2dcede83so12239951b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784726709; x=1785331509; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1m9B3TqTXQp52+cm2Y/AlOog6dUAN0pTGZwsxsnFWrM=;
        b=Ikc5kTHTD2uzA05BOKMOChj3oT4jbzS/IqdxaVNgE2uLw2tjsLoeNQuUxQjUGiUdvo
         /vkr0VGrJtgUVz7vmHP6dxHXJ2EqZmw+3gYp4rPZsf/lRm32/UmCKVmYAttAWK9GDlJi
         0EhlNOZkF1K2uka4IKgTK6i735qvVBOZMwZMriuj7gQgbnMopiR6aFLEB0C3gTy2+kPR
         ffVJUx1yw38OIiSeYg5ZvBV8+j6nlS4zRx9OUw4j9xb1555dzFyltvHltedfNY57Z9la
         ihomu9UDsKpuDMXykjH85AvN/DZloDv8j3/ZLPHypd5RWV2I3pEHuaNxPteDDAELfweM
         WMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784726709; x=1785331509;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1m9B3TqTXQp52+cm2Y/AlOog6dUAN0pTGZwsxsnFWrM=;
        b=SxkXgII2kBqSBgSU5nyq3Qa9OgIV893c8SX5iBqZn6ygLdpDI6kD9FIg26XXU1FxBP
         KlsLV07mdTTEgNyImKEEqHxEoyscZP9uNmfcybQ90AhYkux+4i/dFqxfyjFUUU01HhEm
         +ZVQwbS9+/d7QL7LhA9lUAMMwQNyeBK9HRe7cmkNaa7Vv9xW6xXZJVXBkBKrmG2tVPy+
         RhObZEOJXgn32GR9UM8k3JXbrIO2kF9W0684Y2Em+Rm1RPDq1FfE0/8sCTS0iBUdHn52
         U1vWXcOceZIiK9PomJ7RBSv9IL7viP4nqgIGPD5t1gQ7EOzc9zwa6Q6iFEptu84uKHZT
         TUbQ==
X-Forwarded-Encrypted: i=1; AHgh+RqiDAlpkyMH/F5T1RaGS1L9zJ/XO6xElgLziPql7LMboc2QuQ5uHCC81yJ8Io0NSmPONt/GwjRvxgS8zwE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyRifE3sU1PAIl8tua3OtLvNLfITVRWZbjQ1AHnCV/68EBZpvwM
	erm1SGgpRo+3lJblS+6i0e7cVPna2Z+q7etzBl37vHGxCVW39R0vSyH7J2yOnlnmldM=
X-Gm-Gg: AR+sD100/LZdgAFMvqhl+Gy8VemQqETMHWmf92y18QKBIOxVilfz0dDyyVH6RvcpsCL
	kpljjBESdziy68kUhN/mMZEZ0Roci5ZDIMRlKgBK+8DfeJj1o5rkEs5+1fwdbQ65OcMKxHDPPQx
	88vvmiDj73cqksxcwPQS/l5Iq960ww+zVcfJFxp9oJwmJw5CQ8umIWJPSMOr2mHTgWVmlGRl3RK
	MkUEqZBarKTbF2kaXjiod8eNTnGju9zNGcU6vr/lsv5hW0Zd0qK+0Di2zQoZzo5D3KklQp/1ed/
	NU9nTArruHcozgNdigwj0d96wQVjbSfYLgwURRkH5rg2KCqOQk7tXR5Mjk+0+pVylUmDzWG2ZKq
	13sP+2liUZEJ/ZxiPe8wqDbfvNmot6VCmbPJ7dP0mrx00D7f26RojaTUH6Bk=
X-Received: by 2002:a05:6a00:13aa:b0:84a:2ec8:fac1 with SMTP id d2e1a72fcca58-84c29545550mr24635234b3a.72.1784726709431;
        Wed, 22 Jul 2026 06:25:09 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17602046sm1332323b3a.59.2026.07.22.06.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 06:25:08 -0700 (PDT)
Date: Wed, 22 Jul 2026 06:25:08 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 10/14] net: enetc: refactor SI VLAN
 promiscuous mode configuration
Message-ID: <amDEtJmcET788Lls@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-11-wei.fang@oss.nxp.com>
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
In-Reply-To: <20260720014317.1059359-11-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:12AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> Remove the enetc_set_vlan_promisc(), enetc_enable_si_vlan_promisc() and
> enetc_disable_si_vlan_promisc() functions, and introduce a new unified
> function enetc_set_si_vlan_promisc() to enable or disable VLAN
> promiscuous mode for a specific SI. This simplifies the logic and makes
> the interface more straightforward. The vlan_promisc_simap field in
> struct enetc_pf is no longer needed to track the current state.
> 
> As ENETC V4 only changes the address offset of PSIPVMR register compared
> to V1 without any functional difference, enetc_set_si_vlan_promisc() can
> be moved to enetc_pf_common.c in the future with minor adjustments to be
> reused by the ENETC V4 driver
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../net/ethernet/freescale/enetc/enetc_hw.h   |  5 ++-
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 36 ++++++++-----------
>  .../net/ethernet/freescale/enetc/enetc_pf.h   |  1 -
>  3 files changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 66bfda60da9c..16da732dc5de 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -185,9 +185,8 @@ enum enetc_bdr_type {TX, RX};
>  #define  PSIPMMR_SI_MAC_MP(n)	BIT((n) + 16)
>  
>  #define ENETC_PSIPVMR		0x001c
> -#define ENETC_VLAN_PROMISC_MAP_ALL	0x7
> -#define ENETC_PSIPVMR_SET_VP(simap)	((simap) & 0x7)
> -#define ENETC_PSIPVMR_SET_VUTA(simap)	(((simap) & 0x7) << 16)
> +#define  PSIPVMR_SI_VLAN_P(n)	BIT(n) /* n = SI index */

I suppose it would have been nice to only have a single space after #define
above.

The rest of the code looks right and I think the promisc logic is clearer, so:

Reviewed-by: Joe Damato <joe@dama.to>

