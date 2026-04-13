Return-Path: <linuxppc-dev+bounces-19688-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9AEF34C48
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 11:59:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvQtx2j4Xz2ydn;
	Mon, 13 Apr 2026 21:59:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776081577;
	cv=none; b=F521V4Mb/2VR0qJg+QrGlx/m7/gGWSML4VB+vIlbOHXFprAqrFqO9QiOkDuSpjzZ8jPda+Xkn80xcIiQrlgUzloIGiT1J86gzLxsg/U/SWtQu4psDiGKUyCgufOD45DUh0YyKPy7DDKnw+d5PQZn9j3v8JBzeWqpRF2/XPE/8uO8Sj6iCozFYz5gCVQL+xqsY2VrrfJHlTA+za9uBIWleG/wKw5m8cxSwGcNFG11reOibZ/28WTR1yRzuS/e9HgN32xobs8XWixp4lRRjRWkU6aVwz6mP4eSrvMQSV/rkNafFJ5rUhh2+GxPsQZ1emInJLhnZgs9G40VqQ3Qn1jafA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776081577; c=relaxed/relaxed;
	bh=eZh6Xvy/Tn/yRfPlB7qkYaqF5dmm/smdgSOuZYDpvY8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YfdmO4UX2PPP6S6J4f8HKNB1kaqkSBFuhsGiI9dwGdEhoOZjlHw6Ient3BS3QYk6tNt4cy6Hos13/Z3wzzfa+70D53G4LyESMdymsG0xhg9VUedSqkb+3PYTgUkN9eBypM9ITEZ/2nNvQNpssPxDWHXEw7GRXQKHbttcXn6pZlExxbTXe+gB8h7s6tMmEywneeEgh6ZFbmYehZxpCzRo5TljGSDt4vCONgBNclHmLeyJz4ut1opYVr0S5z99idmJ5S59wQvjt98MB0vS0Zv+mjFX9ZtBLf9otaDJGFsM89Lvtevsj8srtMMYJYq28j5Eh+N4TJK3WA63OOlHyKGACg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T2Kx19Z1; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T2Kx19Z1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvQtw0BtMz2ySb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 21:59:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776081577; x=1807617577;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=XjCiDo9y+OHrVQDJKUrYSIpvMP1U6UUn5n4372Stk5c=;
  b=T2Kx19Z1UytYRyOyG4sYCFiKoapQjZZlsHMACWwMIPAudW1TdEoswSAu
   q4YrTcTL9zX6ebOpcItUiveVtB9p6d08pQI7P2Ma1Twt60WHjkqo6lKYV
   s9rCcukaGVvlRgZXtQNGO6oIFXEI/FfbBA3ll69Bgfpdx/1zZ1rRwo0r1
   jWn5weFTT/75Xu76ZbyeTiwdFfMMSDsHoRW2lUkG+TLvgm6BIlDLxFQ3X
   /gu1jHK6YM7eapLiUQ3ZokOrqgaqnMS09eERNO0gYxObSiss5RnYPpSez
   Bfnoz3KTSLzdRcpyMCdy5w3njwfKeNme1lpQjUpLSsUSFXd4zSXshA1iC
   w==;
X-CSE-ConnectionGUID: tWmenPArRv6POfsamzyC9A==
X-CSE-MsgGUID: FSBSsZxsRo6szXSvzCgTwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88088839"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="88088839"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:59:32 -0700
X-CSE-ConnectionGUID: AWmqfKN+SAKDaoql7UTAbw==
X-CSE-MsgGUID: 0dDCkOLFShWVnJktOyq7nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="226597919"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.63])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 04:59:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 13 Apr 2026 14:59:19 +0300 (EEST)
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
Subject: Re: [PATCH v4 20/24] PCI: Add macros for legacy I/O and memory
 address space sizes
In-Reply-To: <20260411080148.471335-21-kwilczynski@kernel.org>
Message-ID: <a73af6f4-9f9a-cff8-e00e-042dcf934708@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-21-kwilczynski@kernel.org>
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
Content-Type: multipart/mixed; BOUNDARY="8323328-972594317-1776081516=:962"
Content-ID: <ad975c4c-2f7e-f46a-75e8-090fb701efc6@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-972594317-1776081516=:962
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <061d9599-649d-f8aa-2b31-8fe5344029e1@linux.intel.com>

On Sat, 11 Apr 2026, Krzysztof Wilczy=F1ski wrote:

> Add defines for the standard PCI legacy address space sizes,
> replacing the raw literals used by the legacy sysfs attributes.
>=20
> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Krzysztof Wilczy=F1ski <kwilczynski@kernel.org>
> ---
>  include/linux/pci.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index f6f55005f82d..6b630bac8c08 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -27,6 +27,7 @@
>  #include <linux/mod_devicetable.h>
> =20
>  #include <linux/types.h>
> +#include <linux/sizes.h>
>  #include <linux/init.h>
>  #include <linux/ioport.h>
>  #include <linux/list.h>
> @@ -1167,6 +1168,10 @@ enum {
>  /* These external functions are only available when PCI support is enabl=
ed */
>  #ifdef CONFIG_PCI
> =20
> +/* PCI legacy I/O port and memory address space sizes. */
> +#define PCI_LEGACY_IO_SIZE=09(SZ_64K - 1)
> +#define PCI_LEGACY_MEM_SIZE=09SZ_1M
> +
>  extern unsigned int pci_flags;
> =20
>  static inline void pci_set_flags(int flags) { pci_flags =3D flags; }
>=20

Shouldn't this also convert the use in pci-sysfs.c (which you now mixed=20
into the static attrs conversion patch)?

--=20
 i.
--8323328-972594317-1776081516=:962--

