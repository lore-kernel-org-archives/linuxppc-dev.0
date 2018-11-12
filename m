Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18408C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 01:10:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F1D2087F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 01:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bWg7Cp9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F1D2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tXkT3XQHzF3Qt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 12:10:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bWg7Cp9l";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tXgw1qwZzF3Nm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 12:08:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="bWg7Cp9l"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42tXgv4st2z9s9h; Mon, 12 Nov 2018 12:08:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1541984907;
 bh=nTyzEJI2XRK1oDzQ9cAJj7voHKDKjORKwcvd+7qwTEs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bWg7Cp9l5IFX13s7Wn0rTf+FgXjtH/3bnwXTQne/mJ2k7OGrj7g5aJGDrJQ7J5mbb
 Xup2vGwmpyLTf1WJND+db4URiZ0KLLDEzLpfse/KT986BJ9bNceimUABLivDXCcMdm
 RONoZZdga8LKNjTQsyTwovmR7+SwEfr45y3TVfPI=
Date: Mon, 12 Nov 2018 12:08:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 3/3] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] [10de:1db1] subdriver
Message-ID: <20181112010819.GA21020@umbus.fritz.box>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-4-aik@ozlabs.ru>
 <20181016130824.20be215b@w520.home>
 <71c11c53-c83d-b0b6-5036-574df45009e4@ozlabs.ru>
 <20181017155252.2f15d0f0@w520.home>
 <2175dbbd-21d9-df26-67f5-4b41f90ab1bc@ozlabs.ru>
 <20181018105503.088a343f@w520.home>
 <0e0db29d-a1e8-af85-b715-c1ba1a2f3875@nvidia.com>
 <20181018120502.057feb7a@w520.home>
 <918290dc-59c3-f269-38d4-a07d323173f9@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <918290dc-59c3-f269-38d4-a07d323173f9@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Reza Arbab <arbab@linux.ibm.com>, kvm@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 19, 2018 at 11:53:53AM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 19/10/2018 05:05, Alex Williamson wrote:
> > On Thu, 18 Oct 2018 10:37:46 -0700
> > Piotr Jaroszynski <pjaroszynski@nvidia.com> wrote:
> >=20
> >> On 10/18/18 9:55 AM, Alex Williamson wrote:
> >>> On Thu, 18 Oct 2018 11:31:33 +1100
> >>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>  =20
> >>>> On 18/10/2018 08:52, Alex Williamson wrote: =20
> >>>>> On Wed, 17 Oct 2018 12:19:20 +1100
> >>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>>     =20
> >>>>>> On 17/10/2018 06:08, Alex Williamson wrote: =20
> >>>>>>> On Mon, 15 Oct 2018 20:42:33 +1100
> >>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:   =20
> >>>>>>>> +
> >>>>>>>> +	if (pdev->vendor =3D=3D PCI_VENDOR_ID_IBM &&
> >>>>>>>> +			pdev->device =3D=3D 0x04ea) {
> >>>>>>>> +		ret =3D vfio_pci_ibm_npu2_init(vdev);
> >>>>>>>> +		if (ret) {
> >>>>>>>> +			dev_warn(&vdev->pdev->dev,
> >>>>>>>> +					"Failed to setup NVIDIA NV2 ATSD region\n");
> >>>>>>>> +			goto disable_exit;
> >>>>>>>>   		} =20
> >>>>>>>
> >>>>>>> So the NPU is also actually owned by vfio-pci and assigned to the=
 VM? =20
> >>>>>>
> >>>>>> Yes. On a running system it looks like:
> >>>>>>
> >>>>>> 0007:00:00.0 Bridge: IBM Device 04ea (rev 01)
> >>>>>> 0007:00:00.1 Bridge: IBM Device 04ea (rev 01)
> >>>>>> 0007:00:01.0 Bridge: IBM Device 04ea (rev 01)
> >>>>>> 0007:00:01.1 Bridge: IBM Device 04ea (rev 01)
> >>>>>> 0007:00:02.0 Bridge: IBM Device 04ea (rev 01)
> >>>>>> 0007:00:02.1 Bridge: IBM Device 04ea (rev 01)
> >>>>>> 0035:00:00.0 PCI bridge: IBM Device 04c1
> >>>>>> 0035:01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> >>>>>> 0035:02:04.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> >>>>>> 0035:02:05.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> >>>>>> 0035:02:0d.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev ca)
> >>>>>> 0035:03:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100=
 SXM2]
> >>>>>> (rev a1
> >>>>>> 0035:04:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100=
 SXM2]
> >>>>>> (rev a1)
> >>>>>> 0035:05:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V100=
 SXM2]
