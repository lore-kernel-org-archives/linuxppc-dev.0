Return-Path: <linuxppc-dev+bounces-19054-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5BD3FF60E7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 08:22:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flLhN45Xfz2ydn;
	Tue, 31 Mar 2026 19:22:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774945348;
	cv=none; b=GaF2vxYte678OhFzcvjQCl/fanskQ1tFPsSBRwmU0Y+SQ/U/K2sBP6oK92/2U3O0NEc+2NcNhWBqm2APx0wIYlKmQr77umnpoDyumgQ22+wZKNG+mvMr02BWlqkEb/PSUUIcolgOiRCRoznGlo2qHkyjlsXpMfsJMJfjBeuge+kDQD9iTCNMg8mw+DvMmzPITnuWi3mwgmWkc0O39pl6ysKO5tOhudNFebhti/b2SY/eStEg33fiQaE94qW/8rsPq/I8UORmq2e7wgmQgMBChZJ24hvnQkW5C+HlAMj3KnYUNiP2HNAxE4WCawwZN6I9jdF3kgvFqCZARci6AKQsUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774945348; c=relaxed/relaxed;
	bh=1tTr3uCpcw0w7zr+KeCm8gNKpMn9eSAJB28W04BfdRY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=oXDKJAs/N2hdmaa2Zz8GQ8Cc2F2IbBC/uda1MYdJIoDSR3yh1OlCdG1ltXzvsFR9YQ1hDjyuCtHW0N0JvN9ukv+Anlv+W6A554eYl4IImgmTC+MGI1udymLBXoD3x8g/t5TI2LedleLE/Yy53Klf+6bl98zewhSzw3Xzwlf1HbOEk6HzpaaSUc3khO3QlmfpDj/KpQSxABu9ZV8UiycC7XgVUZmGUSBA/RGYQjHAznvBErMTIOH3UBRQBaRz28F+6lVDQ5xz+FLjaoPIISRzaWqjXitvjtIdUQAV5zdffjH82mD188u9iGFJcmTcFGoud6mzGKG6Va/86xHuANU79g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hSy9+x0o; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hSy9+x0o;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flLhM5RmYz2ydQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 19:22:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C4EA460126;
	Tue, 31 Mar 2026 08:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491C9C19423;
	Tue, 31 Mar 2026 08:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774945345;
	bh=l6+1fNT+srCycsiVVoib27WaB3v/ZfJTiLnjMUHoUKo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hSy9+x0oWet2Vv+Oa/3w4GpGm2W4uKeHJBTg9yWIIsbEo6AeK4CHA2HWQrg43wVml
	 UVDFcKRzAiCTcPrPYa8DFRgndlsXnw4fTPckVVFiVQb06rsmUThpiBFwbHCwFpNgx9
	 aItzsCrpgMmhdBzOksIXuo4KjSj0zwKhq5Cid6OYUD9yR5jXXRbnJ0gLf3fnZTo/+d
	 1ltaJGKRSE2hkkenVvfpB0JLleI13qUWazlmX5cCzMNZECQq3dZ5sC7thgT6+6cjC8
	 i3Qv/NInrpLzf5qRyZ3z333YkadqamLF6R3ft0Ny0IUSwt34LY7sCNzSn76UOiN7FG
	 7FAeA2EXbVc6w==
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
Date: Tue, 31 Mar 2026 10:22:14 +0200
Message-Id: <DHGTLY0FJWD2.2VLT6NQWF97YY@kernel.org>
Subject: Re: [PATCH 05/12] PCI: use generic driver_override infrastructure
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Russell King"
 <linux@armlinux.org.uk>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Ioana Ciornei"
 <ioana.ciornei@nxp.com>, "Nipun Gupta" <nipun.gupta@amd.com>, "Nikhil
 Agarwal" <nikhil.agarwal@amd.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 "Haiyang Zhang" <haiyangz@microsoft.com>, "Wei Liu" <wei.liu@kernel.org>,
 "Dexuan Cui" <decui@microsoft.com>, "Long Li" <longli@microsoft.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "Armin Wolf" <W_Armin@gmx.de>,
 "Bjorn Andersson" <andersson@kernel.org>, "Mathieu Poirier"
 <mathieu.poirier@linaro.org>, "Vineeth Vijayan" <vneethv@linux.ibm.com>,
 "Peter Oberparleiter" <oberpar@linux.ibm.com>, "Heiko Carstens"
 <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger"
 <borntraeger@linux.ibm.com>, "Sven Schnelle" <svens@linux.ibm.com>, "Harald
 Freudenberger" <freude@linux.ibm.com>, "Holger Dengler"
 <dengler@linux.ibm.com>, "Mark Brown" <broonie@kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>, "Xuan Zhuo"
 <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "Juergen Gross" <jgross@suse.com>, "Stefano
 Stabellini" <sstabellini@kernel.org>, "Oleksandr Tyshchenko"
 <oleksandr_tyshchenko@epam.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-hyperv@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <platform-driver-x86@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-remoteproc@vger.kernel.org>, <linux-s390@vger.kernel.org>,
 <linux-spi@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <kvm@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
 <linux-arm-kernel@lists.infradead.org>, "Gui-Dong Han"
 <hanguidong02@gmail.com>
