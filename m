Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 83269DDE30
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 21:02:51 +1100 (EST)
Date: Fri, 11 Jan 2008 21:02:37 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 1/5] Warp Base Platform
Message-Id: <20080111210237.5636d0c3.sfr@canb.auug.org.au>
In-Reply-To: <47871675.6030602@pikatech.com>
References: <47852C41.8000506@pikatech.com>
	<20080111174259.b749f1f0.sfr@canb.auug.org.au>
	<47871675.6030602@pikatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_Jan_2008_21_02_37_+1100__aX0tswXRIYudDgO"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__11_Jan_2008_21_02_37_+1100__aX0tswXRIYudDgO
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Fri, 11 Jan 2008 02:10:45 -0500 Sean MacLennan <smaclennan@pikatech.com>=
 wrote:
>
> Stephen Rothwell wrote:
> > On Wed, 09 Jan 2008 15:19:13 -0500 Sean MacLennan <smaclennan@pikatech.=
com> wrote:
> >  =20
> >> No comments? I really thought I would get raked over the coals for thi=
s one.
> >
> > Ah ha! A challenge!  :-)
> >  =20
> I hoped somebody would respond to that ;)

Glad to oblige.

> >> +static int pika_dtm_thread(void *fpga)
> >> +{
> >> +	extern int ad7414_get_temp(int index);
> >
> > no externs in C code - put it in a header file.
> =20
> I didn't know where to put this extern. It is fairly specific to this=20
> driver, although a generic function... if that makes sense. It returns=20
> the exact contents of the register rather than doing any conversion.
>=20
> Any recommendations for a location gladly accepted.

I don't where that function is actually defined - I assume it is in one
of the other recent patch sets.

/me searches ...
/me reads "ad7414 driver" email ...
/me notes spaces missing there as well :-)

Tricky.  You have something that can only be built in (pika_dtm_thread in
warp.c) calling something that might be a module ... I think you need to
think of a new way of organizing these pieces.=20

While I am looking, the return type of ioremap is "void __iomem *", so
you need to annotate your "fpga" variable appropriately and the parameter
to pika_dtm_thread.

> And below has all the above mentioned fixes, except the extern.

You seem to have forgotten some of the spaces after "if"s, "switch"s and
"while"s.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__11_Jan_2008_21_02_37_+1100__aX0tswXRIYudDgO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHhz7DTgG2atn1QN8RAkYSAJ9trF1zceAKRFJHwJ1jlhIF32z+bgCfejbV
nYnwQ7Wpxp/iyjbmbNqCtk4=
=djg3
-----END PGP SIGNATURE-----

--Signature=_Fri__11_Jan_2008_21_02_37_+1100__aX0tswXRIYudDgO--
