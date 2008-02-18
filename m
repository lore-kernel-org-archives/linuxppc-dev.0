Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 7D01ADDED9
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 23:43:09 +1100 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id CC09737B1
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 13:44:05 +0100 (CET)
Received: from pclaurent.technotrade.biz (pclaurent.technotrade.biz
	[192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id AEA9E3723
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Feb 2008 13:44:05 +0100 (CET)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: How to describe FPGA-based devices in the device tree ?
Date: Mon, 18 Feb 2008 13:43:52 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1876216.z91CmVQhpn";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802181343.54989.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1876216.z91CmVQhpn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I'm (at last) trying to move from ARCH=3Dppc to ARCH=3Dpowerpc. After readi=
ng=20
Documentation/powerpc/booting-without-of.txt and various device trees in=20
arch/powerpc/boot/dts, I still don't know how to express some devices in th=
e=20
device tree.

The target board has several devices on the processor local bus, as describ=
ed=20
in the following device tree fragment.

        localbus@f0010100 {
                compatible =3D "fsl,mpc8260-localbus",
                             "fsl,pq2-localbus";
                #address-cells =3D <2>;
                #size-cells =3D <1>;
                reg =3D <f0010100 60>;

                ranges =3D <0 0 40000000 01000000
                          2 0 f2000000 00100000
                          3 0 f3000000 00100000
                          4 0 f4000000 00100000>;

                flash@0,0 {
                        compatible =3D "cfi-flash";
                        reg =3D <0 0 01000000>;
                        bank-width =3D <2>;
                };

                nvram@2,0 {
                        compatible =3D "mtd-ram";
                        reg =3D <2 0 00100000>;
                        bank-width =3D <2>;
                };

                bcsr@3,0 {
                        device_type =3D "board-control";
                        reg =3D <3 0 00000020>;
                };

                fpga@4,0 {
                        reg =3D <4 0 00010000>;
                };
        };

The fourth device is a FPGA that contains several IP cores such as an=20
interrupt controller and a SD/MMC host controller. If I understand things=20
correctly, each IP core should have its own node in the device tree to allo=
w=20
proper binding with device drivers. As booting-without-of.txt describes the=
=20
localbus node ranges as corresponding to a single chipselect and covering t=
he=20
entire chipselect access window, I can't have nodes for each IP core as=20
children of the localbus node.

Should I put IP core nodes as children of the FPGA node ? If so, how do I m=
ap=20
addresses at the FPGA level ? A ranges property in the FPGA node would let =
me=20
map addresses in the FPGA scope to the localbus scope. However, as the=20
localbus scope use the chipselect number as its first address cell and 0 as=
=20
its second address cell, I don't see how I could translate offsets in the=20
=46PGA into an address at the localbus scope.

Could anyone advice me regarding how to properly describe my hardware in th=
e=20
device tree ?

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1876216.z91CmVQhpn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHuX2K8y9gWxC9vpcRAoyNAJwKSDlkkx5bOHY3b/qTjIyzQQx/rQCeLoi0
+CXSZRn21qbIw4MKcmUj2oc=
=D9g7
-----END PGP SIGNATURE-----

--nextPart1876216.z91CmVQhpn--
