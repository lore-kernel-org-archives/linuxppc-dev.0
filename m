Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 06A0CDE207
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 01:57:21 +1000 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 2633916A71
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 17:57:18 +0200 (CEST)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id AC5AA16A1F
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Aug 2008 17:57:17 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: RFC: Could cpm2_clk_setup and cpm2_set_pin be exported ?
Date: Thu, 28 Aug 2008 17:57:13 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2206070.VGu18LOXuS";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200808281757.16903.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2206070.VGu18LOXuS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everybody,

I'm facing a situation where I need to call cpm2_clk_setup and cpm2_set_pin=
 from a device driver compiled as a module. Before submitting a patch to ex=
port both functions, I'd like to make sure there isn't a cleaner way to imp=
lement the desired functionality without calling functions that are suppose=
d to be used by board setup code.

The hardware is an Infineon SHDSL chip connected directly to 3 SCC ports of=
 an MPC8248. The SHDSL ports roles can be set at runtime to Central Office =
or Remote Terminal (thing about a kind of master/slave configuration). SCC =
clock routing needs to configured at runtime to accommodate the ports roles=
 (in one of the roles the SCC uses a baud rate generator, while in the othe=
r it receives the clock from the chip). Clocks are described in the device =
tree, so the driver does not hardcode clock values, but I need to call cpm2=
_clk_setup at runtime. Should this be done through board-supplied callbacks=
 passed to the driver in a platform data structure (in which case I can't d=
eclare the device in the device tree as I'm doing now) or would it be accep=
table to export cpm2_clk_setup ?

cpm2_set_pin is used for a similar purpose, as I have to setup BRG/CLK pins=
 in input or output mode depending on the clock configuration. Additionally=
, cpm2_set_pin is also used to configure all inputs as outputs when the dri=
ver detects that the optional SDHSL module is not plugged in. Would it be s=
afe to leave those pins as floating inputs, or could that potentially damag=
e the MPC8248 ?

Thanks for your help.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2206070.VGu18LOXuS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAki2ytwACgkQ8y9gWxC9vpdEPwCgtxj7VbmpPKxJ69s6jUC+Lj+d
dlkAoLJ8AGs1Mstiw/ef3C3lqlOt1ZEf
=eQJJ
-----END PGP SIGNATURE-----

--nextPart2206070.VGu18LOXuS--
