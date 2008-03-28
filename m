Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id CB02CDE0C2
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 04:54:33 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCHv2 2/3] ep8248e: Reference SMC parameter RAM base in the
	device tree.
Date: Fri, 28 Mar 2008 18:54:25 +0100
References: <200803261217.46671.laurentp@cse-semaphore.com>
	<200803281726.47566.laurentp@cse-semaphore.com>
	<47ED26BE.2080507@freescale.com>
In-Reply-To: <47ED26BE.2080507@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3051985.H0C0pMzI5O";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803281854.28595.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart3051985.H0C0pMzI5O
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 28 March 2008 18:11, Scott Wood wrote:
> Laurent Pinchart wrote:
> > Locating the end of the muram isn't as straightforward as it could be. =
As
> > the current code already uses the beginning of the muram to store the B=
Ds
> > and data buffers, should I really bother locating the end or can I store
> > the SMC parameter ram at the beginning as well ?
>=20
> Maybe, but the end would be safer.  What's the problem with finding the=20
> end?

That requires manual parsing of all the cells in the reg property. The=20
device-tree API doesn't provide a way to get the length of a property, so=20
I'll have to use a big enough pre-allocated buffer. I'm also not sure if=20
resources are guaranteed to be sorted in increasing order.

This doesn't make finding the end of the muram really difficult. I was just=
=20
wondering if the increased code complexity was worth it, especially seeing=
=20
how the cpm_serial code in the boot wrapper seem quite unstable.

I'm not familiar with the boot wrapper code so I'm sometimes not very=20
confident in my assumptions, but isn't the handling of the virtual-reg=20
property in cpm_console_init broken ?

        void *reg_virt[2];

	...

        n =3D getprop(devp, "virtual-reg", reg_virt, sizeof(reg_virt));
        if (n < (int)sizeof(reg_virt)) {
                for (n =3D 0; n < 2; n++) {
                        if (!dt_xlate_reg(devp, n, &reg_phys, NULL))
                                return -1;

                        reg_virt[n] =3D (void *)reg_phys;
                }
        }

        if (is_smc)
                smc =3D reg_virt[0];
        else
                scc =3D reg_virt[0];

        param =3D reg_virt[1];

If I'm not mistaken, getprop will return the address and size of the first=
=20
resource and not the addresses of the first two resources. What is=20
virtual-reg used for ? To report the virtual address without requiring a=20
device tree walk ? Does it provide any information that dt_xlate_reg can't=
=20
find ?

> Even the end of the first reg resource would be OK.=20

If I use the end of the first resource, can I assume it spans 0x0000 - 0x80=
00=20
to set the default tx BD address in Kconfig ?

> > If I'm not mistaken, once the SMC parameter ram gets relocated to the=20
> > beginning/end of the muram, the boot loader preallocated space can be=20
> > reclaimed and can be added to the muram in the device tree like I did in
> > my previous patch. Is that correct ?
>=20
> Yes.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart3051985.H0C0pMzI5O
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH7TDU8y9gWxC9vpcRAsWVAKC+otJRjJeqpB8LkseR2SGdu2giaQCghavb
s8vHsU5k2P/Yqfq7/3YoMiA=
=PkWz
-----END PGP SIGNATURE-----

--nextPart3051985.H0C0pMzI5O--
