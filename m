Return-Path: <linuxppc-dev+bounces-24570-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4188C44524
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 02:22:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h41Pn2DKMz2xqJ;
	Tue, 21 Jul 2026 12:22:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784561342;
	cv=none; b=IwdTBzErCb6y7jy8Rtqc0Uc2KdUSBwWKPSEW61LESNYrNfgKS9qPhxmUH1xbUxMr8ckysX0bX6c1wugMZ/64M7rSH1Dp3Yfz0xcUYgqh8zwMLIyPcN5SJPlrVTCw86wF5aKbuzoSakV3n1RfkXpktYf78s4ZDg3ku4jbOe+N7/M4uVa0jdMNldqwvUTqG8VBergQLYbOoRvAKni/o+Y/uSMX6c05oKPF5w+n58Nb9iI2vGT1pA62YiB7chDEuycWklr/nS6yEz+BtkfF8P1rPniFyoUyQ4r97DYr9BICfbrhCE8FFsL5QbeRoYhFKDxZICLhOBrFBTHoRJ+hNacYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784561342; c=relaxed/relaxed;
	bh=bgz7Y8qBkufWfij3p6tfrGVbR4yOWWu3669don02deQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuhvZuJISxAOHb9byJvbecXA0fEFKgpImdbZgvoCBwjlEGDUM/BPk2RlU5Um0/jPb2os+H2SFXMEQROhpcHTp9iGyo4JQyLgEvr/Ej6sQEQTEolKL34xxN+44TluAe1VfUif2I8d4VigCSebesXm2nn0Z38+1QUC4oPnRH9gp0nfeuSI/O0RD4cG9dhmzcgT7wKP8sKtwCddUWDcnZvokFTPc8tpqplXIQERvmfdcpwrlYA97Ee6bFptokb8Vi9mklRoFpf06yr/kq0Zzk4kDV6xEQxWFbYXJ4EcsazqHhO8mqS+qVpmdXb7+W6vjNOTO6GjgAZKs0RexgCqMWGtZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to; dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=hDqSysrn; dkim-atps=neutral; spf=none (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org) smtp.mailfrom=dama.to
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=hDqSysrn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=dama.to (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=joe@dama.to; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3kvK4lB8z2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 01:29:01 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2ceae1ed204so81131675ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 08:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1784561339; x=1785166139; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bgz7Y8qBkufWfij3p6tfrGVbR4yOWWu3669don02deQ=;
        b=hDqSysrnk0F8tB6uLCjOiHmzI1in1qSMzESOK+57lks7eykc5UVavqwHXn8OH0nLO1
         XuMo8QGFKCN9bl9nhEYKRbcnk43cxOPhLXHR3oaXGRH5n8oCxQVb4F3/abvO6jcYtzde
         n0+VHa0O8IrvCKXZHCEETUxJGM0sTHVn1ZgE2UrWWxQBogaawZBfadHD8WMj9qxQPj2L
         CABbImHvIekAlvgRp63NaRhCFDQODIRBc7gkBJRjAQJOXdD0l0rqOOkOxjSZqvj0zUHk
         cKbbOS6hUCiVEukJ092Q+7P1TilrQKWnBxcquaVYQjAKfwsmSU6vUsIajd44YDJNkoQf
         v1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784561339; x=1785166139;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bgz7Y8qBkufWfij3p6tfrGVbR4yOWWu3669don02deQ=;
        b=ZrvXVZRzP4t2bSYuNkG7wmU0b0Vbap0gAT/8yZQCLfuB+UPLBUS8FYQnMuOsDkLZ2R
         56YTlHOAOc+y+33jhV2QFtf/DFR665O2RjkcJbTAQqdjL5/bniCB/Eoa/LryQLGGRXPa
         Tm4OjtBRasMCj/Kl+QVfz57iQIJ3T8lpc4xBn8op8R2zHhdvKiTQyzb37IPAAx5baeDU
         DArMIIbuinNSSstVdxZgHl64sNfUurZ/gNdvxhQsGTiVEsjPuCVsoREfVspGSYlyAczJ
         jqaDFF84qxZ1TE8yQo76wI9rhLl/ZGZRzxQFw6UDQLVAEXeKe5OYTOUC8v2T1zTayaO8
         Z9rQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvScQcG5jFlq6L5JKJtsMUHq1+VQD2pvEjj5Ld3fpAHRujGfCGgTCti0gpHQFLyChqlFkI8VTZXLRYDLw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyH0SeS1Hb5A5jsSnedaQs1ln2OJb7mxygEWPh5sCZbq/E1TGXu
	XuK7Op6ykjrUhJS5hDimrMhDklNC+26IBtWhfEDcolncOhm1Rx6xy3PmSeHxgHZzGp8=
X-Gm-Gg: AR+sD136dxfckyalKQuO9kwGsMeDSHaucV699H8aBWgWEP0l/sFwHVu5oLtGcBztUeS
	6lXRVAE1C14ovpeOfbtiBBUMbeA/iz2no5Kznfoi3qZoC4hVtQA9AbwLvX7JhFnH0dYnz9j/Gtx
	Bl41ay0wrqqZhSAu5qOEoWnsykeh9n9wkhT1NCszQuU5BT4gCa6fjQaDdfe2u0LoWA70P7OyLfy
	DWK2SnyPkKTWPkydDjdL4vt+e4+yZ8S2CMVE2ucK6zGJdzW25jPv96BI5i2IwByXiyL3XxLgsbg
	l3BTKa5fT1DUYSrcM8FcET6pumw2qsWL5lRvzlDt56/J7BiGserP/Iz3o1c+IFe6zdjtw24toey
	tn5xxNaKPNWUb1FzjeU07t1n5gKgwRO2tvoELhb3isvPh8HdmtIpkshBhJ6o=
X-Received: by 2002:a17:903:1b25:b0:2ca:3b31:ef4f with SMTP id d9443c01a7336-2cf34a0a6b5mr140652465ad.40.1784561339559;
        Mon, 20 Jul 2026 08:28:59 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34730e35sm58695305ad.64.2026.07.20.08.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:28:58 -0700 (PDT)
Date: Mon, 20 Jul 2026 08:28:58 -0700
From: Joe Damato <joe@dama.to>
To: wei.fang@oss.nxp.com
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	wei.fang@nxp.com, chleroy@kernel.org, maxime.chevallier@bootlin.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RESEND v4 net-next 11/14] net: enetc: move
 enetc_set_si_vlan_promisc() to enetc_pf_common.c
