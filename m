Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 3EABEDDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jun 2008 20:29:36 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Help on MPC82XX USB Host controller Development using m82xx-hcd.
Date: Wed, 4 Jun 2008 12:29:29 +0200
References: <16304553.post@talk.nabble.com>
	<200803270956.12203.laurentp@cse-semaphore.com>
	<17643409.post@talk.nabble.com>
In-Reply-To: <17643409.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1976427.ReqeVsRqgD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806041229.32995.laurentp@cse-semaphore.com>
Cc: gforgcc <narendra.ka@lntemsys.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1976427.ReqeVsRqgD
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Naren,

On Wednesday 04 June 2008 12:12, gforgcc wrote:
>=20
> Laurent Pinchart-4 wrote:
> >=20
> > The cpm2usb project isn't maintained. If possible you should upgrade to=
 a
> > more recent kernel and switch to the powerpc architecture where a new U=
SB
> > driver called fhci is available.
> >=20
> > The MPC872ADS is supported in recent kernels so switching shouldn't be =
too=20
> > difficult.
> >=20
> >=20
>=20
> Hi Laurent,
> i have some basic queries, i have some knowledge on what is UHCI or OHCI,
> but can you please brief me what is FHCI and some info regarding this ?
> googling on this dint help me much.. :(

=46HCI stands for Freescale Host Controller Interface. The term is unoffici=
al=20
and not referenced in the CPM documentation.

> we are using powerpc architecture with latest kernel 2.6.25.. and trying =
to
> implement the USB host controller driver and have similar problems..=20

The good news is that Anton Vorontsov wrote and posted a FHCI driver for=20
QE-based parts on the linux-ppc mailing list (search the archive for "[PATC=
H]=20
=46reescale QUICC Engine USB Host Controller"). The driver can be easily=20
modified to work with CPM2-based parts.

The bad news is that, from my experience with the CPM2, the controller is=20
almost unusable. It eats around 40% CPU time on my MPC8248 system, and=20
requires software help to generate SOF tokens, which results in bad SOF=20
tokens being sent on the bus. Most USB disks don't seem to care, but all th=
e=20
USB Bluetooth host controllers I've tested crashed.

We will be looking for an external USB host controller (or even another CPU=
)=20
for the next revision of the design.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1976427.ReqeVsRqgD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD4DBQBIRm6M8y9gWxC9vpcRAkcRAKDIC+4PQEutzbZ9VjI9pOuA8kaYhQCYy4ld
0esKJ9UHUWIzmW+Pfu5t3w==
=oTZM
-----END PGP SIGNATURE-----

--nextPart1976427.ReqeVsRqgD--
