Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] [POWERPC] Support setting affinity for U3/U4 MSI sources
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070917201229.GA17302@lixom.net>
References: <20070917201229.GA17302@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-oidK/03CWAWGrQqZzvrb"
Date: Thu, 20 Sep 2007 16:36:06 +1000
Message-Id: <1190270166.30289.12.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-oidK/03CWAWGrQqZzvrb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-09-17 at 15:12 -0500, Olof Johansson wrote:
> Hook up affinity-setting for U3/U4 MSI interrupt sources.
>=20
> Tested on Quad G5 with myri10ge.

And a JS21 blade:

# echo 1 > /proc/irq/21/smp_affinity=20
# cat /proc/interrupts=20
           CPU0       CPU1      =20
 21:        126        375  MPIC-U3MSI Edge      eth1
# ping -c 1000 -f cradle
1000 packets transmitted, 1000 received, 0% packet loss, time 135ms
# cat /proc/interrupts=20
           CPU0       CPU1      =20
 21:       2153        375  MPIC-U3MSI Edge      eth1
# echo 2 > /proc/irq/21/smp_affinity=20
# cat /proc/interrupts=20
           CPU0       CPU1      =20
 21:       2174        379  MPIC-U3MSI Edge      eth1
# ping -c 1000 -f cradle
1000 packets transmitted, 1000 received, 0% packet loss, time 138ms
# cat /proc/interrupts=20
           CPU0       CPU1      =20
 21:       2174       2389  MPIC-U3MSI Edge      eth1


Acked-by: Michael Ellerman <michael@ellerman.id.au>

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-oidK/03CWAWGrQqZzvrb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG8hTWdSjSd0sB4dIRAtJ2AKCvYuhNbQEfPdhOiox0vD1d4LPJbwCdEyJc
ITjmjYq+scRUUOMNY4/5fCg=
=Xy3G
-----END PGP SIGNATURE-----

--=-oidK/03CWAWGrQqZzvrb--
