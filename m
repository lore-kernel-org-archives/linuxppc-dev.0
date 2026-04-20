Return-Path: <linuxppc-dev+bounces-19848-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7CFF557F2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Apr 2026 09:47:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fzgdC3MRBz2yqT;
	Mon, 20 Apr 2026 19:47:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776678447;
	cv=none; b=kXzDtKRII3qloMMEMYo/ojvjRwArI44wEKYvklbrl3zl4FZwlWEbl2dYQaSZJUyHn8DJA/qMQ459qOWfVzrV0XtSAhZyVGJLp5GLT+oOuuonSOsDXspFHYiaoh3nqDznA2RiwnIp6d7gp3WBeABfSenwOrIZviMoXZ5bRVfv2p6CFFwl9q0HXdbXl3CF+74GYAdxWiZglK04NMQKPZIeJIa22sK4QxtG0hssoCKJriubtcbL+GJDAZanufEDbtZijgibOrFnBpiP4SXRzcNzANfIvg/P4VrpPoLsDmY0J1miBslhdxQYWQ9Ex4Vcgkpae4A2BP6AwS2m4uviO43TTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776678447; c=relaxed/relaxed;
	bh=KAVr4gcYQPKLFREcsBIts77JanzSsBrywfqlSj+lsSc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EiGaHvw/6f/EZ4v489nANTrwx1LEiJw+bwB6ZWSher0fZtfKYIgcO2AZX33QzCPYTd516yMhks9EZVCxtt0fokfRULILvMeq0FTx4EVrN/5CJ0X05VQPIMrLfPOLgDy/AGwP7QevoPh1+xu+LzSMrgbfCoSwEjdY7DdrkCa2fULerErNJDGiftDYReMWEgpnxSZ8NIyZZRZsjQ3p1vA6IEKoEJTrkCRRNhrV1IBkcNfAGOGhJsHCejmfKNV+t63yiTbQ6YjV6+1FicUTZhqO8hcO492zRZDKTCeuJdLqcyoM2b4ou/ePRLNJFuISYhPDaK3js6jnmlP6fK1F88xcdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GXt9GQTM; dkim-atps=neutral; spf=pass (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GXt9GQTM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fzgd736d4z2ynn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 19:47:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776678443; x=1808214443;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JFSro+t5cfTihkk1XTLSii/7TZW36jeEtaup6yNEuCs=;
  b=GXt9GQTMaFYAqii/4At2hQaiqloJWKNKAR2UzAFBjqgMSdYzpHdJVdlW
   Q4BCfJgAFRKsjTBIwAMQk9k3LBdk8Tj9kutvo7F11VVwNOCuIBO6ISvhi
   /ktkR7Z/7ABqIoyBYnRXNPUPBPR18bvtkk3RJzaC8qfFZv2OAyeOkYQMT
   kX+pjuGmU/JInTwF77XU4JCrTJ/ZQz2y06Bx6DkEeNPoMJmNRaGWkEMs+
   Sh4t8buImHWV53Gyige0hbHGvyiHGC6Xs5ClaTPEFI3NoQRB8IQrFzviW
   zRmnjWWXlOI0Pa1kkiKrcm03uz7AqjDzmK6f39mp+MRx28W8Kepdwbvbs
   A==;
X-CSE-ConnectionGUID: uahWGufNTR6Cr48b6pDMGA==
X-CSE-MsgGUID: ukPFgwKKSaSzOeuCitYb8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="94991947"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="94991947"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:47:17 -0700
X-CSE-ConnectionGUID: Cq4LhFZUQ5GSWTu6mUchiA==
X-CSE-MsgGUID: Dh4SzLQpS522PYXnc5DLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="231547815"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.150])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:47:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 20 Apr 2026 12:47:06 +0300 (EEST)
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
Subject: Re: [PATCH v4 07/24] PCI/sysfs: Convert PCI resource files to static
 attributes
In-Reply-To: <20260417114912.GD1625998@rocinante>
Message-ID: <4083baf4-c1f3-e3a7-12f9-f1936b6fc803@linux.intel.com>
References: <20260411080148.471335-1-kwilczynski@kernel.org> <20260411080148.471335-8-kwilczynski@kernel.org> <eca4c119-65a8-ac84-3869-4064aa1f0829@linux.intel.com> <20260417114912.GD1625998@rocinante>
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
Content-Type: multipart/mixed; boundary="8323328-1542172744-1776678426=:961"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1542172744-1776678426=:961
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 17 Apr 2026, Krzysztof Wilczy=F1ski wrote:

> Hello,
>=20
> > > -=09/* Expose the PCI resources from this device as files */
> > > -=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > > +=09if (!pci_resource_len(pdev, bar))
> > > +=09=09return 0;
> [...]
> > Did you accidently forget to address some of the comments as I thought =
you=20
> > were agreeing to changing this to resource_assigned() but I found no=20
> > resource_assigned() from entire series?
>=20
> I have not.  Sorry for late reply here.
>=20
> When testing resource_assigned() as replacement for pci_resource_len(),
> none of the resource files would be made visible.
>=20
> The resource_assigned() checks res->parent, but the static .is_bin_visibl=
e
> callback runs at device_add() time, called from pci_device_add() during b=
us
> enumeration, so before pci_assign_unassigned_bus_resources() runs and ins=
erts
> resources into the resource tree via pci_claim_resource(), etc.
>=20
> The call sequence in pci_host_probe() is:
>=20
>   pci_scan_root_bus_bridge()
>     pci_scan_child_bus()
>       pci_scan_slot()
>         pci_scan_single_device()
>           pci_scan_device()
>             pci_setup_device()
>               pci_read_bases()        <- res->start/end set from BARs
>           pci_device_add()
>             device_add()              <- is_bin_visible() runs here
>                                          res->parent still NULL
>=20
>   pci_assign_unassigned_root_bus_resources()
>     pci_claim_resource()
>       request_resource_conflict()
>         __request_resource()          <- res->parent set here
>=20
> At that point, the pci_resource_len() would return a non-zero value as
> res->start and res->end would already be set, but the res->parent is
> still NULL (not yet assigned to tree).
>=20
> The old dynamic code ran from pci_sysfs_init() as a late_initcall (after
> assignment), where resource_assigned() would have worked.
>=20
> As such, we can't really use resource_assigned() together with static
> sysfs attributes, at least not without solving the resources evaluation
> order here.
>=20
> Thank you!

Okay, understood (I already saw you coverletter as well).

This however implies there's no guarantee the resource space range is even=
=20
available for the BAR if the check is not based on ->parent. (Hit a=20
problem like this kind of highlights how using pci_resource_len() is=20
definitely hacky.)

I suppose it would be more proper to always recalculate the sysfs
visibilities after resources have been rearranged (released or assigned).
But as with the BAR resize, there's the race window when releasing BARs
so solving it may be non-trivial to get the ordering right (without mass
removing sysfs files prior to running the resource fitting and assignment
algorithm which doesn't seem wise either).

So to conclude, IMO, this series is a major improvement to state of
things as is and solving this pci_resource_len() vs resource_assigned()=20
within the context of this series doesn't seem worth the extra delay and=20
complexity. Thus, I'm fine with using pci_resource_len() for now.

--=20
 i.

--8323328-1542172744-1776678426=:961--

