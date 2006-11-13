Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH]: PowerPC: make sure the rtas stop-self token is defined.
From: Michael Ellerman <michael@ellerman.id.au>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061111010108.GX30625@austin.ibm.com>
References: <20061110182253.GV30625@austin.ibm.com>
	<20061110200152.GC23089@localdomain>
	<20061111010108.GX30625@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9k7rMPgzqnwcwzed5+ty"
Date: Mon, 13 Nov 2006 11:32:24 +1100
Message-Id: <1163377944.7410.12.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9k7rMPgzqnwcwzed5+ty
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-11-10 at 19:01 -0600, Linas Vepstas wrote:
> On Fri, Nov 10, 2006 at 02:01:52PM -0600, Nathan Lynch wrote:
> > Linas Vepstas wrote:
> > >=20
> > > There are a variety of code paths that lead to rtas_stop_self()
> > > being called, primarily through cpu_die(). However, rtas_stop_self()=20
> > > has a BUG_ON(rtas_args->token =3D=3D RTAS_UNKNOWN_SERVICE); in it, an=
d
> > > this rtas token is only set up if CONFIG_HOTPLUG_CPU is defined.
> > >=20
> > > Rather than wrapping all of the callers of rtas_stop_self()
> > > with CONFIG_HOTPLUG_CPU, it seems wiser to just unwrap the token
> > > definition.
> >=20
> > Is there actually a code path that calls rtas_stop_self with
> > CONFIG_HOTPLUG_CPU=3Dn?  That would be a bug, I think.
>=20
> Yeah, that was my first reaction too, right next to "user error".=20
> But then I started tracing the code paths, and after they multiplied
> a bit, it was clear that the answer wouldn't be clear.=20
>=20
> So then I philosophized a bit: if the code cannot be called
> unless CONFIG_HOTPLUG_CPU=3Dy, then I should add #ifdef CONFIG_HOTPLUG_CP=
U
> to make sure that the code doesn't even get compiled in.
>=20
> Well, there used to be such ifdefs (according to Joel) but someone=20
> removed the ifdefs. I'm guessing that these got removed during the
> powerpc tree migration.
>=20
> So... Rather than wrapping all of the callers of rtas_stop_self() ...

I can only find one caller? Is it called via a #define or something?

Wouldn't it be preferable to just change rtas.h like so:

#ifdef CONFIG_HOTPLUG_CPU
extern void rtas_stop_self(void);
#else
static inline void rtas_stop_self(void) { }
#endif

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-9k7rMPgzqnwcwzed5+ty
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFV70YdSjSd0sB4dIRAmxwAKCKo2QnNfkiZS7jdelPuQjfr1dakQCeISSw
Rcf0Lsq7qeopXoTCh9ajiFs=
=vnBY
-----END PGP SIGNATURE-----

--=-9k7rMPgzqnwcwzed5+ty--
