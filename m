Return-Path: <linuxppc-dev+bounces-23774-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B284FC44501
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 07:43:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gw97H1fF3z2yS0;
	Wed, 08 Jul 2026 17:43:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783496587;
	cv=none; b=Vol4Eg0pYCWD1MGObHzmmSWSmJaBl1B3wRaZRF9KttQM/ONbnzYtr52oJ0o6l7QEX9aSGUsWn1CE7Vr7oMB3Ua2nFjP9CjViwsN+r3pis7+b7yGwOv1z3n3lczSrBzdflkThcE8QrFLmsCGP1QFV7FKpBp2OLpL47yUL+9M8cbMESuL3Qq+TKkoOMiFNwfVU1ofmJ1tMmaOPFNvhIEtMvXOijWhiQfuHPLT+fXzYgUFq6a9PWHyPAZ5dYjTRMU8mzSKWSLRYndyw4JLlQ4MDmEKqRoisp5hnit5nsqMz70oLpfN/iPGxQMCT134HsZWgqT4GKLiUpreFLCgAV+q3vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783496587; c=relaxed/relaxed;
	bh=wqspe9peDUDf7Lj0Ckvg+Ou41duj870AZXBlowe/bLA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhGtlvb5sz5yedkk5yf1fUxXxRFgvE/AJHkhEzAH+fT1d2ObOO1B04tV1CX9hmxN0AX+UHF+YmK9YSsPllEFasrqn42JYGan/dxYSHTS2NofBPfq6rvQs38bWZhO1G4Ukw9+NwUtk1rsAexpcMMTQsUIfJy5I9ZA+/MvaAPVJgy3nNn7blzuWNW2+BOXB2ZPsdsSoAGoqHc19q8oEjbd+d0Ze8AAWvFmTjMIVdFehmqCePZW/zxcL9RBOoF8v5IivdEEyPCckLN8PBm8JQ7PxfjDufYOgIJmFYz0AgFahrcjmdsQmw1hLR5cCzs3rDzYbtNhbvkWlTh3xTlE+OWVnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdVixJQY; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UdVixJQY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gw97G09DJz2y7r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 17:43:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 887AE43D8B
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2026 07:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5921F00A3A
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2026 07:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783496582;
	bh=wqspe9peDUDf7Lj0Ckvg+Ou41duj870AZXBlowe/bLA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=UdVixJQYfC8sGwm2LkLtOuhdj8rGXYZvhM/nEvj78/GfwKlgApbA2mM7v4TKCDBtM
	 TkD+j6IdxnEthYn0jShnTGRcHvUl3uWT0ZDhmk6v26dbgga280PtMUZDwzHv6zk6w9
	 Yi8sszDGyw24AvoZisXpI7QNHqYDfzKTPKFdZGUiCUBuP3uOnWP2zicuVvIaA40jxJ
	 EVB46mt6atPqufA0m9s4aa5bEOsisUWJKTjqkHfv44JLBSqWrvCACa81iSvV/e8lQX
	 OTmHzverjKM3OU5lQEPWgn0fZKvlavTlsO4QonPQHPIENoNkOtr3nIiF1feGEE3W9d
	 dt2lpEp1ZXFPw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aec201b582so435672e87.1
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 00:43:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpwF63b1RMPJYzXlBFd1ZoY8kMEd1CXpg/INl3I9LDmvSuHBM51IO4ag2XCYkRKSw0GbLC6ULkS9KTCdBQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMle1sE/GMK5n4RrJFEYssgmyRJTKE86kfNIwO98/UNenGWKXY
	XmLaZoLyuApNjF+kQMfSMa329j1oUX0iHkj5Ql7q4d/P3FL+2xkUug7zT7Zm98zO2bABHZu7/I1
	BiGzMVM3Fl11sY14kmtcfWEI+ZWjklibmBsH3rr8p3A==
X-Received: by 2002:a05:6512:3a8:b0:5ae:a9eb:c5c3 with SMTP id
 2adb3069b0e04-5b011478162mr274920e87.61.1783496580641; Wed, 08 Jul 2026
 00:43:00 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 00:42:58 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 00:42:58 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ak0jyUbNonSRiP_g@ashevche-desk.local>
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
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-5-1ff028e33779@oss.qualcomm.com> <ak0jyUbNonSRiP_g@ashevche-desk.local>
Date: Wed, 8 Jul 2026 00:42:58 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md7-XMBKpdPuZ4=epfTn6F-PXKJBZNPGuz5xbVy58BHsg@mail.gmail.com>
X-Gm-Features: AVVi8Cc97SNnhCE85729H_fOi3Wx8wY1APMX-PhjHPSFVtKB-jxewFEQvchpN2c
Message-ID: <CAMRc=Md7-XMBKpdPuZ4=epfTn6F-PXKJBZNPGuz5xbVy58BHsg@mail.gmail.com>
Subject: Re: [PATCH v3 05/20] driver core: update kerneldoc for platform_device_alloc()
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
	mfd@lists.linux.dev, Manuel Ebner <manuelebner@mailbox.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Jul 2026 18:05:29 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Mon, Jul 06, 2026 at 02:44:17PM +0200, Bartosz Golaszewski wrote:
>> Users of platform_device_alloc() + platform_device_add() must not modify
>> certain fields of the dynamically created platform device object. Update
>> the kernel doc to say which fields are affected and which functions to
>> use.
>
> Consider using __private checker attribute for them as well. It will make
> sparse scream.
>

Sure but let's leave it for another series.

Bart

