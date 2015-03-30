Return-Path: <dja@axtens.net>
Received: from mail-pd0-x229.google.com (mail-pd0-x229.google.com
 [IPv6:2607:f8b0:400e:c02::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4346D1A0272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 10:57:38 +1100 (AEDT)
Received: by pddn5 with SMTP id n5so1450157pdd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 16:57:36 -0700 (PDT)
Message-ID: <1427759862.11226.21.camel@axtens.net>
Subject: Re: [PATCH 04/27] powerpc/fsl_pci: Don't change ppc_swiotlb_enable
 after swiotlb_subsys_init
From: Daniel Axtens <dja@axtens.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 31 Mar 2015 10:57:42 +1100
In-Reply-To: <20150330123215.A276C14015A@ozlabs.org>
References: <20150330123215.A276C14015A@ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-AsYgAPfy9Id1E7S5uyg9"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-AsYgAPfy9Id1E7S5uyg9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


> Hmm, I think we got this wrong. I don't remember exactly but it was proba=
bly me
> who told you it could be removed, but I probably hadn't had a coffee yet =
:}
>=20
> I see setup_pci_atmu() called by fsl_pci_syscore_do_resume(), ie. at runt=
ime =3D=3D
> late. So ignore that.
>=20
> But also fsl_add_bridge(), called from fsl_pci_probe(), which is a platfo=
rm
> driver, registered at arch initcall via fsl_pci_init().
>=20
> arch initcall happens *before* subsys, so in that case this will be effec=
tive.
>=20
> So I think we need to leave it alone.
>=20
OK, yeah you're right. Darn.

It looks like we can keep the general approach here, but drop this patch
and the rename patch. Then if we move the swiotlb hooks to the end of
fsl_add_bridge, everything should happen in the right order.

I'll get that into v2.

Thanks for the detailed checking!

-- d

> cheers


--=-AsYgAPfy9Id1E7S5uyg9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCAAGBQJVGeL2AAoJEPC3R3P2I92Fj3oP+gNxJN8exQppt19YZFPlwBo1
nCSAHZfhSLmik4bPxJB4DR0TXG6Xd8nunIGUYq/GIWTwpSNXUMHMgWXKWq660ohL
uDmYh+EQwnunEdMur1jgabSATtJ7K395BfO5svvSCIC0BPYe1NfSF6qfiCxrP+UV
08pKpBkmol9pp9QtPCzWPJYbRP+hEC6Ks5PeHBPzAzzd8bZ2r/io5UQr30wbJugs
HX9JDBVTrZ1kB7RPWPno4hivuIL06O+QQsKqzbBqNIbzJcmAm7dK6PHVLS3r+zqJ
7uX6vybTQiR/uo+FPWAGumoC3WS+hGbZCIEeqlJI6eguGeRj9d0cj2wj5+KL1sGp
93EW1k8egnQhkJU0Spm3sajz4wZeaqciIq2kh+9ZFiaoCtJpadNS5JsTkBYZglTM
g3uh2cAjbJHA3p+rgeJzZ5cH4Lyz0XeWi6ipQF2K/lDFFQxW+m93QbDYLnFILKYf
RJQhpQ4XWq8fDcPQxl78JjmmTZbzb8DlFvEBinOvlS5GNQdFsPQsOVNUmGV/rPib
mlQG049ZeA1TFdtLh1GQsZf1lFfcHoAyyDu9l3KiaAWMcJxyaOW6SZ1iRc25Er/x
JVIuWzjbrIjNasHO4quvugIOgzYvhbFd29b21/tB9hME0SLAWt3hdTVisLHnmwKg
r4aAez1AKQWQUp6Oz046
=8slW
-----END PGP SIGNATURE-----

--=-AsYgAPfy9Id1E7S5uyg9--
