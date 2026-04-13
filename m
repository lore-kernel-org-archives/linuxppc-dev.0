Return-Path: <linuxppc-dev+bounces-19684-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE49F34C41
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 11:45:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvQb55K1dz2yhv;
	Mon, 13 Apr 2026 21:45:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776080753;
	cv=none; b=REsa9L7Sh5JG6hGwxjTkMrUs26CSqbjothn5Xn8L5bjAUUjy7FINvb4THiceH10InUlMOMTqmpicm+lNPk4NJIf4Esy9ADVGsLK/VqwlYJcjM5PzxuOzKlb3eQADHmOTSBaT75PiE6/0U5s5CRXtV2Kr792qo8NE9iaZZwtLqKiwC9xQejHRVNpKnZrlS/nES/YPnum0xSUI912D81U0Lvc3ObjQF2wVv9Y9HnbRH59S1f7eyzY4L98usEr1w3VUxYTWplov3UMHW37ddqXEU1r/e++nkmcp7j7QXyUHJCsObH5wJRQST1Jik2QvCclwIDB7EQXCGatj1D3A7jlK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776080753; c=relaxed/relaxed;
	bh=c1FAGHuyjhipUADF7LLDKYzSAhODhm1PpHvjU2C5dVA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oEvnRP2ZDwXSe0pqavKup2KJpG6u1eKjzDcTf97bUUZO2GW6sziLu3i7IDf9dSDSl2QWDsf72D3iHGGotrzf7vHy9BrVUuk5nZ2QCpqN8KnlKwyfiOlx8C9wAFsgIu5drqNpjxWN+8pxc/djz/mdmSeGnrpqcJnExHfF/+4+GuD4v6O+PtOCyK2cZ5IND5NUCdHlz5xim9lbFTPnVqxTuW7cCYcdG4dEbWPWvzpP3f8uPZ21JD2tIdcNauiH9krI02pme17+EbCPPBQ3pUGM1qtyeSf+3lIzLRSHm1KpNNdyuzts7bJpMfVm9wxGPsINYHz4z9dKeEEgj5BBbS1Rdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dFecN39Q; dkim-atps=neutral; spf=pass (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dFecN39Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvQb43Spcz2yDk
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 21:45:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776080753; x=1807616753;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MXb8znk6JA5uSw7e9wrvMoeQSHS1hheycQygUFtOceI=;
  b=dFecN39QA5gEfKm94Lfcv/D7pkGvTejcC6j2d4U2R0oj35LRV3BLvaKS
   HN+t5rrC0u18S3567k6IIIKPiewdLXaW9QoFZXQS2vVzwh/GEHvEGgD8f
   vSH6AkI0hlrlKolse1rJyQ/SJzT+p2W0vFfmcNHw15Km6b67AXPxmi1QS
   L3gcPFpldxBRkDAChJZsEzLr5kyxUXpAUqQ5teiCm1/Gseez9PCHmamM6
   tqoCR2soEi2BgNtg1PH8eS8rtf6x6g1VSQK8kdwq1zAHNTPNMd36ivn+1
   voIZNNfzd6oM5SIXEjyc+v9rIzpZSo3MYYPIHzGEh8V/wvQEfdLkPGOxU
   A==;
X-CSE-ConnectionGUID: uSOWJZSzT6yuZTiVTUENMw==
X-CSE-MsgGUID: oi4Muw0HTlGNxwt2MCRs5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88396347"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="88396347"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:45:49 -0700
X-CSE-ConnectionGUID: RZP0kXKVTxepfqH2u5Mj1w==
X-CSE-MsgGUID: hvRUpLyoSQGtB1aLUpdGmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="231496176"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:45:41 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:45:32 +0300 (EEST)
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
Subject: Re: [PATCH v4 16/24] alpha/PCI: Remove WARN from __pci_mmap_fits()
In-Reply-To: <20260411080148.471335-17-kwilczynski@kernel.org>
Message-ID: <683c3e65-4589-b3a1-ac51-6d7e2b679944@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-17-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-1168042318-1776080732=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1168042318-1776080732=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Remove the WARN() that fires when userspace attempts to mmap beyond
> the BAR bounds.  The check still returns 0 to reject the mapping,
> but the warning is excessive for normal operation.
>=20
> A similar warning was removed from the PCI core in the commit
> 3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 2748000a7486..c136603ddf2c 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -48,13 +48,7 @@ static int __pci_mmap_fits(struct pci_dev *pdev, int n=
um,
>  =09start =3D vma->vm_pgoff;
>  =09size =3D ((len - 1) >> (PAGE_SHIFT - shift)) + 1;
> =20
> -=09if (start < size && size - start >=3D nr)
> -=09=09return 1;
> -=09WARN(1, "process \"%s\" tried to map%s 0x%08lx-0x%08lx on %s BAR %d "
> -=09=09"(size 0x%08lx)\n",
> -=09=09current->comm, sparse ? " sparse" : "", start, start + nr,
> -=09=09pci_name(pdev), num, size);
> -=09return 0;
> +=09return start < size && size - start >=3D nr;
>  }
> =20
>  /**
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1168042318-1776080732=:962--

