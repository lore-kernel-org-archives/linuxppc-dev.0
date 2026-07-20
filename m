Return-Path: <linuxppc-dev+bounces-24503-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04BCC4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 14:39:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3jnt63Cpz2xlZ;
	Tue, 21 Jul 2026 00:39:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784558354;
	cv=none; b=LawWJYuRXjt9yR3fyVMoVZbXCyzdr3m5bst1cVOlDB9JR0g01W7xKdTXED1QWYYaHrEO9jpFJmnKoGm9u5x3f6kXRAWGs+o+hV6fJ091uLlJS/zY2B0V9Kz0Mp+H4QiBJxiZAk23BR85i9OqQLgHtoiMoe+4OPOhewDscQLqW4aLubA3h/Ljy1258QpJH/geWpcik9JsCAEunJ/+ZXPmyVUaXuKsgay5WSvFB7rH3Funatak6m6WpJ5HGfeRtrKhdLDuu0vq2wdxNywRETkTlWtNmLLqI2VuLgvuuLT4Ruh8trz8h/2dIqTg53NMWIXg9+dR/aBrPqFxE9RqxPK7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784558354; c=relaxed/relaxed;
	bh=RMjWEzu38tseHoFo/YUCFGtCdWHHOcvPUTf8wfVO9l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glFL16Mkk4Of+VcBmAGefF4YPZR5l9+wKD4YETSrQkEBQcV+gwK6o0IMwrmdDqkX1CONW0UdRYi1I9a8tIx3wBTgbkPd26u3m28mhaJsJCJt8nq7zTRADluk4+s48zAAteMhDgt/VLBANsKmZg8sDUR+x8KBltqLS8p+h5rodFglr7EevP1aatUKlSaZRPoa9Yn64E0hG3dUFCl0uZwt8V/OuiTaDjSupv34BDoMlxKoB++ZK532R6JxUFA3BE241Kuk13HB3jQYxCyNLG5qAXN0pHZc0nGC1Z8+/yrh3dCAjiOF2ZRwy+0pmfkakE4dh2AlXTkjhSsNj82MC9jbAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=jlS/QNzG; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=jlS/QNzG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3jnr4pcNz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 00:39:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RMjWEzu38tseHoFo/YUCFGtCdWHHOcvPUTf8wfVO9l4=; b=jlS/QNzG8jL6ztl+koDV7jIKGy
	hJ8MoU4EgaQgOE1qzjLmdtFbbmi/0fgZfb4iTHwPI1fG+fHHula2om3ezgCqqfeAdRQe4ZBDMr05+
	gPG4MNS98XzezJlKLfyz2QX0gg43IJlG3DiKv4snsRh78RHhZP5X+0/L4MTdSThyYxYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wlp8g-00DH7Y-1A; Mon, 20 Jul 2026 16:38:38 +0200
Date: Mon, 20 Jul 2026 16:38:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
	driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pm@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 4/8] net: bcmgenet: use platform_device_set_fwnode()
Message-ID: <ae9da5dd-3528-4270-ada0-d17ed14478e0@lunn.ch>
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-4-2dee93f42c54@oss.qualcomm.com>
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
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-4-2dee93f42c54@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 11:24:51AM +0200, Bartosz Golaszewski wrote:
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.

Why?

This driver is OF only. It does not support ACPI, and probably never
will. In general, networking and ACPI don't go together, ACPI is not
sufficiently advanced.

What is you use case here?

	Andrew

