Return-Path: <linuxppc-dev+bounces-22026-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E9D4CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 12:33:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWPB83zNpz2yRn;
	Thu, 04 Jun 2026 22:33:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780576416;
	cv=none; b=leuTe0ShznOwkSPZ1wDD44oPOZIevlMapaZ7/uylavqiWPzLVZs+2knEIyiCzbXLTv4xA3tBHGElHlGBLvnwR19F4DylSGdlTyR0S7tBQzzTQZJyr86LALpSFfItLZq08eg/HTPCxQ37olwKuMyeskzHIM/6hLguBJxgPbtxikcC4eZ28Ypzx/jZi0tyJ9Ir8/0wWKZJatPe9+0yGHZDRJHl1YOpZ1iKj6+f2Yc2Zj/gL56bPCzBj0Vo+QJAq1BjijQJDj8bkUzC3440o+UFSpQ/3P88+rg96ACcEWk+qJlJ724fUHeQaAb7uePd/2WGy+S66b5cOKr5J1wbumjMpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780576416; c=relaxed/relaxed;
	bh=5kiOPwwtw5er+j3pQh3lrbhA4I9B2m+C9oKB0UBWW9E=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kiMr19H+3MkXtbccp6cCk0WVZnjKxsoqLQFxPCi4YArw3eHFCEAX6MN60rfTFlNJq+vHqwhz79Qy9XBNQ7X+vWON+8guowyfgCkYypp4wXyf7sl13aGEojUNppafm6nzXTMQktusztWt7QoV21Q/eXGY4jFDUnLVmDL9hDVXl9+bcHZhz169vN5na/RlYIdnL1IzTe6Z0T7bDichpR/paM22R3ynXCr1AQhDKx8f+LvryGuYzXDLTzR5MYLX7E4ahNY5bluH6j+JHiqnDoMMmKfmsUOxZ7/xIoFqjmsxSQCS5/Yp7xxwNoPI3Fhs/0A5XqK1WLh+OdD8BCmkl413iA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fP9rNTi5; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fP9rNTi5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWPB75LGhz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 22:33:35 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BE5F844662
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2026 12:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8571F0089A
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2026 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576413;
	bh=5kiOPwwtw5er+j3pQh3lrbhA4I9B2m+C9oKB0UBWW9E=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=fP9rNTi5MtE7GCGm/x/LyhMZobzDw2BPjzDPFH8vu6A2Ihc1x0gZCGx/8KHtKr+NQ
	 9VU8hrkHxq4QD3yOaMQhJxyg5QmB193Bl0ZPkoFOqK9aG4fqijPuyGUaShi+2Kcg6Q
	 WNJyWoBtHQTw/ffnZhT2lBeH4E+j/daht+qed1ocXq5IaM7LCqk8LdZ6oiRSFoFWGH
	 qVMkffhSF4xNFZpT0RuH0BP/QIMVy9iVKoOdwGpjFzetMPvPPN/kFu3cFOoETaSWHA
	 xRtqHx+25lqBcSS+qwunrA10HLhbGycr55T5kf3P4VR83pcARAwuSQhBeLmDEXT+H3
	 auAKRLtqmlw3w==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3967620ceabso5981191fa.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2026 05:33:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/2W4uJkiTzpRkUEBc/zD87SIIA6545GIcTMfA1eUJHkwsFcTB8o92lujLByYdFGIqdil3s5Tic0tKRQNw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw8SNHIs75M0dekOvdgFpwytHq2zix3GLoYlaAcLPdjDgC3surO
	D+ytut1m75ogkDSeO3yvhqdF7YjRItXPhlydKOhogBMicajp+PyzJto0D1Kp2CY/O5zdcJoVu07
	+D6DVP6Qa9hotkxb27RLs3P+jk2SEIJSAqWl4Vg7YHw==
X-Received: by 2002:a05:6512:2256:b0:5aa:6bd0:b1e3 with SMTP id
 2adb3069b0e04-5aa7c038408mr3094935e87.8.1780576412192; Thu, 04 Jun 2026
 05:33:32 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:33:30 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 4 Jun 2026 05:33:29 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ah9O15bMlAYgSlHx@ashevche-desk.local>
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
 <20260521-pdev-fwnode-ref-v1-8-88c324a1b8d2@oss.qualcomm.com> <ah9O15bMlAYgSlHx@ashevche-desk.local>
Date: Thu, 4 Jun 2026 05:33:29 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeFxtwwXvOD7FLmbhjpraDKa2O7KdwMaUXM-mNj7Ob2ow@mail.gmail.com>
X-Gm-Features: AVHnY4L20t8vC6nB7rdbE5RCKEyJuG_U-L0VQ-6S9fbqED8WJ64Vn6Fpm8JRl-0
Message-ID: <CAMRc=MeFxtwwXvOD7FLmbhjpraDKa2O7KdwMaUXM-mNj7Ob2ow@mail.gmail.com>
Subject: Re: [PATCH 08/23] driver core: platform: provide platform_device_set_of_node_from_dev()
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

On Tue, 2 Jun 2026 23:44:55 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, May 21, 2026 at 10:36:31AM +0200, Bartosz Golaszewski wrote:
>> Provide a platform-specific variant of device_set_of_node_from_dev(). In
>> addition to bumping the reference count of the OF node being assigned,
>> it also assigns the fwnode of the platform device.
>
> Can we rather investigate the way how to make that of node reuse thingy
> (which is used solely by pin control) differently and then drop this confusing
> device_set_of_node_from_dev() call altogether?
>

Possibly but I can't do everything in a single series. Let's take it one step
at a time. The goal of this is to make software node handling for platform
devices more correct.

Bart

