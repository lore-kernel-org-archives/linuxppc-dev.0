Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7E2606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lV2xvfee
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLlwf1vbjz2xJR;
	Sat, 07 Nov 2026 04:07:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793984850;
	cv=none; b=Hi7ETG9WWU7oJ+njJkXyeNNE5Y2f9aaAYytm5sEyhd7DZS8CSh6QKLNt1/IBkCTZMTQ+HAaGAqGgx2bqmg17LG2kaFUG18fTz08gEqldLAXRJCizq8y70sdJYK2c0YcPQeh234YXKwMm4UjeBZqDUkLcrWHravMgqP3/bXM+cBe4UW3aEBzaiuhrtRdbKxDCURyawvX8GudvKMd2np7fdrWA903bFoj+YcAyVOAwWBSlx49ZwJ6Te8yY/6KXlYv6z+fxX3j1w+jVWPOtEDY2YfJVm6QP6O2IzxrQYi1ADL/D8rEyamNk39InzgDDHKk752Azs2jSIDiDH+wgIq8vZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793984850; c=relaxed/relaxed;
	bh=h4wLrSGHj4slcS32zD5Mhy8jbQmXlZ0LxI54YGq/KDU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OyvOoypAwMF2Lv48SdN9xmayodgY/Ep8C4Kn50zCtUsTr1yUK3tlcjjDNM77V12IRXXj+z19M/VDEnP69mhiyA5Q3mdiy2O45DTCAIzJ9O35yoOtZwHbMCrRqu3BOLOgJfSZhoLdXqswsnMOleK2Lwp0TdHnkY6YoqegTV49bmdMygchEvjMTwUrTAH1Byq3k/wGp6BsyhIAn7rABwC0yiYZdqCsvCG6OxAffCALm49fEDVcEJlfbBJruLbt4lXOxRplex4gKFIywgutlQ2OIN2fSMw0tlc0UY4tqczoExjW3f3MaUejna4rVUjPXmOnBT5dR9I5o+A0N4brp4xzHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lV2xvfee; dkim-atps=neutral; spf=pass (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lV2xvfee;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLlwb5Xq9z2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 04:07:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793984848; x=1825520848;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o72H/k4m8RggJftGbHKGzjcIpYaBMrB/bAouRtVXLdw=;
  b=lV2xvfee8MEEUJGE74Wssqt167wKrFxnKswxro7at1SiNAc4byOVO2L5
   3mStf2Jy19eB5uVU5vmwIJr7sKzId7jyXJT2qelw4fpWK+Hd1UjaU0oCI
   ZafZLH41CBeR7pCmjntr1UozkhmzpO48sYd77NKqzeNIh0JdVUeFviZvm
   OQjubMsI2cObxgRq3f4Nk/xDklMZ6VB6n/8UI9r+lmzxwQDDW5eAlJ3L7
   1M2pftol4h0DEJIndOG3o6w7jJb8Z4WWzaOr7yLFhrGCLqaDqcifa/0bS
   jZdAvvWNyplwqup8t3H4jxq8aQhjhhRw/j8Sneh6gkJdVgY/vLWUPJdTk
   g==;
X-CSE-ConnectionGUID: EAVm6KjtQQyEf33Fgyos5g==
X-CSE-MsgGUID: tPID2AbMQDSnZQMd5BWHZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2902035"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2902035"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 09:07:23 -0800
X-CSE-ConnectionGUID: oLfO/3DcRY6GArIwDvbrkQ==
X-CSE-MsgGUID: Ec1D3GvdS4eJbv+yodRZRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7354993"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 09:07:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 6 Nov 2026 19:07:16 +0200 (EET)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
    Sourabh Jain <sourabhjain@linux.ibm.com>, 
    Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
    Alex Deucher <alexander.deucher@amd.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Keith Busch <kbusch@kernel.org>, 
    Maciej Grochowski <Maciej.Grochowski@sony.com>, 
    Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 2/2] PCI/AER: Check validity of Error Source ID
 register
In-Reply-To: <357275f9c2554a61bfa6fcbe9a25416cafe9ce00.1793982724.git.lukas@wunner.de>
Message-ID: <93acd5b0-e952-4ecf-d074-8dee5c160792@linux.intel.com>
References: <cover.1793982724.git.lukas@wunner.de> <357275f9c2554a61bfa6fcbe9a25416cafe9ce00.1793982724.git.lukas@wunner.de>
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
Content-Type: multipart/mixed; boundary="8323328-1115972685-1793984836=:2032"
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1115972685-1793984836=:2032
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 6 Nov 2026, Lukas Wunner wrote:

