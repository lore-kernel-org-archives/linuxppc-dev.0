Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc64-dev@ozlabs.org
Date: Fri, 5 Aug 2005 19:08:20 +1000
References: <1123023575.2614.25.camel@cashmere.sps.mot.com>
	<688ba2276de281a9473b030a16a514c0@embeddededge.com>
	<20050805174705.731ffa05.sfr@canb.auug.org.au>
In-Reply-To: <20050805174705.731ffa05.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5735798.Z77uV6j3gj";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200508051908.24019.michael@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 1/2 Start header file merger (Was: Re: Beginning Merger
	Patch)
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart5735798.Z77uV6j3gj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

And for the faint of heart there's a patch at:

http://michael.ellerman.id.au/files/misc/header-merge.patch

cheers

On Fri, 5 Aug 2005 17:47, Stephen Rothwell wrote:
> On Tue, 2 Aug 2005 19:10:56 -0400 Dan Malek <dan@embeddededge.com> wrote:
> > On Aug 2, 2005, at 6:59 PM, Jon Loeliger wrote:
> > > ..... A stub is left
> > > in asm-ppc and asm-ppc64 pointing to the unified files.
> >
> > Why bother?  You may as well change all of the source
> > files, too, or else that will never get done :-)
>
> You actually don't need to modify (m)any source files.
>
> Here is an alternative approach.  These patches depend on Olaf's
> boot code cleanup for ppc64 (or similar).  Do the following:
>
> cd linux/include
> mkdir asm-powerpc
> cd asm-ppc
> for i in *
> do
> 	[ -e ../asm-ppc64/$i ] || mv $i ../asm-powerpc/$i
> done
> cd ../asm-ppc64
> for i in *
> do
> 	[ -e ../asm-ppc/$i ] || mv $i ../asm-powerpc/$i
> done
> for i in *
> do
> 	[ -f ../asm-ppc64/$i ] && cmp -s $i ../asm-ppc64/$i &&
> 		mv $i ../asm-powerpc/$i && rm ../asm-ppc64/$i
> done
>
> Then apply the patch below and the patch in the following email.
>
> I have built this kernel for ppc (defconfig), ppc64 (iSeries, pSeries and
> pmac).

=2D-=20
Michael Ellerman
IBM OzLabs

email: michael:ellerman.id.au
inmsg: mpe:jabber.org
wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--nextPart5735798.Z77uV6j3gj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC8yyHdSjSd0sB4dIRAkrCAJ0aH4SeSUp+OS3q/zAWTDY3KU9FhgCgjW9U
qU5+T8nUk/bW0C79w/2hWi8=
=bL9F
-----END PGP SIGNATURE-----

--nextPart5735798.Z77uV6j3gj--
