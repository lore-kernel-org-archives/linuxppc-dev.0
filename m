Return-Path: <linuxppc-dev+bounces-19559-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32781F364DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:11:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsYyp5X9yz2yZ6;
	Fri, 10 Apr 2026 21:11:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775819490;
	cv=none; b=Rw3rjeMVZov0JjKcoGL8nPrkVV7xbHL92tYkKw9LgMpNwp5cqkyJO/djhuP/8bOY2m00GiVxML4iJ8JyVFvZ7ksBrzz2Fto1PbN5AH+TYLSwDeSNyPAri3pnQ6IkIt9bNbM1YlJ/VuZZOdh5xGSWQEMwi7c9rA3mSnNpRzqYFWM5pm8tM5Pdtr2Qfxnx0sPCKk7C3pyuZQGChDsR33tjoDWaPLL9qn9HPPyHHVXSbyRn5Fgol6bOknIHwEdpknztMm2nZhxTBDfVwoeYrNx1wRYhcCt/Fo+ASO+xfXlMG0MNaKwH2SgBjckk4GMgf3oyVPF4ZSb9sqEVcxrc39BLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775819490; c=relaxed/relaxed;
	bh=/1nu+i+xJBr0gNAW4Tv1D35zSdF63RaLALTRmfPqfA0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HhoYqS9tAEChxf6LjBgewIYHLBoPgMc/HtaXMpxsICJ/NiKmioCKCimn0ig5D/nEbkDnGVi2BWNrm+Vk0E0e7RZq4UFz66fBtfmRvL3Lr6LcMOM7mWAJIPe0i2/np1JKtGAi2T5Hvdl+9qbhuQFUPowp4XmRux7jO9w6W53XhbSLnYKyGLAFfs9v2pddYxsuDay0mGHR39783jwbVMt3dpulLbbO/XkVXu+/EpX/C9ouE3FG6KJF5RjavRsAygDuqkXgB5RlTMxA43o4E3InJW/I8p52R+IaeHnQRJlGOk3lhWZWpRFvNMAkflNoAGIks0ksIU9gmO39ZhiWtYXQzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GspGzkgp; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GspGzkgp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsYyl1W4Gz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:11:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775819488; x=1807355488;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=YmmZv/KghyXwXxLltau1kH9MzqjsToUkSr3yj3hE0LI=;
  b=GspGzkgp+eyMHzu3/TSebFjgdg7QWzpl/1ZE4qsgqn7EtjFCxjYhgiOz
   5VJ9qV4ZqQWpvsQ08zN4zyEodFDpRu2ZE8hpjPr6P8MWmj57iuB0QSd6R
   fyIR/sDF96kgMPsw+oq3BGlhOWeqpgVI4+7pM27L80MLczL4v7oFrBPKX
   yrH3ijwohzFqrnxL2VgeRfAjhck6XnhnBsjH5MsNDnixieiLQMazG09iQ
   23qWBMLskkm4zovb+206gOW3SSG5G1h6X1gnGdhNPXTU7JAMKlGLqq3Gz
   jINHnVNcGjc8TYlp2WogkUt7qfmwV3dsPUxQ0o5SrdL4lKNH3nrw4+q2A
   A==;
X-CSE-ConnectionGUID: 1i/QnXFcTc+MPVPN8LmexA==
X-CSE-MsgGUID: s8wokyzqTl+KeWkO3Eo3hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="77023376"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="77023376"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:11:22 -0700
X-CSE-ConnectionGUID: RGX5iTjcQ+GI+udWcK3Itg==
X-CSE-MsgGUID: pFRvyePbSROC6CAFst+SHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="224315446"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:11:14 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 14:11:11 +0300 (EEST)
To: =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>
cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
    Richard Henderson <richard.henderson@linaro.org>, 
    Christophe Leroy <chleroy@kernel.org>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    Dexuan Cui <decui@microsoft.com>, 
    =?ISO-8859-2?Q?Krzysztof_Ha=B3asa?= <khalasa@piap.pl>, 
    Lukas Wunner <lukas@wunner.de>, Oliver O'Halloran <oohall@gmail.com>, 
    Saurabh Singh Sengar <ssengar@microsoft.com>, 
    Shuan He <heshuan@bytedance.com>, 
    Srivatsa Bhat <srivatsabhat@microsoft.com>, linux-pci@vger.kernel.org, 
    linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 12/20] alpha/PCI: Use PCI resource accessor macros
In-Reply-To: <20260410055040.39233-13-kwilczynski@kernel.org>
Message-ID: <f36a3096-4a9c-93f7-48cb-e6f4c60fdb93@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-13-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-1891398941-1775819471=:1195"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1891398941-1775819471=:1195
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Replace direct pdev->resource[] accesses with pci_resource_n(),
> and pdev->resource[].flags accesses with pci_resource_flags().
>=20
> No functional changes intended.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index c84867ce31f5..7aac5e76dcd6 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -141,7 +141,7 @@ static int sparse_mem_mmap_fits(struct pci_dev *pdev,=
 int num)
>  =09long dense_offset;
>  =09unsigned long sparse_size;
> =20
> -=09pcibios_resource_to_bus(pdev->bus, &bar, &pdev->resource[num]);
> +=09pcibios_resource_to_bus(pdev->bus, &bar, pci_resource_n(pdev, num));
> =20
>  =09/* All core logic chips have 4G sparse address space, except
>  =09   CIA which has 16G (see xxx_SPARSE_MEM and xxx_DENSE_MEM
> @@ -181,7 +181,7 @@ static int pci_create_attr(struct pci_dev *pdev, int =
num)
>  =09suffix =3D "";=09/* Assume bwx machine, normal resourceN files. */
>  =09nlen1 =3D 10;
> =20
> -=09if (pdev->resource[num].flags & IORESOURCE_MEM) {
> +=09if (pci_resource_flags(pdev, num) & IORESOURCE_MEM) {

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

I started wonder though if we'd want to add pci_resource_is_mem/io()=20
shortcuts for these, as it's largely what

    git grep pci_resource_flags

results contain.

--=20
 i.

--8323328-1891398941-1775819471=:1195--

