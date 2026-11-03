Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919C606A32D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fx7qOHpR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJp7b5zyvz2xK7;
	Tue, 03 Nov 2026 23:40:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793709611;
	cv=none; b=I25VMQqw3be5tHdwUbwdJZScnWZyETSZTAq9R6RUydv9NH13GAjyMOJsUUEDawJRxtvX6JHvgxFo0r+j1tedTHGqMrsYcOM+oSfNJD8inh845PWtPOdownb6jhq9738C1FbfM/VA/59PSKKZpaCmyk2IS+aK/PMSr1HHeBjCa/dXp07hmSJB2mO9gvK4L3x4uYxlun08scuCwaA73yrfpn/pFj5euknilHmPG0qO1mwlMl+UEafEcomXr07kfxPvzBGsUmezBtVyIBSyO2K5F3mNxjCneBFIxauuqx2O/f1rcv/zp/OVY4qwnFk7cGJWssLcKgNfXYJSl/bsUCfMog==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793709611; c=relaxed/relaxed;
	bh=kNMbnPFcyJK77TPDd1xGOQdAATjK7eqRZWunEZL/ni0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CZlljtvKjb/GBfyvIH7quk2ioYqq0Bdr7Q66WlhFB5I9E/EbcKFDTcum6YzkXgcohYN664CHVR6RrmSK27Tg4KiN6WNnN3TODxRjpJ48zL4gre0B14P7gooWsZq4Gbm43Rqg4JOeaFL9apsDVPhSdOs9AoDjOR2oJNka7t1ZrNyWCX+MX/hw/gaKgPjT6ODT3I5TzXQnsla3Ad2wRNsla9VDAlWP8ikWun9Cpsj8Tx6+hzWp5Jrrr/9tQkPsLSImv/TUTDqujVfgExSgaTSyqQHvuM0cqKiWocEe1KOh54g1A0UFLI6RBGdPbDFGNFhaUbALlqyXfj3bWJFdjtjUbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fx7qOHpR; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fx7qOHpR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJp7X2qQyz2xH9
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 23:40:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793709608; x=1825245608;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XCiKLwinV99WNnDVV2Sect+DLYC+kykjSYXDYWEmi0s=;
  b=Fx7qOHpRN8B0l5j7zu5nIEj/339sx87DVD2dKfN/XBc9Gfaf5tAQaDNS
   ocX3+ZvzzLRR66sGVEYbBA2gz58VFRLoR3LIHRzoGFYvu2uio8pUAM2mo
   Ff+zwB7O8SbvTHNnytSs5E5epqHRhOWOkj4w5PKQ4zI1kTyeETTDsTcws
   pE9MC+Wozihilg5MkZQuWX30TI3uL8/FKj1J015pNDh2lySqhr3ilaEOn
   HFSIUW3P5mzX59hSxiJ26eQ1Vl48hG46u1WG2IrG7og91O0eizyJUJ6qy
   ZH7roUoWtdu4cFQ/ZlJxbX9+d/UDP0hrLXE/sA/cUdaIlXYSj+n+fcrZr
   Q==;
X-CSE-ConnectionGUID: PouGuzoNQ0+g5qJLnBFXEA==
X-CSE-MsgGUID: dbF/h3x4Q9ab2hK9mL2t4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2311453"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2311453"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 04:40:03 -0800
X-CSE-ConnectionGUID: cyacEPFhQBuDb0dqgLmxcg==
X-CSE-MsgGUID: X3JjSi4fToyNNKZdyldFTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6742790"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 04:40:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 3 Nov 2026 14:39:55 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Sourabh Jain <sourabhjain@linux.ibm.com>, 
    Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
    Alex Deucher <alexander.deucher@amd.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Keith Busch <kbusch@kernel.org>, 
    Maciej Grochowski <Maciej.Grochowski@sony.com>
Subject: Re: [PATCH 1/2] PCI/AER: Avoid NULL pointer deref on search for
 Error Source
In-Reply-To: <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
Message-ID: <cb623055-e0fd-1d3f-7944-ed20971f6b7b@linux.intel.com>
References: <cover.1793697480.git.lukas@wunner.de> <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-699220464-1793709595=:1105"
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-699220464-1793709595=:1105
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 3 Nov 2026, Lukas Wunner wrote:

> A Root Port's subordinate bus may be NULL if the PCI core runs out of bus
> numbers on enumeration.  Yet when the AER driver searches for the source
> of an Error Message, it dereferences the subordinate pointer without
> checking for NULL.  Fix it.
>=20
> Fixes: 28eb27cf0839 ("PCI AER: support invalid error source IDs")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v2.6.31+
> ---
>  drivers/pci/pcie/aer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index db4f607f889c..d492c7ce01e1 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1251,7 +1251,7 @@ static bool find_source_device(struct pci_dev *pare=
nt,
> =20
>  =09if (pci_pcie_type(parent) =3D=3D PCI_EXP_TYPE_RC_EC)
>  =09=09pcie_walk_rcec(parent, find_device_iter, e_info);
> -=09else
> +=09else if (parent->subordinate)
>  =09=09pci_walk_bus(parent->subordinate, find_device_iter, e_info);
> =20
>  =09if (!e_info->error_dev_num)
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-699220464-1793709595=:1105--

