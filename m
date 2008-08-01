Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 2D471DDF16
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Aug 2008 21:32:30 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: floating point support in the driver.
Date: Fri, 1 Aug 2008 13:32:22 +0200
References: <18772109.post@talk.nabble.com>
In-Reply-To: <18772109.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1728548.YCVG2RL5cy";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200808011332.25368.laurentp@cse-semaphore.com>
Cc: Misbah khan <misbah_khan@engineer.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart1728548.YCVG2RL5cy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 01 August 2008, Misbah khan wrote:
>=20
> Hi all,
>=20
> I have a DSP algorithm which i am running in the application even after
> enabling the VFP support it is taking a lot of time to get executed hence=
=20
>=20
> I want to transform the same into the driver insted of an user applicatio=
n.
> Can anybody suggest whether doing the same could be a better solution and
> what could be the chalenges that i have to face by implimenting such
> floating point support in the driver.
>=20
> Is there a way in the application itself to make it execute faster.

=46loating-point in the kernel should be avoided. FPU state save/restore op=
erations are costly and are not performed by the kernel when switching from=
 userspace to kernelspace context. You will have to protect floating-point =
sections with kernel_fpu_begin/kernel_fpu_end which, if I'm not mistaken, d=
isables preemption. That's probably not something you want to do. Why would=
 the same code run faster in kernelspace then userspace ?

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1728548.YCVG2RL5cy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiS9EkACgkQ8y9gWxC9vpdnNgCghGqqMvy+RovNDs7cbqgm753o
TUUAnRkseTJE9X3JF8VAkKVaGoWcTWb1
=d3Wj
-----END PGP SIGNATURE-----

--nextPart1728548.YCVG2RL5cy--
