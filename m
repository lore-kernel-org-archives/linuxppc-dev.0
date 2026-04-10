Return-Path: <linuxppc-dev+bounces-19557-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1796F364DB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:04:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsYpp0wdpz2yZ6;
	Fri, 10 Apr 2026 21:04:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775819074;
	cv=none; b=eCif3ao9GX7sg9P4kmAg7v0MKCGCFMvYFZgNNiaF/QQHRap5Indly0MDbb/miqpabX4BI7bKwy9v366JjaBVyoEOc651YQCsMHP+QHXdfGwrUttwE/kAA8Su4ylR6O6X67kPE9hEDKJDnoA2vgnOhC0WaIg9vBzjivn2MYmBM5m39QtByKw9yIEIUc8gVNRJu3lNu2L6sC8e1lszEUfMCPS7I6QBCG1izu9lc05wceR5s3/CbEl4ZgQWI7yMLSwuyuncMKNQ30zaQsPJy369eLcsYVtknXeOe7I+BsMlW4ak6auFAKbWt25MDwkGmh1D6duBMGDb39Ik+tTumShjGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775819074; c=relaxed/relaxed;
	bh=0Ykeq5M8C7fHPxjiFFLiU9Ta+PpIQ8ybI3+n6Kdy408=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZQgyX1Xty4sr1VjhgAKeGzv4eAS+fiy/0xRYMI9+1T57BwFlBSc0iJL6A7rLzS59+2V0RCoT6HXIZEHIzO1neQtL4XmRyOSztyzsYVZgnO3hAeE5GTRm8riJX9pZGjvoc8zkbOu+NHiH5iKzmsZ612a7FR152uhQCrYVKfh2+YFs+3RhgEC0VYyqXgty/Wi+NG0RnzOaVwJbBGIzO/BfqrmQxKkDfxu86y5IZX7xsQ1zPZA+f9Z6GCOLivcmgTG8GOcmDgtE69TbQwgoX8ny3e6EN1nt4RXAf3TH/WnWk0gA/cheeug4/Xyb79H2FiqrwehTffnjwn58iBwpp8vacw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n9xZFUFx; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n9xZFUFx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsYpm3rPqz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:04:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775819074; x=1807355074;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ie5mL37AI9/SoDKmjWEXYIZ3Y62rbPGSCw23WIYez+M=;
  b=n9xZFUFxYrYlKZVy5L6YhLA8RVXEjuLGugMBYo3YiEEfyzjJFSFPIdNs
   0/nwUy/fyVeVprtKn+RNTwj5uHu3E1KQj9T3VCCi7pr9jMfIbsdIUr3pc
   83JWb9hZLVkdj2iveHID8OZl+/1cDIFI4j8pVtttmRFNT3tIpduci4P7z
   uMp4iO2bAQbrvv/hDdSktK3Q9s6S+HON5kSycxeUYulnzcSZYrMMYw/Xu
   dCcx9sEDn2euLZx9mmYi9nt7Hs1+3/6NDKBtO/Z5VaqNBXNQJlVjDuNK7
   t0m0PoaUhO6zNd+IqwijJqVjilI6Q7Rp1Sugvm8EJ4deTvowcdcXQYFzK
   g==;
X-CSE-ConnectionGUID: Nfl7FehcQRG5vXoZEUkjVw==
X-CSE-MsgGUID: qREuCkGzTlWzxeB2JwbVEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87913349"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="87913349"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:04:29 -0700
X-CSE-ConnectionGUID: AFN9uzRlTtyiLYJXbIC8Hg==
X-CSE-MsgGUID: 1Qnc4FGjTdGVlIiX03QVWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="228059061"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:04:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 14:04:16 +0300 (EEST)
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
Subject: Re: [PATCH 10/20] alpha/PCI: Add security_locked_down() check to
 pci_mmap_resource()
In-Reply-To: <20260410055040.39233-11-kwilczynski@kernel.org>
Message-ID: <93f81aa9-ce74-92bb-5227-d2ccb0a3e06c@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-11-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-1107943852-1775819056=:1195"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1107943852-1775819056=:1195
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Currently, Alpha's pci_mmap_resource() does not check
> security_locked_down(LOCKDOWN_PCI_ACCESS) before allowing
> userspace to mmap PCI BARs.
>=20
> The generic version has had this check since commit eb627e17727e
> ("PCI: Lock down BAR access when the kernel is locked down") to
> prevent DMA attacks when the kernel is locked down.
>=20
> Add the same check to Alpha's pci_mmap_resource().
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Maybe add Fixes: eb627e17727e ...

> ---
>  arch/alpha/kernel/pci-sysfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 3048758304b5..2324720c3e83 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -11,6 +11,7 @@
>   */
> =20
>  #include <linux/sched.h>
> +#include <linux/security.h>
>  #include <linux/stat.h>
>  #include <linux/slab.h>
>  #include <linux/pci.h>
> @@ -71,7 +72,11 @@ static int pci_mmap_resource(struct kobject *kobj,
>  =09struct resource *res =3D attr->private;
>  =09enum pci_mmap_state mmap_type;
>  =09struct pci_bus_region bar;
> -=09int i;
> +=09int i, ret;
> +
> +=09ret =3D security_locked_down(LOCKDOWN_PCI_ACCESS);
> +=09if (ret)
> +=09=09return ret;
> =20
>  =09for (i =3D 0; i < PCI_STD_NUM_BARS; i++)
>  =09=09if (res =3D=3D &pdev->resource[i])
>=20

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1107943852-1775819056=:1195--

