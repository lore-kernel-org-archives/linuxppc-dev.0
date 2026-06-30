Return-Path: <linuxppc-dev+bounces-23189-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB98C43327
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:38:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqLkh4NMyz2yZ8;
	Tue, 30 Jun 2026 21:38:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782819516;
	cv=none; b=UkxcTgqNN8K2k1+cIUiW5Z6XgRjNVBIqeITSNAs1vmScipJfRHNcQSi9qyd8yrhuKlyMkzyfKL2xnOrZ1FPc+5jaSQfIxxVE2JmGC+cvM7cd2rWM4PX83Q64PnPYef+xVmFdHJQC+4Yld0m+xWMOUursnAg8JRfNr8EhHhEKhameuQoZzt9nRRhkKngTj1uTpWNrdI8qwkByDWxTvEyuRWaYGQeys016Wb2fv46jVgjn4jSABhFYUHH4CqnUx4vgvFhBFf45oyUukV5x6eegb4+QoIqTa756tZdL65N+NDjHXe45WAK1bAdv2A0e7BMkdnnSb/mgIp+OOT6qb0a+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782819516; c=relaxed/relaxed;
	bh=xShlwrKyTIF4qAdBox24ShRYzAy+zv7+bJMeZEybzao=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U7ZewZCypGPNfwpTHi9udmmg31KdMWQziqv/imQ44rZ7RivLAx6w5QGpLxAsa2gwPd1Vbx77d6ELckBVLHao+OCfOnuJsXBtbZGhXEE5O4/CuF9S9Zwpu6NCBHPlErAh8ECcp/KE1FKNIplXhSH0Oz5Y1NlNluDcQlnrjNCZrb8RUfDZ/6tVp9Oq/S6PgmKVp6lSM3prwK5jwRMEoadjeFvVqi5sXNBxHNis4+O5TciQNe2azObKvrzTNdkPBvpWlstq01JZjKZYuXI8khxUz+tL2f8Um8OhtAIopi7Y7WjPuaXBFM+oTAYQotuq4k+GScWVfcJKqABTdjHozjBTyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YCB6Twpa; dkim-atps=neutral; spf=pass (client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org) smtp.mailfrom=mailbox.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=YCB6Twpa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mailbox.org (client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org; envelope-from=manuelebner@mailbox.org; receiver=lists.ozlabs.org)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [IPv6:2001:67c:2050:0:465::103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqLkf1TyKz2xq0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 21:38:34 +1000 (AEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gqLkP18PWz9ttL;
	Tue, 30 Jun 2026 13:38:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1782819501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xShlwrKyTIF4qAdBox24ShRYzAy+zv7+bJMeZEybzao=;
	b=YCB6TwpaO927QjEdXrlIiJBt3S2TMj/lUoTQyC5iej5UxCRKDn/XljRoPJbwW7XxlugG6N
	xBgQ8xLD8khNkgkWh+g0ulj34prUa724A/+poOtOInojCqpSRpE4vb6OBmRtDmIJAxSA4f
	q+iHkCtSckNXJ49ELVp3wKYekx4Hu3LHe2ZUyT3N5n18Mwi4lpbcu585fLX8dl6Sm1920r
	w0LYy0isS0hDcqp6fFRitgGmFoMYdelUtHSbx9Tm6NOH0N4ee+iItLHiYZcykaDEt9MsqF
	xFH0uK67m+VTeUGiD6g7C/77X5TkshLws6H+4ToFw4GPgFvrVvyldWMMbrXUAQ==
Message-ID: <263f58b418a27a2339fc2478f93234e0208b0ad9.camel@mailbox.org>
Subject: Re: [PATCH v2 02/19] driver core: platform: provide
 platform_device_set_of_node()
From: Manuel Ebner <manuelebner@mailbox.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Lee Jones	
 <lee@kernel.org>, Thierry Reding <thierry.reding@avionic-design.de>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Srinivas Kandagatla	 <srini@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul	 <vkoul@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich	
 <dakr@kernel.org>, Rob Herring <robh@kernel.org>, Saravana Kannan	
 <saravanak@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)"	 <chleroy@kernel.org>, Andi Shyti
 <andi.shyti@kernel.org>, Andy Shevchenko	
 <andriy.shevchenko@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Doug Berger
 <opendmb@gmail.com>,  Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson <ulfh@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team	 <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, Matthew Brost	 <matthew.brost@intel.com>, Thomas
 =?ISO-8859-1?Q?Hellstr=F6m?=	 <thomas.hellstrom@linux.intel.com>, Rodrigo
 Vivi <rodrigo.vivi@intel.com>,  David Airlie <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>,  Paul
 Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, Philipp Zabel
 <p.zabel@pengutronix.de>,  Maximilian Luz <luzmaximilian@gmail.com>, Hans
 de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 iommu@lists.linux.dev, 	linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
	linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date: Tue, 30 Jun 2026 13:37:54 +0200
In-Reply-To: <20260629-pdev-fwnode-ref-v2-2-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
	 <20260629-pdev-fwnode-ref-v2-2-8abe2513f96e@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-MBO-RS-ID: e997ada4adfcbcacfc2
X-MBO-RS-META: xtee85ryzhfy8x8szdsj4cwckgtw999y

On Mon, 2026-06-29 at 11:12 +0200, Bartosz Golaszewski wrote:
> [...]
> =C2=A0
> +/**
> + * platform_device_set_of_node - assign an OF node to device
> + * @pdev: platform device to add the node for
> + * @np: new device node
> + *
> + * Assign an OF node to this platform device. Internally keep track of t=
he
> + * reference count. Devices created with platform_device_alloc() must us=
e this
> + * function instead of assigning the node manually.

Doesn't it make sense to add a remark to the kernel doc of platform_device_=
alloc()?

Thanks
 Manuel

>  [...]