> Certain Intel and AMD Root Ports are known to populate the Error Source I=
D
> register with an invalid value.  The AER driver seeks to recognize such
> buggy silicon by assuming invalidity if the bus number is zero.  It then
> searches for the error-signaling device in the hierarchy below the Root
> Port.  This was introduced by commit 28eb27cf0839 ("PCI AER: support
> invalid error source IDs").
>=20
> Alex has provided dmesg output which shows an invalid Error Source ID wit=
h
> a non-zero bus number.  The AER driver's heuristic fails to recognize its
> invalidity:
>=20
>   pcieport 0000:00:07.1: AER: Correctable Error message received from 000=
0:01:00.0 (no details found)
>=20
> The Root Port at 0000:00:07.1 has secondary bus 04, so an error source on
> bus 01 is obviously invalid.  The range of secondary buses is cached and
> checking against it is cheap.
>=20
> Do that instead of relying on a heuristic.  Emit a message when an invali=
d
> Error Source ID is detected to alert silicon validation engineers.
>=20
> If the Error Source ID is the Root Port itself, assume that it is valid.
> This changes behavior if the Error Message originated from a device which
> happens to have the same slot and function number as the Root Port and
> whose bus number was zeroed in the Error Source ID register.  On affected
> Intel and AMD systems, the invalid Error Source ID always has a zero slot
> and function number and there is no Root Port at 0000:00:00.0, so it is
> expected that this change does not lead to false-negatives in practice.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D222095
> Tested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
=2Eintel.com>
> ---
> Changes versus v1:
>  Reorder a < b && b < c comparisons (Ilpo, Bjorn)
>  Amend kernel-doc of find_source_device() (Sathya)
>  s/subordinate/secondary/ in commit message (Bjorn)
>  Document behavioral change in commit message (sashiko)
> =20
>  drivers/pci/pci.h       |  7 ++++++-
>  drivers/pci/pcie/aer.c  | 35 ++++++++++++++++++++++++++---------
>  drivers/pci/pcie/rcec.c | 14 ++++++++++++++
>  3 files changed, 46 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 77efa4c5c960..aa392bb6a482 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -871,6 +871,9 @@ static inline bool pci_dev_binding_disallowed(struct =
pci_dev *dev)
>   * @id: Value from register PCI_ERR_ROOT_ERR_SRC
>   * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
>   * @root_ratelimit_print: Flag to log or not log the root's error. 0=3DN=
otLog/1=3DLog
> + * @id_valid: Whether @id is a valid value.  Some Root Ports report an i=
nvalid
> + *=09Error Source ID, necessitating a search for the error-signaling dev=
ice
> + *=09in the hierarchy below the Root Port.
>   * @multi_error_valid: If multiple errors are reported
>   * @first_error: First reported error
>   * @__pad2: Padding for alignment
> @@ -893,7 +896,8 @@ struct aer_err_info {
> =20
>  =09unsigned int severity:2;
>  =09unsigned int root_ratelimit_print:1;
> -=09unsigned int __pad1:4;
> +=09unsigned int __pad1:3;
> +=09unsigned int id_valid:1;
>  =09unsigned int multi_error_valid:1;
> =20
>  =09unsigned int first_error:5;
> @@ -955,6 +959,7 @@ void pcie_link_rcec(struct pci_dev *rcec);
>  void pcie_walk_rcec(struct pci_dev *rcec,
>  =09=09    int (*cb)(struct pci_dev *, void *),
>  =09=09    void *userdata);
> +bool pci_rcec_associated(struct pci_dev *rcec, u16 id);
>  #else
>  static inline void pci_rcec_init(struct pci_dev *dev) { }
>  static inline void pci_rcec_exit(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d492c7ce01e1..6f2460231422 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -951,12 +951,13 @@ static void aer_print_source(struct pci_dev *dev, s=
truct aer_err_info *info,
>  {
>  =09u16 source =3D info->id;
> =20
> -=09pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s\n",
> +=09pci_info(dev, "%s%s Error message%s from %04x:%02x:%02x.%d%s%s\n",
>  =09=09 info->multi_error_valid ? "Multiple " : "",
>  =09=09 aer_error_severity_string[info->severity],
>  =09=09 info->multi_error_valid ? "s received, first one" : " received",
>  =09=09 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
>  =09=09 PCI_SLOT(source), PCI_FUNC(source),
> +=09=09 info->id_valid ? "" : " (invalid source)",
>  =09=09 found ? "" : " (no details found)");
>  }
> =20
> @@ -1146,6 +1147,24 @@ static int add_error_device(struct aer_err_info *e=
_info, struct pci_dev *dev)
>  =09return 0;
>  }
> =20
> +static bool source_id_valid(struct pci_dev *root, u16 id)
> +{
> +=09/* The Root Port or RCEC can itself be a valid Error Source */
> +=09if (pci_dev_id(root) =3D=3D id)
> +=09=09return true;
> +
> +=09/* For RCECs, @id shall be in range of its associated buses/devices *=
/
> +=09if (pci_pcie_type(root) =3D=3D PCI_EXP_TYPE_RC_EC)
> +=09=09return pci_rcec_associated(root, id);
> +
> +=09/* For Root Ports, @id shall be in range of its subordinate buses */
> +=09if (!root->subordinate)
> +=09=09return false;
> +
> +=09return root->subordinate->busn_res.start <=3D PCI_BUS_NUM(id) &&
> +=09       PCI_BUS_NUM(id) <=3D root->subordinate->busn_res.end;
> +}
> +
>  /**
>   * is_error_source - check whether the device is source of reported erro=
r
>   * @dev: pointer to pci_dev to be checked
> @@ -1157,11 +1176,8 @@ static bool is_error_source(struct pci_dev *dev, s=
truct aer_err_info *e_info)
>  =09u32 status, mask;
>  =09u16 reg16;
> =20
> -=09/*
> -=09 * When bus ID is equal to 0, it might be a bad ID
> -=09 * reported by Root Port.
> -=09 */
> -=09if ((PCI_BUS_NUM(e_info->id) !=3D 0) &&
> +=09/* Some Root Ports report an invalid Error Source ID */
> +=09if (e_info->id_valid &&
>  =09    !(dev->bus->bus_flags & PCI_BUS_FLAGS_NO_AERSID)) {
>  =09=09/* Device ID match? */
>  =09=09if (e_info->id =3D=3D pci_dev_id(dev))
> @@ -1174,8 +1190,7 @@ static bool is_error_source(struct pci_dev *dev, st=
ruct aer_err_info *e_info)
> =20
>  =09/*
>  =09 * When either
> -=09 *      1) bus ID is equal to 0. Some ports might lose the bus
> -=09 *              ID of error source id;
> +=09 *      1) Error Source ID register is invalid;
>  =09 *      2) bus flag PCI_BUS_FLAGS_NO_AERSID is set
>  =09 *      3) There are multiple errors and prior ID comparing fails;
>  =09 * We check AER status registers to find possible reporter.
> @@ -1231,7 +1246,7 @@ static int find_device_iter(struct pci_dev *dev, vo=
id *data)
>   * Return: true if found.
>   *
>   * Invoked by DPC when error is detected at the Root Port.
> - * Caller of this function must set id, severity, and multi_error_valid =
of
> + * Callers must set id, id_valid, severity, and multi_error_valid fields=
 of
>   * struct aer_err_info pointed by @e_info properly.  This function must =
fill
>   * e_info->error_dev_num and e_info->dev[], based on the given informati=
on.
>   */
> @@ -1566,6 +1581,8 @@ static void aer_isr_one_error_type(struct pci_dev *=
root,
>  {
>  =09bool found;
> =20
> +=09info->id_valid =3D source_id_valid(root, info->id);
> +
>  =09found =3D find_source_device(root, info);
> =20
>  =09/*
> diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> index 2bf6d9d549ba..88070ef0019c 100644
> --- a/drivers/pci/pcie/rcec.c
> +++ b/drivers/pci/pcie/rcec.c
> @@ -21,6 +21,20 @@ struct walk_rcec_data {
>  =09void *user_data;
>  };
> =20
> +bool pci_rcec_associated(struct pci_dev *rcec, u16 id)
> +{
> +=09if (!rcec->rcec_ea)
> +=09=09return false;
> +
> +=09if (rcec->bus->number =3D=3D PCI_BUS_NUM(id)) {
> +=09=09unsigned long bitmap =3D rcec->rcec_ea->bitmap;
> +=09=09return test_bit(PCI_SLOT(id), &bitmap);
> +=09}
> +
> +=09return rcec->rcec_ea->nextbusn <=3D PCI_BUS_NUM(id) &&
> +=09       PCI_BUS_NUM(id) <=3D rcec->rcec_ea->lastbusn;
> +}
> +
>  static bool rcec_assoc_rciep(struct pci_dev *rcec, struct pci_dev *rciep=
)
>  {
>  =09unsigned long bitmap =3D rcec->rcec_ea->bitmap;
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-1115972685-1793984836=:2032--

