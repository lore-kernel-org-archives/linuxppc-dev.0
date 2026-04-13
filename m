Return-Path: <linuxppc-dev+bounces-19687-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEAEF34C45
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 11:55:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvQnq69kxz2ydn;
	Mon, 13 Apr 2026 21:55:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776081311;
	cv=none; b=RMoBWaaBiT9WE/lZ+XLP5Y8R+xHALVjYOmJ+Sf7xSfWcZWXRQ+DcZ8OL3gV+U7dK7wF2qFjwX6PTQEEJkXYzF6yDO8c2YJRszCO12JDzp19/iogTIRnp1VXc6IekAQe1wdlV5S0HlmK7k7KLtDwPDuMqTueoD1zMfqeYdWt8k4FoEsFRTV9wK4g4YVBRe9/R6/FGLgZ+ymkSF+LTVU27+l8MYNpov7nG0b7nIH21BD5SVQpUySCpos7HBlGqvjZmiBdYvA29AQp1ChDS1lDh3dinBTPiLzNcPNxROdequiGqDSuCkQld0mwtW2UwuVa4JMtEKg9aa5ksxpFnAxoXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776081311; c=relaxed/relaxed;
	bh=8A4EsbcgctBgp/jMKS8aEzwZfBFINXltZzMv/SLL/g4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d/dukMSNvuwdlu5/U/rPbPqu1tzilbBH7xNusA02+URN8xzY7m+JjAil8y4mWriBWE616W7LklRd+B4sIhQIustNuJJRwaDDpQElJ89y7Eckk/O/iAZisDdhunLpSrjks+/+oO3TrC/rIKwE3tM4/5vzVNLO2LGOTVpY2KIX2tulzkdYgacw4uhjdQtsxwkrKz90XeaW+JAnvOS5gBsWKwt6rMAYCI+AsX5Y9NN2MXoL5LAmpVB8ImvoyooYOhmKLHG1F/80VaGRxRYW+oLbEEZ3suClmr61AweiX//kLu4cDvbNHGZg1nGsLG/aqk2EApDg4gJHbL1YdRAdhpmYgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SzkAE+rr; dkim-atps=neutral; spf=pass (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SzkAE+rr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvQnp1gJDz2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 21:55:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776081310; x=1807617310;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=m4D4xwrjWoPcKd39e9WIlNBkYbShl/QU18qRe1RJS34=;
  b=SzkAE+rrY2MJiai2r4AEEJLk98wMmAsgAYxPxLpH0vW3tSQyq9lFMM8u
   P+4oA/vdZ913sxyH2Jz3ZGuSH7Xa06dxrOt/GOWrN97xIVv3jq3OGI7f1
   ZvwdTT/y64DsmsKWHj8POS+nT4m3zugZcdQzr5Fo5xOPV+zsx5pB095Gu
   UdnIHWxkuO08F1uobzbmmEJ0nfgTFy3A9f4oGZG1byZyjWi2mFon56uol
   bzj+gzSDbYJDB4RgEd98aZJKpBLSf7dy3lSNPbnq9beXXqLV/UKDM1A5b
   wJuUnDZraf/sTVE9c25hn3MBYYRBIxBO0gbpYTeOmwDwhMhxlZchHxyT5
   A==;
X-CSE-ConnectionGUID: CYW6CHlGTaWD8ZYjyJnHiQ==
X-CSE-MsgGUID: 2/YAci/gTVeBAb5kGLi0OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="77030133"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="77030133"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:55:05 -0700
X-CSE-ConnectionGUID: lbiB9JauRxu0nvnsRhAtXQ==
X-CSE-MsgGUID: 7eAaEOTEQUC6kP4Yz6kYCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="252959648"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:54:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:54:55 +0300 (EEST)
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
Subject: Re: [PATCH v4 14/24] alpha/PCI: Clean up pci_mmap_resource()
In-Reply-To: <20260411080148.471335-15-kwilczynski@kernel.org>
Message-ID: <b4088182-cc79-3ee6-4b0c-9fa8f12d5cdf@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-15-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-878657269-1776081295=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-878657269-1776081295=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Replace open-coded res->flags type checks with new pci_resource_is_mem()
> and pci_resource_start() helpers.  Move the pci_resource_n() call into
> pcibios_resource_to_bus() and drop the local struct resource pointer.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 7aac5e76dcd6..6c011dab326d 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -70,7 +70,6 @@ static int pci_mmap_resource(struct kobject *kobj,
>  {
>  =09struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
>  =09int barno =3D (unsigned long)attr->private;
> -=09struct resource *res =3D pci_resource_n(pdev, barno);
>  =09enum pci_mmap_state mmap_type;
>  =09struct pci_bus_region bar;
>  =09int ret;
> @@ -79,15 +78,16 @@ static int pci_mmap_resource(struct kobject *kobj,
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09if ((res->flags & IORESOURCE_MEM) && iomem_is_exclusive(res->start))
> +=09if (pci_resource_is_mem(pdev, barno) &&
> +=09    iomem_is_exclusive(pci_resource_start(pdev, barno)))
>  =09=09return -EINVAL;
> =20
>  =09if (!__pci_mmap_fits(pdev, barno, vma, sparse))
>  =09=09return -EINVAL;
> =20
> -=09pcibios_resource_to_bus(pdev->bus, &bar, res);
> +=09pcibios_resource_to_bus(pdev->bus, &bar, pci_resource_n(pdev, barno))=
;
>  =09vma->vm_pgoff +=3D bar.start >> (PAGE_SHIFT - (sparse ? 5 : 0));
> -=09mmap_type =3D res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_i=
o;
> +=09mmap_type =3D pci_resource_is_mem(pdev, barno) ? pci_mmap_mem : pci_m=
map_io;
> =20
>  =09return hose_mmap_page_range(pdev->sysdata, vma, mmap_type, sparse);
>  }
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-878657269-1776081295=:962--

