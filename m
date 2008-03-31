Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id C83E7DE139
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 02:43:51 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHv3 3/4] ep8248e: Reference SMC parameter RAM base in the device
	tree.
Date: Mon, 31 Mar 2008 18:37:03 +0200
References: <200803311834.42327.laurentp@cse-semaphore.com>
In-Reply-To: <200803311834.42327.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2468007.ELHC1abLqj";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803311837.03692.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2468007.ELHC1abLqj
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch modifies the Embedded Planet EP8248E device tree to reference the
SMC paramater RAM base register instead of the parameter RAM allocated by t=
he
boot loader.

The cpm_uart driver will allocate parameter RAM itself, making the serial p=
ort
initialisation independent of the boot loader.

The patch adds the parameter RAM allocated by the boot loader in the CPM mu=
ram
node, making it available to the kernel.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 arch/powerpc/boot/dts/ep8248e.dts |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/ep8248e.dts b/arch/powerpc/boot/dts/ep82=
48e.dts
index 5d2fb76..756758f 100644
=2D-- a/arch/powerpc/boot/dts/ep8248e.dts
+++ b/arch/powerpc/boot/dts/ep8248e.dts
@@ -121,8 +121,7 @@
=20
 				data@0 {
 					compatible =3D "fsl,cpm-muram-data";
=2D					reg =3D <0 0x1100 0x1140
=2D					       0xec0 0x9800 0x800>;
+					reg =3D <0 0x2000 0x9800 0x800>;
 				};
 			};
=20
@@ -138,7 +137,7 @@
 				device_type =3D "serial";
 				compatible =3D "fsl,mpc8248-smc-uart",
 				             "fsl,cpm2-smc-uart";
=2D				reg =3D <0x11a80 0x20 0x1100 0x40>;
+				reg =3D <0x11a80 0x20 0x87fc 2>;
 				interrupts =3D <4 8>;
 				interrupt-parent =3D <&PIC>;
 				fsl,cpm-brg =3D <7>;
=2D-=20
1.5.0


=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2468007.ELHC1abLqj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH8RMv8y9gWxC9vpcRAq8TAKCfD0r8/xsc5Ip22nA629jPmEqvUQCg4bOj
pYdhYHT+GrgPdWhbAPGZtvo=
=box2
-----END PGP SIGNATURE-----

--nextPart2468007.ELHC1abLqj--
