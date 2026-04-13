Return-Path: <linuxppc-dev+bounces-19680-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34465E64007
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 11:24:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvQ6Z4tPdz2yhv;
	Mon, 13 Apr 2026 21:24:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776079478;
	cv=none; b=Fz40SNk4YcopmuLqYcqw52zwoscuhFgRxFVbpe2BU8aDbwm/Dcu9rVyBO5ubNRNPdJPyRo6UfAmXb41IooSqvbog13+ZPRvFIJIRQu/ZR6iFeMEEN2lh6e3ToCdi9CJ3taDAMbu3T4AB71IlEnBXmwTr+WEEHXsQqb5fuJs4Xv7JqneMsmJJoyYK3lfdABLcjSc64zLsJUhRg68IMdEOY6sw1SoOr25JiBJgVcl1GBtSumbu1Q7IIEUNHh5djlMIs/F4Ioupifs3UdbjMoT9NKcx7supRX+77gSq8HCmrZCA67SK0EgfeduMznytD2obc4TR50HI+PPBu4O4k2fKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776079478; c=relaxed/relaxed;
	bh=YvAkN0RS3DwY2XgDuzhn5Q2jKfqwUUtLHM27/M5s7Pc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LPUQDfyqovDGy7huYBTlbPLDvlEjKHxjNIU6jtKqAtVrbbS9tvackPznG3ssvM8lp47lfbwNbqNPwJyszFvral0TqSGBv1MCYMHD3MacbW8u0KPLIoEkmLmJ1AEX5mNNMFWa933OTIqFKiq3Jgqt78Cjx6sfpfwBfRHjFtWl8CJEnC+5Rek7tDBwIsu+KSMjZDtsFQTYPjeCPN3hhpDToRdOcA+Sf7g3CeIk7X5L9bv4c1f9CKyzNkI2bmhmgHZ5f4smpmd7cG4ix5SuaR5R7aWWPMOBklH4yeMohuDtmbiZ6+3bQ01qx0dgp/bgpybzqemJlKnAn0gn+twdoFTySw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QcHeJwuo; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QcHeJwuo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvQ6X42n9z2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 21:24:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776079477; x=1807615477;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ANPSmnJ2+vAlYbN/js49nW9FDlFUvNpC6ZARORPHgV0=;
  b=QcHeJwuo1F3PUONnLFRuEhCtY6dpxInSrGcnk4gmQ8QU1WIUNMDPpBU1
   zmTfTTfHpRUjo3f1E/Xu9vQ4pSXTGd90AJqkRP7aaFB1jNuiy4JMHUmIB
   Nv2TnScxQ2sJLaxEr6AJQIvd6stackjbMyn2+0j/a812ixtPquIZCwbJN
   +W+lhs4mCfGVyvW7ESRyFCh9dMuRvTUAj6ZQFIP3XOVnP0BafkNzCEp8Z
   D4I+PZVVssquV8Jika8jeDJiIDHnQQhAO0hqDbX17cO7S8p4iIqgb1QBy
   5bnppswQconffcJRvo0Z5UWNSPF91xYjFOv6+hkw/c6rVFbcFYw4/zp9W
   A==;
X-CSE-ConnectionGUID: 7iHTUpmES4GWChnzaa5tfw==
X-CSE-MsgGUID: pfMmp+FuTdyoxHj0gjIHaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76177574"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="76177574"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:24:31 -0700
X-CSE-ConnectionGUID: 33yh9LIcQJ+TH04CgmlBIg==
X-CSE-MsgGUID: TtU1KKBaSB6pirkxzyn3rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="252952094"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:24:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:24:23 +0300 (EEST)
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
Subject: Re: [PATCH v4 03/24] PCI/sysfs: Only allow supported resource types
 in I/O and MMIO helpers
In-Reply-To: <20260411080148.471335-4-kwilczynski@kernel.org>
Message-ID: <8424773e-84cd-25dc-6591-dd68292150fd@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-4-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-22180800-1776079463=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-22180800-1776079463=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Currently, when the sysfs attributes for PCI resources are added
> dynamically, the resource access callbacks are only set when the
> underlying BAR type matches, using .read and .write for IORESOURCE_IO,
> and .mmap for IORESOURCE_MEM or IORESOURCE_IO with arch_can_pci_mmap_io()
> support.  As such, when the callback is not set, the operation inherently
> fails.
>=20
> After the conversion to static attributes, visibility callbacks will
> control which resource files appear for each BAR, but the callbacks
> themselves will always be set.
>=20
> Thus, add a type check to pci_resource_io() and pci_mmap_resource()
> to return -EIO for an unsupported resource type.
>=20
> Use the new pci_resource_is_io() and pci_resource_is_mem() helpers
> for the type checks, replacing the open-coded bitwise flag tests and
> also drop the local struct resource pointer in pci_mmap_resource().
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  drivers/pci/pci-sysfs.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index ad3c17f86c7f..6783c6168445 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1108,20 +1108,24 @@ static int pci_mmap_resource(struct kobject *kobj=
, const struct bin_attribute *a
>  =09struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
>  =09int bar =3D (unsigned long)attr->private;
>  =09enum pci_mmap_state mmap_type;
> -=09struct resource *res =3D pci_resource_n(pdev, bar);
>  =09int ret;
> =20
>  =09ret =3D security_locked_down(LOCKDOWN_PCI_ACCESS);
>  =09if (ret)
>  =09=09return ret;
> =20
> -=09if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
> +=09if (!pci_resource_is_mem(pdev, bar) &&
> +=09    !(pci_resource_is_io(pdev, bar) && arch_can_pci_mmap_io()))
> +=09=09return -EIO;
> +
> +=09if (pci_resource_is_mem(pdev, bar) &&
> +=09    iomem_is_exclusive(pci_resource_start(pdev, bar)))
>  =09=09return -EINVAL;
> =20
>  =09if (!pci_mmap_fits(pdev, bar, vma, PCI_MMAP_SYSFS))
>  =09=09return -EINVAL;
> =20
> -=09mmap_type =3D res->flags & IORESOURCE_MEM ? pci_mmap_mem : pci_mmap_i=
o;
> +=09mmap_type =3D pci_resource_is_mem(pdev, bar) ? pci_mmap_mem : pci_mma=
p_io;
> =20
>  =09return pci_mmap_resource_range(pdev, bar, vma, mmap_type, write_combi=
ne);
>  }
> @@ -1149,6 +1153,9 @@ static ssize_t pci_resource_io(struct file *filp, s=
truct kobject *kobj,
>  =09int bar =3D (unsigned long)attr->private;
>  =09unsigned long port =3D off;
> =20
> +=09if (!pci_resource_is_io(pdev, bar))
> +=09=09return -EIO;
> +
>  =09port +=3D pci_resource_start(pdev, bar);
> =20
>  =09if (port > pci_resource_end(pdev, bar))
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-22180800-1776079463=:962--