Message-ID: <al4+uiiXKgaNBa91@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, wei.fang@oss.nxp.com,
	claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux@armlinux.org.uk, wei.fang@nxp.com, chleroy@kernel.org,
	maxime.chevallier@bootlin.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
 <20260720014317.1059359-12-wei.fang@oss.nxp.com>
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
In-Reply-To: <20260720014317.1059359-12-wei.fang@oss.nxp.com>

On Mon, Jul 20, 2026 at 09:43:13AM +0800, wei.fang@oss.nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> The PSIPVMR in ENETC v4 has the same bit layout and functionality as the
> PSIPVMR register in ENETC v1: bit n (n <= 15) controls VLAN promiscuous
> mode for SI n. The only difference between the two hardware generations
> is the register address offset.
> 
> Since the register functionality is identical, the VLAN promiscuous mode
> setting code can be shared between ENETC v1 and v4 drivers.
> 
> Move enetc_set_si_vlan_promisc() from enetc_pf.c to enetc_pf_common.c
> and export it so that it can be shared between the two drivers. Add a
> revision check using is_enetc_rev1() to select the correct register
> offset (ENETC_PSIPVMR for v1 and ENETC4_PSIPVMR for v4) while keeping
> the same logic.
> 
> Remove the v4-specific enetc4_pf_set_si_vlan_promisc() from enetc4_pf.c
> and replace its call site with the new common enetc_set_si_vlan_promisc()
> to eliminate code duplication.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../net/ethernet/freescale/enetc/enetc4_pf.c  | 17 ++------------
>  .../net/ethernet/freescale/enetc/enetc_pf.c   | 16 --------------
>  .../freescale/enetc/enetc_pf_common.c         | 22 +++++++++++++++++++
>  .../freescale/enetc/enetc_pf_common.h         |  1 +
>  4 files changed, 25 insertions(+), 31 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

