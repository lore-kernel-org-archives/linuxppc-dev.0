Return-Path: <linuxppc-dev+bounces-21314-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B82CD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 09:30:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLjnC64CLz2xdL;
	Thu, 21 May 2026 19:30:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779355823;
	cv=none; b=gqacQjVX4kJuxBHeYQQ4ajqxLT5nFbN2G64EU4Z4pir7+paWI3JxIiUewyDX1ZceAVtHqETu3mccqzqNdc/3RBGwr9zcHnzstld/EqkhX2RM5E5JNkaTsRvNzRKDrQDuEutnsCs3T4QcyyiXINwqTRCuL+g6RpiA3txznzJtBuTbEP4ixwTMBsb7m/Z5SXyOn7pZ5frKvJ1+wKU9ljYq+fQ+rW7RcNOTF+gm9Pe+EE20fmag/g45SSLd0g3919Pu1PzW1SGvA1bE2QBNN7HL01Va8BJLabPpMV7vDD/KznyA4fm/VxIqa1LiWuI5/0pmyGvZqqPzpk4/TlgzdCYlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779355823; c=relaxed/relaxed;
	bh=Ff12f+xeEXoOZ6ISjNWjK5es8Z76Ux83Stxx6bkIL2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cV/Ncu9NX+EeXYqkByE1L2LZ/7IWjfO4GceN0oBsjP76TmhYnxB9pxuolZdVrB2ta631z9/qjRuM+ZIveTQLSeF96UicDfxjU30Dotuw1fig6HCptbMSwNhyckl/yZyXsYmmYX130neO3/3pVTd0QlmBuoQzoR+5+TD7Z/UlH8Gqq2gz5DXdmw6AWe7cMGxBW8syiyiwdUm4rPyqDPT53l+v5HF4uf4bgnUnXHBHESOx+qkAiso35ZNitDn/ZK9zNIyKFg29plxlXFvdFp78BK2y45LQ7w8tft4cR+wmxFBA1daizuEEF5aKqlx6bzYD11XuK5wNVcCDDI2CECym3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=T5tm6Vpt; dkim-atps=neutral; spf=pass (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=sang-engineering.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=T5tm6Vpt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sang-engineering.com (client-ip=194.117.254.33; helo=mail.zeus03.de; envelope-from=wsa+renesas@sang-engineering.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 966 seconds by postgrey-1.37 at boromir; Thu, 21 May 2026 19:30:18 AEST
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLjn65QT8z2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 19:30:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Ff12
	f+xeEXoOZ6ISjNWjK5es8Z76Ux83Stxx6bkIL2k=; b=T5tm6VptISE3O93lHV5y
	d1q/FYUIW2uqPFQf4AutKE+i5zanr4UksjM12JMxuf3nzccBAC59W7CZrFMQf4ke
	sYwjOF5rZY2SyYYDIJNe8nJH8ByPTr4OfMy9I9PZeD0YPhd2ivJwqtoVLrYHUqol
	/qFE9/8U++tZNJHOjg8zaND7WbjUSiiz1WZbcFBTrKV/EIY7/NjJlJuBYuh7BD4z
	LwWph88oAywOufRMhvrZsuYznaAwP8ZpzepDh50Uq3KZ7DRV9tY13cWYAUbbF62P
	zMc0y1xCm5sFLOJwZQmj/qB46Aw1bcv3E7fQfmLpeC8uTSbrUAopKqMMpO19X8Qa
	8Q==
Received: (qmail 996243 invoked from network); 21 May 2026 11:13:53 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 May 2026 11:13:53 +0200
X-UD-Smtp-Session: l3s3148p1@tTS7VFBSRpwujnvC
Date: Thu, 21 May 2026 11:13:51 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Peter Chen <peter.chen@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
	driver-core@lists.linux.dev, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, linux-pm@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 11/23] i2c: pxa-pci: use platform_device_set_of_node()
Message-ID: <ag7MzzkiA6sseuVb@shikoro>
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

On Thu, May 21, 2026 at 10:36:34AM +0200, Bartosz Golaszewski wrote:
> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the OF node for dynamically allocated
> platform devices with the provided helper.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com> # for I2C


