Return-Path: <linuxppc-dev+bounces-28751-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C68B2CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 11:47:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx6Tv16d7z2yNj;
	Fri, 02 Oct 2026 21:47:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790941667;
	cv=none; b=iKMinCLE6lCR/KFGCTVyKT46W0Y9mLlF5zk6LHMr4UHUqiD4g6mUfFQv5mEMSY5qgjU+dl9cpRJNjh707qktqcZFY+LV9GnmDDb/S7x7G26e4Yxd4vHwPsuhhUuqiaJxXOD/8hChrs2d0E/rWh2OWi0BGZ8rQI9pfA2bH4Sf1E5XXJBpM2KpQeoDZbIhSUMHLR9erH/5lSqLVkJjZVRoC0DN8ZkfX4ob6+cVK74HcbU0X/FonMvXEaKonBfpOTSdnJgOO6XZqR84Oh7LKzxR+vVsRDOnarQvJjOhLdFwm6WHg8/Mj3cOB4lZJ14Tu7hzrXuvueWyodYBQKTasn3UdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790941667; c=relaxed/relaxed;
	bh=R33ZAYuwnPBAoLjaMBYUmIjSR5xpgxOTVgp5BCiNXo0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z+7kSlRq8tI/DJOWuJYQSMA3rq0bMKw0iWmxfAoPtvdM1HZumOt/TVCUoQtHt8+0iR3ZCfT7Xs6Xcgnf5klr7MjhmEpPaqus4btX1qQVEG9d3T1kueuaZf/tOUfpzI6N2Y6eQzNNSnjwPCTI2wJcygPcseItg8I/DCoMmZkftpxoqpTGi/3byeXmhfdb2HqN3LI7Sz9xrtg5349KIjGwyTy91FS7bKrPBHE7Mx8W+U5J/D/l61bZiZZt3Bijp+yEYXA7ogoErt66Ny06GVeM+NheJkm64xN4+yNO+t4gWV+KEkgIC8kT/pQu1hvukYppvYcyTrfDVr3J4y9/TkbJNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C46QNPMj; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C46QNPMj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=jani.nikula@intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 62 seconds by postgrey-1.37 at boromir; Fri, 02 Oct 2026 21:47:45 AEST
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx6Ts4Y17z2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 21:47:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790941666; x=1822477666;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=mWoRIntWaGO76TOBS5XHUSkSv1qY1n9P/rXRzsVfJNo=;
  b=C46QNPMjDs40kfSxRHO7++wyGczYEsSL8dHVXZAHHlKuRJ9OolbrwjfQ
   pJSScM5yOHzsh9cr/nYdFHdQHzyPs/7Ho1IXJE4sH0yprk7mVrdDmm3zE
   D0Ne71ysZMKDJJmzGuj7/SLicqf2Mn77Z+u1f5ZxkbcGNbGq2rrRRFlWu
   akfx5HDP3fsuPYESj4Fn14jYZ+1oqK/7++WS4SeMp4+4qvwQz0Ajy3INU
   AFxfFVkbYGKnhIWZj4L746L7yeKShiO4o2hyhAP0f8ukaVyICqdz2Ivzq
   5b2dT3zGqhQPE5LGyewtmnsQwUEOZYiOo9YUjdYU5plYJQmC7gnWmL51A
   Q==;
X-CSE-ConnectionGUID: etG+QASkQg6XbtkU/5KSAA==
X-CSE-MsgGUID: UN31xGfwTuq2yNkH4SJbKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90660510"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90660510"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:46:39 -0700
X-CSE-ConnectionGUID: QMfvUu4kR32GValX2JFXAA==
X-CSE-MsgGUID: KT12av6fSySLPozcZziDoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="279970531"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 04:46:28 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Maciej
 Grochowski
 <Maciej.Grochowski@sony.com>, Nikolas Joshua Britton <nbritton@exabit.io>,
 Geramy Loveless <gloveless@jqluv.com>, Eric Auger <eauger@redhat.com>,
 Alexey Fomenko <alexey.fomenko@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Richard Henderson
 <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, Magnus
 Lindholm <linmag7@gmail.com>, Russell King <linux@armlinux.org.uk>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, John Paul
 Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max
 Filippov <jcmvbkbc@gmail.com>, David Airlie <airlied@redhat.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Simona
 Vetter <simona@ffwll.ch>, Ilpo =?utf-8?Q?J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: Bradley Morgan <brads@mainlining.org>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 3/7] PCI: Honor alignment overrides
