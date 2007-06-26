Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] Make jprobes a little safer for users
From: Michael Ellerman <michael@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20070626055347.GB6841@lst.de>
References: <78935473b1f70c863ab0be7d6cf4bcb04922b20b.1182822366.git.michael@ellerman.id.au>
	<7a070581b2fe53ea65216e86c86abc4f40464341.1182822366.git.michael@ellerman.id.au>
	<20070626055347.GB6841@lst.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+e4huUY0AJAXVWIIpGA0"
Date: Tue, 26 Jun 2007 16:03:58 +1000
Message-Id: <1182837838.6673.17.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	anil.s.keshavamurthy@intel.com, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+e4huUY0AJAXVWIIpGA0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-06-26 at 07:53 +0200, Christoph Hellwig wrote:
> On Tue, Jun 26, 2007 at 11:48:51AM +1000, Michael Ellerman wrote:
> > I realise jprobes are a razor-blades-included type of interface, but
> > that doesn't mean we can't try and make them safer to use. This guy I
> > know once wrote code like this:
> >=20
> > struct jprobe jp =3D { .kp.symbol_name =3D "foo", .entry =3D "jprobe_fo=
o" };
> >=20
> > And then his kernel exploded. Oops.
> >=20
> > This patch adds an arch hook, arch_deref_entry_point() (I don't like it=
 either)
> > which takes the void * in a struct jprobe, and gives back the text addr=
ess
> > that it represents.
> >=20
> > We can then use that in register_jprobe() to check that the entry point
> > we're passed is actually in the kernel text, rather than just some rand=
om
> > value.
>=20
> Please don't add more weak functions, they're utterly horrible for
> anyone trying to understand the code.  Otherwise this looks fine to me.

What do you recommend instead? #define ARCH_HAS_FOO_BAR ?

I don't see what's utterly horrible about them. The fact that they're
weak is fairly reasonable documentation that they're overridden
somewhere else. And grep/cscope/ctags will find both the weak and
non-weak versions for you?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-+e4huUY0AJAXVWIIpGA0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGgKxOdSjSd0sB4dIRAifTAJ9LmFQ+hmx8v2ZFSncWC+fhZSUWdwCfXBuR
+jFxgT6VxkHsDVqF3+LAvdY=
=V1LP
-----END PGP SIGNATURE-----

--=-+e4huUY0AJAXVWIIpGA0--
