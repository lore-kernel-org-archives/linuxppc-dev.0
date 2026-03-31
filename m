Return-Path: <linuxppc-dev+bounces-19106-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EFD109B489
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 15:51:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flXfJ4F1lz2yfl;
	Wed, 01 Apr 2026 02:51:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774972280;
	cv=none; b=WXIcRJlpSnZiIt+e3evG63EogpOATtLeCB0/s4k7oCS8qVeNNaMmidJL9mAcgHDZfF11neSVbsdlDV+/olgV2gJn/d9x4+j01sx/1fHwm6GeUv35IriJIoQ7liSAXUg2aEOBoCyFWTuyKiCc++nTHycJsB89cFP1XuSYrP3xZv9bKlC1oAL41fEoGnEhbB1tYeMOHa2Gx5LqVUrRJDd0gusSCAdSuKyMNiQhHIofkvA05Js2NCznSpNEsWT2DyEn8J2QW9hAKEiEo2IkndAk8KX3dFWLrsziVFsZps1F12SjcSFNaolpByibtukWwQtwsxiICQTMExQZC5j0BTRc1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774972280; c=relaxed/relaxed;
	bh=xCitqohc2ZPk38YAwqjTUOzYFV6zBQmsO2Na6pZrWmg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ekTGRJuZJlCaKPxRPZylseW0SANmm5/meLRkiUHJZWaat92mV+iQY4nebVfubehhupNUDq9ZbUHnqCilWkiLbUHRVtc5LuFeUrxHHH3etT8ORuVJBy3hiEWgitYTddWLwWAhDRMA+BcAWMg7zXdvgw3hHeX4kwsBdmIuutOlOJepS3H8rVEM6G4m35yF87Be2lr8A5BKHKBsqmuWLmmdiUOLz+4tej64wD804CkRT6dVae7lB872Xc8kaf2ZuMBgq8Zs5IhfW5W1n6Xvs9E62rc+WGxBuf7BEQHlZbSGG7tsykO95+wuByERRJYzqZ751i3kOHl2pYkLGt0Xdpe87g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oGkWa4NQ; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oGkWa4NQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flXfG0JK1z2ydn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 02:51:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774972278; x=1806508278;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nge5zor6zpLsko98SNlgKwkLdBZ67zYKvW4fhw7iRFI=;
  b=oGkWa4NQJ5gNPG6Bly0lSaCaoDkNiXKPZqy347TvPdDqNFezQQ8ilHoE
   6EMa5neBGW4P5/v2/2Jt0EZu9hDcP130wSYBCYSfdDDr4dNAbMxSyLbH8
   G4T2NRBpdlkBCmC3V2RBKILb/IMZ3yJLM2Q6SUkGkS+YW1COinczDFyWr
   KEoD/7p38925oM13jne6oIC2LAYhh4DAE7BmDRHvaRGy0LCrquSsnW1Nd
   eUNrwybbrrY3wcSNpv4FZcLzmf9ESCeZFNfwk6D7sf2G+A5wmYhGnG3qH
   MaJ0k1pdiFGbhGTzKegcbjgshZBuXstjTgG/OvVxkMVvAhSBFMSeI5xHi
   A==;
X-CSE-ConnectionGUID: Gv3OX+MiS8y8hyvrnedd0Q==
X-CSE-MsgGUID: R5jv0SZrTFuFQH+zD2UFEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75162617"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="75162617"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:51:14 -0700
X-CSE-ConnectionGUID: Erx6h0j4SBaLVonmWZa8AQ==
X-CSE-MsgGUID: i5Ax2DCyQZGon6IlICWnbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230465746"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 08:50:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 31 Mar 2026 18:50:52 +0300 (EEST)
To: Danilo Krummrich <dakr@kernel.org>
cc: Russell King <linux@armlinux.org.uk>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Ioana Ciornei <ioana.ciornei@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>, 
    Nikhil Agarwal <nikhil.agarwal@amd.com>, 
    "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, Armin Wolf <W_Armin@gmx.de>, 
    Bjorn Andersson <andersson@kernel.org>, 
    Mathieu Poirier <mathieu.poirier@linaro.org>, 
    Vineeth Vijayan <vneethv@linux.ibm.com>, 
    Peter Oberparleiter <oberpar@linux.ibm.com>, 
    Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
    Alexander Gordeev <agordeev@linux.ibm.com>, 
    Christian Borntraeger <borntraeger@linux.ibm.com>, 
    Sven Schnelle <svens@linux.ibm.com>, 
    Harald Freudenberger <freude@linux.ibm.com>, 
    Holger Dengler <dengler@linux.ibm.com>, Mark Brown <broonie@kernel.org>, 
    "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
    Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
    =?ISO-8859-15?Q?Eugenio_P=E9rez?= <eperezma@redhat.com>, 
    Alex Williamson <alex@shazbot.org>, Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, driver-core@lists.linux.dev, 
    linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org, 
    linux-pci@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
    linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
    linux-s390@vger.kernel.org, linux-spi@vger.kernel.org, 
    virtualization@lists.linux.dev, kvm@vger.kernel.org, 
    xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org, 
    Gui-Dong Han <hanguidong02@gmail.com>
Subject: Re: [PATCH 06/12] platform/wmi: use generic driver_override
 infrastructure
In-Reply-To: <f819b7d8-5c80-4463-9afa-933a2ddc8ab3@kernel.org>
Message-ID: <dc11f3fd-a5c7-16e9-8417-6dddb63129fa@linux.intel.com>
References: <20260324005919.2408620-1-dakr@kernel.org> <20260324005919.2408620-7-dakr@kernel.org> <f15629e4-ef8f-b1b6-0158-064f40f111da@linux.intel.com> <f819b7d8-5c80-4463-9afa-933a2ddc8ab3@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-2141551316-1774972252=:989"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2141551316-1774972252=:989
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 31 Mar 2026, Danilo Krummrich wrote:

> On 3/31/26 5:02 PM, Ilpo J=C3=A4rvinen wrote:
> > I tried applying this to platform-drivers tree but it failed to compile=
 so=20
> > I ended up dropping the changed.
>=20
> As the cover letter mentions, it sits on top of v7.0-rc5, did you conside=
r this?

I noticed it but I just assumed you were working on top of that, not that=
=20
there's something past -rc1 that is required.

> I can also pick it up via the driver-core tree.

If there's some post -rc1 material this depends, it's probably better that=
=20
way.

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-2141551316-1774972252=:989--

