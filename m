Return-Path: <linuxppc-dev+bounces-19561-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A782DF44842
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:15:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsZ332r7wz2yZ6;
	Fri, 10 Apr 2026 21:15:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775819711;
	cv=none; b=c1Rdsmpt2uLijHsoF/h9nCGBQAbzwjHe821pOWKXvluOYOnOzyxzXniIbBieX1SEgLwlw/vTEoN3io0KCtAUshWC5I764yQw9jaocdALH1pWGwbb89y89zxCwdOHNvlK4X32tCnKFfxEUy8oTu7JEEr660anWD5k3tR0Mbzowa0iLatHdwyjqgJixHbvDG1kTIjXXkYhSf9XRHpjOyTnQBPHzoHNUPCHUlOpX44t+W4UYhbcN+OIYiwpkiPcUzj1w1cfNL6beLtSGF19Se0ST8YlhzqFPLofoYWCtmR8PonVygvBWM/rWl2sX/VffrEIkgChvqb2RwUh21nH4G08LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775819711; c=relaxed/relaxed;
	bh=AjxalHPdeTS7oFuihHSHMPAnRhS7F2ULqIIUORCmR14=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oAjsomSxxFZHHKId/QTyfDgkxlTMR1wjOUER8S9yy8cD8shwSRS/Jp4i5M4/IWXT+Rdirh2nMNb+lJU4ofLb98wTcmMYxkDbIcI6FYuF9dU+GNAS9KIi5ZHC/0XZdj2wBz7dVWrXJwXyv596DqY3dEBxjFYuV1cYTIUEK3YlUif+SIIrLe554gAPp0BVXGlEwyvfxILZXRahVnhAd7hX1vDNNDUtItvZAVP7Lz7KsHInDWVDSR69Ua12HbFjwfI2bN0+kDixf6nqkwsgUb5qX8nHDBQWa+sIBUj0iuva8rG+0BrjAuJulJnJ0lVFUVcE5iUDV10G/oXqKIlW7p5xaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CkN7lzyZ; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CkN7lzyZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsZ321gjlz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:15:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775819711; x=1807355711;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LQlh8I55FJSDZdIW0plgYRYVBRUjST2rjdHoYnP/X9g=;
  b=CkN7lzyZsx0QDHnxQ11tZHiFE70jFZqtz5+JUFEBpybzNSNqRsLPuFcV
   /8FZ0ExAdj+4xSWMSDbctdVFvkhdhmaf2T+lEjSFh734dxKh2+zQgHGbx
   VTh6G8Cc6qwQm1N0RcDX6Mop0UFuZlSb5IBx72zD1yi4Kb80DL4cd5S+8
   uq/L8LBd40vYWfhplZ8qVbngo17+0xPvx1YfleYkqcXSNa7CrDKmzS/Bj
   Cp5ePC2APtIW/KuL5Bnz8ZHcRas1c14dPBrosossIxyKDgDAa1pWBRuYu
   dppV9LRXAQqx7Y/vUQtKcY4+P5nl+ntAnTNjUnVTU44pYaSyp2CkKbVgg
   g==;
X-CSE-ConnectionGUID: BfLyQN1SQm2+wM3qh33UsQ==
X-CSE-MsgGUID: eGgjDwDAQRqVVWjvGA6eyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="94415840"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="94415840"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:15:07 -0700
X-CSE-ConnectionGUID: XwV8+G46Tz+BFYBFlBtq8g==
X-CSE-MsgGUID: z5AtohwQS8qN4xrUHCo/DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="267023344"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:14:58 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 14:14:55 +0300 (EEST)
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
Subject: Re: [PATCH 13/20] alpha/PCI: Clean up __pci_mmap_fits()
In-Reply-To: <20260410055040.39233-14-kwilczynski@kernel.org>
Message-ID: <66eb23bf-1995-363f-78e6-f5a397a063a2@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-14-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-133140870-1775819695=:1195"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-133140870-1775819695=:1195
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Currently, __pci_mmap_fits() computes the BAR size using
> pci_resource_len() - 1, which wraps to a large value when the
> BAR length is zero, causing the bounds check to incorrectly
> succeed.
>=20
> Thus, add an early return for empty resources.
>=20
> Also, remove the WARN() that fires when userspace attempts to
> mmap beyond the BAR bounds.  The check still returns 0 to reject
> the mapping, but the warning is excessive for normal operation.
>=20
> A similar warning was removed from the PCI core in the commit
> 3b519e4ea618 ("PCI: fix size checks for mmap() on /proc/bus/pci files").

This looks like entirely separate two changes to me which just happen=20
within the same context.

> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 7aac5e76dcd6..867199b988de 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -37,20 +37,18 @@ static int hose_mmap_page_range(struct pci_controller=
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

--=20
 i.

--8323328-133140870-1775819695=:1195--

