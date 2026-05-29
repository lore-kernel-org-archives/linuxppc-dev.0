Return-Path: <linuxppc-dev+bounces-21752-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1E2CD6E49
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 22:51:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRz9j70CHz2xYg;
	Sat, 30 May 2026 08:51:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780059351;
	cv=none; b=PPqTafQ7bybI5pCecxt28YO8Mv2eFaje8/xiZb09c4Slb1W8tiDMjKl8bg4qfkUOyhH/eqiJDYE54U5d4xkqykJUuW0dMiTyHJ7LUXyFotHRsW7PGayQKaV57oEBbmO0JeMa7nb1N0NzhSRbID6x9ZkdQNES90BFhK667sH1WFmnfk3O4G4ZzIXcWHpLARa9lmyTmXIgPcgr4HBmInhy9TmBTp+1K6tMHR1i0aYnZxuV06MXkTo8mECCwIVJPXtdNWWyZqObt/1N0butVt4y9A+cf0SxPGTAU0KTUeoQfp/sK6Cg+M85vTFTA0aA1OZiOKZlQtOtqpi0LslRfPThcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780059351; c=relaxed/relaxed;
	bh=+6AiMcZa3bd0LPjamkN4r9S9jW+Apu//pCbttaoWdDI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=caBg/ud6LeQ+Dbx2+43n9N2r1g5kK0xKHMBo1xOk0PyEb2FJ/LdxNu7j+scit48073lB+lvFiF+mdlB7rM7kI7uJUPnTbd+61W+KV9vDeQ+WMV8iQ6kwfnMY2fvSSjbozttb4ZOoTPr545EnojUZEnvSesCQmsztPfXPap/BaAFDmKesB3/hR9p8Wkp+T0MaWyE+qFeLXSE/FO1opfHd0PSucpktT7d7iUkR/auVbYSr3BPNMLTw21H0nWaP6hBnjaE2cBQnSZQzJdPH9A6HdsqzzaV+rb8xJHHHTyX+UDCmHyvnugezBomc3gRcAZPTrKB3VoYReYDhetbe+xVsEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKme3PJu; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srini@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HKme3PJu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srini@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRjyZ4P60z2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 22:55:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1A6B8605AB;
	Fri, 29 May 2026 12:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6271F00893;
	Fri, 29 May 2026 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780059346;
	bh=+6AiMcZa3bd0LPjamkN4r9S9jW+Apu//pCbttaoWdDI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HKme3PJuW/g8Xe3fa9pH4ndcExyYxHcd2cNlg9NECKqK4v1asLZhvhZEXzEeGPFwC
	 krMU26G83m8iPSglCfYKCqgciw6JWvcuzjQUTI3wFtoI62nF0UChddzGFraXimF9pJ
	 1k54Uu9U94IdLdsnRGH4hwmLSLP/pSSK0uKpJsDzqk30FcWpIwESOtKLiumR4V+6As
	 unm055hDnQ1A4hKk4u4dzRoTU87SIvLvelBGdBip7ZDoIZon4MXvQ/IpRhuSbyjuUY
	 udebOV+LpQuBbeFt6sWaU5lZ0itKuFGMHeMAFQa8OxgbyKZLGpVxsvBB1IjU2d1o4J
	 48Eb2LMB+rd1A==
From: Srinivas Kandagatla <srini@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Mark Brown <broonie@opensource.wolfsonmicro.com>, 
 Thierry Reding <thierry.reding@avionic-design.de>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
 Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
 driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 00/23] driver core: count references of the
 platform device's fwnode, not OF node
Message-Id: <178005933352.9337.17178239685242465219.b4-ty@kernel.org>
Date: Fri, 29 May 2026 13:55:33 +0100
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 21 May 2026 10:36:23 +0200, Bartosz Golaszewski wrote:
> I'd like to first apologize for the long, treewide series and an
> extensive Cc list but I think it's important to show the big picture and
> the end result of this rework.
> 
> Platform device core provides helper interfaces for dealing with
> dynamically created platform devices. Most users should use
> platform_device_register_full() which encapsulates most of the
> operations but some modules will want to use the split approach of
> calling platform_device_alloc() + platform_device_add() separately for
> various reasons.
> 
> [...]

Applied, thanks!

[03/23] slimbus: qcom-ngd-ctrl: fix OF node refcount
        commit: 0208edaf0b32cae5b922729c4ef52dcd865e2e19

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


