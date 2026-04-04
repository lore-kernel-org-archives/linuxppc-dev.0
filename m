Return-Path: <linuxppc-dev+bounces-19320-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72C5E63FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 17:04:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fp24z3Yhnz2yl2;
	Sun, 05 Apr 2026 03:04:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775322275;
	cv=none; b=kQo1mP3buOLHUekOA+VPJyrrC4DEXlTPm4ycMSngXq5NMRxLKkXZ/Q/CIdzZXx2BC480GGM5QyCF9qsOo5Yi/Ze2ECr7A8+hnJHrRDJtNvEwMDvtPQ2Xqjbj9GUlzZ5eRjUjpOng3XJ19YZPkSyD+ItXot0O00rJ6J6l+dFCVYLutXMZr4VEHLv6/UFR1gRClDcY8JHSNBUJ/3vpZQ0fGLWNcyjmkEzIBu/+faiiQM8k590MJDhv1EjFgd3IQIUoSg09tIBrWgtyzi9RtljfUN1EL9KrjWE2pF/m1BogJlF7E/fCyWrYg9SSddDGs3eTQ4YM2HQntzqK0E+rrmI66w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775322275; c=relaxed/relaxed;
	bh=fK4CeZGVb1KNMIdR5Au5izpo8ayGMJknWsxoBx3biqw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=HOEsxbwLdx9IUdplrCYlN+DheVy6idFMFLoK6GLQR0tSOjI5eEwiV5A2qQy+OLRxrvS02RBsCdxLU3dbalMSjoqqC+8AowQybWu4/x64Y/rQvH6UCPZzxFb0mAuElg/AOxnhsHZ7KxcZW2QQb6LkwS2BGueSqulyS7xgbndHMKCcJoe+eY+ArkxfeUH/8J23Vc9B1mqQAQPsndFeRH1uoNfuTuu5/nrerihBNXmwBWr4hggOchMdAgzmuTPwOHqjguGjWGdG+rMEnuoR8Ei2UhlVYiaZrhMRO6EnHE37UOSPHPephPll8709I70qPcmPhi5dI4Pik6erFaDdYPj73Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fe5eJq1d; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fe5eJq1d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fp24y4dcXz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Apr 2026 03:04:34 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 979924060D;
	Sat,  4 Apr 2026 17:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6663AC19421;
	Sat,  4 Apr 2026 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775322272;
	bh=7PzP6n6U4E9ZflmrRkBSMwOeYsGN0d+ge+8bYc26zsY=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=fe5eJq1d99JHNmPB8IpFig8PRyyyj5sltf3KPYrDsk0N8TKZGpBePJLkrkPDItx5u
	 OD9XiP1BsdzxhDnieDTpdRavUaIxIOsfwema+FPuAf2OftNWG3RNzfc/+E74+vzYXL
	 hr6gl/9eoMudVQ+SB7i9KoJ64jNeCH7KBFn19c9SoYtuyJxnlnjg/gnFezKFCEM8UT
	 pXBEauClp409xFE/+hMuTZWOGegzPULPyvlbewkUUrLyfkmmluI/xnbmAAlztMocbH
	 5TCceEPtW/9Z41b0BUe5ZnMFG66SCb9IcaE5AfJKxdvb9nrxftJLbDrCkbK9ayIBu8
	 7zufDNhS7HSYw==
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
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 19:04:21 +0200
Message-Id: <DHKJ7VWI1CHO.3ETHUGQVPFFDE@kernel.org>
Cc: "Russell King" <linux@armlinux.org.uk>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Ioana Ciornei" <ioana.ciornei@nxp.com>, "Nipun Gupta"
 <nipun.gupta@amd.com>, "Nikhil Agarwal" <nikhil.agarwal@amd.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, "Haiyang Zhang" <haiyangz@microsoft.com>,
 "Wei Liu" <wei.liu@kernel.org>, "Dexuan Cui" <decui@microsoft.com>, "Long
 Li" <longli@microsoft.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Armin
 Wolf" <W_Armin@gmx.de>, "Bjorn Andersson" <andersson@kernel.org>, "Mathieu
 Poirier" <mathieu.poirier@linaro.org>, "Vineeth Vijayan"
 <vneethv@linux.ibm.com>, "Peter Oberparleiter" <oberpar@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Harald
 Freudenberger" <freude@linux.ibm.com>, "Holger Dengler"
 <dengler@linux.ibm.com>, "Mark Brown" <broonie@kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>, "Xuan Zhuo"
 <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "Alex Williamson" <alex@shazbot.org>, "Juergen
 Gross" <jgross@suse.com>, "Stefano Stabellini" <sstabellini@kernel.org>,
 "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-hyperv@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
 <linux-s390@vger.kernel.org>, <linux-spi@vger.kernel.org>,
 <virtualization@lists.linux.dev>, <kvm@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, <linux-arm-kernel@lists.infradead.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: (subset) [PATCH 00/12] treewide: Convert buses to use generic
 driver_override
References: <20260324005919.2408620-1-dakr@kernel.org>
 <DHKGQN6D0ANO.2QYY3JTM5435O@kernel.org>
 <76355cb5-0b5d-4a29-9702-8d020a79f4c0@kernel.org>
In-Reply-To: <76355cb5-0b5d-4a29-9702-8d020a79f4c0@kernel.org>

On Sat Apr 4, 2026 at 6:58 PM CEST, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 04/04/2026 =C3=A0 17:07, Danilo Krummrich a =C3=A9crit=C2=A0:
>> On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
>>> Danilo Krummrich (12):
>>>    PCI: use generic driver_override infrastructure
>>>    platform/wmi: use generic driver_override infrastructure
>>>    vdpa: use generic driver_override infrastructure
>>>    s390/cio: use generic driver_override infrastructure
>>>    s390/ap: use generic driver_override infrastructure
>>=20
>> Applied to driver-core-testing, thanks!
>>=20
>>>    amba: use generic driver_override infrastructure
>>>    cdx: use generic driver_override infrastructure
>>>    hv: vmbus: use generic driver_override infrastructure
>>>    rpmsg: use generic driver_override infrastructure
>>=20
>> I have not picked these up, as they have not received ACKs from the
>> corresponding subsystem maintainers so far.
>>=20
>>>    bus: fsl-mc: use generic driver_override infrastructure
>
> I droped it from soc_fsl tree, some dependency must be missing.
>
> Feal free to take it if you can, it is acked-by Ioana.

It is based on v7.0-rc5; if you want I can pick it up.

>>>    spi: use generic driver_override infrastructure
>>=20
>> These have already been picked up via the respective subsystem trees -- =
thanks!
>>=20
>> Thanks,
>> Danilo


