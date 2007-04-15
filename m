Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] hvc_console polling mode timer backoff
From: Michael Ellerman <michael@ellerman.id.au>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1176491513.28514.66.camel@farscape.rchland.ibm.com>
References: <1176394477.28514.32.camel@farscape.rchland.ibm.com>
	<1176450459.4734.32.camel@concordia.ozlabs.ibm.com>
	<1176491513.28514.66.camel@farscape.rchland.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MEgbk1dEHFK4UtPh0jkG"
Date: Sun, 15 Apr 2007 23:33:32 +1000
Message-Id: <1176644012.5422.3.camel@concordia.ozlabs.ibm.com>
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


--=-MEgbk1dEHFK4UtPh0jkG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-13 at 14:11 -0500, Will Schmidt wrote:
> On Fri, 2007-13-04 at 17:47 +1000, Michael Ellerman wrote:
> > Because this is a super tight performance critical inner loop I've
> > changed it to use a shift instead of divide. So now it's more like 1.5%=
,
> > but still the point is it increases faster as time passes.
>=20
> Using a shift here is a good idea.  I had considered accelerating the
> backoff value, but it got more complex than I wanted quickly.. I didnt
> consider a shift. :-)=20
>=20
> > It'd be good if some more people can bang on this and see what they
> > think of the interactivity.
>=20
> Still works OK on my power4.   I can see the delay on my console, but
> I'm specifically looking for it, I don't think it's an issue.=20

Cool. Yeah I think people will hardly notice it unless they're trying to
t notice it.

> > +#include <linux/debugfs.h>
> > +static int hvc_debug_init(void)
> > +{
> > +	debugfs_create_u32("hvc_timeout", 0400, NULL, &timeout);
> > +	return 0;
> > +}
> > +__initcall(hvc_debug_init);
> > +
>=20
> Is this part temporary for your graphing, or think it's something that
> should go in?=20

No that's just debug foobar I used for the graphs, I'll send a cleaned
up version during the week if you don't beat me to it.

> I used /proc/timer_stats output for my graphing, just dont have a good
> public spot to upload the pics..=20

Time to get a blag! ;)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-MEgbk1dEHFK4UtPh0jkG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGIimsdSjSd0sB4dIRAmebAJ9ATVilZlwEwkkTweDrPQ7iW9CykQCeLRGa
IfmQrdocHCIM2NneSze41IE=
=c014
-----END PGP SIGNATURE-----

--=-MEgbk1dEHFK4UtPh0jkG--
