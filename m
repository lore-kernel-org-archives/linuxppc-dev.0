Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] hvc_console polling mode timer backoff
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070412190902.GA8158@lixom.net>
References: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
	<20070412173334.GP4747@austin.ibm.com>
	<1176403411.28514.55.camel@farscape.rchland.ibm.com>
	<20070412190902.GA8158@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0zmnwjl0xSo0TyuuuuSJ"
Date: Fri, 13 Apr 2007 10:45:43 +1000
Message-Id: <1176425143.4734.8.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0zmnwjl0xSo0TyuuuuSJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-04-12 at 14:09 -0500, Olof Johansson wrote:
> On Thu, Apr 12, 2007 at 01:43:30PM -0500, Will Schmidt wrote:
> > On Thu, 2007-12-04 at 12:33 -0500, Linas Vepstas wrote:
> > > On Thu, Apr 12, 2007 at 11:14:36AM -0500, Will Schmidt wrote:
> > > > +/*
> > > > + * timeout will vary between the MIN and MAX values defined here. =
 By default
> > > > + * and during console activity we will use a default MIN_TIMEOUT o=
f 10.  When
> > > > + * the console is idle, we increase the timeout value on each pass=
 through
> > > > + * msleep until we reach the max.  This may be noticeable as a bri=
ef (average
> > > > + * one second) delay on the console before the console responds to=
 input when
> > > > + * there has been no input for some time.
> > > > + */
> > > > +#define MIN_TIMEOUT		(10)
> > > > +#define MAX_TIMEOUT		(2000)
> > >=20
> > > [...]
> > > > +				msleep_interruptible(timeout);
> > >=20
> > >=20
> > > These values are milliseconds (that's what the m in msleep stands for
> > > or at least it did last time I looked). This 10 is 1/100 of a second,
> > > which makes a responsive keyboard for even a very very fast typist.
> > > That's fine.  But 2000 is two seconds, which is longer than the amoun=
t=20
> > > of time that I wait before I start panicking that something is broken=
.=20
> >=20
> > Well, I usually give my systems at least ten seconds before I start to
> > worry. :-)=20
> >=20
> > I did ponder the max value to use.   Though when I sit down at &random&
> > console in the lab, It often takes a moment for the terminal to warm up=
,
> > or for the screen to unblank.   With that in mind, a couple seconds max
> > for the console does not seem unreasonable to me.
> >=20
> > Will see if other folks have an opinion either way..=20

I found the 2 second value was fine. If you're really paying attention
you might notice the lag, but if you're not expecting it I don't think
it's enough to really scare you.

> I wasn't going to bring it up since I think it's a good approach as is,
> but another thing that could be worth considering is to not just go
> from whatever value to min on every actual input, instead go down in
> delay a bit (say half the delay). Likewise you might be able to back off
> more aggressively than just one millisecond per iteration.   Of course,
> both of these should take min/max values into consideration.

I experimented with increasing the delay faster (100ms per iteration)
and found it effected the feel of the console too much when you're
actually typing. Though perhaps increasing by 10%-20% of the current
delay every iteration might work OK.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0zmnwjl0xSo0TyuuuuSJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGHtK3dSjSd0sB4dIRAhpNAJ0WxoyQ0aauM+u1i+jH1sl4qKgHwwCgluxF
2Svn5v8UjtnHSUjoV2YcEFE=
=A1+T
-----END PGP SIGNATURE-----

--=-0zmnwjl0xSo0TyuuuuSJ--
