Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 4C2CCDDF2A
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 01:21:05 +1100 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 3147257AD
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 15:21:02 +0100 (CET)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 1164C579D
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 15:21:02 +0100 (CET)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Trouble with SCC UART ports when moving from ppc to powerpc
Date: Fri, 7 Mar 2008 15:20:55 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1895092.sp5X23Gbpd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803071521.00383.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1895092.sp5X23Gbpd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I'm trying to move from ARCH=3Dppc to ARCH=3Dpowerpc on an MPC8272 based bo=
ard.

I updated my bootloader (U-Boot) to get FDT support, wrote a device tree an=
d=20
compiled a powerpc kernel with CONFIG_PPC_CPM_NEW_BINDING set. No problem s=
o=20
far (well, no problem I haven't been able to solve).

I then tried to get the serial console on SCC1 to work. The serial port was=
=20
silent, and the kernel hanged in cpm_uart_console_write while waiting for t=
he=20
CPM to clear the ready bit in tx buffer descriptors.

After checking the SCC1 configuration registers, parameter RAM and buffer=20
descriptors, I found out that something was overwriting the buffer=20
descriptors were stored in the DPRAM at offset 0.

Right after initializing the rx buffer descriptors, dumping the rx bds dpra=
m=20
with the BDI2000 gave me

90000088 003518e0 90000008 00351900
90000000 00351911 b5400000 2dace564

while I was expecting

90000088 003518e0 90000008 00351900
90000000 00351920 b0000000 00351940

Some data was clearly being overwritten by something.

The CPM dual port ram was defined in the device tree as follows (copied fro=
m=20
the MPC8272ADS board device tree).

        muram@0 {
                #address-cells =3D <1>;
                #size-cells =3D <1>;
                ranges =3D <0 0 10000>;

                data@0 {
                        compatible =3D "fsl,cpm-muram-data";
                        reg =3D <0 2000 9800 800>;
                };
        };

Changing the reg property to

reg =3D <80 1f80 9800 800>;

fixed my problem.

Does anyone have any clue regarding what could write to the dpram ? I thoug=
ht=20
about some CPM peripheral set up by the boot loader, but my board=20
initialization code calls cpm2_reset() long before initializing SCC1.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1895092.sp5X23Gbpd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH0U9M8y9gWxC9vpcRAmzhAJ40EXMFB3MKze1AR5Kj6eEstQsoZACg3LxE
HfGSKLAFN9rkOjBvvwIbgAQ=
=ihWJ
-----END PGP SIGNATURE-----

--nextPart1895092.sp5X23Gbpd--
