Return-Path: <dja@axtens.net>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 653BE1A0729
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 11:58:30 +1000 (AEST)
Received: by pacan13 with SMTP id an13so62141599pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 18:58:28 -0700 (PDT)
Message-ID: <1438048591.26043.11.camel@axtens.net>
Subject: Re: eeh-powernv.c: Unbalanced IRQ warning
From: Daniel Axtens <dja@axtens.net>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 28 Jul 2015 11:56:31 +1000
In-Reply-To: <20150728012832.GA26199@gwshan>
References: <1437982623.6262.56.camel@axtens.net>
 <2661799.peC5JiyMCl@mexican> <20150728012832.GA26199@gwshan>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-iHrTjr4Is7TEle5Cg9rM"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-iHrTjr4Is7TEle5Cg9rM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alistair and Gavin,

The patch from Alistair fixes my issue. Thanks heaps!

Alistair, are you right to post that formally?

Regards,
Daniel

On Tue, 2015-07-28 at 11:28 +1000, Gavin Shan wrote:
> On Tue, Jul 28, 2015 at 11:14:51AM +1000, Alistair Popple wrote:
> >Hi Daniel,
> >
> >I see the problem - pnv_eeh_next_error() re-enables the interrupt but it=
 gets=20
> >called from a loop if there are more outstanding events to process. The =
most=20
> >obvious solution would be to do this check before enabling interrupts:
> >
> >        if (ret =3D=3D EEH_NEXT_ERR_NONE && eeh_enabled())
> >
> >instead of:
> >
> >        if (eeh_enabled())
> >
> >This should work fine so long as pnv_eeh_next_error() is called continuo=
usly=20
> >until is returns either EEH_NEXT_ERR_NONE or another value which signals=
 that=20
> >pnv_eeh_next_error() should never be called again. As far as I can tell =
this=20
> >looks to be true (perhaps Gavin can confirm?)
> >
>=20
> Yeah, I confirmed. The way that Alistair fixes the issue is simple and mo=
re
> precise. Please try his fix and ignore the one I sent couple of minutes
> before.
>=20
> Thanks,
> Gavin
>=20
> >Would you mind trying the below patch and seeing if it fixes the problem=
?=20
> >Thanks!
> >
> >-- >8 --
> >>From 6eeed1d6dd25e8cf6bfe3423dc50ff855d1cbc42 Mon Sep 17 00:00:00 2001
> >From: Alistair Popple <alistair@popple.id.au>
> >
> >---
> > arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc=
/platforms/powernv/eeh-powernv.c
> >index ca825ec..ff41c03 100644
> >--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> >+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> >@@ -1478,7 +1478,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
> > 	}
> >
> > 	/* Unmask the event */
> >-	if (eeh_enabled())
> >+	if (ret =3D=3D EEH_NEXT_ERR_NONE && eeh_enabled())
> > 		enable_irq(eeh_event_irq);
> >
> > 	return ret;
> >--=20
> >1.8.3.2
> >
> >
>=20

--=20
Regards,
Daniel

--=-iHrTjr4Is7TEle5Cg9rM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJVtuFPAAoJEPC3R3P2I92FwDsP/0ukOjXqkDrs6zNT2fziqRun
BSxY3hVogN17F6Qt7zAbAeWvhBZ1017he415JwklRsyEbXP7dZKb3poyeZuTwUCO
V6ArKdT3qlHg7PXS3hmCn9IUPlOX7C8/JjMAOZbCj/lz8HsApjtlwFkFUnPayK7/
H4bfki5bh5pUuDfcir1YPSyItWzy26c7wVEKk6GgDC49ha/x6UV2TdtX3GX5kC6e
VeqHDTwq9cVyc7c1OlEfpCJLzceCQdBq/UTl1BLE3GoAiTmfj4O67EKHaG0+6ND1
G0NBL4Xo4sYfCguVl/FSb3+7HaEvfARGFSNVXVT/z0h30iUZDbTNh6as/LwnV7fS
kK5InPKX+pfs5Kxkpk4OIk701/Dd1JFGpS1wYb1HmEUQ2E2wVMEIoZjilRYG0Rwh
dwRGemk5qn4tJ/dI15wqCmKCIvTubfWhpdWTw7DfaO+wR58RRE4yklsqap7HtP1b
S3x1zbv1W68WaY/nz7x15ul25in6YGQSc5YnvKQjxntAfRZiPz1lKR4s57pypakN
Pq3y/enP/QhKYAfKWzs+vU0MpL/Yl2T5a9ActJOmaHT65T5AcPOcXtFtogkqEf5W
V78DBkbVW6m5/r6d8oZECkz6zHO7hvEMg2Sz4wVRliw17qhDMRKQ362n8EXrlI1I
7WUZUpIKsN0N3TSJJ9+J
=oGzE
-----END PGP SIGNATURE-----

--=-iHrTjr4Is7TEle5Cg9rM--