> >>>>>> (rev a1)
> >>>>>>
> >>>>>> One "IBM Device" bridge represents one NVLink2, i.e. a piece of NP=
U.
> >>>>>> They all and 3 GPUs go to the same IOMMU group and get passed thro=
ugh to
> >>>>>> a guest.
> >>>>>>
> >>>>>> The entire NPU does not have representation via sysfs as a whole t=
hough. =20
> >>>>>
> >>>>> So the NPU is a bridge, but it uses a normal header type so vfio-pci
> >>>>> will bind to it? =20
> >>>>
> >>>> An NPU is a NVLink bridge, it is not PCI in any sense. We (the host
> >>>> powerpc firmware known as "skiboot" or "opal") have chosen to emulat=
e a
> >>>> virtual bridge per 1 NVLink on the firmware level. So for each physi=
cal
> >>>> NPU there are 6 virtual bridges. So the NVIDIA driver does not need =
to
> >>>> know much about NPUs.
> >>>> =20
> >>>>> And the ATSD register that we need on it is not
> >>>>> accessible through these PCI representations of the sub-pieces of t=
he
> >>>>> NPU?  Thanks, =20
> >>>>
> >>>> No, only via the device tree. The skiboot puts the ATSD register add=
ress
> >>>> to the PHB's DT property called 'ibm,mmio-atsd' of these virtual bri=
dges. =20
> >>>
> >>> Ok, so the NPU is essential a virtual device already, mostly just a
> >>> stub.  But it seems that each NPU is associated to a specific GPU, how
> >>> is that association done?  In the use case here it seems like it's ju=
st
> >>> a vehicle to provide this ibm,mmio-atsd property to guest DT and the =
tgt
> >>> routing information to the GPU.  So if both of those were attached to
> >>> the GPU, there'd be no purpose in assigning the NPU other than it's in
> >>> the same IOMMU group with a type 0 header, so something needs to be
> >>> done with it.  If it's a virtual device, perhaps it could have a type=
 1
> >>> header so vfio wouldn't care about it, then we would only assign the
> >>> GPU with these extra properties, which seems easier for management
> >>> tools and users.  If the guest driver needs a visible NPU device, QEMU
> >>> could possibly emulate one to make the GPU association work
> >>> automatically.  Maybe this isn't really a problem, but I wonder if
> >>> you've looked up the management stack to see what tools need to know =
to
> >>> assign these NPU devices and whether specific configurations are
> >>> required to make the NPU to GPU association work.  Thanks, =20
> >>
> >> I'm not that familiar with how this was originally set up, but note th=
at=20
> >> Alexey is just making it work exactly like baremetal does. The baremet=
al=20
> >> GPU driver works as-is in the VM and expects the same properties in th=
e=20
> >> device-tree. Obviously it doesn't have to be that way, but there is=20
> >> value in keeping it identical.
> >>
> >> Another probably bigger point is that the NPU device also implements t=
he=20
> >> nvlink HW interface and is required for actually training and=20
> >> maintaining the link up. The driver in the guest trains the links by=
=20
> >> programming both the GPU end and the NPU end of each link so the NPU=
=20
> >> device needs to be exposed to the guest.
> >=20
> > Ok, so there is functionality in assigning the NPU device itself, it's
> > not just an attachment point for meta data.  But it still seems there
> > must be some association of NPU to GPU, the tgt address seems to pair
> > the NPU with a specific GPU, they're not simply a fungible set of NPUs
> > and GPUs.  Is that association explicit anywhere or is it related to
> > the topology or device numbering that needs to match between the host
> > and guest?  Thanks,
>=20
> It is in the device tree (phandle is a node ID).

Hrm.  But the device tree just publishes information about the
hardware.  What's the device tree value actually exposing here?

Is there an inherent hardware connection between one NPU and one GPU?
Or is there just an arbitrary assignment performed by the firmware
which it then exposed to the device tree?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvo0oEACgkQbDjKyiDZ
s5KCRxAAvIQK2JDwl4w7ZRE71d0u6nblVQVE+Dko0jBD8vi2v0UuQ+SmOrzCUxys
rKiRvuDq0FAKF/OqJnShRc1aZXcxGjFW3rrxWi2rrvfEihAMlOzKd38nz3w52ovg
MWSWMh8b/Tp9VPGCKSybGRt3zwDdaiuF6emM+XOpx8jYkiABxy9JMAr8gLdPu6Xr
RcZW7DOZcM9P+KPMN3xEBsjUB1m9RBBlrULYTNkmnr4LPzRlMkmcIIcCtEjP5BX+
6tBAKLKx6nHUyPhaRgw2nyYLvh6YHPG+ub6WTZBZpWBsAQy2hgVVB0oQxqULTOLK
NoaI5UJV6EjI8mNwZupqElORafUyzdwmRgnAv+8lBSSYLdsMdPAqrI05rGFHQt2n
H6Sk+zCy03Ej4ifNZmS2VeOyNmPWYuyekP2gck6zpBfF8DnH6NskwciSP1poPVF8
MV3wvxXHj4CaZzSwm5IT/BUf6fCA/JnczslVLK/OLLLMYCYNF8/IGNdgZNjrMd5m
NPT4/lJBDdpB/+52W3QzyBjna9MKhIqMM0B5csZt5/PDLOe1bae43ZCMTS6y4diG
t0ZU/k0p9CLSTBYOGot2P1G2xLj6NNOsZ+VeoFzgq3QMLX1T+T5T/ZSynpfJiHr6
i0IYJ0fU7Y19IQj5vU9m7g8K0eySkGPJtsCI3Gy9hmrwkpBQc7w=
=meZa
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
