Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc: Make early xmon logic immune to location
	of early parsing
From: Michael Ellerman <michael@ellerman.id.au>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20060518010826.GO22868@smtp.west.cox.net>
References: <1147852841.148164.91320074069.qpush@concordia>
	<20060517212955.GA31362@smtp.west.cox.net>
	<1147910586.7360.8.camel@localhost.localdomain>
	<20060518010826.GO22868@smtp.west.cox.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-q4E9kDkwCwinnc2/KIk0"
Date: Mon, 22 May 2006 17:03:08 +1000
Message-Id: <1148281388.24345.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-q4E9kDkwCwinnc2/KIk0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 18:08 -0700, Tom Rini wrote:
> On Thu, May 18, 2006 at 10:03:05AM +1000, Michael Ellerman wrote:
> > On Wed, 2006-05-17 at 14:29 -0700, Tom Rini wrote:
> > > On Wed, May 17, 2006 at 06:00:41PM +1000, Michael Ellerman wrote:
> > >=20
> > > > Currently early_xmon() calls directly into debugger() if xmon=3Dear=
ly is passed.
> > > > This ties the invocation of early xmon to the location of parse_ear=
ly_param(),
> > > > which might change.
> > > >=20
> > > > Tested on P5 LPAR and F50.
> > > >=20
> > > > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > >=20
> > > Please no, parse_early_param() is there so things like xmon or kgdb c=
an
> > > be dropped into as soon as we're able to parse any params that might =
be
> > > usable early on.
> >=20
> > Sure, did you read the rest of the series? I want to parse parameters
> > eariler, so early that xmon isn't ready to run when we parse them, so I
> > have to defer jumping into xmon until after xmon is initialised. The ne=
t
> > effect on when xmon runs is zero. Or did I miss your point?
>=20
> My point would be that xmon should either be fixed to work that early or
> parse things a bit later as a regular param.  I know the current system
> is flawed but I really don't like the idea (especially as a comaintainer
> of kgdb) of having to do a special plug here or there for one param
> because we parse early stuff too early, but regular stuff not early
> enough (which is why Andrew Morton got me to poke at the early param
> stuff a while back and then I think Rusty did something better, or
> something along those lines, anyhow).

Ok. I don't know the history so I can't comment on that. I don't think
we can make xmon run that early, the early parsing in my patch is before
we know what machine type we're on.

But as far as xmon and kgdb is concerned it really shouldn't matter that
the parsing is happening earlier. Instead of calling directly into
xmon/kgdb from the parsing code you set a global which is tested later.
If we ever get around to consolidating the 32/64 bit early setup code we
might even be able to move all the xmon logic into xmon_init(), which
would be even cleaner.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-q4E9kDkwCwinnc2/KIk0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEcWIsdSjSd0sB4dIRArMAAJsEQMlsrErCuaGm/4wawFQv21PoTwCgtgs/
2stfT7qvEnWCzoC/7ff8fSc=
=Wbk5
-----END PGP SIGNATURE-----

--=-q4E9kDkwCwinnc2/KIk0--
