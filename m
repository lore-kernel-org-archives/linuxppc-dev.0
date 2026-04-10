Return-Path: <linuxppc-dev+bounces-19562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66327F44842
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Apr 2026 11:19:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsZ8K0LKpz2yZ6;
	Fri, 10 Apr 2026 21:19:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775819984;
	cv=none; b=fQTKECbNNEgqtDPNIlImbY8KCY0NzO52xivB/l4l50DjOMtm9XdevcLyFlR0yLAlhuvWhetZy8EYkQN1CiHWB4bd5USzZ5OsnMK4AzCPKmaHeOTrjaySqgdWcrLMSjBK58PnbBPIAi0I0HG8HJc7rClhzFsug6iszqgTfMs/M8nANUiTeSnIqt676/W8Sr4VvMTX/PF7XPFen2JF4bYAElE77mH/Cv1+L9r5AMNTihqJDR9NyXejq9HPYkuc/PsrykylFsDoGczoOwu0Lyawr4XwZ5w4Ng7sJuYRRsSyJLw/obXKufeFDkYYFUC9Tu3jORfqG2UtsE1idq35ySxbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775819984; c=relaxed/relaxed;
	bh=67auzAubWDosQ38P7bTOD5Yhnbe4po39pXwfkc4RbPw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QssTURRPXMkCprcAJDIQxO+xbHXmN6P3JZCYq0lQH2kgFXmmF/tUW7QU9ySBeadTsXaY0guwgu0koxUqelAGKBQuTyP4zn0UtHzvyCHOIASaMzFWQ7WcB6UDXIIqEb3o50wGh6GqxLktVsNmXSdhxvPR/tK/RYHn8UW2VYu5XWNRfzsPNhKmg7JAinevnHaTAn2IjZhfrZUcl6iJZKFaj5gzRULa2oDzGjNfZ/suqGJYKjI5F0bXw3Uj1luxBE9e7ZXARD5cC1basobY4psCeiEQvcG9HHro4AuJHBG/u84rINdJVJfYRMIjpgYBihvW4/BlBQC47nDyIHNKQmZTBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fCQv0xM6; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fCQv0xM6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fsZ8H2pPvz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2026 21:19:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775819984; x=1807355984;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=y2Ft9tQbJmBllEvwEPLEzQ//AalTGbNGlcFniNwTlWc=;
  b=fCQv0xM6hh16yFMdXp9x4xNDLKgISIJwDXBtbPMTE+4jqVGxVcZuFDpU
   uZO5vY7DTsSilHuLxKLTB1WHxjRoSIudzZ4Llr35ztr9XBMIHDXoPhUBE
   /kG5lvlPZt09qfuTGEHrUBDxqtK9SXjiRrb4LAy3VO+mTdJmh8VtibdPr
   zPeRQZ061j7Xlw11cTfYjkVTasGxpYK2oSHkMaF3YDJq1e/2qK2Z+aJt6
   RWRx+Tc8vHAMPz+AvCNl8IkNhtqkU6NcAdZC1A3rNNjYgbqJ3IPpOV3A6
   MajvZO0KtpZ9QQnNFoBsRyZK82/HC6pPqsXCjzkJdSFX6elvYLBNke61F
   g==;
X-CSE-ConnectionGUID: vDQepudUQYusr3TSaw+Y9A==
X-CSE-MsgGUID: eMCIOIjWTjumtC9QOXbzgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76745204"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="76745204"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:19:40 -0700
X-CSE-ConnectionGUID: xvtL+CXXRjqr7ImdpYZiRw==
X-CSE-MsgGUID: HohmFH4wSUuwW10pd0WNPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; 
   d="scan'208";a="222569712"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 04:19:30 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 Apr 2026 14:19:27 +0300 (EEST)
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
Subject: Re: [PATCH 14/20] alpha/PCI: Add static PCI resource attribute
 macros
In-Reply-To: <20260410055040.39233-15-kwilczynski@kernel.org>
Message-ID: <2c5b50c7-b357-025d-e0de-1fce1fcddf20@linux.intel.com>
References: <20260410055040.39233-1-kwilczynski@kernel.org> <20260410055040.39233-15-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; BOUNDARY="8323328-866756695-1775819880=:1195"
Content-ID: <2a2e8981-2c02-5e58-5eae-1f1106216ee6@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-866756695-1775819880=:1195
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <ff8eb51f-5b94-3fee-1a97-87bd0c1b2236@linux.intel.com>

On Fri, 10 Apr 2026, Krzysztof Wilczy=F1ski wrote:

> Add macros for declaring static binary attributes for Alpha's PCI
> resource files:
>=20
>   - pci_dev_resource_attr(),        for dense/BWX systems (mmap dense)
>   - pci_dev_resource_sparse_attr(), for sparse systems (mmap sparse)
>   - pci_dev_resource_dense_attr(),  for dense companion files (mmap dense=
)
>=20
> Each macro creates a const bin_attribute with the BAR index stored in
> the .private property and the appropriate .mmap callback.
>=20
> Signed-off-by: Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index 867199b988de..0e016b597b06 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -104,6 +104,26 @@ static int pci_mmap_resource_dense(struct file *filp=
, struct kobject *kobj,
>  =09return pci_mmap_resource(kobj, attr, vma, 0);
>  }
> =20
> +#define __pci_dev_resource_attr(_bar, _name, _suffix, _mmap)=09=09\
> +static const struct bin_attribute=09=09=09=09=09\
> +pci_dev_resource##_bar##_suffix##_attr =3D {=09=09=09=09\
> +=09.attr =3D { .name =3D __stringify(_name), .mode =3D 0600 },=09=09\
> +=09.private =3D (void *)(unsigned long)(_bar),=09=09=09\
> +=09.mmap =3D (_mmap),=09=09=09=09=09=09\
> +}
> +
> +#define pci_dev_resource_attr(_bar)=09=09=09=09=09\
> +=09__pci_dev_resource_attr(_bar, resource##_bar,,=09=09=09\
> +=09=09=09    pci_mmap_resource_dense)
> +
> +#define pci_dev_resource_sparse_attr(_bar)=09=09=09=09\
> +=09__pci_dev_resource_attr(_bar, resource##_bar##_sparse, _sparse,=09\
> +=09=09=09    pci_mmap_resource_sparse)
> +
> +#define pci_dev_resource_dense_attr(_bar)=09=09=09=09\
> +=09__pci_dev_resource_attr(_bar, resource##_bar##_dense, _dense,=09\
> +=09=09=09    pci_mmap_resource_dense)
> +
>  /**
>   * pci_remove_resource_files - cleanup resource files
>   * @pdev: pci_dev to cleanup
>=20

Wouldn't this belong together with the next patch, or is there some good=20
reason why you added them separately?

--=20
 i.
--8323328-866756695-1775819880=:1195--

