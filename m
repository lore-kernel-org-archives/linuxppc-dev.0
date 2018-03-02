Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zswhJ3f9mzF16w
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Mar 2018 15:05:52 +1100 (AEDT)
Date: Fri, 2 Mar 2018 13:21:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata.rao@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Hotplug + Reboot is crashing HPT guest with HPT resizing enabled
Message-ID: <20180302022144.GG13135@umbus.fritz.box>
References: <CAGZKiBoy5kZxijbGg0VaRr_HbgPyoHS-UnkXyhHt15sCpcT4ow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HKEL+t8MFpg/ASTE"
In-Reply-To: <CAGZKiBoy5kZxijbGg0VaRr_HbgPyoHS-UnkXyhHt15sCpcT4ow@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--HKEL+t8MFpg/ASTE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 03:02:40PM +0530, Bharata B Rao wrote:
> Hi,
>=20
> Rebooting a hash guest after hotplugging memory to it is crashing the
> guest. This is seen only when HPT resizing is enabled. I see guest crashi=
ng
> at multiple places, but this location is fairly commonly seen:
>=20
> kernel BUG at mm/slub.c:3912!
>=20
> Testing with latest guest kernel and ppc-for-2.12 branch of QEMU.

Ugh.  We had several bugs along these lines, but I thought I'd fixed
them.  I wonder what this one is.

> A bit of debugging shows me that when memory is added, the guest kernel
> tries to resize HPT to a htab_shift value lesser than the value with which
> the guest has booted. For eg. a 8GB guest boots with htab_shift of 26. Wh=
en
> 1G is hot-added,
> arch/powerpc/mm/hash_utils_64.c:resize_hpt_for_hotplug() ends up assigning
> 24 to target_hpt_shift. This looks suspicious as we are increasing the
> memory, but kernel is asking for shrinking the HPT size.

So the shrink-HPT-on-add-memory is actually expected and should be
harmless.  It occurs because qemu estimates HPT size on the
traditional HPT =3D=3D RAM size / 64 formular, which was devised with 4k
pages in mind.  The kernel on the other hand, knows it is using 64k
pages and so estimates a smaller HPT size.  Hot plugging memory always
prompts the guest to re-estimate the required HPT size, but if the
added memory is small enough, that size can still be smaller than
qemu's initial guess.

> HPT resizing
> requests fail though, but next reboot crashes the guest.

As noted the shrink is expected, so we need to debug the crash
separately.  Do you have 9478956794c11239b7c1c3ef9ce95c883bb839a3 in
your tree?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HKEL+t8MFpg/ASTE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqYtTYACgkQbDjKyiDZ
s5Jc3RAAmzoaHsMSdJkrpnT64gKY43pcs9j61/DVxdwyzzyifev0mNdUdS2n9CBA
0YdSbSysPKDDZaE2+2gzh758aoLV54/9pLHy453PIJs3pD2Y5G/1nC8GVJyeFOJK
EKfomVXp67AestFni3MMoH3OfyOQP6mOan+lfAuVSNefh7u8qLPrT6csped/eFYH
vFiyA4eMMRxKojm1soOi+xzMQT2cwr7F7gjOhLCYmIrssw5x03LROaJv6FZcUh0s
xgHlMBXe4zbwDzSt6RiodCzqxcc0cSNpsAmOUMhyVBJBdJBbaBIDs9zMtocPOSpb
eFzSNjSIyFsWjL1oq5j/wVWh2zYg0vDQZgHmecZz6iBznLqcp2T1HtRxVCobbjuA
QwSn5EX5QRU5pK2dK4t4ogTCWhdTMYsDCQgPAqPLMfd+zLhbM0hRJOsqyQ/wG0nl
M8ddpcIQLlMJvcQdjWNxenUgDIGDXf25FKB1xOYVOCPaAFcV9n3eA4zs77xXxsh2
3UKFLb2dsZRPbaSwtXG8oL0bCmonuxw7CGMzByzmU/0thwOxEORdtoSFhuJaw4G3
m7gKujJwyH53LUpxjVbJwofAJ8834oW1crkEe59G8leJg4gmEMdazgEWTd10CpUK
SOuqIaLCocOnQqpKikBHb58Ly6CjsVNFaxcUkuJkXJgiPO1VTW4=
=QIhj
-----END PGP SIGNATURE-----

--HKEL+t8MFpg/ASTE--
