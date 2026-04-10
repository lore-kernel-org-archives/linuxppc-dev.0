Return-Path: <linuxppc-dev+bounces-19555-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DCAE99078
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 10:21:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsXrZ51m9z2yZ6;
	Fri, 10 Apr 2026 20:21:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775816462;
	cv=none; b=alPLrgHHZZzsQ4cbDYJbNrn+Kw5zL3FACs/JDt7S0rbOLTsRVV6kTcfLWJMdBRNhfwwvFxvWaJiYCexfYu8SotmBJTOjO9mMfgs5DzZ4WUMghuCk1Uo2TlGP7VIvr3O44igVVooIynmAx7Ow+8OI/nFda58KsqqfVVPTomjN1iV1Z98M2sNtbAtYNhQWdINgi94xzqYK79luW05R7A+1HkUk8VizRaNgIVS9scghsD9bL30KbUK/85JuMS8Vs+jAiGTT2PqvNqIXkux4Ra9k9RGoRsvf8tNo7er/I1/tKk6UXO5BLdG4U84mT9UdDaJ73qUfoEHDp0BIrCrTkrpHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775816462; c=relaxed/relaxed;
	bh=R+m2XjyshhlJqj0lW9x+tA1ilj0yLqEDc7gDjYdxx+4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dtQ0BBoH4So02gGLJGj7mqRfw5b1KaVy0GtrHvzMJzXH73UpYG44o0OQRDJfh6+na9ca+lrslDvENCOFhCNOl3Mvr9WjsWiiA8T1mzjegYWO1Ja/sbdHJ6IaZv5oI8L/tW1hHBwjCRPGbwcC59i/JlX9iXs8WU4tJIF9MJ7X+bZsed3BHV/AnylLTVug1c4YOMeAsYyEODnbbmB8kw+WbSIqPRXjrwDzXat0X9Moa+1H8h6V9HxhRoyOz79qzyJ+p7N+mNHSN5dOn1fgP8bfQDnBux3BeKVcD0ZT6RbvCUH2oyJxccP74Bm8f7dM+A9RrDPiQ1R/srQhYXX+1WcAew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q1XpHFLo; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q1XpHFLo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsXrY2wxTz2xLt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 20:21:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775816462; x=1807352462;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=N7SkzmsbvwjvxbIwFnYfZTQzj2yOdMq5pJu+/jX/36o=;
  b=Q1XpHFLoU2ItMd8RtjZDLWUhAgVsezfaps9yL4C02UoXV+s08vXw9Vjk
   tFCzfnJ9Ozw8LQ+ws0hh5HE5AZnc/wViBqqXWzZSlJmOUIo0W5BJfGcA9
   7zTkeNvYonfsl6UrlQ97fAb0+PHM5/7g3rIF58AN/YMCfHU3P3NytMBOk
   8KdkUJlMStkm1ykAKnAqns7H4PhLlwyosJ6AG6P2FyTE8kIddylG/GVIq
   N/A5IoXliVGbMl3qo0xV3I4A7oRJ2SSz+A7BAhi7cmZgTSCQM2sz8wRhK
   omSGkyl1PMBdcCjlwrEb5K5p4ffOXPCPpq+HlECm1PKOIJ4lxl2UqKnrW
   w==;
X-CSE-ConnectionGUID: UFv+MaBgQdqEWQwA5IxgxQ==
X-CSE-MsgGUID: JYcTuw65QL+Jeinfqou1ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="80723456"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="80723456"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 03:20:57 -0700
X-CSE-ConnectionGUID: b1xv5qhxQKewR1yTv/q0Pw==
X-CSE-MsgGUID: CBvJAwIOR3+IrzUnbUoSAg==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 03:20:49 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 13:20:44 +0300 (EEST)
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
Subject: Re: [PATCH 01/20] PCI/sysfs: Use PCI resource accessor macros
In-Reply-To: <20260410055040.39233-2-kwilczynski@kernel.org>
Message-ID: <a1a53dfb-ec7b-ac2e-0384-7f294b02596e@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-2-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-511166342-1775816444=:1195"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-511166342-1775816444=:1195
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
>  drivers/pci/pci-sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 16eaaf749ba9..ad3c17f86c7f 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -177,7 +177,7 @@ static ssize_t resource_show(struct device *dev, stru=
ct device_attribute *attr,
>  =09=09max =3D PCI_BRIDGE_RESOURCES;
> =20
>  =09for (i =3D 0; i < max; i++) {
> -=09=09struct resource *res =3D  &pci_dev->resource[i];
> +=09=09struct resource *res =3D pci_resource_n(pci_dev, i);
>  =09=09struct resource zerores =3D {};
> =20
>  =09=09/* For backwards compatibility */
> @@ -715,7 +715,7 @@ static ssize_t boot_vga_show(struct device *dev, stru=
ct device_attribute *attr,
>  =09=09return sysfs_emit(buf, "%u\n", (pdev =3D=3D vga_dev));
> =20
>  =09return sysfs_emit(buf, "%u\n",
> -=09=09=09  !!(pdev->resource[PCI_ROM_RESOURCE].flags &
> +=09=09=09  !!(pci_resource_flags(pdev, PCI_ROM_RESOURCE) &
>  =09=09=09     IORESOURCE_ROM_SHADOW));
>  }
>  static DEVICE_ATTR_RO(boot_vga);
> @@ -1108,7 +1108,7 @@ static int pci_mmap_resource(struct kobject *kobj, =
const struct bin_attribute *a
>  =09struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
>  =09int bar =3D (unsigned long)attr->private;
>  =09enum pci_mmap_state mmap_type;
> -=09struct resource *res =3D &pdev->resource[bar];
> +=09struct resource *res =3D pci_resource_n(pdev, bar);
>  =09int ret;
> =20
>  =09ret =3D security_locked_down(LOCKDOWN_PCI_ACCESS);
> @@ -1312,7 +1312,7 @@ static int pci_create_resource_files(struct pci_dev=
 *pdev)
>  =09=09retval =3D pci_create_attr(pdev, i, 0);
>  =09=09/* for prefetchable resources, create a WC mappable file */
>  =09=09if (!retval && arch_can_pci_mmap_wc() &&
> -=09=09    pdev->resource[i].flags & IORESOURCE_PREFETCH)
> +=09=09    pci_resource_flags(pdev, i) & IORESOURCE_PREFETCH)
>  =09=09=09retval =3D pci_create_attr(pdev, i, 1);
>  =09=09if (retval) {
>  =09=09=09pci_remove_resource_files(pdev);
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-511166342-1775816444=:1195--

