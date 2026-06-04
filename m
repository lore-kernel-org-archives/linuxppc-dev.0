Return-Path: <linuxppc-dev+bounces-22027-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A884CD6E6B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 12:34:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWPC15sTFz2yRn;
	Thu, 04 Jun 2026 22:34:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780576461;
	cv=none; b=h4UUqTjaeU3hAAMkEGEIvjUO61v/KFT6LxmX2VSp2QJdFmkCnUqF6Zu2ryHROO5gMgJT/LQvUtd7x1qvGtq47vTSrbOBjkqQ+EUdOjQizvHeipgNqjaoCHUKm1tu0ygfSzBmkbJJuEfNkrZiCM+21suyNymQDAlQjN37oItN2DqnLFZ0EJKwcHGBn0Z3jk4L/I69eBiezlxIaMtx/zjCo0Ssu9szqD5PuJXqM5nkuvWqbDUXK6vAsc4oxoMbNlX+msP2c3CyzyZcstccnN//rI0zlYf8139wti1/ljQM10C2+oPi981DVkjkPCfG/PbvKiUojz+0Fn7lIHsg5h3gIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780576461; c=relaxed/relaxed;
	bh=kQ6M6FDKXPf9y7Y2G+ZlFRRaP5oLHz23vLbG+bNrvo8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5lpmQnD6QdLGlAuUuLbIcDZk26uXXG4CuBvNWAhef9D/DwcdykjPzxPlJ4tI4bTqJLHUpMoupxrqjxfUObSbuKn05LA4tQBXyC72DZ4Hu4IZw9HdVh06fECpj5HgkGXMv/agvFxoE8SdMfpduMVZaqUTpMEJcqNRTS0wnEQDbfrYeiz8Rv7v/XIoHfY4J9bz4F5Qt1l2Wt+SqF/GsUExk1wFqoh30OsHlDCjQC4ER5PYwyr07iLy+jicRtG4ELOE0Dl8nolfANGjzwCTgtJEGP20VkilXks4qWnEAfoLEVQH+Gi73/lEGSI9Mp2LdyPfcdETsbJtbCC6kCK2b1KmQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1ErmNFN; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e1ErmNFN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWPC10rb2z2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 22:34:21 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 97AF9445C9
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2026 12:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 671301F00A0B
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2026 12:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576459;
	bh=kQ6M6FDKXPf9y7Y2G+ZlFRRaP5oLHz23vLbG+bNrvo8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=e1ErmNFNc3B2GEwYqb/P6xaZrlvHojwGUKOx+yleFIv+SrequIqnOzpFPLS1QoJOu
	 M6UveWB9G9jMFR2xQgcuoOfCqwtUFLxtREEtbjlRtcR8Oiz300JksvjDpoAiEHZWl5
	 DK4tJNSy64M+EydtbLB3r3qwSx6AoeXlzSDvlHLB9/hX0rPhEzKIn8xc9Bfw8dWGhh
	 8YQLs+n/OsaOYQD5t+KUjWzIRs9cKpu34ToF65wYvg8QcIy+50z8yHU8exS3cwA7GT
	 lIqRVAp3Dz2GuvmZ2qOOkeo5ggbyFzMytBjaNxsOZHoXJpBb89z7x9cipR7tV9C/DW
	 ReyLRDqG/Vt9Q==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39677242021so5524911fa.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 05:34:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/NFNqwzbENjFk/8dLFdTjNHs2JETNRCUg36g2TFX5O+oRnhrnCl+EUxx45aaBl2OeThnluaKaaFV0hsFY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJW//JZ/DipMTZjUECbmBABx7bK8spZKpEIfW0+AzHBPDpjk2g
	jqReC3w6TSu8UTx8T4rYWmJUYECQPMca4R8hT242+MwDr2xsoTrhZ3/jgNoYdiv3ijUB9z8RcDs
	UgQYgG0aCxbqCG8hIdX5OsEDB6tDM5kTIRzyeQMZ/4Q==
X-Received: by 2002:a2e:bcc1:0:b0:396:8eb1:a4a4 with SMTP id
 38308e7fff4ca-396af436443mr25706941fa.14.1780576458112; Thu, 04 Jun 2026
 05:34:18 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 08:34:16 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 08:34:16 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ah9P6Xt9SyKgc2oJ@ashevche-desk.local>
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
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-20-88c324a1b8d2@oss.qualcomm.com> <ah9P6Xt9SyKgc2oJ@ashevche-desk.local>
Date: Thu, 4 Jun 2026 08:34:16 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdhjZhGL9tEx9WEjn2f95d=ObNM0AtBNpcevm6aHgpj+Q@mail.gmail.com>
X-Gm-Features: AVHnY4IaL6Srer7kIaxoyyrYpvf7EUQjky2qCo2_J16coVWA1ajpEEsVM7UfQA8
Message-ID: <CAMRc=MdhjZhGL9tEx9WEjn2f95d=ObNM0AtBNpcevm6aHgpj+Q@mail.gmail.com>
Subject: Re: [PATCH 20/23] usb: chipidea: use platform_device_set_of_node_from_dev()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lee Jones <lee@kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, 
	Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 23:49:29 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, May 21, 2026 at 10:36:43AM +0200, Bartosz Golaszewski wrote:
>> Ahead of reworking the reference counting logic for platform devices,
>> encapsulate the assignment of the OF node from another device for
>> dynamically allocated platform devices with the provided helper.
>
> ...
>
>>  	pdev->dev.parent = dev;
>> -	device_set_of_node_from_dev(&pdev->dev, dev);
>> +	platform_device_set_of_node_from_dev(pdev, dev);
>
> Why do they even do that? Do they have a USB connected pin control?
>

I don't know. I can't test it so I don't want to break it. If they don't need
it, the person who can test it, can remove it later.

Bart

