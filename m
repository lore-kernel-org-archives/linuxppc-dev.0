Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id B93D1DDED5
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 18:52:56 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: CPM2 mii-bitbang: Allowing mdio on port pins other than port C
Date: Mon, 16 Jun 2008 10:52:53 +0200
References: <49B96DF39F2CDD499DA8B9C7753A060D2275FC@stamp.senetas.com>
In-Reply-To: <49B96DF39F2CDD499DA8B9C7753A060D2275FC@stamp.senetas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1531777.k9iCzBvR69";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806161052.53268.laurentp@cse-semaphore.com>
Cc: Mark Ware <mark.ware@senetas.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1531777.k9iCzBvR69
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Mark,

On Monday 16 June 2008 08:19, Mark Ware wrote:
> Hello,
>=20
> I am preparing a board port (from 2.4.18!) for a proprietary board which
> has it's mdio on a different port than mdc.  The current mii-bitbang
> driver in fs_enet assumes both pins are connected to port C.  I have
> created a fairly simple patch to make this more flexible, but I'm new to
> device trees and am unsure how best to describe the situation in the
> dts.
>=20
> The current mdio node for CPM2 looks something like:
>=20
> mdio@10d40 {
>   device_type =3D "mdio";
>   compatible =3D "fsl,cpm2-mdio-bitbang";
>   #address-cells =3D <1>;
>   #size-cells =3D <0>
>   reg =3D <0x10d40 0x14>;
>   fsl,mdio-pin =3D <12>;
>   fsl,mdc-pin =3D <15>;
> }
>=20
> I have made mdio work on our board by adding a second reg range and
> using the first one for mdc and the second one for mdio:=20
>=20
>   reg =3D <0x10d40 0x14 0x10d60 0x14>;  // mdc=3Dport D, mdio=3Dport A
>   fsl,mdio-pin =3D <12>;    		  // PD12
>   fsl,mdc-pin =3D <15>;     		  // PC15
>=20
> The code remains backwards compatible, in that if only one reg range is
> present it is used for both.
>=20
> Is this a valid (and acceptable) way to extend the reg property?

It is. Sergej Stepanov submitted similar patches some times ago. You can fi=
nd=20
them at

http://www.spinics.net/lists/netdev/msg45778.html
http://www.spinics.net/lists/netdev/msg47159.html

> Is their a cleaner way I should look at?

Using the GPIO lib might be cleaner. Have a look at=20
http://www.nabble.com/-PATCH-0-2--MDIO-on-GPIO-support-for-the-fs_enet-driv=
er-ts17468958.html=20
for a patch.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1531777.k9iCzBvR69
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIVinl8y9gWxC9vpcRAqzsAKCKdkILbKdTREbGGimZLE6FoefAUgCdF9JH
S0846ukbuCa/wGEH3LLC2F8=
=OzDW
-----END PGP SIGNATURE-----

--nextPart1531777.k9iCzBvR69--
