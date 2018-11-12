Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FF6C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:35:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C2D21582
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 04:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qMu+sQJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C2D21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tdGn4x0XzF3HF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 15:35:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="qMu+sQJm";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42td1K6D4YzF3Ky
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 15:23:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="qMu+sQJm"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42td1J666lz9s4s; Mon, 12 Nov 2018 15:23:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1541996628;
 bh=fA5Z5c5wGOhaWyV6pO4cdpIsH9xdnuNctNu4kFR4eFU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qMu+sQJmiaeFkOdh35BNBisn0DoM3nNpGYfhEo7MHLcOP26cEnSOoOHloG7MmHpL6
 oX+PY7ct0Cnp7XCQuBiL3oJTYNBkx/6wSHDMxK3eZDXNepl+g6zurh4IRS9NlV7ub0
 NtkxxyRDE/zYH4+GqXMQ92pGI/EJ3j91zsU426bU=
Date: Mon, 12 Nov 2018 15:23:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 3/3] vfio_pci: Add NVIDIA GV100GL [Tesla V100
 SXM2] [10de:1db1] subdriver
Message-ID: <20181112042343.GB21020@umbus.fritz.box>
References: <20181016130824.20be215b@w520.home>
 <71c11c53-c83d-b0b6-5036-574df45009e4@ozlabs.ru>
 <20181017155252.2f15d0f0@w520.home>
 <2175dbbd-21d9-df26-67f5-4b41f90ab1bc@ozlabs.ru>
 <20181018105503.088a343f@w520.home>
 <0e0db29d-a1e8-af85-b715-c1ba1a2f3875@nvidia.com>
 <20181018120502.057feb7a@w520.home>
 <918290dc-59c3-f269-38d4-a07d323173f9@ozlabs.ru>
 <20181112010819.GA21020@umbus.fritz.box>
 <87de990e-7ea5-d544-ab2a-15d69e57703c@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <87de990e-7ea5-d544-ab2a-15d69e57703c@ozlabs.ru>
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


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2018 at 01:36:45PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 12/11/2018 12:08, David Gibson wrote:
> > On Fri, Oct 19, 2018 at 11:53:53AM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 19/10/2018 05:05, Alex Williamson wrote:
> >>> On Thu, 18 Oct 2018 10:37:46 -0700
> >>> Piotr Jaroszynski <pjaroszynski@nvidia.com> wrote:
> >>>
> >>>> On 10/18/18 9:55 AM, Alex Williamson wrote:
> >>>>> On Thu, 18 Oct 2018 11:31:33 +1100
> >>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>>  =20
> >>>>>> On 18/10/2018 08:52, Alex Williamson wrote: =20
> >>>>>>> On Wed, 17 Oct 2018 12:19:20 +1100
> >>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>>>>     =20
> >>>>>>>> On 17/10/2018 06:08, Alex Williamson wrote: =20
> >>>>>>>>> On Mon, 15 Oct 2018 20:42:33 +1100
> >>>>>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:   =20
> >>>>>>>>>> +
> >>>>>>>>>> +	if (pdev->vendor =3D=3D PCI_VENDOR_ID_IBM &&
> >>>>>>>>>> +			pdev->device =3D=3D 0x04ea) {
> >>>>>>>>>> +		ret =3D vfio_pci_ibm_npu2_init(vdev);
> >>>>>>>>>> +		if (ret) {
> >>>>>>>>>> +			dev_warn(&vdev->pdev->dev,
> >>>>>>>>>> +					"Failed to setup NVIDIA NV2 ATSD region\n");
> >>>>>>>>>> +			goto disable_exit;
> >>>>>>>>>>   		} =20
> >>>>>>>>>
> >>>>>>>>> So the NPU is also actually owned by vfio-pci and assigned to t=
he VM? =20
> >>>>>>>>
> >>>>>>>> Yes. On a running system it looks like:
> >>>>>>>>
> >>>>>>>> 0007:00:00.0 Bridge: IBM Device 04ea (rev 01)
> >>>>>>>> 0007:00:00.1 Bridge: IBM Device 04ea (rev 01)
> >>>>>>>> 0007:00:01.0 Bridge: IBM Device 04ea (rev 01)
> >>>>>>>> 0007:00:01.1 Bridge: IBM Device 04ea (rev 01)
> >>>>>>>> 0007:00:02.0 Bridge: IBM Device 04ea (rev 01)
> >>>>>>>> 0007:00:02.1 Bridge: IBM Device 04ea (rev 01)
> >>>>>>>> 0035:00:00.0 PCI bridge: IBM Device 04c1
> >>>>>>>> 0035:01:00.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev c=
a)
> >>>>>>>> 0035:02:04.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev c=
a)
> >>>>>>>> 0035:02:05.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev c=
a)
> >>>>>>>> 0035:02:0d.0 PCI bridge: PLX Technology, Inc. Device 8725 (rev c=
a)
> >>>>>>>> 0035:03:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V1=
00 SXM2]
> >>>>>>>> (rev a1
> >>>>>>>> 0035:04:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V1=
00 SXM2]
> >>>>>>>> (rev a1)
> >>>>>>>> 0035:05:00.0 3D controller: NVIDIA Corporation GV100GL [Tesla V1=
00 SXM2]
> >>>>>>>> (rev a1)
> >>>>>>>>
> >>>>>>>> One "IBM Device" bridge represents one NVLink2, i.e. a piece of =
NPU.
> >>>>>>>> They all and 3 GPUs go to the same IOMMU group and get passed th=
rough to
> >>>>>>>> a guest.
> >>>>>>>>
> >>>>>>>> The entire NPU does not have representation via sysfs as a whole=
 though. =20
