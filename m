Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9237667A3F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 22:06:10 +1000 (EST)
Subject: PowerMac7,3 sound (was: PowerBook5,4 -- no sound?)
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1145307118.3912.11.camel@localhost.localdomain>
References: <878xq51t61.fsf@briny.internal.ondioline.org>
	<je1wvxo70l.fsf@sykes.suse.de>
	<1145220233.9833.11.camel@localhost.localdomain>
	<je7j5phz9j.fsf@sykes.suse.de>
	<1145231658.9833.17.camel@localhost.localdomain>
	<je3bgdhwre.fsf@sykes.suse.de>
	<1145233812.9833.21.camel@localhost.localdomain>
	<je1wvwfh7s.fsf@sykes.suse.de>
	<1145307118.3912.11.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uHPh8IJcjE1Aros/asIs"
Date: Wed, 17 May 2006 12:34:32 +0200
Message-Id: <1147862072.14395.25.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-uHPh8IJcjE1Aros/asIs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > request_mem_region(80000000 - 80000fff, i2sbus control)
> >=20
> >       80000000-8007ffff : 0.80000000:mac-io
> >         8000002c-8000002f : 0.0000004c:fans
> >         80000030-80000033 : 0.0000004c:fans
> >         80000034-80000037 : 0.0000004c:fans
> >         8000004c-8000004f : 0.0000004c:fans
> >         80000050-8000008a : 0.00000050:gpio

> Look like the bugs in the device-tree I told you about ...

Ben, is it safe to just hardcode 0x80010000-0x80010fff? Or hardcode
0x10000-0x10fff and have it do the translation depending on the
device-tree node, iow assume that the 'reg' property is bogus and
essentially replace it with one that contains the values
  0x00010000 0x00001000 (buggy one seems to be 0x00000000 0x00001000)
  0x00008000 0x00000100
  0x00008100 0x00000100
and then go from there? Even then though, I have no idea how to do the
ranges translation for the node. Maybe we should just fix up the reg
property in the device-tree for the affected machine(s)?

Btw, it doesn't look like snd-powermac handles this correctly, it only
ever handles the rx/tx specially and also takes the control io area
straight from the device tree.

Andreas, you'll probably be able to get a bit further by inserting the
following code in front of the loop in i2sbus-core.c line 162, and
removing the of_address_to_resource call inside the loop.

  dev->resources[0].start =3D 0x80010000;
  dev->resources[0].end   =3D 0x80010fff;
  dev->resources[1].start =3D 0x80008000;
  dev->resources[1].end   =3D 0x800080ff;
  dev->resources[2].start =3D 0x80008100;
  dev->resources[2].end   =3D 0x800081ff;

But I'm not sure that is correct on all machines (in fact, I'm not
perfectly sure it is correct on your machine).

After that, you'll probably still not have usable sound though because I
know nothing about the layout-id of your machine. If I have support for
your codec already, that should be easy though.

johannes

--=-uHPh8IJcjE1Aros/asIs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGr8NqVg1VMiehFYAQJTPQ//aZH34PLLNcXZ21jqscy8DclWWlMtZz56
0++WtaQtfG3E9a9sXVM0RHuNy1fCPYgpR8wdgnDqwxhbozTT0PNt6B/Yj/7l3DXV
EoOJxzJJmGT1duO6RldzPTr9av9PK2sZyoZ9DebpKsTcLi0a+tr9WPdseMF/4u2N
tgcA0+xPhf8/Y7z0N1qoRlQwsKs0THv5I8fSnIEpbtbFpWzfE5rg50nrKbjeHFIH
DckLH9eDFX7+f2MUQEu33MgyZKcJziCNpjeLFSR5zb2gxRWR2x8qGFlB2FVRxFT+
wdYtj/Lh/EnfXsnICgvewGdn5scAVt5cUeyH7p39MC5Hi+Y3wMOhdGW92EVQ95cu
2iGYp3+nU+ke8jWq2fsDGYhz7WMOZM9aValgFBJ0X92+ftR5zvWfMzU79h3JRhmh
sgJJPK5xibqXGadPddXucJ5WgETrmZLcfkQ7/hpmVA/8kR/STKz5DLM9Fk7Oz+74
gayQ/7jc1gYVqTGI+vcMt8DKzZ3iQGsZv3+htEKzT3ybetZf6eLmaXDdV2PD7cPW
r3eiAm8/3qKTGktivmQfuXgFqjzu37jAl/bP4tB9Dj3RUjBxybBRqrKUrFQipFp6
NQRbpbgUsP+IbDPMjdeoiz0jXHPfpbOgyAZv9m5jexIFvrpnYFhoj+sfPaZiKlRr
THp9pDtMOyQ=
=sBEn
-----END PGP SIGNATURE-----

--=-uHPh8IJcjE1Aros/asIs--
