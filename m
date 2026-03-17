Return-Path: <linuxppc-dev+bounces-18324-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35029FED9E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 15:26:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZwmD5B1mz2yh4;
	Wed, 18 Mar 2026 02:26:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773761196;
	cv=none; b=H6TMBrEJelZ95fWvd00DplKcPsCoj4WGFndAGpDdHQ4CsYWFk+WhghR7wxe8lvFkRBIv9F6wtTtgFWa1CAQ1QrZXOi6c7EosE8onxwvr2vWTCFT4cXIeTVf26RMXUIthDCGaNnaG+bu07OF0CRG4YNrf3YmrJNcY3BEqEAyKmSiycgiVvKtkTOweZuFyWBHQaHohBMfVNr4c6oaXscwW+001QM9WTgbrcqvx9Qp1J9WF+M//7am4coz/w9VSvZbLBoKWI7cv8oxhFoyy5oG0SvhmNvH1fxew3Fx+dSxfj5+V5WTlDihHFqE2XAjHxK40fjD0c8gJPuE8w0gyIGQExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773761196; c=relaxed/relaxed;
	bh=KIQ6xtapd9/L6M5LvJi2i18CX9YCdA7sE0Usfp9KiK8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WVL6jEvyonGDPKv25XuuWeZK2f+kk1Wq+OVmVcPwu2V/PXfM1gM4ET6m47xKB15WOOEZuAiudvqIZga3ZvrpYXXYE8lmvfbBbUazKAoz8szSZ4EwnvktHvm4bm/XHxtDlRLXrR4y1BXq1hSOao2j48Qwd64MvuopqqKL55hJz5+kZ2+lbUofWZBxobbony36vfF8aLgJTec0wljA52nLhus0JWhgzKsNDEUf7QBqiRIZXnDfPfgcNa1xJ/22kVio9+6VngC5y1Ie+zTpHsl88EH6yCnmlEtMCOz3Kt1Is2SKww7IFKqNOI4xFqb+cY4bRWR0DbgPTOT9ouOER2qpJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GrB3BH7p; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GrB3BH7p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZwmB6JbHz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 02:26:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773761195; x=1805297195;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hYXp9a2NLaQVekWjZ+4yth845DCIClXSayYXXsM3Uyc=;
  b=GrB3BH7ppcjvO+kIiI+SvomZcfUuVuJBA8j9LFevGTM3uPTsLyAc3zdQ
   eq68h631InilJTPjybFfpc541VTn+6sE4vKRcs/apuaGbuEwxtiDDsKjJ
   AwtKYBEw0ge/LGT1YBgWE1XvPGUBbidnGCTFLPJ6F0C26tfpVjocky8Cg
   neD+elM5UuSpsHIcAvGaZOpisNoWmA5aSdiwUeImXPuBk1V2lKkfDkRFL
   LGBfDjo5goXf4d3lOT1d14yDU+3LvHlKzzbqlCigsSlNWTbBfjTWoZ6B0
   tK8LyCG2Kow/jSytKLfRLnscTVIL+2LUeltLbAsT1SkyPcOs8DveSmoLO
   w==;
X-CSE-ConnectionGUID: vCEgCsIfRmutaFZgMyIsAg==
X-CSE-MsgGUID: bF5e2qtFT/WkOO3fQ/T8nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74681346"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="74681346"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:26:32 -0700
X-CSE-ConnectionGUID: ZST71INmRsKeCKApGPuKCQ==
X-CSE-MsgGUID: m12kp4T8QlWEYWIU2Ok2MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="245322289"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:26:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 17:26:22 +0200 (EET)
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
    =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, 
    Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, 
    Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
    "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
    Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, 
    Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v2 4/4] PCI: rpaphp: Simplify with scoped for each OF
 child loop
In-Reply-To: <20260317133322.266102-8-krzysztof.kozlowski@oss.qualcomm.com>
Message-ID: <b983a05b-2d90-2a88-4b60-49c6c5ee777d@linux.intel.com>
References: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com> <20260317133322.266102-8-krzysztof.kozlowski@oss.qualcomm.com>
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
Content-Type: multipart/mixed; boundary="8323328-1763753626-1773761182=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1763753626-1773761182=:968
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Mar 2026, Krzysztof Kozlowski wrote:

> Use scoped for-each loop when iterating over device nodes to make code a
> bit simpler.
>=20
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
>=20
> ---
>=20
> Changes in v2:
> Tags
> ---
>  drivers/pci/hotplug/rpaphp_slot.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpap=
hp_slot.c
> index 33ca19200c1b..67362e5b9971 100644
> --- a/drivers/pci/hotplug/rpaphp_slot.c
> +++ b/drivers/pci/hotplug/rpaphp_slot.c
> @@ -82,7 +82,6 @@ EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
>  int rpaphp_register_slot(struct slot *slot)
>  {
>  =09struct hotplug_slot *php_slot =3D &slot->hotplug_slot;
> -=09struct device_node *child;
>  =09u32 my_index;
>  =09int retval;
>  =09int slotno =3D -1;
> @@ -97,11 +96,10 @@ int rpaphp_register_slot(struct slot *slot)
>  =09=09return -EAGAIN;
>  =09}
> =20
> -=09for_each_child_of_node(slot->dn, child) {
> +=09for_each_child_of_node_scoped(slot->dn, child) {
>  =09=09retval =3D of_property_read_u32(child, "ibm,my-drc-index", &my_ind=
ex);
>  =09=09if (my_index =3D=3D slot->index) {
>  =09=09=09slotno =3D PCI_SLOT(PCI_DN(child)->devfn);
> -=09=09=09of_node_put(child);
>  =09=09=09break;
>  =09=09}
>  =09}
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1763753626-1773761182=:968--

