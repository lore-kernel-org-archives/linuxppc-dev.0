Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 7D00CDDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 19:02:01 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Date: Tue, 8 Apr 2008 11:01:53 +0200
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172429.GF7727@localhost.localdomain>
In-Reply-To: <20080311172429.GF7727@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2108713.kEotnm0LFT";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804081101.55784.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2108713.kEotnm0LFT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 11 March 2008 18:24, Anton Vorontsov wrote:
> GTM stands for General-purpose Timers Module and able to generate
> timer{1,2,3,4} interrupts.
>=20
> There are several limitations in this support:
> 1. Cascaded (32 bit) timers unimplemented (1-2, 3-4).
>    This is straightforward to implement when needed, two timers should
>    be marked as "requested" and configured as appropriate.
> 2. Super-cascaded (64 bit) timers unimplemented (1-2-3-4).
>    This is also straightforward to implement when needed, all timers
>    should be marked as "requested" and configured as appropriate.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

[snip]

> +void gtm_stop_timer_16(struct gtm_timer *tmr)
> +{
> +	struct gtm *gtm =3D tmr->gtm;
> +	int num =3D tmr - &gtm->timers[0];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&gtm->lock, flags);
> +
> +	setbits8(tmr->gtcfr, GTCFR_STP(num));

Shouldn't we clear the timer events with

out_be16(tmr->gtevr, 0xFFFF);

here ? Otherwise the timer interrupt could still fire after the timer is=20
stopped. This introduces a race condition in drivers that blindly re-arm th=
e=20
timer in the interrupt handler. I've been bitten by this while porting your=
=20
=46HCI USB driver to a CPM2 platform.

> +
> +	spin_unlock_irqrestore(&gtm->lock, flags);
> +}
> +EXPORT_SYMBOL(gtm_stop_timer_16);

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2108713.kEotnm0LFT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH+zSD8y9gWxC9vpcRAvl6AJwLyF0lgRv7Gqtna3HEWXP/9vQNjACgkGRU
BpB0u42i3OFNPaqRYIRKEFo=
=a4cr
-----END PGP SIGNATURE-----

--nextPart2108713.kEotnm0LFT--
