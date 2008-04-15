Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 3E8A7DE33B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 23:32:29 +1000 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id BA78DBC28
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 15:32:27 +0200 (CEST)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id A03BB997E
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 15:32:27 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] Using two baud rate generators with the cpm_uart driver
Date: Tue, 15 Apr 2008 15:32:26 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6107132.MQacW3snp2";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804151532.27057.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart6107132.MQacW3snp2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

thanks to a bad hardware design decision, I'm faced with a software issue w=
ith=20
the cpm_uart driver.

My hardware uses either SCC4 or SMC2 (production-time option) as an RS485 p=
ort=20
with an external transceiver. The transceiver's data direction is controlle=
d=20
by external logic that monitors the SCC4/SMC2 TxD signal.

The external logic needs an input clock at the baud rate frequency on the=20
MPC8248 BRG5 output pin (although I could modify it to accept an input cloc=
k=20
at 16x the baud rate frequency). This means the cpm_uart driver has to setu=
p=20
two baud rate generators instead of one.

The ppc architecture was easy to hack as it used a fs_uart_platform_info=20
structure in which I added a set_brg function pointer provided by platform=
=20
code. This isn't possible with the powerpc architecture anymore.

Is there a clean way to fix this issue ? Kicking the hardware designer won'=
t=20
help :-)

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart6107132.MQacW3snp2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIBK5r8y9gWxC9vpcRAjteAKDHcQ6YUmHYaD0aZzUJDRKiEUjEjACeJ+0E
YaJUbYVgxXvpk2eVOQ2h2xo=
=RZnU
-----END PGP SIGNATURE-----

--nextPart6107132.MQacW3snp2--
