Return-Path: <linuxppc-dev+bounces-19683-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18164F34C41
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 11:44:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvQYx5Zhbz2yhv;
	Mon, 13 Apr 2026 21:44:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776080693;
	cv=none; b=gGMo5YwV6/zTFHQnVbawkDHvBK6/G8F75R4Bo+yBn+44qc3MygmMAFnmaNU4MEiKHmuHKZiL5tEqhDKbzLvQ5CRAKhlXjc0yzzsqzsa8vknnGU9fgLvDvaHrUBObCa0uCTKMHvaAifBiDXjyOYXHUsYbjghzNDLuI+Tb9ePntAczZi07TsbEAF2acb6YGOFnurcqYc+jdboD/rpserj0fI/matfLg9B25R85Oj1cVg2rf216sLjj2JnTNL+ao8ePxdu3OFFxYfNQQpqoo3sENrNKfNeDPLRIJ+KLdY8cuixH2MndZnwNSc9X2jqvJDF6vqBjd2dKQLpOtCsN1K1Tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776080693; c=relaxed/relaxed;
	bh=0OPnmwYBvXZosOFjXMJRrVIVarhnf2RU37zaKd9adfc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=hS6MIdeQ0PCTBKTzcVc0zRwuINimh87Obnlp+Y3G+boYP3/tAFrqY5F4IgPV7Xf0nWZ1t3L1bfLzOeVmkTrnvHvCItBbia2LiajXyTIPlAJkoI2BAfGJw4mM6U17yxrbm/rbatjZ5mh9jiJTVOaUSyhJIzM44E5kNIprXSYzwDw0IUWehIEPYU+DM2l+/tHdXR762FfEwzHNfrutAx1m5TdfcryU0B38qbUUsipRW+838XCTdrBN5wfi39zQ2p7zBGwUTfXrBLUDRzlLOgUCSdtx2YifIK1upFwyEkuqijixltuR/qJyt050lWPKQjYjlaxfqsngXbkYYonGFozuDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bOoVIJdq; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bOoVIJdq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvQYt0x35z2yDk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 21:44:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776080691; x=1807616691;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=AFSD+d73vMww+hbY63uE4fAGE+VrR8hSSF0t67UtcMY=;
  b=bOoVIJdqYkC1pefJe/IwhcPX/nTb1u1Vc+Wuoix66X6F4m8k8chfbbrC
   NU5KkJPN+w3YBVonWtbGf6kIIsuRAi/ARx6hiV83H9gX7RM7x9tiNMDar
   FwHvWwoFo6ertVEnmsc1i7b1fwaVvxNus1ZfBm1BMgn8YIJoaRWY3k3Ep
   xUNIbxLlocbubpNCRMMqnxr/za1PRtRP2IGx7aHF5XcyIjgnimqqo4gE7
   Rw8MuHxsOxHgFQABWb21HzD1IuafDXF9KLOMqQz3VMGkkaGMUEQQc52/r
   UzGCQcG6N7cPFb8pF21JdiueMF6YEcAuqVd4kjTyRr0iywNLiN9BnRmK+
   A==;
X-CSE-ConnectionGUID: MLaJM7KdQFawDgIJe9VqUQ==
X-CSE-MsgGUID: pZMucf0nQriT1XmFxq7Hbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="80894520"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="80894520"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:44:45 -0700
X-CSE-ConnectionGUID: hIZS6DwhSW2wkfAszU3ESQ==
X-CSE-MsgGUID: 0jcsmTVPSeCQKJIJ8iTaGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="225482707"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:44:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:44:29 +0300 (EEST)
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
Subject: Re: [PATCH v4 15/24] alpha/PCI: Fix __pci_mmap_fits() overflow for
 zero-length BARs
In-Reply-To: <20260411080148.471335-16-kwilczynski@kernel.org>
Message-ID: <e6dfcdef-c5ba-7c23-73cc-cf2ffd084b4e@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-16-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-1214616222-1776080669=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1214616222-1776080669=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Currently, __pci_mmap_fits() computes the BAR size using
> pci_resource_len() - 1, which wraps to a large value when the
> BAR length is zero, causing the bounds check to incorrectly
> succeed.
>=20
> Thus, add an early return for empty resources.
>=20
> Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 6c011dab326d..2748000a7486 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -37,12 +37,16 @@ static int hose_mmap_page_range(struct pci_controller=
 *hose,
>  static int __pci_mmap_fits(struct pci_dev *pdev, int num,
>  =09=09=09   struct vm_area_struct *vma, int sparse)
>  {
> +=09resource_size_t len =3D pci_resource_len(pdev, num);
>  =09unsigned long nr, start, size;
>  =09int shift =3D sparse ? 5 : 0;
> =20
> +=09if (!len)
> +=09=09return 0;
> +
>  =09nr =3D vma_pages(vma);
>  =09start =3D vma->vm_pgoff;
> -=09size =3D ((pci_resource_len(pdev, num) - 1) >> (PAGE_SHIFT - shift)) =
+ 1;
> +=09size =3D ((len - 1) >> (PAGE_SHIFT - shift)) + 1;
> =20
>  =09if (start < size && size - start >=3D nr)
>  =09=09return 1;
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1214616222-1776080669=:962--

