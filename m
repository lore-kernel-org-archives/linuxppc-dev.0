Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][WIP][RFC] powerpc: fixup lwsync at runtime
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0806201131040.17834@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0806201131040.17834@blarg.am.freescale.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-n9GlkHJfsVYojWyvFowt"
Date: Sat, 21 Jun 2008 20:27:23 +1000
Message-Id: <1214044043.13524.6.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-n9GlkHJfsVYojWyvFowt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-06-20 at 11:36 -0500, Kumar Gala wrote:
> This is a work in progress towards make lwsync fixed up at runtime.  The
> patch is based (requires) the module refactoring patch.  Some of this cod=
e
> should be reworked based on the code patching work from Michael.  Also,
> ppc64 and vdso support needs a bit of cleaning up.

Hi Kumar,

This will clash in practice, though not in spirit, with the stuff I've
been working on to allow alternative feature sections. The code is in my
tree on kernel.org if you want to check it out, I was about to send
yesterday it but realised it breaks if you have exception table entries
in your alternative case code >:/

http://git.kernel.org/?p=3Dlinux/kernel/git/mpe/linux-2.6.git;a=3Dsummary

> Some questions:
> * How do we determine at runtime if we need to convert sync to lwsync.
> This is simliar to cpu_feature but has the issue that cpu_feature is abou=
t
> either having code in or not.

Isn't it just if cpus_possible =3D 1 ?

> * Do we simplify the section of fixup information and remove the mask and
> value since we don't use them and they double the size of the section

I guess it depends how many you end up with. My patches add another two
longs to the fixup entry also. It is all freed after boot.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-n9GlkHJfsVYojWyvFowt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIXNeLdSjSd0sB4dIRArmZAJwKMF0hrJio9RzyvsnaS1T45rwEQACgwmLv
PIQON0CGNmAse6oGkbfgrEM=
=mDtt
-----END PGP SIGNATURE-----

--=-n9GlkHJfsVYojWyvFowt--