In-Reply-To: <20261002113319.6652-4-ilpo.jarvinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20261002113319.6652-1-ilpo.jarvinen@linux.intel.com>
 <20261002113319.6652-4-ilpo.jarvinen@linux.intel.com>
Date: Fri, 02 Oct 2026 14:46:25 +0300
Message-ID: <9e51b97829056a26ae1fd72f665ead94c018d004@intel.com>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 02 Oct 2026, Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wro=
te:
> pci=3Dresource_alignment argument can override the default alignment for
> the resource. The remainder code introduced in the commit 9036bd0efcb6
> ("PCI: Align head space better") can move remainder space (non-aligning
> part of the size) before the aligning left edge which results in
> violating the requested alignment.
>
> Introduce struct pci_resreq_data to hold device and user-given alignment
> to be able to honor it in pci_align_resource(). When user-given alignment
> is found, any remainder movement is skipped.
>
> Fixes: 9036bd0efcb6 ("PCI: Align head space better")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/linux-pci/20260923133202.07DF61F000FF@smtp.=
kernel.org/
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

So I don't have the time to figure out what's going on here, but
assuming you get proper review, the i915 part is

Acked-by: Jani Nikula <jani.nikula@intel.com>

for merging via whichever tree makes sense.

> ---
>  arch/alpha/kernel/pci.c          |  3 ++-
>  arch/arm/kernel/bios32.c         |  5 +++--
>  arch/m68k/kernel/pcibios.c       |  4 ++--
>  arch/mips/pci/pci-generic.c      |  5 +++--
>  arch/mips/pci/pci-legacy.c       |  5 +++--
>  arch/parisc/kernel/pci.c         |  5 +++--
>  arch/powerpc/kernel/pci-common.c |  5 +++--
>  arch/sh/drivers/pci/pci.c        |  5 +++--
>  arch/x86/pci/i386.c              |  5 +++--
>  arch/xtensa/kernel/pci.c         |  5 +++--
>  drivers/char/agp/intel-gtt.c     |  5 ++++-
>  drivers/gpu/drm/i915/i915_gmch.c |  5 +++--
>  drivers/pci/pci.c                |  5 +++--
>  drivers/pci/setup-res.c          | 19 +++++++++++++------
>  include/linux/pci.h              | 26 ++++++++++++++++++++++++--
>  15 files changed, 75 insertions(+), 32 deletions(-)
>
> diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
> index 11df411b1d18..c5d725a9781f 100644
> --- a/arch/alpha/kernel/pci.c
> +++ b/arch/alpha/kernel/pci.c
> @@ -128,7 +128,8 @@ pcibios_align_resource(void *data, const struct resou=
rce *res,
>  		       const struct resource *empty_res,
>  		       resource_size_t size, resource_size_t align)
>  {
> -	struct pci_dev *dev =3D data;
> +	struct pci_resreq_data *rr =3D data;
> +	struct pci_dev *dev =3D rr->dev;
>  	struct pci_controller *hose =3D dev->sysdata;
>  	unsigned long alignto;
>  	resource_size_t start =3D res->start;
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index ac0e890510da..3e61826f07fb 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -564,7 +564,8 @@ resource_size_t pcibios_align_resource(void *data, co=
nst struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t align)
>  {
> -	struct pci_dev *dev =3D data;
> +	struct pci_resreq_data *rr =3D data;
> +	struct pci_dev *dev =3D rr->dev;
>  	resource_size_t start =3D res->start;
>  	struct pci_host_bridge *host_bridge;
>=20=20
> @@ -578,7 +579,7 @@ resource_size_t pcibios_align_resource(void *data, co=
nst struct resource *res,
>  				start, size, align);
>=20=20
>  	if (res->flags & IORESOURCE_MEM)
> -		return pci_align_resource(dev, res, empty_res, size, align);
> +		return pci_align_resource(rr, res, empty_res, size, align);
>=20=20
>  	return start;
>  }
> diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
> index 7a9e60df79c5..3024408412bc 100644
> --- a/arch/m68k/kernel/pcibios.c
> +++ b/arch/m68k/kernel/pcibios.c
> @@ -31,14 +31,14 @@ resource_size_t pcibios_align_resource(void *data, co=
nst struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t align)
>  {
> -	struct pci_dev *dev =3D data;
> +	struct pci_resreq_data *rr =3D data;
>  	resource_size_t start =3D res->start;
>=20=20
>  	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
>  		start =3D (start + 0x3ff) & ~0x3ff;
>=20=20
>  	if (res->flags & IORESOURCE_MEM)
> -		return pci_align_resource(dev, res, empty_res, size, align);
> +		return pci_align_resource(rr, res, empty_res, size, align);
>=20=20
>  	return start;
>  }
> diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
> index c2e23d0c1d77..7f3ecb91b85b 100644
> --- a/arch/mips/pci/pci-generic.c
> +++ b/arch/mips/pci/pci-generic.c
> @@ -25,7 +25,8 @@ resource_size_t pcibios_align_resource(void *data, cons=
t struct resource *res,
>  				       const struct resource *empty_res,
>  				       resource_size_t size, resource_size_t align)
>  {
> -	struct pci_dev *dev =3D data;
> +	struct pci_resreq_data *rr =3D data;
> +	struct pci_dev *dev =3D rr->dev;
>  	resource_size_t start =3D res->start;
>  	struct pci_host_bridge *host_bridge;
>=20=20
> @@ -39,7 +40,7 @@ resource_size_t pcibios_align_resource(void *data, cons=
t struct resource *res,
>  				start, size, align);
>=20=20
>  	if (res->flags & IORESOURCE_MEM)
> -		return pci_align_resource(dev, res, empty_res, size, align);
> +		return pci_align_resource(rr, res, empty_res, size, align);
>=20=20
>  	return start;
>  }
> diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
> index dae6dafdd6e0..82d4b01db64e 100644
> --- a/arch/mips/pci/pci-legacy.c
> +++ b/arch/mips/pci/pci-legacy.c
> @@ -55,7 +55,8 @@ pcibios_align_resource(void *data, const struct resourc=
e *res,
>  		       const struct resource *empty_res,
>  		       resource_size_t size, resource_size_t align)
>  {
> -	struct pci_dev *dev =3D data;
> +	struct pci_resreq_data *rr =3D data;
> +	struct pci_dev *dev =3D rr->dev;
>  	struct pci_controller *hose =3D dev->sysdata;
>  	resource_size_t start =3D res->start;
>=20=20
> @@ -70,7 +71,7 @@ pcibios_align_resource(void *data, const struct resourc=
e *res,
>  		if (start & 0x300)
>  			start =3D (start + 0x3ff) & ~0x3ff;
>  	} else if (res->flags & IORESOURCE_MEM) {
> -		start =3D pci_align_resource(dev, res, empty_res, size, align);
> +		start =3D pci_align_resource(rr, res, empty_res, size, align);
>=20=20
>  		/* Make sure we start at our min on all hoses */
>  		if (start < PCIBIOS_MIN_MEM + hose->mem_resource->start)
> diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
> index 518f532ccddc..d582be996051 100644
> --- a/arch/parisc/kernel/pci.c
> +++ b/arch/parisc/kernel/pci.c
> @@ -193,7 +193,8 @@ resource_size_t pcibios_align_resource(void *data, co=
nst struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t alignment)
>  {
> -	struct pci_dev *dev =3D data;
> +	struct pci_resreq_data *rr =3D data;
> +	struct pci_dev *dev =3D rr->dev;
>  	resource_size_t align, start =3D res->start;
>=20=20
>  	pci_dbg(dev, "%pR: pcibios_align_resource(%lx, 0x%llx, 0x%llx), parent =
%pR\n",
> @@ -205,7 +206,7 @@ resource_size_t pcibios_align_resource(void *data, co=
nst struct resource *res,
>  	if (align > alignment)
>  		start =3D ALIGN(start, align);
>  	else
> -		start =3D pci_align_resource(dev, res, empty_res, size, alignment);
> +		start =3D pci_align_resource(rr, res, empty_res, size, alignment);
>=20=20
>  	return start;
>  }
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-c=
ommon.c
> index 4fc52c21fe5d..23594759cfe2 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1131,7 +1131,8 @@ resource_size_t pcibios_align_resource(void *data, =
const struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t align)
>  {
> -	struct pci_dev *dev =3D data;
> +	struct pci_resreq_data *rr =3D data;
> +	struct pci_dev *dev =3D rr->dev;
>  	resource_size_t start =3D res->start;
>=20=20
>  	if (res->flags & IORESOURCE_IO) {
> @@ -1140,7 +1141,7 @@ resource_size_t pcibios_align_resource(void *data, =
const struct resource *res,
>  		if (start & 0x300)
>  			start =3D (start + 0x3ff) & ~0x3ff;
>  	} else if (res->flags & IORESOURCE_MEM) {
> -		start =3D pci_align_resource(dev, res, empty_res, size, align);
> +		start =3D pci_align_resource(rr, res, empty_res, size, align);
>  	}
>=20=20
>  	return start;
> diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
> index 878a27a1acfb..279f2770ff4b 100644
> --- a/arch/sh/drivers/pci/pci.c
> +++ b/arch/sh/drivers/pci/pci.c
> @@ -172,7 +172,8 @@ resource_size_t pcibios_align_resource(void *data, co=
nst struct resource *res,
>  				       resource_size_t size,
>  				       resource_size_t align)
>  {
> -	struct pci_dev *dev =3D data;
> +	struct pci_resreq_data *rr =3D data;
> +	struct pci_dev *dev =3D rr->dev;
>  	struct pci_channel *hose =3D dev->sysdata;
>  	resource_size_t start =3D res->start;
>=20=20
> @@ -186,7 +187,7 @@ resource_size_t pcibios_align_resource(void *data, co=
nst struct resource *res,
>  		if (start & 0x300)
>  			start =3D (start + 0x3ff) & ~0x3ff;
>  	} else if (res->flags & IORESOURCE_MEM) {
> -		start =3D pci_align_resource(dev, res, empty_res, size, align);
> +		start =3D pci_align_resource(rr, res, empty_res, size, align);
>  	}
>=20=20
>  	return start;
> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> index e2de26b82940..4178ae4380c2 100644
> --- a/arch/x86/pci/i386.c
> +++ b/arch/x86/pci/i386.c
> @@ -156,7 +156,8 @@ pcibios_align_resource(void *data, const struct resou=
rce *res,
>  		       const struct resource *empty_res,
>  		       resource_size_t size, resource_size_t align)
>  {
> -	struct pci_dev *dev =3D data;
> +	struct pci_resreq_data *rr =3D data;
> +	struct pci_dev *dev =3D rr->dev;
>  	resource_size_t start =3D res->start;
>=20=20
>  	if (res->flags & IORESOURCE_IO) {
> @@ -165,7 +166,7 @@ pcibios_align_resource(void *data, const struct resou=
rce *res,
>  		if (start & 0x300)
>  			start =3D (start + 0x3ff) & ~0x3ff;
>  	} else if (res->flags & IORESOURCE_MEM) {
> -		start =3D pci_align_resource(dev, res, empty_res, size, align);
> +		start =3D pci_align_resource(rr, res, empty_res, size, align);
>=20=20
>  		/* The low 1MB range is reserved for ISA cards */
>  		if (start < BIOS_END)
> diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
> index 305031551136..4e8ad4a3c9fe 100644
> --- a/arch/xtensa/kernel/pci.c
> +++ b/arch/xtensa/kernel/pci.c
> @@ -42,7 +42,8 @@ pcibios_align_resource(void *data, const struct resourc=
e *res,
>  		       const struct resource *empty_res,
>  		       resource_size_t size, resource_size_t align)
>  {
> -	struct pci_dev *dev =3D data;
> +	struct pci_resreq_data *rr =3D data;
> +	struct pci_dev *dev =3D rr->dev;
>  	resource_size_t start =3D res->start;
>=20=20
>  	if (res->flags & IORESOURCE_IO) {
> @@ -55,7 +56,7 @@ pcibios_align_resource(void *data, const struct resourc=
e *res,
>  		if (start & 0x300)
>  			start =3D (start + 0x3ff) & ~0x3ff;
>  	} else if (res->flags & IORESOURCE_MEM) {
> -		start =3D pci_align_resource(dev, res, empty_res, size, align);
> +		start =3D pci_align_resource(rr, res, empty_res, size, align);
>  	}
>=20=20
>  	return start;
> diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
> index bcc26785175d..2214347906a6 100644
> --- a/drivers/char/agp/intel-gtt.c
> +++ b/drivers/char/agp/intel-gtt.c
> @@ -1038,10 +1038,13 @@ static struct agp_memory *intel_fake_agp_alloc_by=
_type(size_t pg_count,
>=20=20
>  static int intel_alloc_chipset_flush_resource(void)
>  {
> +	struct pci_resreq_data rr;
>  	int ret;
> +
> +	pci_init_pci_resreq_data(&rr, intel_private.bridge_dev);
>  	ret =3D pci_bus_alloc_resource(intel_private.bridge_dev->bus, &intel_pr=
ivate.ifp_resource, PAGE_SIZE,
>  				     PAGE_SIZE, PCIBIOS_MIN_MEM, 0,
> -				     pcibios_align_resource, intel_private.bridge_dev);
> +				     pcibios_align_resource, &rr);
>=20=20
>  	return ret;
>  }
> diff --git a/drivers/gpu/drm/i915/i915_gmch.c b/drivers/gpu/drm/i915/i915=
_gmch.c
> index b0ef6ef577a3..d35097bebc0f 100644
> --- a/drivers/gpu/drm/i915/i915_gmch.c
> +++ b/drivers/gpu/drm/i915/i915_gmch.c
> @@ -38,6 +38,7 @@ static int mchbar_reg(struct drm_i915_private *i915)
>  static int
>  intel_alloc_mchbar_resource(struct drm_i915_private *i915)
>  {
> +	struct pci_resreq_data rr;
>  	u32 temp_lo, temp_hi =3D 0;
>  	u64 mchbar_addr;
>  	int ret;
> @@ -55,12 +56,12 @@ intel_alloc_mchbar_resource(struct drm_i915_private *=
i915)
>  	/* Get some space for it */
>  	i915->gmch.mch_res.name =3D "i915 MCHBAR";
>  	i915->gmch.mch_res.flags =3D IORESOURCE_MEM;
> +	pci_init_pci_resreq_data(&rr, i915->gmch.pdev);
>  	ret =3D pci_bus_alloc_resource(i915->gmch.pdev->bus,
>  				     &i915->gmch.mch_res,
>  				     MCHBAR_SIZE, MCHBAR_SIZE,
>  				     PCIBIOS_MIN_MEM,
> -				     0, pcibios_align_resource,
> -				     i915->gmch.pdev);
> +				     0, pcibios_align_resource, &rr);
>  	if (ret) {
>  		drm_dbg(&i915->drm, "failed bus alloc: %d\n", ret);
>  		i915->gmch.mch_res.start =3D 0;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b2879a6be5f8..1b7a4469c6ca 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6444,8 +6444,8 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
>   * RETURNS: Resource alignment if it is specified.
>   *          Zero if it is not specified.
>   */
> -static resource_size_t pci_specified_resource_alignment(struct pci_dev *=
dev,
> -							bool *resize)
> +resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> +						 bool *resize)
>  {
>  	int align_order, count;
>  	resource_size_t align =3D pcibios_default_alignment();
> @@ -6497,6 +6497,7 @@ static resource_size_t pci_specified_resource_align=
ment(struct pci_dev *dev,
>  	spin_unlock(&resource_alignment_lock);
>  	return align;
>  }
> +EXPORT_SYMBOL_GPL(pci_specified_resource_alignment);
>=20=20
>  static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
>  					   resource_size_t align, bool resize)
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 376f09630a4a..441a62807719 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -265,17 +265,21 @@ resource_size_t pci_resource_alignment(const struct=
 pci_dev *dev,
>   * before res->start if there's enough free space there. This enables
>   * tighter packing for resources.
>   */
> -resource_size_t pci_align_resource(struct pci_dev *dev,
> +resource_size_t pci_align_resource(struct pci_resreq_data *rr,
>  				   const struct resource *res,
>  				   const struct resource *empty_res,
>  				   resource_size_t size,
>  				   resource_size_t align)
>  {
> +	struct pci_dev *dev =3D rr->dev;
>  	resource_size_t remainder, start_addr;
>=20=20
>  	if (!(res->flags & IORESOURCE_MEM))
>  		return res->start;
>=20=20
> +	if (rr->user_align)
> +		return res->start;
> +
>  	if (IS_ALIGNED(size, align))
>  		return res->start;
>=20=20
> @@ -306,18 +310,21 @@ resource_size_t __weak pcibios_align_resource(void =
*data,
>  					      resource_size_t size,
>  					      resource_size_t align)
>  {
> -	struct pci_dev *dev =3D data;
> +	struct pci_resreq_data *rr =3D data;
>=20=20
> -	return pci_align_resource(dev, res, empty_res, size, align);
> +	return pci_align_resource(rr, res, empty_res, size, align);
>  }
>=20=20
>  static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *de=
v,
>  		int resno, resource_size_t size, resource_size_t align)
>  {
>  	struct resource *res =3D pci_resource_n(dev, resno);
> +	struct pci_resreq_data rr;
>  	resource_size_t min;
>  	int ret;
>=20=20
> +	pci_init_pci_resreq_data(&rr, dev);
> +
>  	min =3D (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
>=20=20
>  	/*
> @@ -329,7 +336,7 @@ static int __pci_assign_resource(struct pci_bus *bus,=
 struct pci_dev *dev,
>  	 */
>  	ret =3D pci_bus_alloc_resource(bus, res, size, align, min,
>  				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
> -				     pcibios_align_resource, dev);
> +				     pcibios_align_resource, &rr);
>  	if (ret =3D=3D 0)
>  		return 0;
>=20=20
> @@ -341,7 +348,7 @@ static int __pci_assign_resource(struct pci_bus *bus,=
 struct pci_dev *dev,
>  	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
>  		ret =3D pci_bus_alloc_resource(bus, res, size, align, min,
>  					     IORESOURCE_PREFETCH,
> -					     pcibios_align_resource, dev);
> +					     pcibios_align_resource, &rr);
>  		if (ret =3D=3D 0)
>  			return 0;
>  	}
> @@ -354,7 +361,7 @@ static int __pci_assign_resource(struct pci_bus *bus,=
 struct pci_dev *dev,
>  	 */
>  	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
>  		ret =3D pci_bus_alloc_resource(bus, res, size, align, min, 0,
> -					     pcibios_align_resource, dev);
> +					     pcibios_align_resource, &rr);
>=20=20
>  	return ret;
>  }
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d31a8d107b1e..fe0233f0d9e6 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1217,12 +1217,34 @@ int __must_check pcibios_enable_device(struct pci=
_dev *, int mask);
>  /* Architecture-specific versions may override this (weak) */
>  char *pcibios_setup(char *str);
>=20=20
> -/* Used only when drivers/pci/setup.c is used */
> +/* Resource assignment request handling */
> +/**
> + * struct pci_resreq_data - Data passed to pcibios_align_resource()
> + * @dev: PCI device
> + * @user_align: User provided alignment override (pci=3Dresource_alignme=
nt param)
> + */
> +struct pci_resreq_data {
> +	struct pci_dev *dev;
> +	resource_size_t user_align;
> +};
> +
> +resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
> +						 bool *resize);
> +static inline void pci_init_pci_resreq_data(struct pci_resreq_data *rr,
> +					    struct pci_dev *dev)
> +{
> +	bool user_aligned;
> +
> +	memset(rr, 0, sizeof(*rr));
> +	rr->dev =3D dev;
> +	rr->user_align =3D pci_specified_resource_alignment(dev, &user_aligned);
> +}
> +
>  resource_size_t pcibios_align_resource(void *data, const struct resource=
 *res,
>  				       const struct resource *empty_res,
>  				       resource_size_t size,
>  				       resource_size_t align);
> -resource_size_t pci_align_resource(struct pci_dev *dev,
> +resource_size_t pci_align_resource(struct pci_resreq_data *rr,
>  				   const struct resource *res,
>  				   const struct resource *empty_res,
>  				   resource_size_t size,

--=20
Jani Nikula, Intel