To: "Alex Williamson" <alex@shazbot.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
 <20260324005919.2408620-6-dakr@kernel.org>
 <DHGATG6LJOM1.2AI7BYQ2O4DFU@kernel.org>
 <20260330141050.2cb47bd9@shazbot.org>
 <DHGT9XCG8Y96.3IB1EI6FF1ZDZ@kernel.org>
In-Reply-To: <DHGT9XCG8Y96.3IB1EI6FF1ZDZ@kernel.org>

On Tue Mar 31, 2026 at 10:06 AM CEST, Danilo Krummrich wrote:
> On Mon Mar 30, 2026 at 10:10 PM CEST, Alex Williamson wrote:
>> On Mon, 30 Mar 2026 19:38:41 +0200
>> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>
>>> (Cc: Jason)
>>>=20
>>> On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
>>> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio=
_pci_core.c
>>> > index d43745fe4c84..460852f79f29 100644
>>> > --- a/drivers/vfio/pci/vfio_pci_core.c
>>> > +++ b/drivers/vfio/pci/vfio_pci_core.c
>>> > @@ -1987,9 +1987,8 @@ static int vfio_pci_bus_notifier(struct notifie=
r_block *nb,
>>> >  	    pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>>> >  		pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_override\n",
>>> >  			 pci_name(pdev));
>>> > -		pdev->driver_override =3D kasprintf(GFP_KERNEL, "%s",
>>> > -						  vdev->vdev.ops->name);
>>> > -		WARN_ON(!pdev->driver_override);
>>> > +		WARN_ON(device_set_driver_override(&pdev->dev,
>>> > +						   vdev->vdev.ops->name)); =20
>>>=20
>>> Technically, this is a change in behavior. If vdev->vdev.ops->name is N=
ULL, it
>>> will trigger the WARN_ON(), whereas before it would have just written "=
(null)"
>>> into driver_override.
>>
>> It's worse than that.  Looking at the implementation in [1], we have:
>>
>> +static inline int device_set_driver_override(struct device *dev, const =
char *s)
>> +{
>> +	return __device_set_driver_override(dev, s, strlen(s));
>> +}
>>
>> So if name is NULL, we oops in strlen() before we even hit the -EINVAL
>> and WARN_ON().
>
> This was changed in v2 [2] and the actual code in-tree is
>
> 	static inline int device_set_driver_override(struct device *dev, const c=
har *s)
> 	{
> 		return __device_set_driver_override(dev, s, s ? strlen(s) : 0);
> 	}
>
> so it does indeed return -EINVAL for a NULL pointer.
>
>> I don't believe we have any vfio-pci variant drivers where the name is
>> NULL, but kasprintf() handling NULL as "(null)" was a consideration in
>> this design, that even if there is no name the device is sequestered
>> with a driver_override that won't match an actual driver.
>>
>>> I assume that vfio_pci_core drivers are expected to set the name in str=
uct
>>> vfio_device_ops in the first place and this code (silently) relies on t=
his
>>> invariant?
>>
>> We do expect that, but it was previously safe either way to make sure
>> VFs are only bound to the same ops driver or barring that, at least
>> don't perform a standard driver match.  The last thing we want to
>> happen automatically is for a user owned PF to create SR-IOV VFs that
>> automatically bind to native kernel drivers.
>> =20
>>> Alex, Jason: Should we keep this hunk above as is and check for a prope=
r name in
>>> struct vfio_device_ops in vfio_pci_core_register_device() with a subseq=
uent
>>> patch?
>>
>> Given the oops, my preference would be to roll it in here.  This change
>> is what makes it a requirement that name cannot be NULL, where this was
>> safely handled with kasprintf().
>
> Again, no oops here. :)
>
> I still think it makes more sense to fail early in
> vfio_pci_core_register_device(), rather than silently accept "(null)" in
> driver_override. It also doesn't seem unreasonable with only the WARN_ON(=
), but
> I can also just add vdev->vdev.ops->name ?: "(null)".

(Or just skip the call if !vdev->vdev.ops->name, as a user will read "(null=
)"
from sysfs either way.)

> Please let me know what you prefer.
>
> - Danilo
>
>> [1] https://lore.kernel.org/all/20260302002729.19438-2-dakr@kernel.org/
>
> [2] https://lore.kernel.org/driver-core/20260303115720.48783-1-dakr@kerne=
l.org/


