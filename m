Return-Path: <linuxppc-dev+bounces-23052-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B19C43638
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 09:06:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gpgPM13FTz2yT0;
	Mon, 29 Jun 2026 19:06:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782723975;
	cv=none; b=LHuNOMy9NtgBhi+izqNd28SAAx2/XAmkfKUy0CKCiqB5xky5wsXt8wN7goOrUqly30fzazKYktYYIaiBmqwQqpWUqe3Tg49+QfdP572I1I/Frb6OZh7MWOemf+G3iNCrdRmow7jzvD5gLPwC0E1gIh1z8JvO2nC8oo1tnkIK28ORzBxI0h8iPF7NVl3Ah2ZKKL/ZZbM7JvkxG28vax0tW8lfzwWdgHznCNhyKR49iNy1eFwAqpkYzHvfMCTxt10G4lxGZPyvOxweqni/k62zokJGZzpG1TVrGWtuT37RLZgEq7Vb6LL3A55N6LXIEV/wCkqtQGQ7rhZCegF6rWWGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782723975; c=relaxed/relaxed;
	bh=qB4tJg2aYLg8hehpYin2dptPRoadEzGzbBpoppNMyKk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGb2IlOTtZdrIJcdpsiijU/EBWtKf4aHi9rpVJaqpoZ/n6E67lBWjbwJx7AnpNPginmkmhACNt/3moj1sMjQdfT13CnskMaTyQzyvTL1+rEPGQGKEBw/Ukx3bGwmtJtxV7o9itma2r59w1xmg3N7CbWQj5x8cy0UomvMDySjBL5iHfGUXg7VhrfNld1wbbWqblM8A8dRutpvTqSshDpeSKklGXCxLN9TX2aKZHBO9JaXg6Rw0My/XabRjq08L4xXduBuMx1AO/79/UlDnFs7Os3+SP/ib6fEhHbEESfn0f6gqA3P787ahP2wpf3zRj7aomnFjtukPgGkTgb401AXow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyUhTV03; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyUhTV03;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpgPL17SYz2yFc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:06:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DAC9F43F5B
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2A31F01565
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 09:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782723971;
	bh=qB4tJg2aYLg8hehpYin2dptPRoadEzGzbBpoppNMyKk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=iyUhTV03bOKBX3P50ZCu5uI5Z9GdSG5FaWYf46X7lJcOmFmX+TOB5ZSHaEGQvoVvi
	 w7QBgX5wGnlIt9PwETkpMRIPTtL2gcrwvVGZlvQ9UEO6y0jwZX9Mmn6Zpk9DscDEuY
	 F0AAPET4mFlLtpb3GilD+x3+Q8aLT5LUaL+qRXeepLEhJbSMjM6672Tt+0t+JTi4Ib
	 aZbeAoeQD4GZ24bf76pYRPdkOembLX2HEF5nuge3oTrb5EA6IK7gusKHdgBYLt0wZe
	 2UB/jbL1RUF+Rd3fa80u2w1VGLhbQLmwYrqVheU88CxYlRSZkCxTIpqImYjye4YPzK
	 QVoyZa2wkJ4iA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39af6402933so14210291fa.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:06:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoW2z6jYmU4j8FQ4hFECB6NoMjRewD0QFOBwP2GUUxp5bh0gCEzGpodnEnCGdTL/CM2sl8vjVO4OVavfzE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxRITUeD8omUx5RBjnK525DiO20rEsjxsSAgZb3x0nCrYLmiF3U
	Il/KQLTGc9JSF9OHT4wB2prBHoLpsuPu+cPzWeRDrG3Aj2JM7bK2KX2Nx4b43ySooDJ3Pvse6Lm
	ZRwqtHCyLZU5D+5cRlHXtxhufnoDg7+klnEHcxU+NBw==
X-Received: by 2002:a05:651c:1587:b0:39a:e3c7:6644 with SMTP id
 38308e7fff4ca-39ae3c76ecdmr17150311fa.12.1782723969253; Mon, 29 Jun 2026
 02:06:09 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 09:06:07 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jun 2026 09:06:07 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ah9QPgco9BxEix7T@ashevche-desk.local>
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
 <20260521-pdev-fwnode-ref-v1-21-88c324a1b8d2@oss.qualcomm.com> <ah9QPgco9BxEix7T@ashevche-desk.local>
Date: Mon, 29 Jun 2026 09:06:07 +0000
X-Gmail-Original-Message-ID: <CAMRc=McSDNdBMc_MAbBiOgeWusQXPEvivxniX5dJq+X6rp3UZw@mail.gmail.com>
X-Gm-Features: AVVi8Cem7nS_T_r8P1YOw4p48wRJJJKggepy3MNLXmsKDTbaRpH5jyNSSJ0YwZw
Message-ID: <CAMRc=McSDNdBMc_MAbBiOgeWusQXPEvivxniX5dJq+X6rp3UZw@mail.gmail.com>
Subject: Re: [PATCH 21/23] usb: musb: use platform_device_set_of_node_from_dev()
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

On Tue, 2 Jun 2026 23:50:54 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, May 21, 2026 at 10:36:44AM +0200, Bartosz Golaszewski wrote:
>> Ahead of reworking the reference counting logic for platform devices,
>> encapsulate the assignment of the OF node from another device for
>> dynamically allocated platform devices with the provided helper.
>
> Same Q as per chipidea. Do they provide a pin control facility at the same time?
>
> Otherwise simple device_set_node() or whatever platform analogue should suffice.
>

Hi!

I don't know and I can't test it so let me respin the series as is. This can
always be amended separately later.

Bart

