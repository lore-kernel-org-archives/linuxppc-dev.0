Return-Path: <michael@ellerman.id.au>
Subject: Re: [BUG] 2.6.25-rc5-mm1 kernel panic with "Exception: 501 " on
	powerpc
From: Michael Ellerman <michael@ellerman.id.au>
To: Matthew Wilcox <matthew@wil.cx>
In-Reply-To: <20080312175102.GC613@parisc-linux.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org>
	<47D7D2C9.4090001@linux.vnet.ibm.com>
	<20080312104645.34e58319.akpm@linux-foundation.org>
	<20080312175102.GC613@parisc-linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-FKcgb/W1x+QFNN+GQlWd"
Date: Thu, 13 Mar 2008 09:26:09 +1100
Message-Id: <1205360769.7436.8.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-FKcgb/W1x+QFNN+GQlWd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-03-12 at 11:51 -0600, Matthew Wilcox wrote:
> On Wed, Mar 12, 2008 at 10:46:45AM -0700, Andrew Morton wrote:
> > On Wed, 12 Mar 2008 18:25:37 +0530 Kamalesh Babulal <kamalesh@linux.vne=
t.ibm.com> wrote:
> > Beats me.  Maybe we're still enabling interrupts too early.  But the ne=
w
> > semaphore code got fixed (didn't it?)
>=20
> On the 7th, according to my records.  Easy to check -- look in
> kernel/semaphore.c and see whether down() is using spin_lock_irqsave
> (good) or spin_lock_irq (bad).

down() looks OK, but there's still a spin_lock_irq() in __down_common(),
although I don't know if it makes sense for us to be in __down() at that
stage.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-FKcgb/W1x+QFNN+GQlWd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH2FiBdSjSd0sB4dIRAl2yAJ99xRvlB9Y9gSWnrlO5I81Y2WInMwCePnvQ
tIC8LxVMBAH4DYX1jOsCmsk=
=FYb4
-----END PGP SIGNATURE-----

--=-FKcgb/W1x+QFNN+GQlWd--