> >>>>>>>
> >>>>>>> So the NPU is a bridge, but it uses a normal header type so vfio-=
pci
> >>>>>>> will bind to it? =20
> >>>>>>
> >>>>>> An NPU is a NVLink bridge, it is not PCI in any sense. We (the host
> >>>>>> powerpc firmware known as "skiboot" or "opal") have chosen to emul=
ate a
> >>>>>> virtual bridge per 1 NVLink on the firmware level. So for each phy=
sical
> >>>>>> NPU there are 6 virtual bridges. So the NVIDIA driver does not nee=
d to
> >>>>>> know much about NPUs.
> >>>>>> =20
> >>>>>>> And the ATSD register that we need on it is not
> >>>>>>> accessible through these PCI representations of the sub-pieces of=
 the
> >>>>>>> NPU?  Thanks, =20
> >>>>>>
> >>>>>> No, only via the device tree. The skiboot puts the ATSD register a=
ddress
> >>>>>> to the PHB's DT property called 'ibm,mmio-atsd' of these virtual b=
ridges. =20
> >>>>>
> >>>>> Ok, so the NPU is essential a virtual device already, mostly just a
> >>>>> stub.  But it seems that each NPU is associated to a specific GPU, =
how
> >>>>> is that association done?  In the use case here it seems like it's =
just
> >>>>> a vehicle to provide this ibm,mmio-atsd property to guest DT and th=
e tgt
> >>>>> routing information to the GPU.  So if both of those were attached =
to
> >>>>> the GPU, there'd be no purpose in assigning the NPU other than it's=
 in
