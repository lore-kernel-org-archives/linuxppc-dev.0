Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E435DDDF69
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 23:12:40 +1000 (EST)
Date: Sun, 27 Jul 2008 23:11:49 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: [PATCH 1/2] leds: make the default trigger name const
Message-Id: <20080727231149.1b2508da.sfr@canb.auug.org.au>
In-Reply-To: <20080727020857.GM12191@secretlab.ca>
References: <Pine.LNX.4.64.0807181339500.10116@t2.domain.actdsltmp>
	<1217019705-24244-1-git-send-email-tpiepho@freescale.com>
	<20080727020857.GM12191@secretlab.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__27_Jul_2008_23_11_49_+1000_nza_GRb/r6/K0b.d"
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Richard Purdie <rpurdie@rpsys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__27_Jul_2008_23_11_49_+1000_nza_GRb/r6/K0b.d
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Trent,

On Sat, 26 Jul 2008 20:08:57 -0600 Grant Likely <grant.likely@secretlab.ca>=
 wrote:
>
> On Fri, Jul 25, 2008 at 02:01:44PM -0700, Trent Piepho wrote:
> > The default_trigger fields of struct gpio_led and thus struct led_class=
dev
> > are pretty much always assigned from a string literal, which means the
> > string can't be modified.  Which is fine, since there is no reason to
> > modify the string and in fact it never is.
> >=20
> > But they should be marked const to prevent such code from being added, =
to
> > prevent warnings if -Wwrite-strings is used and when assigned from a
> > constant string other than a string literal (which produces a warning u=
nder
> > current kernel compiler flags), and for general good coding practices.
> >=20
> > Signed-off-by: Trent Piepho <tpiepho@freescale.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

I would ack this as well, except I am not sure what tree this patch is
against.  In the current powerpc next tree,


> > +++ b/include/linux/leds.h
> > @@ -48,7 +48,7 @@ struct led_classdev {
> > =20
> >  	struct device		*dev;
> >  	struct list_head	 node;			/* LED Device list */
> > -	char			*default_trigger;	/* Trigger to use */
> > +	const char		*default_trigger;	/* Trigger to use */

this is already const, but there is another structure slightly further
down (struct led_info) that has a non-const default_tigger.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__27_Jul_2008_23_11_49_+1000_nza_GRb/r6/K0b.d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiMdBUACgkQjjKRsyhoI8wkPQCfXx7UyEDbUIM6bv8qFmwDl44m
HAoAn1WKfzXFkpfL8+/5MYHOCBtd8AIT
=25GB
-----END PGP SIGNATURE-----

--Signature=_Sun__27_Jul_2008_23_11_49_+1000_nza_GRb/r6/K0b.d--
