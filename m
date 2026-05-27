Return-Path: <linuxppc-dev+bounces-21597-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD7BCD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 15:36:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQYcc67Y2z3cZ1;
	Thu, 28 May 2026 01:36:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779896176;
	cv=none; b=i+xHhPO5NLtFU+WNlOjnp6WRUOTkRt+8E7CCren+8xL5vttiagdOntflppoW/r1eKCwPRvH1A6DP10W61AOIeyet5TxS4pCdVzxmr2vFUafAcX9jLz2YtPNY8yFZGZSIktLeRcw61S67jsOpI+lDtLtImVLTHqCCltAr+IHonxxtki1KQD9xW8Zvqc6JhXTavz/NIB9zI2/ugPAsqWvHGRm7rCuOrtTnxQbJ7fpavJZZCro+6C2tlsuf0+8Y0nLs35xJgBlqmM3vlBFGL8e9Bbgil+Uc3xTXJcC20DSJUeQ8OXwTB73kCpF4ZqBEK58CBi9bn1Vyim1qGr6u7aEfng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779896176; c=relaxed/relaxed;
	bh=tyMTaumHRjBinJdhP3tD87rZtnu90BQDmn//aI/sKmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Kry3LhpA7dRilwpq7W/giRaCmlRydd8lTF4KmdmvqY1iCCn/9yJWVkFiX+0Qj+xHxSveOJBEYukzA/pjg3JvdDXMXNOFjkYybtt/xetDYB7k0pFEAfh+H92jGBGhklOjHDOhgeTr7InP2I0hVzLcVN4pZtQC71ztGcAHHmdgknMoRQSEaJmX8LwbC7sfsv7n411J2GCp6Rg68imT2yjvJKTKreDrO0v360X+eVfJa+jRlms88u0AqIje/kNXztS0CUH2EPPlZN409ul0t2vxclOCqfepAQ6HWdkeoOfDLnOKEUMuMW5JCVGl2jR9aWhKCIEW4Oc12qAx8agghLrW1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CO7NzX0a; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CO7NzX0a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=lee@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQYcb4GGnz2yrX
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 01:36:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D03B24031F;
	Wed, 27 May 2026 15:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142B81F000E9;
	Wed, 27 May 2026 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896172;
	bh=tyMTaumHRjBinJdhP3tD87rZtnu90BQDmn//aI/sKmo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CO7NzX0aE0E+SHj+82S+F/U8cAQzuwA8hkUPUNhJLQ2phlY3RB4OcpfkpOC+dW4us
	 qjbQuYT4T45deTaGv3FFA8SHPEUNFhx94kaWnwwyDuaie2bUyyAN0N5GPX9GmjjbT8
	 yx2NyadlN03P0nR703Zi77z6eXdY9EVjHiC85zMb1twHn3rLnsS+bt/vbWFG2XZ5J/
	 7fNu4YopxFJ1v2ZqzTS3CpuuX1QzQ6zn1hKuaz5vYmfBQaCyMiCiE685vOoS+B+oKi
	 t8mW6mahwlddIi1E01MbB0ycvEVyQW350njEZzE+LYQZHRbCx9c6rKFsuimdasqz1e
	 VM+dsl4Rrhleg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 Mark Brown <broonie@opensource.wolfsonmicro.com>, 
 Thierry Reding <thierry.reding@avionic-design.de>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
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
In-Reply-To: <20260521-pdev-fwnode-ref-v1-1-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-1-88c324a1b8d2@oss.qualcomm.com>
Subject: Re: (subset) [PATCH 01/23] mfd: tps6586x: fix OF node refcount
Message-Id: <177989616081.737612.15563215651036638106.b4-ty@b4>
Date: Wed, 27 May 2026 16:36:00 +0100
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Thu, 21 May 2026 10:36:24 +0200, Bartosz Golaszewski wrote:
> Platform devices created with platform_device_alloc() call
> platform_device_release() when the last reference to the device's
> kobject is dropped. This function calls of_node_put() unconditionally.
> This works fine for devices created with platform_device_register_full()
> but users of the split approach (platform_device_alloc() +
> platform_device_add()) must bump the reference of the of_node they
> assign manually. Add the missing call to of_node_get().
> 
> [...]

Applied, thanks!

[01/23] mfd: tps6586x: fix OF node refcount
        commit: 60a28e85ba5c0707b743857a3304107f2f9d0482

--
Lee Jones [李琼斯]


