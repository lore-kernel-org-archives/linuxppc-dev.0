Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc64-dev@ozlabs.org
Date: Tue, 27 Sep 2005 09:05:24 +1000
References: <Pine.LNX.4.61.0509231408170.3791@nylon.am.freescale.net>
	<200509261157.37514.michael@ellerman.id.au>
	<1127774755.15882.104.camel@gaston>
In-Reply-To: <1127774755.15882.104.camel@gaston>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4805018.qdbr8lFOc8";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200509270905.29545.michael@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: merged asm/cputable.h
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart4805018.qdbr8lFOc8
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tue, 27 Sep 2005 08:45, Benjamin Herrenschmidt wrote:
> On Mon, 2005-09-26 at 11:57 +1000, Michael Ellerman wrote:
> > Here's a version of my patch updated to apply on top of the merge tree.
> > It'll be a lot cleaner when ppc32 has a single cur_cpu_spec, as we'll
> > be able to remove a lot of the #ifdefs.
>
> There is a small issue here: You turn identify_cpu into C code. However,
> on ppc32, this is called with the kernel not yet relocated (before
> prom_init even !). Same with the feature fixup. On ppc32, in order to
> run C code that early, it needs to be in -mrelocatable bits of code
> (like prom_init) or use RELOC macros (ugh !).

We could keep the bulk of the patch (turn cur_cpu_spec into a struct) but=20
still do identify_cpu() in asm, although it would seem like a step backward.

Do people think it's "better" to have one unified asm implementation, or on=
e=20
in asm for ppc32 and one in C for ppc64?

cheers

=2D-=20
Michael Ellerman
IBM OzLabs

email: michael:ellerman.id.au
inmsg: mpe:jabber.org
wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart4805018.qdbr8lFOc8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDOH65dSjSd0sB4dIRAi/JAKC9F6N86x4yOlePo8CMM+wxcmDKNACggBDL
IXyFVlmhqHiAcrSZNCgNu98=
=Z49N
-----END PGP SIGNATURE-----

--nextPart4805018.qdbr8lFOc8--
