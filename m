Return-Path: <linuxppc-dev+bounces-19686-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DA4F34C45
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 11:53:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvQlS5q4hz2ydn;
	Mon, 13 Apr 2026 21:53:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776081188;
	cv=none; b=UIz6ZKMa2FbVRTndAbO2m6k2Dgf2eGBe87s40cErBEo7eT/4A/nNMysDedCJ4VdcfHM3tzz/nOWNWr6F/ZeLbDJQzxaW1HqcJLrdxmtxWGtEAe3V5AW7VoJ6adP1/IImPQqieSUt8E5w2G1rzKB+Gkl4kL4ByDxOYi3asTDUuqy9IKG+i5VkL49mvUkAali++ZMOX5F8Dyl0ua9D1C8erCRnDwMgP4feKBcL4pD1INB35Ezgcdy7SFKo4Zw8DZRjp7lLXgOCKIhun5Ecq3m2oY35NQJRAUs5JD7QiHIhuJ5KpjqcVDoRHY62nod+HrcFjUbnVBcsEvtFuTbvDw5OoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776081188; c=relaxed/relaxed;
	bh=Xp1/f8DE27Wv/yXP3ntPLcP3czKhbR8L0cQnmpze/Dc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=amDjwatf+zu0dh1hoaIq90ZrC0Fub6L0otsgcF0VShVOBGWbxBdomkLY9BkyV11A3vz4DdS1zIkCBezwgpcIpzDyDcqGAhkcjeEqz6RRcLKjXa+reeles+KKIkWQXYGmaTU7q8dyuFpLfrPdOBisqW8p1VUd9blA2XRWFYc/9seyEh214FepvdvqtONlrCUILRJ3+USJV93wjElmaTh0W539Qo0nSGx1Bnc1wyaMVkywn4V8dEeXEBiFJa8p0tJ5z2L4RRw/F5HCt4OaUoj7SXy5y8LUm8FEjE+i6JuWJvAgD7qqVCdaWHZ1vC6opG+HFR0BCPZRkAqr3vNywjRf+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TS8TraSw; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TS8TraSw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvQlR4MrYz2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 21:53:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776081188; x=1807617188;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dJVGufupuRzhM0xublRPUyKnOZZPoagICx16HUyrYow=;
  b=TS8TraSwYeghi5TBYGUfwoVOvmFuBvgjUrjzyeSlbAEv25bEWd7ZPchz
   tFjw7Udll5ffOZmTEBBK+gDNN4DNqFBY2t/qTbImvyzTZrDCFF6NBLjId
   hphQimAk2ktrjf5tPAD30wMWPAz/Uo0RX+CB6CGXVc+n469TISegYXxG3
   z0jzlFkMlraQt1DQ5gGshUiTXOboUwcyd2U8nA3nsPSXQ2GqogfvwgtCg
   DG7TFOlSYYu5Ru7+a76mIwOXeT8e0+TdLkA0Y3RwMQpodVWElyYJ7O8+K
   DamLbHLsvqSV6VI8ZVBldyZEG+QgViueqptRMFSIFMySW+0LDQk6s/5NQ
   g==;
X-CSE-ConnectionGUID: khFgoeAlRIqX5GCHkqx1mQ==
X-CSE-MsgGUID: 3f8ALSS4T9W+dMIYGiq1Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="76046437"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="76046437"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:53:04 -0700
X-CSE-ConnectionGUID: Qi86xDZ0TgiVjehP4JCm2w==
X-CSE-MsgGUID: nvS2V3eiR/y1R3IE9KDruQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="253165075"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:52:54 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:52:49 +0300 (EEST)
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
Subject: Re: [PATCH v4 13/24] alpha/PCI: Use PCI resource accessor macros
In-Reply-To: <20260411080148.471335-14-kwilczynski@kernel.org>
Message-ID: <5c4f32d1-0648-31d1-d7c0-661ccec4f8bc@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-14-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; boundary="8323328-1935294158-1776081169=:962"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1935294158-1776081169=:962
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 11 Apr 2026, Krzysztof Wilczy=C5=84ski wrote:

> Replace direct pdev->resource[] accesses with pci_resource_n(),
> and pdev->resource[].flags accesses with pci_resource_flags().
>=20
> No functional changes intended.
>=20
> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> ---
>  arch/alpha/kernel/pci-sysfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.=
c
> index c84867ce31f5..7aac5e76dcd6 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -141,7 +141,7 @@ static int sparse_mem_mmap_fits(struct pci_dev *pdev,=
 int num)
>  =09long dense_offset;
>  =09unsigned long sparse_size;
> =20
> -=09pcibios_resource_to_bus(pdev->bus, &bar, &pdev->resource[num]);
> +=09pcibios_resource_to_bus(pdev->bus, &bar, pci_resource_n(pdev, num));
> =20
>  =09/* All core logic chips have 4G sparse address space, except
>  =09   CIA which has 16G (see xxx_SPARSE_MEM and xxx_DENSE_MEM
> @@ -181,7 +181,7 @@ static int pci_create_attr(struct pci_dev *pdev, int =
num)
>  =09suffix =3D "";=09/* Assume bwx machine, normal resourceN files. */
>  =09nlen1 =3D 10;
> =20
> -=09if (pdev->resource[num].flags & IORESOURCE_MEM) {
> +=09if (pci_resource_flags(pdev, num) & IORESOURCE_MEM) {

This could have used the new helper but since this code is going away=20
anyway in a later patch it doesn't matter,

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-1935294158-1776081169=:962--