> >>>>> the same IOMMU group with a type 0 header, so something needs to be
> >>>>> done with it.  If it's a virtual device, perhaps it could have a ty=
pe 1
> >>>>> header so vfio wouldn't care about it, then we would only assign the
> >>>>> GPU with these extra properties, which seems easier for management
> >>>>> tools and users.  If the guest driver needs a visible NPU device, Q=
EMU
> >>>>> could possibly emulate one to make the GPU association work
> >>>>> automatically.  Maybe this isn't really a problem, but I wonder if
> >>>>> you've looked up the management stack to see what tools need to kno=
w to
> >>>>> assign these NPU devices and whether specific configurations are
> >>>>> required to make the NPU to GPU association work.  Thanks, =20
> >>>>
> >>>> I'm not that familiar with how this was originally set up, but note =
that=20
> >>>> Alexey is just making it work exactly like baremetal does. The barem=
etal=20
> >>>> GPU driver works as-is in the VM and expects the same properties in =
the=20
> >>>> device-tree. Obviously it doesn't have to be that way, but there is=
=20
> >>>> value in keeping it identical.
> >>>>
> >>>> Another probably bigger point is that the NPU device also implements=
 the=20
> >>>> nvlink HW interface and is required for actually training and=20
> >>>> maintaining the link up. The driver in the guest trains the links by=
=20
> >>>> programming both the GPU end and the NPU end of each link so the NPU=
=20
> >>>> device needs to be exposed to the guest.
> >>>
> >>> Ok, so there is functionality in assigning the NPU device itself, it's
> >>> not just an attachment point for meta data.  But it still seems there
> >>> must be some association of NPU to GPU, the tgt address seems to pair
> >>> the NPU with a specific GPU, they're not simply a fungible set of NPUs
> >>> and GPUs.  Is that association explicit anywhere or is it related to
> >>> the topology or device numbering that needs to match between the host
> >>> and guest?  Thanks,
> >>
> >> It is in the device tree (phandle is a node ID).
> >=20
> > Hrm.  But the device tree just publishes information about the
> > hardware.  What's the device tree value actually exposing here?
> >=20
> > Is there an inherent hardware connection between one NPU and one GPU?
> > Or is there just an arbitrary assignment performed by the firmware
> > which it then exposed to the device tree?
>=20
> I am not sure I understood the question...
>=20
> The ibm,gpu and ibm,npu values  (which are phandles) of NPUs and GPUs
> represent physical wiring.

So you're saying there is specific physical wiring between one
particular NPU and one particular GPU?  And the device tree properties
describe that wiring?

I think what Alex and I are both trying to determine is if the binding
of NPUs to GPUs is as a result of physical wiring constraints, or just
a firmware imposed convention.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvpAEwACgkQbDjKyiDZ
s5IA/hAAiUkYkdyqtcPHdDyKHIApvK6/7rjVHGO/IjxMWNT8gAc3yvUDgGK7GFWe
jIj4VGCwjBg8Q51P6Bn3maz1q9/BvgTDhRICAqfyoB71hewP3j38rzLZJV1BoYmr
P0tRxVeg3/F3pozjgr9hbyskvb0FYz5uMDJwaP7AH+9e0fhSDltoXlBEnBy5rUXa
MB6dGEVYjdA19BLGJGhLOgTYojrakHA3YmJ8uxA1qoNoMjNzrqSL5g73v29CNL7c
ia44CRYcPpfpBe6rLZs+SDCFX8ytqohonTiXoxmJLkQcEgKWJxxqH34JFaColERm
UNfLC9Vv3GkRD2OzMt+klutHCb1HCa2d+zVqul2NYWUxyOZDvd49JuGl9kKjSOrO
qh0i1MyFPL/uYf/ry/GhuKDha9/CqupPVfoUBa2n4mfv0Oyno8nFyElZq6Te5YP8
38DOqxhZMYbIL5nMsMx8Oq92oiI/uJtarJkC2sHuc6oJFTKknKe63C5a0zteE3Su
wSydyHr1Q3OTZQTmKJ4/fZCQhfiPMMsuQOT0Smc7nGFQst9yeHdVk6AF0EfZ9tlg
FQjQuSGYyG6KO7YRMB+ck733ZXGEq5k3aD9jZ3+lUUa+Ee7ZXMWOICmPSQRhVat8
pXnR/EJ9kxecSshRybEafEW2L3sJj77o1bRIXjF+tuLHtN+etaw=
=s0NA
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
