Return-Path: <linuxppc-dev+bounces-19053-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A0DFF60D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 08:06:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flLLH3ggxz2xnZ;
	Tue, 31 Mar 2026 19:06:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774944407;
	cv=none; b=fhPcCyYeDOWSqw/JSD/UapRx7ibCOaRQGTpFqlgfurCwX2gdxCdB482+b5wD885crDXlDHMu3WjJwoDwcjO+WnW1A3Y1EOPeBjopCyf5okfQCLLHw2fU8VDGRkdyGM8jwVeD90XACIV9mdbk6z8S+S79hp+5c4DFXxSO5qGBdq7BY4/vBln3N2gh6Tk7sSGvh6EfhRSD4iqT0VKbWflm/77foxTvYbv2SJzR/0MKLN3jrESefSbCV0SnpDQSfd9zHYVgvrM4pTghDsiR3juQjmv+9UPXmKEhnuU90Z6NkpHo5I2MDCZM/vVaFBBnDbSPPymdO/Q2Y5a4ihA9YaNChA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774944407; c=relaxed/relaxed;
	bh=Tw/cKtFdiLF09y34hph3UamFXBgy8d+h+o3fkHZct0g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=coSxpmetntKQZYugTG32DW1+4l1AAPmbVvFI4p0pluOEy4MQGvwIKhPr+P5VN1bAoAksDqSf2llfMAfzdBjm1kq8XVrL84jnNpmh8BiGIfh3/9xK8McXC3SqAEKzoY8w8TPPsHW3akHMcvCQLKzZKZkgAyNHQ8VhE6gnOnyzb5pNLoQoQ2FRdrvyqbjWzMQbgsJ1Oq3L0wUeGPaDgWYJ1jYVx+lCLkL43+Kp5yQLjo99zJj0aWHg1Gz1t3Qzs01RWRi3Oto/LZWEcLzAAKjqe6FJeMqQsz+ADQkGnt7310GFE5xyw9lpfV2d4zHc/ztvLm9eokPGtvK0LLkLpxhEpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AWIlCHwQ; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AWIlCHwQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=dakr@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flLLG4CDWz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 19:06:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E36C860133;
	Tue, 31 Mar 2026 08:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9364DC2BCB1;
	Tue, 31 Mar 2026 08:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774944403;
	bh=7ZnFUcGBpSYxCeawHwcWvE73wN8LYb8XSX/aZ34llBU=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=AWIlCHwQfZsUuHzOmGZpVGY5YC2rf+d68CeBHq+msonYwp7U2eqLrZxes/cDwOhzj
	 cxpHUVzGLXyiRtTuiesiUTZk1jZ4TcDex7KFW8cftoKdzZUi7rr5OJwggbIXG1Qkjk
	 y+1kJYFjlXJgwRMxjX5gpnBgZX2SWzf28LHVl+Lqu+vuVqVDfsqOYyI0fBSLNK4oiz
	 5o/ZjxvWe1HfMi03Q77GYttGBzv0VRF/kGrPedoVKNJAcdTkHpW3bIz1sDtXTCy1mo
	 2Z3qOFa/hlvy8JEPivh5B8wp9J/5+CgONWe9R6Y+M3smVnPJrUWUnRppA4rHbFzvHS
	 mmm1NDCdVo7ag==
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
Date: Tue, 31 Mar 2026 10:06:32 +0200
Message-Id: <DHGT9XCG8Y96.3IB1EI6FF1ZDZ@kernel.org>
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
In-Reply-To: <20260330141050.2cb47bd9@shazbot.org>

On Mon Mar 30, 2026 at 10:10 PM CEST, Alex Williamson wrote:
> On Mon, 30 Mar 2026 19:38:41 +0200
> "Danilo Krummrich" <dakr@kernel.org> wrote:
>
>> (Cc: Jason)
>>=20
>> On Tue Mar 24, 2026 at 1:59 AM CET, Danilo Krummrich wrote:
>> > diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_=
pci_core.c
>> > index d43745fe4c84..460852f79f29 100644
>> > --- a/drivers/vfio/pci/vfio_pci_core.c
>> > +++ b/drivers/vfio/pci/vfio_pci_core.c
>> > @@ -1987,9 +1987,8 @@ static int vfio_pci_bus_notifier(struct notifier=
_block *nb,
>> >  	    pdev->is_virtfn && physfn =3D=3D vdev->pdev) {
>> >  		pci_info(vdev->pdev, "Captured SR-IOV VF %s driver_override\n",
>> >  			 pci_name(pdev));
>> > -		pdev->driver_override =3D kasprintf(GFP_KERNEL, "%s",
>> > -						  vdev->vdev.ops->name);
>> > -		WARN_ON(!pdev->driver_override);
>> > +		WARN_ON(device_set_driver_override(&pdev->dev,
>> > +						   vdev->vdev.ops->name)); =20
>>=20
>> Technically, this is a change in behavior. If vdev->vdev.ops->name is NU=
LL, it
>> will trigger the WARN_ON(), whereas before it would have just written "(=
null)"
>> into driver_override.
>
> It's worse than that.  Looking at the implementation in [1], we have:
>
> +static inline int device_set_driver_override(struct device *dev, const c=
har *s)
> +{
> +	return __device_set_driver_override(dev, s, strlen(s));
> +}
>
> So if name is NULL, we oops in strlen() before we even hit the -EINVAL
> and WARN_ON().

This was changed in v2 [2] and the actual code in-tree is

	static inline int device_set_driver_override(struct device *dev, const cha=
r *s)
	{
		return __device_set_driver_override(dev, s, s ? strlen(s) : 0);
	}

so it does indeed return -EINVAL for a NULL pointer.

> I don't believe we have any vfio-pci variant drivers where the name is
> NULL, but kasprintf() handling NULL as "(null)" was a consideration in
> this design, that even if there is no name the device is sequestered
> with a driver_override that won't match an actual driver.
>
>> I assume that vfio_pci_core drivers are expected to set the name in stru=
ct
>> vfio_device_ops in the first place and this code (silently) relies on th=
is
>> invariant?
>
> We do expect that, but it was previously safe either way to make sure
> VFs are only bound to the same ops driver or barring that, at least
> don't perform a standard driver match.  The last thing we want to
> happen automatically is for a user owned PF to create SR-IOV VFs that
> automatically bind to native kernel drivers.
> =20
>> Alex, Jason: Should we keep this hunk above as is and check for a proper=
 name in
>> struct vfio_device_ops in vfio_pci_core_register_device() with a subsequ=
ent
>> patch?
>
> Given the oops, my preference would be to roll it in here.  This change
> is what makes it a requirement that name cannot be NULL, where this was
> safely handled with kasprintf().

Again, no oops here. :)

I still think it makes more sense to fail early in
vfio_pci_core_register_device(), rather than silently accept "(null)" in
driver_override. It also doesn't seem unreasonable with only the WARN_ON(),=
 but
I can also just add vdev->vdev.ops->name ?: "(null)".

Please let me know what you prefer.

- Danilo

> [1] https://lore.kernel.org/all/20260302002729.19438-2-dakr@kernel.org/

[2] https://lore.kernel.org/driver-core/20260303115720.48783-1-dakr@kernel.=
org/

