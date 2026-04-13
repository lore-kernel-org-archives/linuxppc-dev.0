Return-Path: <linuxppc-dev+bounces-19679-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057DFEBFD3B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 11:19:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvQ1123X2z2yhv;
	Mon, 13 Apr 2026 21:19:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776079189;
	cv=none; b=iLkdgz18BpR8H6sTjrAJ+7SblcivFSVw8IzWi6QcG/Ju/QtaFAdKlLdOdwyBPjy5GhZCWGr2l0wfKxlX20yh7oYKVV9RNx6huncTd6yHW1n+LYW3MEBF5VnbLFUJCfqh3YFUO5I15i9JIxCY8gNjQobhpN+yFP+V0M1zPLd2y/qfYEdNF772rVkS7IwxrskzXdCD7c66ev8vcA1wMvkKEc/BFKq2HyD6DDTIf3CgUO9n25MXt7jVEPxK70uEwukCu09n2aCETO4EGfb12t3FIYKPi0fWsPX5BpVtMtQS1v8qLPOdf8vgMSHIXNNKyjGijgFnGyU+RTiNGvfnWYU/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776079189; c=relaxed/relaxed;
	bh=FARcUhYNpZjwLnnPL43yYu/rcQKJ4x/Tu7Rb0vwVPQI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Kl2C9fJHLz5HGoX4S8xhp/LSKinsTwKnhvZcbgkyLyCVc+vyzeYZMLuZ1fmaSq8s4t410OMB86pIoYeuB7TvzGCSYy6aZkX8Qb1Bz6SV8GLLbUlg+maYHOqsC6HPI1Jcyljqe9dul1IJdwFwA3sqNs/YoE/8POpsUOGk+/7XJapjK5lBCK5Kw5pO+JhGu+WB5tnziKg3+Qxr663e5hCzMuUCAFUSqtZu8arSO32rjSDZfvaaeUTp31alaEI04djxgrc9+xhQzVvP4KboMuUO9UHO1Ip7lux9LTMNRdT6hKp9Y40grgq4cYxv0DcMbFNv4RUm404U0nog2/YFvNTr9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mz4ce3vH; dkim-atps=neutral; spf=pass (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mz4ce3vH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvQ0x3KRXz2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 21:19:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776079186; x=1807615186;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CVbVKb2nM0zwk8+T+WrSIwjJaIItZ5z+YYob7tPm2q0=;
  b=Mz4ce3vHWYTr2o2br+gKJUkb0vzdFmUYRXTHVuHmNQK46GVj6Q0n71E7
   OMXmBXuPLXmzudsEiBIbaFejoIZBxkqU6Jqa85xafapJ704lDARaZ67hz
   KQHJhoR8Yv77LAueYBSjKhOmtLrlY1VgvR8sC+emXcNfqACOJ3O9AMRwB
   RSFNBrBWuFLFd+icSrLmx5LrjNPSp0nq//GzQZ0SPHm3oVuW774Yufz28
   aR3q/JLADSSyE64qXURYHfMHXBvobWRPkEQLwUZK2fXwmEnZE5lrBzQxU
   1fp8H2K9PCOU9e/dMC1cAy7++Vxl6wTuAIQ25KO2X3HqNuIjF1QgVukxJ
   Q==;
X-CSE-ConnectionGUID: sE5cCx6TT+K9EHv/lE5Kog==
X-CSE-MsgGUID: GwvRxoXCRgmlDoGpd4M/bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80597618"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="80597618"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:19:38 -0700
X-CSE-ConnectionGUID: +OGPYEbfShKT7eOQV1rdjg==
X-CSE-MsgGUID: gjMpAYX/ROeP86KL5DHTBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="234741721"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:19:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:19:27 +0300 (EEST)
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
Subject: Re: [PATCH v4 02/24] PCI: Add pci_resource_is_io() and pci_resource_is_mem()
 helpers
In-Reply-To: <20260411080148.471335-3-kwilczynski@kernel.org>
Message-ID: <22b1e95c-4741-66c3-3ef5-5a87daba6056@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-3-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-2046482584-1776079167=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2046482584-1776079167=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Add helpers to check whether a PCI resource is of I/O port or
> memory type.  These replace the open-coded pci_resource_flags()
> with IORESOURCE_IO and IORESOURCE_MEM pattern used across the
> tree.
>=20
> Suggested-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  include/linux/pci.h | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1c270f1d5123..05aceb7f1f37 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2295,6 +2295,31 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, s=
truct vm_area_struct *vma);
>  =09CONCATENATE(__pci_dev_for_each_res, COUNT_ARGS(__VA_ARGS__)) =09\
>  =09=09    (dev, res, __VA_ARGS__)
> =20
> +/**
> + * pci_resource_is_io - check if a PCI resource is of I/O port type.
> + * @dev: PCI device to check.
> + * @resno: The resource number (BAR index) to check.
> + *
> + * Returns true if the resource type is I/O port.
> + */
> +static inline bool pci_resource_is_io(const struct pci_dev *dev, int res=
no)
> +{
> +=09return resource_type(pci_resource_n(dev, resno)) =3D=3D IORESOURCE_IO=
;
> +}
> +
> +/**
> + * pci_resource_is_mem - check if a PCI resource is of memory type.
> + * @dev: PCI device to check.
> + * @resno: The resource number (BAR index) to check.
> + *
> + * Returns true if the resource type is memory, including
> + * prefetchable memory.
> + */
> +static inline bool pci_resource_is_mem(const struct pci_dev *dev, int re=
sno)
> +{
> +=09return resource_type(pci_resource_n(dev, resno)) =3D=3D IORESOURCE_ME=
M;
> +}
> +
>  /*
>   * Similar to the helpers above, these manipulate per-pci_dev
>   * driver-specific data.  They are really just a wrapper around
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-2046482584-1776079167=:962--

