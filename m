Return-Path: <linuxppc-dev+bounces-23145-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1985BC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 23:16:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq2Fz2nvcz2yRM;
	Tue, 30 Jun 2026 09:16:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782774967;
	cv=none; b=FOjrTy9EWpZWXuuSq5N2ash25so6uWyu+UxIMu27WDHIXhBdOjjb1iL+L6axR40JexVmrqAYKbr9ORoqjgoQNlPNLOsek8wXa4/u31gW9JzV1jM++5IanJiyycl/kMxXE6NGEhi+0CRhQIcflCfo7TgxZ4/aC4CJThDGuJSH7q/UxK4ZbHmVAr8YtwhYFLM2QnmzY12CyDW3PREFg6U9NvCtbZTheSQFXfcLb8u1JrICl3b8c3+Hcz9UIjnDDMsNjYsgLIDms5f4HEdueUo+OoStlLVG0K3xCxET8NG7GK/e04WRwkFTn4Ank6zRJ6pqqxa2Xs5AXajqOv5IL2orpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782774967; c=relaxed/relaxed;
	bh=MwyQLZ9TpvSzRB+VQf48dLfzIroZXC4gFHoxVqtwU6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXo/dRrFYJfVVi8qy0Mo0EiAF0LZM+mPnKSwWuXTOyM1PYyTPKxJfX+4U2IUHZWkVY8hdJfyZk8i284vVyj/0C7LWjeh5jfgnpvA5fJ4wubOu4VBTAz0iEeQoX2PcYNbdPTPmMgh+X/oC3UcymDeI5QBztRWKENx6e5NeSutyudGLXWTm2VqENZqkEv+auXfGwBebtIjUEr7WbDruNfI/anOZRwEpGqX8Wiy9Qaa1ey1OxAHOHuHKeh6q6qptNccVWbqVseHJ7TN/0rWK4aa7si+VrFKGRwYuHtQ1y4W1FrLu7ify6TfMJYyg+gDqadcTmHyBpTKnNZEEqHYSXfdSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2I+yRMp; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2I+yRMp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kuba@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq2Fy4J6Mz2yR5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 09:16:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B2AB160008;
	Mon, 29 Jun 2026 23:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF38D1F000E9;
	Mon, 29 Jun 2026 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774963;
	bh=MwyQLZ9TpvSzRB+VQf48dLfzIroZXC4gFHoxVqtwU6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O2I+yRMpFaBx26CCnGVgioJHFGtzKq+R0bOVsH0oasj+qz1/Qx+P30WSLoVK6Dava
	 udbqHxG3UcgZSodQ902oHVWW3FHjNkOSl1wrmdOavciBShtML5Py6dtOjy7sfIcKEQ
	 uLgGk9yqs87/rYDLks/3jdeEx4Q5q9N8E2v5Vq3pXXZz1MGIRHRWai2IVT01VadyB8
	 74TzCo2ERx2JNIMZaR15l33btYCEUG5e8NTUA4SwhsxMXSkVa9VurvOUkps/m97X3L
	 C3v8o2x+VPc2rrKoCHUtWhAxUPt0V9P7LZeXtJlkB2nL+6e3EF6iB42OfucbYu1YkN
	 whrO7lQm85p+A==
Date: Mon, 29 Jun 2026 16:16:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Mark Brown
 <broonie@opensource.wolfsonmicro.com>, Thierry Reding
 <thierry.reding@avionic-design.de>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Srinivas Kandagatla
 <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod
 Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo
 Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan
 <saravanak@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andi Shyti
 <andi.shyti@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Doug Berger
 <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Matthew Brost <matthew.brost@intel.com>, Thomas
 =?UTF-8?B?SGVsbHN0csO2bQ==?= <thomas.hellstrom@linux.intel.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, Paul Cercueil
 <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Maximilian Luz <luzmaximilian@gmail.com>, Hans de
 Goede <hansg@kernel.org>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 driver-core@lists.linux.dev, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 13/19] net: mv643xx: use
 platform_device_set_of_node()
Message-ID: <20260629161600.185e0eaf@kernel.org>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-13-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
	<20260629-pdev-fwnode-ref-v2-13-8abe2513f96e@oss.qualcomm.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 11:12:36 +0200 Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Jakub Kicinski <kuba@kernel.org>

