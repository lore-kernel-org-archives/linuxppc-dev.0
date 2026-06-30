Return-Path: <linuxppc-dev+bounces-23194-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C546EC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 13:22:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqP2S2h7Jz2ybQ;
	Tue, 30 Jun 2026 23:22:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782825744;
	cv=none; b=VgVWMtScxKRWt1r2hatX+8LS0v6xXQBXDyV+U3FjerNRX8Nm4g40bFC7BpksKOIUxjkHIsV6DCxwTe+U7/UNUYS697KrGw79+uOVCvMqlloaxloUBdVLnUjotfepMsIQndw6jGdhPyM8tSUp9ZWTInU54OnSm83CJ3YsWJolH1WvuxvKWtyicSnW0bmEEVVru/CdhfI7ksTKDzwjrLK9KywIWXZQ9Lx7CNYl3HPfY+zjv9dL1Hdw+S8ldTySqfNthTIMGfjVOoK35DSLDB3VCauIWSJeh8RBp6ibev4y6XlV69jZL5OWm5fW2khwaS/pgX372biecIBbXTZzv3au8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782825744; c=relaxed/relaxed;
	bh=siJF0S+CSX6SKMbF6lhMt/C1v2E/StqLW87OFuT5mug=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dm+lDRY0ECmF71SWblFq43E7Ytvulp6BqLM06YgQrXowOUgd3DDDElslVvJn+zGQqUjPEcH/h3iIZfu+QtBJy27nnFTTe/hWKG03iXSZXhwpV0oE+zTV948jN8A5mnjw+jxUK21yWpwSO+AjRN0A/aHMbsuL1vrbtwozOsJ6y43tSFvlNO3PmLKWIvVQhNKaCTEp+62Xzm/SENcQQh9hBkpXYe7vXkHxYxJNEYVqWHMZpNBCRiXZt03KMwnKUGvUYeT6WnYAq1vJMBdKodOZoYb6P9j8I1EbzyKAHPmpWun2VwzYFeH7k/gBwgn7Hyu3I/XNhWYIDl3IIVkkcCm+yA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwMqGpzZ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwMqGpzZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqP2Q6WBcz2yZc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 23:22:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CDEED601DF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 13:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B6E1F00A3E
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782825739;
	bh=siJF0S+CSX6SKMbF6lhMt/C1v2E/StqLW87OFuT5mug=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=AwMqGpzZSvDnV5vSM2z0wkwmPZcuy6Z0HxhXFqaldHKlF6D4sOyHQK4L/B0fF/itF
	 Z9C2BVuksw1mr1+6ch02R+Zz8gUAI5fDmwZjU0wGMt2h6Gvq8cC5ZOCtMOofX5R+yU
	 1Hy/oyLq2B0fQTEZyfgl3xfrexpVhETu+CQgBxy7/99a3XMItUDuxVCBl4oiSjn1eD
	 o38KeGOoUlFVb5zZeSXv+WtlmGXFDo9Wxn8ecfVThX04SgSmZnYMsm+XWmLmYZpjIC
	 zdm9J6iEsk3ibRX/F7HoLCPZU+tHrUTrb8Qp73PbRYfYDyWDS2X2Ru7diIgwCebdnz
	 9GKoHZxfVlf+A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so2164114e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 06:22:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqhJE3HN+vFglU2nL+krI3xlg2nOMTBzFlwz4SuqXtMnlvIMHR9DvRZSkrQOsTHg9qo6XivoF13BYKEaL0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwOOCjsjoQDntWTc8yurqzDXh0HAC7llyqEepMVmE5/vz6balf4
	VBZa1acMGDzj0Tp/ht8KURzxbOtlToTk2PZ4TcVKOJXhEKhwoymrh7DFO6YMpt/NmrTE+NgL3fW
	QiXJcKc9W8AqcX3pz8OmtLhwgQcqhi2fNid3Q09WC3g==
X-Received: by 2002:a05:6512:8041:b0:5ad:4f1c:8e50 with SMTP id
 2adb3069b0e04-5aebdba2f7fmr745427e87.37.1782825738263; Tue, 30 Jun 2026
 06:22:18 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 09:22:16 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Jun 2026 09:22:16 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <263f58b418a27a2339fc2478f93234e0208b0ad9.camel@mailbox.org>
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
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
	 <20260629-pdev-fwnode-ref-v2-2-8abe2513f96e@oss.qualcomm.com> <263f58b418a27a2339fc2478f93234e0208b0ad9.camel@mailbox.org>
Date: Tue, 30 Jun 2026 09:22:16 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdQURjypSn+QjSDJfEiOMC8bbEZmZLgjpt=EquAM1Q1pw@mail.gmail.com>
X-Gm-Features: AVVi8CeQXBZd5M2B6MhLUb095jshYyZGAJu3z11iktq0q6r491Qj_z_hr6U3W70
Message-ID: <CAMRc=MdQURjypSn+QjSDJfEiOMC8bbEZmZLgjpt=EquAM1Q1pw@mail.gmail.com>
Subject: Re: [PATCH v2 02/19] driver core: platform: provide platform_device_set_of_node()
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@avionic-design.de>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Srinivas Kandagatla <srini@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
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
	Krzysztof Kozlowski <krzk@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jun 2026 13:37:54 +0200, Manuel Ebner <manuelebner@mailbox.org> said:
> On Mon, 2026-06-29 at 11:12 +0200, Bartosz Golaszewski wrote:
>> [...]
>>
>> +/**
>> + * platform_device_set_of_node - assign an OF node to device
>> + * @pdev: platform device to add the node for
>> + * @np: new device node
>> + *
>> + * Assign an OF node to this platform device. Internally keep track of the
>> + * reference count. Devices created with platform_device_alloc() must use this
>> + * function instead of assigning the node manually.
>
> Doesn't it make sense to add a remark to the kernel doc of platform_device_alloc()?
>
> Thanks
>  Manuel
>
>>  [...]
>

Sure, will do in the next iteration.

Bart

