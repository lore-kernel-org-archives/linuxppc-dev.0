Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id B79F0DE0C3
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 05:14:30 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: "Rune Torgersen" <runet@innovsys.com>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Tue, 25 Mar 2008 19:14:20 +0100
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251823.32039.laurentp@cse-semaphore.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0427706A@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0427706A@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1972833.p6L5KqdjO2";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803251914.24021.laurentp@cse-semaphore.com>
Cc: ben@simtec.co.uk, David Gibson <david@gibson.dropbear.id.au>,
	linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1972833.p6L5KqdjO2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 25 March 2008 18:56, Rune Torgersen wrote:
> Laurent Pinchart wrote:
> > On Tuesday 25 March 2008 18:02, Sergei Shtylyov wrote:
> >> Laurent Pinchart wrote:
> >>=20
> > Regarding non-volatility nothing prevents a user from using a=20
> > volatile RAM as an MTD device, but there's little point in doing so.
> > Would it be acceptable for the "linear-nvram" specification
> > not to include > volatile RAM ? ROM chips would be excluded too. Is
> that an issue ?
>=20
> We actually use a volatile ram (SRAM) as an MTD device. We use it to
> store info from bootloader and system specific values between resets.

So we're left with two main options.

=2D Reusing the nvram device type from the Device Support Extensions. Volat=
ile=20
devices wouldn't be supported, and we'd need a separate device specificatio=
n=20
for linear-mapped volatile RAMs. I'm not very happy with that.

=2D Using another device node with a compatible value set to "linear-ram" (=
or=20
something similar). This would support both volatile and non-volatile=20
devices, and a property could be added to specify if the device is volatile=
=20
or not.

I'd go for the second option, and I'd specify a "linear-rom" compatible val=
ue=20
as well while we're at it.

Both volatile and non-volatile RAMs can be handled by the physmap_of MTD=20
driver. They both use the same map probe type ("map_ram"). Volatility isn't=
=20
handled there.

ROMs should be handled by the same driver and should use the "mtd_rom" map=
=20
probe type.

As all those devices use the physmap_of MTD driver, what about=20
using "physmap-ram" and "physmap-rom" as compatibility names ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1972833.p6L5KqdjO2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH6UEA8y9gWxC9vpcRAnAdAKCl+R9yUIF3XoE+NEyaD1HywCpcBQCePN+j
0QtPBwPn8tCK7C2F4CBt8Is=
=aT37
-----END PGP SIGNATURE-----

--nextPart1972833.p6L5KqdjO2--
