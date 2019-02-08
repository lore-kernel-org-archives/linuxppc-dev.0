Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A3AC282CB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 06:31:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C3B82147C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 06:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="U20zy5kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C3B82147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wlgk1jf8zDqVW
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 17:31:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wk435K7YzDqVW
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 16:18:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="U20zy5kg"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43wk433lY1z9sP1; Fri,  8 Feb 2019 16:18:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549603123;
 bh=OnlDSgXVai4j1Wx0DoMcFM+8Dx7Mu5BEQyObjLobuvY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=U20zy5kgnhQdyHfOsbUlmQRMTN9pKDjFLcoTl4ro1ZsARkWmYGm5KehEres1LB5ee
 3RpA+IQVkkjmOOzabL7rPDkbpSqM9oNPBQXRNveVl9quXSwjdA13/qMvz/YV1ReJpj
 O5SxtdkUYuYsRUdeMm+WmWwbJf3VaV3/Q+8Cx3hA=
Date: Fri, 8 Feb 2019 16:15:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
Message-ID: <20190208051523.GD2688@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-7-clg@kaod.org>
 <20190204044531.GB1927@umbus.fritz.box>
 <69791b73-f93e-6957-92e8-5b8620b87731@kaod.org>
 <20190205052822.GE22661@umbus.fritz.box>
 <4d565738-a99b-0333-8533-037677358faa@kaod.org>
 <20190206012308.GP22661@umbus.fritz.box>
 <1745dd9f-2927-cae6-e8da-c350b0bd0a66@kaod.org>
 <20190207024950.GA22661@umbus.fritz.box>
 <d20bbaca-5b49-66e4-9d99-21d991c2c345@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline
In-Reply-To: <d20bbaca-5b49-66e4-9d99-21d991c2c345@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 10:03:15AM +0100, C=E9dric Le Goater wrote:
> On 2/7/19 3:49 AM, David Gibson wrote:
> > On Wed, Feb 06, 2019 at 08:21:10AM +0100, C=E9dric Le Goater wrote:
> >> On 2/6/19 2:23 AM, David Gibson wrote:
> >>> On Tue, Feb 05, 2019 at 01:55:40PM +0100, C=E9dric Le Goater wrote:
> >>>> On 2/5/19 6:28 AM, David Gibson wrote:
> >>>>> On Mon, Feb 04, 2019 at 12:30:39PM +0100, C=E9dric Le Goater wrote:
> >>>>>> On 2/4/19 5:45 AM, David Gibson wrote:
> >>>>>>> On Mon, Jan 07, 2019 at 07:43:18PM +0100, C=E9dric Le Goater wrot=
e:
> >>>>>>>> This will let the guest create a memory mapping to expose the ES=
B MMIO
> >>>>>>>> regions used to control the interrupt sources, to trigger events=
, to
> >>>>>>>> EOI or to turn off the sources.
> >>>>>>>>
> >>>>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>>>> ---
> >>>>>>>>  arch/powerpc/include/uapi/asm/kvm.h   |  4 ++
> >>>>>>>>  arch/powerpc/kvm/book3s_xive_native.c | 97 ++++++++++++++++++++=
+++++++
> >>>>>>>>  2 files changed, 101 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/=
include/uapi/asm/kvm.h
> >>>>>>>> index 8c876c166ef2..6bb61ba141c2 100644
> >>>>>>>> --- a/arch/powerpc/include/uapi/asm/kvm.h
> >>>>>>>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >>>>>>>> @@ -675,4 +675,8 @@ struct kvm_ppc_cpu_char {
> >>>>>>>>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
> >>>>>>>>  #define  KVM_XICS_QUEUED		(1ULL << 44)
> >>>>>>>> =20
> >>>>>>>> +/* POWER9 XIVE Native Interrupt Controller */
> >>>>>>>> +#define KVM_DEV_XIVE_GRP_CTRL		1
> >>>>>>>> +#define   KVM_DEV_XIVE_GET_ESB_FD	1
> >>>>>>>
> >>>>>>> Introducing a new FD for ESB and TIMA seems overkill.  Can't you =
get
> >>>>>>> to both with an mmap() directly on the xive device fd?  Using the
> >>>>>>> offset to distinguish which one to map, obviously.
> >>>>>>
> >>>>>> The page offset would define some sort of user API. It seems feasi=
ble.
> >>>>>> But I am not sure this would be practical in the future if we need=
 to=20
> >>>>>> tune the length.
> >>>>>
> >>>>> Um.. why not?  I mean, yes the XIVE supports rather a lot of
> >>>>> interrupts, but we have 64-bits of offset we can play with - we can
> >>>>> leave room for billions of ESB slots and still have room for billio=
ns
> >>>>> of VPs.
> >>>>
> >>>> So the first 4 pages could be the TIMA pages and then would come =20
> >>>> the pages for the interrupt ESBs. I think that we can have different=
=20
> >>>> vm_fault handler for each mapping.
> >>>
> >>> Um.. no, I'm saying you don't need to tightly pack them.  So you could
> >>> have the ESB pages at 0, the TIMA at, say offset 2^60.
> >>
> >> Well, we know that the TIMA is 4 pages wide and is "directly" related
> >> with the KVM interrupt device. So being at offset 0 seems a good idea.
> >> While the ESB segment is of a variable size depending on the number
> >> of IRQs and it can come after I think.
> >>
> >>>> I wonder how this will work out with pass-through. As Paul said in=
=20
> >>>> a previous email, it would be better to let QEMU request a new=20
> >>>> mapping to handle the ESB pages of the device being passed through.
> >>>> I guess this is not a special case, just another offset and length.
> >>>
> >>> Right, if we need multiple "chunks" of ESB pages we can given them
> >>> each their own terabyte or several.  No need to be stingy with address
> >>> space.
> >>
> >> You can not put them anywhere. They should map the same interrupt range
> >> of ESB pages, overlapping with the underlying segment of IPI ESB pages=
=2E=20
> >=20
> > I don't really follow what you're saying here.
>=20
>=20
> What we want the guest to access in terms of ESB pages is something like=
=20
> below, VMA0 being the initial mapping done by QEMU at offset 0x0, the IPI=
=20
> ESB pages being populated on the demand with the loads and the stores fro=
m=20
> the guest :
>=20
>=20
>                  0x0                   0x1100  0x1200    0x1300    =20
>      =20
>          ranges   |       CPU IPIs   .. |  VIO  | PCI LSI |  MSIs
>        	 =20
>                   +-+-+-+-+-+-+-...-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- =
=2E...
>  VMA0    IPI ESB  | | | | | | |     | | | | | | | | | | | | | | | | | |
>           pages   +-+-+-+-+-+-+-...-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- =
=2E...
>=20
>=20
>=20
> A device is passed through and the driver requests MSIs.=20
>=20
> We now want the guest to access the HW ESB pages for the requested IRQs=
=20
> but still the initial IPI ESB pages for the others. Something like below =
:=20
>=20
>=20
>                  0x0                   0x1100  0x1200    0x1300    =20
>      =20
>          ranges   |       CPU IPIs   .. |  VIO  | PCI LSI |  MSIs
>=20
>                   +-+-+-+-+-+-+-...-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- =
=2E...
>  VMA0    IPI ESB  | | | | | | |     | | | | | | | | | | | | | | | | | |
>           pages   +-+-+-+-+-+-+-...-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+- =
=2E...
>                                                                  =20
>  VMA1    PHB ESB                                          +-------+
>           pages                                           | | | | |=20
>                                                           +-------+

Right, except of course VMA0 will be split into two pieces by
performing the mmap() over it.

> The VMA1 is the result of a new mmap() being done at an offset depending =
on=20
> the first IRQ number requested by the driver.

Right... that's one way we could do it.  But the irq numbers are all
dynamically allocated here, so could we instead just put the
passthrough MSIs in a separate range?  We'd still need a separate
mmap() for them, but we wouldn't have to deal with mapping over and
unmapping if the device is removed or whatever.

> This is because the vm_fault handler uses the page offset to find the=20
> associated KVM IRQ struct containing the addresses of the EOI and trigger=
=20
> pages in the underlying hardware, which will be the PHB in case of a=20
> passthrough device. =20
>=20
> >From there, the VMA1 mmap() pointer will be used to create a 'ram device'
> memory region which will be mapped on top of the initial ESB memory regio=
n=20
> in QEMU. This will override the initial IPI ESB pages with the PHB ESB pa=
ges=20
> in the guest ESB address space.

Um.. what?  If that qemu memory range is already mapped into the guest
we don't need to create new RAM devices or anything for the
overmapping.  If we overmap in qemu that will just get carried into
the guest.

> That's the plan I have in mind as suggested by Paul if I understood it we=
ll.
> The mechanics are more complex than the patch zapping the PTEs from the V=
MA
> but it's also safer.

Well, yes, where "safer" means "has the possibility to be correct".

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxdEGsACgkQbDjKyiDZ
s5L6IRAAsuG223LaidxSVSPnjvz10pmj0U4XPSrM0hAbNPl8jMaSuV5hK0LvFeEK
/SXq5IPjz16johTOLxzb/dwC7rLskPw25ipEQiLxSZ0gEENmtMwNBpqwQ8OPwXDy
OBWRSyB/tRwiwKiPKRWd/hzsBd6GfE4D38LfFqOku1XkHK+e5TVvQe9d1I0lDRU+
3UD6gHQGjSZ+40gYlEfKoN7QgXLpDU5292iOAfGPm70umIs97+RH+DiSUxYd5fOj
fWnUUUPuJFOuoeR3a1OKhqXGID6nwNim/CajTEiERB4EFcI2m99AfXyDC8O6Hwqu
qBZNDNIZy8QwucXBslCetAPi6CTT8Y96zuk3JakYCibNR0OBpGqRQvLLGJbV+J3s
3KRxyykC7LN2p138x1eHV7iB8MvyzgsdajBK/gxMm6fVPOoptan/4Ihscnpft7nL
tdRS58679pA1YIovXqqh8VPG0hXqgbjV1SmgpTyCxkVU7jvs4urWWKkiTrD0pPRr
dpTcjWBMriKcw8vL04p8WAlTebBiG+SXrN4iFQZ3BYwMPlWRAkSEKWBuaIcW0sZE
xlXdNzaRBGtg3/dacXB8SryRCJye/HVfxIAi2Sed3tCN7lF27sfebJpl65OVuINz
qyMhvF/bs34/Uy6TPF2LIr1gVvb/34MGK6COpEmUtegicxpB0PE=
=2ooB
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
