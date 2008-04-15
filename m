Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 9B443DE165
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 01:54:26 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] Using two baud rate generators with the cpm_uart driver
Date: Tue, 15 Apr 2008 17:54:16 +0200
References: <200804151532.27057.laurentp@cse-semaphore.com>
	<4804CB12.1000308@freescale.com>
In-Reply-To: <4804CB12.1000308@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2052700.i5aOQyxMV7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804151754.21664.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2052700.i5aOQyxMV7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Scott,

On Tuesday 15 April 2008 17:34, Scott Wood wrote:
> Laurent Pinchart wrote:
> > thanks to a bad hardware design decision, I'm faced with a software iss=
ue
> > with the cpm_uart driver.
> >=20
> > My hardware uses either SCC4 or SMC2 (production-time option) as an RS4=
85
> > port with an external transceiver. The transceiver's data direction is
> > controlled by external logic that monitors the SCC4/SMC2 TxD signal.
> >=20
> > The external logic needs an input clock at the baud rate frequency on t=
he=20
> > MPC8248 BRG5 output pin (although I could modify it to accept an input
> > clock at 16x the baud rate frequency). This means the cpm_uart driver h=
as
> > to setup two baud rate generators instead of one.
> >=20
> > The ppc architecture was easy to hack as it used a fs_uart_platform_inf=
o=20
> > structure in which I added a set_brg function pointer provided by platf=
orm=20
> > code. This isn't possible with the powerpc architecture anymore.
>  >
> > Is there a clean way to fix this issue ? Kicking the hardware designer
> > won't help :-)
>=20
> Maybe not, but it'd be satisfying. :-)

Don't tempt me :-)

> The clean solution would be to have an abstracted clock API, similar to=20
> phylib, where the caller doesn't know details about BRGs and such.=20
> Maybe the linux/clk.h API would be suitable; I haven't looked at it in=20
> detail.

The clock API would have to be quite advanced to express things like "the S=
CC4=20
clock is a combination of BRG2 and BRG5" (and I don't even consider=20
adding "with BRG2 set to 16x the baud rate and BRG5 to the baud rate").

I'm not even sure a generic API should be developed to solve my problem. I'=
m=20
more looking for a not too dirty hack.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2052700.i5aOQyxMV7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIBM+t8y9gWxC9vpcRArEWAKDQeu8oO+h+AdAYZpSdAHWaQv/C1gCdGRYW
Vjyulcw3or25jaMYAT4woQY=
=Nh7S
-----END PGP SIGNATURE-----

--nextPart2052700.i5aOQyxMV7--
