Return-Path: <linuxppc-dev+bounces-18323-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC698FED9E3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 15:26:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZwlq3lnrz2yjN;
	Wed, 18 Mar 2026 02:26:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773761175;
	cv=none; b=lcDgwjzFzUc90YsyHb93HFQ1BUUudbb2kq9496+80ef5WwFQV5EUohQRZvGj7U5PlfbonJdjWVAhCAH6fDklLNwqDfjvEPIn35dEwAIQOXIukyZLDSjCear04E1TQcJbux4c+HKlg6mI9yTPBiT4+3IM2P02/wtUXdqjzkIBGNrkg9VgkcqZHHESCZrXGr4Ny+qvgQwNawBQv1vmkYYdi0AIO/ECZUZu1a2xCoebduU6SFBDmSqeG2CmOLAxL8+4Q2HyrISdol20jz8pQRpyZe4DYLTf/SktZip9o9U8zzZRyZ0EyymfDdgj/Eq0fKalwl/UVUaXR45e3tQhpcnkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773761175; c=relaxed/relaxed;
	bh=/l5us1DzDkOOEZxIUdfNfNp9iE+g2IxdTh54cegGBx8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jo/3rbM7WRGrhkkht6KkbdPmdeDAoi9WMhEuQDy7MO8+OYhqC6TzGWG5ijQGrUdfWEYQrUAwlLeLZVUlSqZE6cAKe0gYP5pWQZfmj8NxTFfH6mF4Mzr8VYmIjVKW4ImA1BzxDnyob7gNyPUf6V1ByLeb5ASBortcoTb/U75UFtwHYd6sh0X6vfaSiCsxjH+ve9KdXtv6bCLy5k/eFqXaOhwU6+uJoOfPM6LBokITD4Kc/gDR1mXNbgVecH4PHAVkLBby4icUZvL4zgXRC/bG4dlpCICYOU3AvuWLKeppvBg+rCIOHW9FO+NYHFpA5NmtRxaMWXSsBzVHTRzOXjgVQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eGCXnztL; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eGCXnztL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZwlm6Qw3z2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2026 02:26:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773761173; x=1805297173;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U6HAOSeXpFA2xVKYhwIX8W3T28VbdLC3tfuXap/m1NI=;
  b=eGCXnztLS2Bm9P0GhQTSIoMnN9+Uf0wHYilfDmOnjueEQPw8vUSneQuq
   qUs28iTRiS1pQelkM+clONzrDu34EgupaHuduXLasZN43ecPWDBbixOaH
   etNb6HNNZUmDjHGJ7kIUqW6kfScZIUKYvrycaDP29mP4xIB+AEoeSuY1c
   hOxYAk8tLapumBc++pe5wtHAqoo8sbnfqpcYO1urkinoVE/2FNSTkdoKn
   bU9Clxg4YdrAjRn9zp3ZSwouiSvBS0kphHm9o0E656v5dr0ItJZGb9toH
   ateu6zgId9gwof7IsqzJ1YDIMh0MmkMwlFKafD21y5kl3pkxGTqzr20Wb
   Q==;
X-CSE-ConnectionGUID: 3BbaWo6PRLy35wRereNgGQ==
X-CSE-MsgGUID: K/gjaywEQo+fNtlZuG6o3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="73814364"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="73814364"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:26:07 -0700
X-CSE-ConnectionGUID: RgYiXBrtSTSlzqFAWWH6Ig==
X-CSE-MsgGUID: MrSQlNn4RuOayo1ru5RS2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; 
   d="scan'208";a="221356702"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.161])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2026 08:26:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Mar 2026 17:25:57 +0200 (EET)
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
Subject: Re: [PATCH v2 3/4] PCI: pnv_php: Simplify with scoped for each OF
 child loop
In-Reply-To: <20260317133322.266102-7-krzysztof.kozlowski@oss.qualcomm.com>
Message-ID: <f4a8c26d-99ee-2f12-ddcf-cda2aaf0cf5b@linux.intel.com>
References: <20260317133322.266102-5-krzysztof.kozlowski@oss.qualcomm.com> <20260317133322.266102-7-krzysztof.kozlowski@oss.qualcomm.com>
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
Content-Type: multipart/mixed; boundary="8323328-823548865-1773761157=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-823548865-1773761157=:968
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
>  drivers/pci/hotplug/pnv_php.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.=
c
> index 5c020831e318..ff92a5c301b8 100644
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -215,24 +215,19 @@ static void pnv_php_reverse_nodes(struct device_nod=
e *parent)
>  static int pnv_php_populate_changeset(struct of_changeset *ocs,
>  =09=09=09=09      struct device_node *dn)
>  {
> -=09struct device_node *child;
> -=09int ret =3D 0;
> +=09int ret;
> =20
> -=09for_each_child_of_node(dn, child) {
> +=09for_each_child_of_node_scoped(dn, child) {
>  =09=09ret =3D of_changeset_attach_node(ocs, child);
> -=09=09if (ret) {
> -=09=09=09of_node_put(child);
> -=09=09=09break;
> -=09=09}
> +=09=09if (ret)
> +=09=09=09return ret;
> =20
>  =09=09ret =3D pnv_php_populate_changeset(ocs, child);
> -=09=09if (ret) {
> -=09=09=09of_node_put(child);
> -=09=09=09break;
> -=09=09}
> +=09=09if (ret)
> +=09=09=09return ret;
>  =09}
> =20
> -=09return ret;
> +=09return 0;
>  }
> =20
>  static void *pnv_php_add_one_pdn(struct device_node *dn, void *data)
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-823548865-1773761157=:968--

