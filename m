Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 8/9] ps3: cleanup ps3fb before clearing HPTE
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <20070126031438.GH18537@lst.de>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251851160.24610@pademelon.sonytel.be>
	<20070126031438.GH18537@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jI0u+NGD2R+qMfYrb39w"
Date: Tue, 30 Jan 2007 13:23:26 +1100
Message-Id: <1170123806.19887.111.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-jI0u+NGD2R+qMfYrb39w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-01-26 at 04:14 +0100, Christoph Hellwig wrote:
> On Thu, Jan 25, 2007 at 06:51:50PM +0100, Geert Uytterhoeven wrote:
> > PS3: Cleanup the frame buffer device before clearing the HPTE mapping
> >=20
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > ---
> >  arch/powerpc/platforms/ps3/htab.c |    5 +++++
> >  1 files changed, 5 insertions(+)
> >=20
> > --- ps3-linux.orig/arch/powerpc/platforms/ps3/htab.c
> > +++ ps3-linux/arch/powerpc/platforms/ps3/htab.c
> > @@ -234,6 +234,11 @@ static void ps3_hpte_invalidate(unsigned
> > =20
> >  static void ps3_hpte_clear(void)
> >  {
> > +	extern void ps3fb_cleanup(void);
>=20
> Externs belong into headers.
>=20
> > +
> > +#ifdef CONFIG_FB_PS3
> > +	ps3fb_cleanup();
> > +#endif

And when you move it into a header, create a dummy version so you can
remove the #ifdef in the C code. eg:

#ifdef CONFIG_FB_PS3
extern void ps3fb_cleanup(void);
#else
static inline void ps3fb_cleanup(void) { };
#endif

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-jI0u+NGD2R+qMfYrb39w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFvqwedSjSd0sB4dIRAuShAKDC7gZB3cC2L5Au9iVUPSfLpYDvpgCgp0hd
XSBBpbLwKNRbgJnqDde5miY=
=QHVl
-----END PGP SIGNATURE-----

--=-jI0u+NGD2R+qMfYrb39w--
