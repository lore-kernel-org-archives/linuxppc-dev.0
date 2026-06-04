Return-Path: <linuxppc-dev+bounces-22067-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35984CD6E7B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jun 2026 23:51:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gWhDq3TXFz2xnK;
	Fri, 05 Jun 2026 09:51:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780617115;
	cv=none; b=L18T9YSPV7VvuGmCObTs9cDYW/aKGsAk7dT0Wa7EbRKBM5p0REUSBRTXNWWjgQjWybhpgjGfBbCZop/HhIpYkFIikkODsfdVG+pxpF99YGb+wS2RjosMDn/thIoBVXzzj/TIVCEloADSWrLlEKsg7FbH6AbabwRf9h6uZ509k5rD3SGsmvQrU3kkJF8Tx6DP6lFeKLKi+yhyUR+BqNo/7WmoZ6APSlt1ZEa+zDFK78TVbtSewed78/xhIz7N89NpRLXzyIOl7fqDmVIVKxdTjvsWRKhHJxpiZYbh3U3ESix73SCOPtBLpbKlILf6//8Acgh+SBzNScSTJkZy3p0bPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780617115; c=relaxed/relaxed;
	bh=qh7GaHudWqFS4OaIxaBj0xspMhNwznx2VYShs8Ojxj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiiCbt3gpjD2z+d1jxyVtZ5Zf18DjzNeVP+vCyiEuNnT4GY5qPO7Zb4JFmP3pBUkjfsxKAA5iB5BfOM35UJt/IgcLZDFYRlREv0Kw0EyIZ9r++wERDSPpxoq66EapXiRnasUqf4WWi4GHHpL4mmkqTUBzahF5AaNtQd0jfvrXyAZsnuN5FKBnAzmrGYYIOOO+aoCMRE5SXgECGCzakojrqnwRCIoE5H17izL042GLHy2W9WDa3wnAXfi+cUnjWQcpKL1/HIzIzbnzix6/ruj+DviTgf/tfQk85Z7zg+6G5dsZsDcvVKTEgKtaVBO2GGj88YPxgQK4ruXFcOCkanwgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKcw/Idx; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKcw/Idx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=andi.shyti@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gWhDp337cz2xLk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jun 2026 09:51:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9EE096001A;
	Thu,  4 Jun 2026 23:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4175F1F00893;
	Thu,  4 Jun 2026 23:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780617111;
	bh=qh7GaHudWqFS4OaIxaBj0xspMhNwznx2VYShs8Ojxj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jKcw/IdxZ03ISnE0pAxKMesbvA2zH37ofT1ZM6iLvTf8bkoWUUHHP7DKIvnR++TXM
	 Sf/wygPpPp5JQO1CJSW1ZQaN6+Pv3ZCFh5pYEcCejg/80HHXVHtqZ36q4p0FYJWVvk
	 uVCsNmN/MfBHpIYpTx/TRT9f0uQ9tCK7jkJNiyBu5hRdCIuL+1XgLZGfizTG4R9PHg
	 9HPvfyNATXVxxjTv8Ex0EVM1wPYQKGO7hWZsyb+6gcqoT7SlSB30uBN1rZq2p3zYTz
	 +QjuVQm/o5LXS9vCa6l2pSEEjJiVgs4nBu8n1ALFSUX0BbHDFAxRy6BKcGRNGYOB3J
	 ku1q3xR/wKM4w==
Date: Fri, 5 Jun 2026 01:51:47 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@opensource.wolfsonmicro.com>, Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Matthew Brost <matthew.brost@intel.com>, 
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Peter Chen <peter.chen@kernel.org>, Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
	brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, driver-core@lists.linux.dev, 
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 11/23] i2c: pxa-pci: use platform_device_set_of_node()
Message-ID: <aiIOrXwc4pNk8ihI@zenone.zhora.eu>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
 <20260521-pdev-fwnode-ref-v1-11-88c324a1b8d2@oss.qualcomm.com>
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
In-Reply-To: <20260521-pdev-fwnode-ref-v1-11-88c324a1b8d2@oss.qualcomm.com>

Hi Bartosz,

On Thu, May 21, 2026 at 10:36:34AM +0200, Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Andi Shyti <andi.shyti@kernel.org>

Thanks,
Andi

