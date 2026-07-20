Return-Path: <linuxppc-dev+bounces-24498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D08C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 13:39:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3hTK4XqRz2yb9;
	Mon, 20 Jul 2026 23:39:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784554789;
	cv=none; b=ev9PjaaZNyp6Ns1q7oIQgzXSbYfYBPhZDr82VNw/w3VRvP6DwR/8JbUKgEQY55sn/aN2D1fzAD8VwMLIJTZ34z5j75I28dFCTz39VKoUuraU4/izTYD/hD6R/WBlxb6ObNB5BGMrEdxRuj32I8oH/oPdgwpVdq5iXjbs+gVCkNKCeUJ+TGt/abb0o0B81p3LGWjV+tV0i5HR+ZOOnIoUnAkHUoWpZ4usebPpzE+PxPgOVBGqhthVZ1M7feyAILXsnl6jAF0mxE6s14wwErMUSg6MOIyw72B3MnKjOChYuz2g0BtTrOr0AiQpEEGpOeLHHlmynuqaH5hqSd8UOinmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784554789; c=relaxed/relaxed;
	bh=hEfQm+fNIIIRf5G5yrPlpKCXyKnl5+VCOUdK6KCQ6M0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNM3JDci+n+HjcXcAeeFHrNOvwdvAsNpE0+c8KZSB4b9bOkdLIgNp23J91+uNHJo4q8zMgawiHT7Sm7KRpmqd8/e8LmzJMh/qwEIgB+zFPoDUR6ll2exvEdyXtV9FMs7uO51IYY+evgJ1cQf8AuTraIF7+kkoDxvfojkJuKqkHgfhmjOONkXIt8dpnp+b/LJh845GjTXmMNkkrBiqG2i0pihBb5kvWwtbreojFpXw+F6hpUfiCsqIx7wEbSKC0wV0DeC/NOKp85bYSCO7Fdwcs8N/9jWw4uEwiSc/yvlrOxjR7J9xPn7w66ZOm0UjTVHd29HSwOFRciGIpTsLBQP7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P753WMTt; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P753WMTt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3hTJ5vjqz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 23:39:48 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EBB3343D11
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 13:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23631F00AC4
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 13:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784554786;
	bh=hEfQm+fNIIIRf5G5yrPlpKCXyKnl5+VCOUdK6KCQ6M0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=P753WMTtN3N/cdKM2rY2AoaIhkA7WYrrYCdJsRLRzCRtZ2BULO9ng7zimHh1IdaCs
	 fbCxpr5ThdzfdSwVSQDaUivRYyRuMuJEf5/fqVibX4WYKdyOebzVqndyuRjnB/sNhA
	 9WPq67iiivZuCEeNkfPelDbHJRNWUvq9pAELM04tvM2V8ICy5f/zflDt+bbrRlCP95
	 WZL33cEVROLzn1dW+DKptxGGr9LPvRP4ciXAIH7uRXsSWzOKBMeIHS95tmiFM8ZXzt
	 L2jzwUEBWKVVmJZLSkO6sk38+BxkCWahA9EDVYUN8GZ7DmvJpSZUPYcvLenowKtbyn
	 llmHGxpg0L1Bw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c9452244aso92077501fa.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 06:39:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqbgic1pDdGqY5069xM1FLuMGDkzr18/GXuZ8lS92G2qcjzVF5iqzDbVFd3GRccqUWBs83w6MAS4+C1fkc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yykl2J1H0/SWR5TUXJmrxKmQa/ETWwKlk4Fj//YP8NHCe+cA37D
	1vRfyORWQ2dfSgBZJd/nqtP6oXlDmHBvMVKjrFNUnm0HTylJZWnMVT9cW1xyU6dZB8HepquiuI6
	xrCV8whJzKJzmxVI+x0A7DjwMWolhlCaG6OJFrpJAGA==
X-Received: by 2002:a2e:be29:0:b0:39c:a06f:12ba with SMTP id
 38308e7fff4ca-39eb294c61dmr29234131fa.40.1784554785347; Mon, 20 Jul 2026
 06:39:45 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 15:39:44 +0200
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 15:39:44 +0200
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <e4f9b266-8d9e-48fe-99c0-58b61e02c9bd@arm.com>
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
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-3-2dee93f42c54@oss.qualcomm.com>
 <e4f9b266-8d9e-48fe-99c0-58b61e02c9bd@arm.com>
Date: Mon, 20 Jul 2026 15:39:44 +0200
X-Gmail-Original-Message-ID: <CAMRc=MefqCMgVv-o5hWoRwS2iXPQNs5nH2qHiz55+ew162LfSA@mail.gmail.com>
X-Gm-Features: AUfX_mzO2mZAcAjFU14cJl1wZGPQmD5GzWNsNbZLHTzrF2PNrvf-Va6RwZ7OmuY
Message-ID: <CAMRc=MefqCMgVv-o5hWoRwS2iXPQNs5nH2qHiz55+ew162LfSA@mail.gmail.com>
Subject: Re: [PATCH 3/8] iommu/fsl: use platform_device_set_fwnode()
To: Robin Murphy <robin.murphy@arm.com>
Cc: brgl@kernel.org, driver-core@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Srinivas Kandagatla <srini@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 14:58:27 +0200, Robin Murphy <robin.murphy@arm.com> said:
> On 20/07/2026 10:24 am, Bartosz Golaszewski wrote:
>> Prefer the higher-level platform_device_set_fwnode() over the
>> OF-specific platform_device_set_of_node() for dynamically allocated
>> platform devices.
>
> This is very much non-portable code specific to OF-only platforms, but
> if the intention is to remove platform_device_set_of_node() again
> already, then FWIW,
>

Providing platform_device_set_of_node() and using it was done to make the
transision to expanding reference counting to all firmware nodes possible.
I don't think we'll remove it just yet as it doesn't make sense to convert
the code under drivers/of/ to using the fwnode variant.

> Acked-by: Robin Murphy <robin.murphy@arm.com>
>
> (Although I'm slightly puzzled by the cover letter - AFAICS in -next,
> platform_device_set_of_node() is itself very much a user of
> platform_device_set_fwnode(), however in terms of symbol exports,
> perhaps the former could now just be a static inline wrapper?)
>

Sure that can be done independently later.

Bart

