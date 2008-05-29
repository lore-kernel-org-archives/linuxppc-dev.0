Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 55645DDF2F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 May 2008 22:14:31 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: USB Host Controller driver for the MPC8270 processor
Date: Thu, 29 May 2008 14:14:23 +0200
References: <BAY122-W428F4FD4AED8DAED5968A1DABF0@phx.gbl>
In-Reply-To: <BAY122-W428F4FD4AED8DAED5968A1DABF0@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart28220191.fMzIght3ui";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200805291414.26798.laurentp@cse-semaphore.com>
Cc: Huub Eikens <huubeikens@hotmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart28220191.fMzIght3ui
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Huub,

On Thursday 29 May 2008 13:03, Huub Eikens wrote:
> Hi,
> =20
> I am in need of a USB Host Controller device for the Freescale MPC8270 for
> the 2.4 linux kernel (ELDK 3.1.1). On internet I found one, but this is o=
nly
> for version 2.6: =20
> http://cpm2usb.sourceforge.net/
>=20
> I have a few options:
> 1. backport this driver to 2.4.25 kernel. I would like to know if this is
> feasible or not. I get the feeling that this will take a lot of time.=20
> 2. upgrade my kernel to 2.6.x. This is not preferable for me since I depe=
nd
> on sw modules writen by external partners. If I upgrade, I really really
> need to be sure that this driver is stable and reliable.
> 3. Use an external USB Host Controller. Can anyone advise me on which
> controller to choose that runs stable and reliable on the 2.4.25 kernel
> (ELDK 3.1.1)?

I'd go for option 3. The CPM2 USB host controller is definitely not reliabl=
e.=20
It relies on software to prepare SOF tokens, and doesn't do much in hardwar=
e.

After some experimentation with the FHCI driver posted on linux-ppc by =20
Anton Vorontsov I found out that the driver would eat around 40% of my CPU=
=20
time, and some SOF tokens would be incorrectly sent.

The CPM3 (aka QE) shouldn't have the same SOF issue, as it prepares SOF tok=
en=20
without any software intervention, but I doubt it would perform much better=
=20
in term of CPU time.

If you can go for an OHCI/UHCI/EHCI based controller that would be much=20
better.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart28220191.fMzIght3ui
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIPp4i8y9gWxC9vpcRArJBAKCJeqBReTvuGBsr8iOoBIDhR663BgCfYzoY
kiP7HkzGNCrn7YAzF8dIopc=
=KtcC
-----END PGP SIGNATURE-----

--nextPart28220191.fMzIght3ui--
