Return-Path: <linuxppc-dev+bounces-21630-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1087BCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 11:21:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gR3wS3HmMz2xLk;
	Thu, 28 May 2026 21:21:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779967304;
	cv=none; b=QKVqpLdT81a2AXMBidYiPC8UDarj2+UV2Prg3D4Gk+tu/5HZBSsniLFUKbm1vAh99lotw/15CG/z6qFi/jP9RiN5OLHWO3mbJDqd/z9Rx9Jd9Yj64Hf94D1pXzhXyz41Z/iZAczjj11W5EZgsdEcjQTovIrfSclyfr9gs4RdPVQhzihS4bsYTlXrkZSjCKMSlYPway6XTzCN1xIoxw7uzUL9bCdY0bbCWuJPAo3vKD/yv+dDPXBirUzDV/L9Ct5y4FEiwPyP5qdXuwsc3SO/cQYNvOHJL4lEpNrkzYBV3E10aaaxJ6fQnXZ4kDDVNmINbkMpnBwIieM/h83XsI6a3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779967304; c=relaxed/relaxed;
	bh=yIrSIGPzt7M2c1Ou/vOLfvk78pAD5Tuf7E8bTspi/XU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PvlHndMFDzgfSaEBt86a2fOH6QBSfGaqlhlxvEjLk4E/mUW793jmnyK7qHGSt03ZWRHrBXu7Zv+VuoGysfBb2+1+XraWli9BXEgldnHAFM4saMCYI9euWdmVBSfmz4FGIGqWN3lKs4c7z3cjSOllnjQUSAEh8vDT5LmDhw9q77ouRncW5jM4/Z0cy754Vr4u6AySOPC8ya/PqaB8e0cGH4U+cphCx+ssq6AGK5ouL7Oc9Qub0Y3EhkikbzXDg+MOrVos/9sgjwOKIJ9ujxqaMnbMXEg1rAN850Y1IcJkD95TUZrOL6RrIPG5os45Nk/wdqJzOjjA8Zy2wH0dMwEVeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ms2fFd6y; dkim-atps=neutral; spf=pass (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ms2fFd6y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gR3wP2VDjz2xHK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 21:21:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779967302; x=1811503302;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=f/lIC4TgmEzyiBDPh2iBCW6oUeY6y5+TmWqzleJFfvY=;
  b=ms2fFd6ykzCiraeZ71ZWOsET/V/dtR7BNMcCMZrIVpo0J/zHMP9HMAi4
   ZFoK5xl8zcm0niviq10nE5VpMBOjKdQR2LxZradV5LI2rY+dEH7uMFVL5
   G5voounvX/U1ZXN4Qt6sGgecTpkKQ5HyT6TyyRtZwsmUGGkWn0sgPYE4H
   rVJHepY5Z4hAtmcTKZQd3XUOobfoaEPMTH2iP9MnEogbLpWO3AszXZhOh
   fEynCPLGXidiNr2Yy7umAlJ/AplxkXH/TVXj8ow8wi8wi5V5VnNXuSEAV
   vWRV0vvctuqEX+NEvS/m/h2NC629E9kBMTSDFlJCxgnf0zHtrkV7JHlzP
   Q==;
X-CSE-ConnectionGUID: vpWRu3Q2R9CowB/79WvtMA==
X-CSE-MsgGUID: DuLhp+mXRraEhBc3qrOBdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="103480354"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="103480354"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 04:21:34 -0700
X-CSE-ConnectionGUID: NhorkxbETOO3yaxAYXvTkQ==
X-CSE-MsgGUID: vXFsgfpXQNSWfwq2pTGuRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="238337774"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.187])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 04:21:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 28 May 2026 14:21:11 +0300 (EEST)
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
cc: Lee Jones <lee@kernel.org>, 
    Mark Brown <broonie@opensource.wolfsonmicro.com>, 
    Thierry Reding <thierry.reding@avionic-design.de>, 
    Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Srinivas Kandagatla <srini@kernel.org>, 
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
    Fabio Estevam <festevam@gmail.com>, 
    Matthew Brost <matthew.brost@intel.com>, 
    =?ISO-8859-15?Q?Thomas_Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, 
    Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
    Simona Vetter <simona@ffwll.ch>, Peter Chen <peter.chen@kernel.org>, 
    Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>, 
    Philipp Zabel <p.zabel@pengutronix.de>, 
    Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
    Krzysztof Kozlowski <krzk@kernel.org>, 
    Benjamin Herrenschmidt <benh@kernel.crashing.org>, brgl@kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
    driver-core@lists.linux.dev, devicetree@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org, 
    iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev, 
    linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org, 
    dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org, 
    linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 19/23] platform/surface: gpe: use
 platform_device_set_fwnode()
In-Reply-To: <20260521-pdev-fwnode-ref-v1-19-88c324a1b8d2@oss.qualcomm.com>
Message-ID: <bfdbc026-b3f9-971b-aaf0-0485434b8411@linux.intel.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com> <20260521-pdev-fwnode-ref-v1-19-88c324a1b8d2@oss.qualcomm.com>
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
Content-Type: multipart/mixed; boundary="8323328-947565217-1779967271=:1291"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-947565217-1779967271=:1291
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 May 2026, Bartosz Golaszewski wrote:

> Ahead of reworking the reference counting logic for platform devices,
> encapsulate the assignment of the firmware node for dynamically allocated
> platform devices with the provided helper.
>=20
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/platform/surface/surface_gpe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/surface/surface_gpe.c b/drivers/platform/su=
rface/surface_gpe.c
> index b359413903b13c4f8e8b284ef7ae6f6db3f47d72..40896a8544b0a4da4261ea881=
b1eaed62d93b32b 100644
> --- a/drivers/platform/surface/surface_gpe.c
> +++ b/drivers/platform/surface/surface_gpe.c
> @@ -317,7 +317,7 @@ static int __init surface_gpe_init(void)
>  =09=09goto err_alloc;
>  =09}
> =20
> -=09pdev->dev.fwnode =3D fwnode;
> +=09platform_device_set_fwnode(pdev, fwnode);
> =20
>  =09status =3D platform_device_add(pdev);
>  =09if (status)
>=20
>=20

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-947565217-1779967271=:1291--

