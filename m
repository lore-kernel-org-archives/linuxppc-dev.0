Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 55CEADE1BD
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:24:08 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org,
 avorontsov@ru.mvista.com
Subject: Re: [PATCH 6/8] [POWERPC] sysdev,qe_lib: implement FSL GTM support
Date: Thu, 17 Apr 2008 16:23:56 +0200
References: <20080311172106.GA4766@localhost.localdomain>
	<47E02A8C.2080705@freescale.com>
	<20080416183904.GA23512@polina.dev.rtsoft.ru>
In-Reply-To: <20080416183904.GA23512@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4006241.QINvi1HIuz";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804171624.02769.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart4006241.QINvi1HIuz
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 16 April 2008 20:39, Anton Vorontsov wrote:
> On Tue, Mar 18, 2008 at 03:48:12PM -0500, Scott Wood wrote:
> [...]
> > How about:
> >
> > struct gtm_timer *gtm_get_specific_timer(struct gtm *gtm, int timer,
> >                                          int width);
> >
> > ...with np->data used by the caller to figure out which gtm pointer to =
=20
> > pass in.
>=20
> Thanks for the comments, I've tried to address them all.
>=20
> Updated patch below (not for applying, still waiting for further
> comments, if any).
>=20
> - - - -
> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Subject: [POWERPC] sysdev,qe_lib: implement FSL GTM support
>=20
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
> ---
>  Documentation/powerpc/booting-without-of.txt |   32 +++-
>  arch/powerpc/Kconfig                         |    5 +
>  arch/powerpc/sysdev/Makefile                 |    1 +
>  arch/powerpc/sysdev/fsl_gtm.c                |  322 ++++++++++++++++++++=
++++++
>  include/asm-powerpc/fsl_gtm.h                |  106 +++++++++
>  5 files changed, 465 insertions(+), 1 deletions(-)
>  create mode 100644 arch/powerpc/sysdev/fsl_gtm.c
>  create mode 100644 include/asm-powerpc/fsl_gtm.h

[snip]

> +/*
> + * This is back-end for the exported functions, it's used to reset single
> + * timer in reference mode.
> + */
> +static int gtm_reset_ref_timer16(struct gtm_timer *tmr, int frequency,
> +				 int reference_value, bool free_run)
> +{
> +	struct gtm *gtm =3D tmr->gtm;
> +	int num =3D tmr - &gtm->timers[0];
> +	unsigned int prescaler;
> +	u8 iclk =3D GTMDR_ICLK_ICLK;
> +	u8 psr;
> +	u8 sps;
> +	unsigned long flags;
> +
> +	prescaler =3D gtm->clock / frequency;
> +	/*
> +	 * We have two 8 bit prescalers -- primary and secondary (psr, sps),
> +	 * plus "slow go" mode (clk / 16). So, total prescale value is
> +	 * 16 * (psr + 1) * (sps + 1).
> +	 */
> +	if (prescaler > 256 * 256 * 16)
> +		return -EINVAL;
> +
> +	if (prescaler > 256 * 256) {
> +		iclk =3D GTMDR_ICLK_SLGO;
> +		prescaler /=3D 16;
> +	}
> +
> +	if (prescaler > 256) {
> +		psr =3D 256 - 1;
> +		sps =3D prescaler / 256 - 1;
> +	} else {
> +		psr =3D prescaler - 1;
> +		sps =3D 1 - 1;
> +	}

Don't forget that the CPM2 doesn't support the primary prescaler.

> +	spin_lock_irqsave(&gtm->lock, flags);
> +
> +	/*
> +	 * Properly reset timers: stop, reset, set up prescalers, reference
> +	 * value and clear event register.
> +	 */
> +	clrsetbits_8(tmr->gtcfr, ~(GTCFR_STP(num) | GTCFR_RST(num)),
> +				 GTCFR_STP(num) | GTCFR_RST(num));
> +
> +	setbits8(tmr->gtcfr, GTCFR_STP(num));
> +
> +	out_be16(tmr->gtpsr, psr);
> +	clrsetbits_be16(tmr->gtmdr, 0xFFFF, iclk | GTMDR_SPS(sps) |
> +			GTMDR_ORI | (free_run ? GTMDR_FFR : 0));
> +	out_be16(tmr->gtcnr, 0);
> +	out_be16(tmr->gtrfr, reference_value);
> +	out_be16(tmr->gtevr, 0xFFFF);
> +
> +	/* Let it be. */
> +	clrbits8(tmr->gtcfr, GTCFR_STP(num));
> +
> +	spin_unlock_irqrestore(&gtm->lock, flags);
> +
> +	return 0;
> +}


=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart4006241.QINvi1HIuz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIB12C8y9gWxC9vpcRAu3DAJ4iB8kTa0oSqVgiHgq0hrsk1auKhwCgo5Jf
NyXz4PUviYKtVWHyeaJLvVI=
=uffL
-----END PGP SIGNATURE-----

--nextPart4006241.QINvi1HIuz--
