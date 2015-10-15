Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4E2AF1A047B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 15:48:27 +1100 (AEDT)
Received: by iodv82 with SMTP id v82so7378421iod.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 21:48:24 -0700 (PDT)
Date: Thu, 15 Oct 2015 12:48:03 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151015044803.GC29432@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151014210419.GY3604@twins.programming.kicks-ass.net>
 <20151014214453.GC3910@linux.vnet.ibm.com>
 <20151015005321.GB29432@fixme-laptop.cn.ibm.com>
 <20151015030705.GD3910@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
In-Reply-To: <20151015030705.GD3910@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2015 at 08:07:05PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 15, 2015 at 08:53:21AM +0800, Boqun Feng wrote:
[snip]
> >=20
> > I'm afraid more than that, the above litmus also shows that
> >=20
> > 	CPU 0				CPU 1
> > 	-----				-----
> >=20
> > 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> > 	r3 =3D xchg_release(&a, 1);	smp_mb();
> > 					r3 =3D READ_ONCE(x);
> >=20
> > 	(0:r3 =3D=3D 0 && 1:r3 =3D=3D 0 && a =3D=3D 2) is not prohibitted
> >=20
> > in the implementation of this patchset, which should be disallowed by
> > the semantics of RELEASE, right?
>=20
> Not necessarily.  If you had the read first on CPU 1, and you had a
> similar problem, I would be more worried.
>=20

Sometimes I think maybe we should say that a single unpaired ACQUIRE or
RELEASE doesn't have any order guarantee because of the above case.

But seems that's not a normal or even existing case, my bad ;-(

> > And even:
> >=20
> > 	CPU 0				CPU 1
> > 	-----				-----
> >=20
> > 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> > 	smp_store_release(&a, 1);	smp_mb();
> > 					r3 =3D READ_ONCE(x);
> >=20
> > 	(1:r3 =3D=3D 0 && a =3D=3D 2) is not prohibitted
> >=20
> > shows by:
> >=20
> > 	PPC weird-lwsync
> > 	""
> > 	{
> > 	0:r1=3D1; 0:r2=3Dx; 0:r3=3D3; 0:r12=3Da;
> > 	1:r1=3D2; 1:r2=3Dx; 1:r3=3D3; 1:r12=3Da;
> > 	}
> > 	 P0                 | P1                 ;
> > 	 stw r1,0(r2)       | stw r1,0(r12)      ;
> > 	 lwsync             | sync               ;
> > 	 stw  r1,0(r12)	    | lwz r3,0(r2)       ;
> > 	exists
> > 	(a=3D2 /\ 1:r3=3D0)
> >=20
> > Please find something I'm (or the tool is) missing, maybe we can't use
> > (a =3D=3D 2) as a indication that STORE on CPU 1 happens after STORE on=
 CPU
> > 0?
>=20
> Again, if you were pairing the smp_store_release() with an smp_load_acqui=
re()
> or even a READ_ONCE() followed by a barrier, I would be quite concerned.
> I am not at all worried about the above two litmus tests.
>=20

Understood, thank you for think through that ;-)

> > And there is really something I find strange, see below.
> >=20
> > > >=20
> > > > So the scenario that would fail would be this one, right?
> > > >=20
> > > > a =3D x =3D 0
> > > >=20
> > > > 	CPU0				CPU1
> > > >=20
> > > > 	r3 =3D load_locked (&a);
> > > > 					a =3D 2;
> > > > 					sync();
> > > > 					r3 =3D x;
> > > > 	x =3D 1;
> > > > 	lwsync();
> > > > 	if (!store_cond(&a, 1))
> > > > 		goto again
> > > >=20
> > > >=20
> > > > Where we hoist the load way up because lwsync allows this.
> > >=20
> > > That scenario would end up with a=3D=3D1 rather than a=3D=3D2.
> > >=20
> > > > I always thought this would fail because CPU1's store to @a would f=
ail
> > > > the store_cond() on CPU0 and we'd do the 'again' thing, re-issuing =
the
> > > > load and now seeing the new value (2).
> > >=20
> > > The stwcx. failure was one thing that prevented a number of other
> > > misordering cases.  The problem is that we have to let go of the noti=
on
> > > of an implicit global clock.
> > >=20
> > > To that end, the herd tool can make a diagram of what it thought
> > > happened, and I have attached it.  I used this diagram to try and for=
ce
> > > this scenario at https://www.cl.cam.ac.uk/~pes20/ppcmem/index.html#PP=
C,
> > > and succeeded.  Here is the sequence of events:
> > >=20
> > > o	Commit P0's write.  The model offers to propagate this write
> > > 	to the coherence point and to P1, but don't do so yet.
> > >=20
> > > o	Commit P1's write.  Similar offers, but don't take them up yet.
> > >=20
> > > o	Commit P0's lwsync.
> > >=20
> > > o	Execute P0's lwarx, which reads a=3D0.  Then commit it.
> > >=20
> > > o	Commit P0's stwcx. as successful.  This stores a=3D1.
> > >=20
> > > o	Commit P0's branch (not taken).
> >=20
> > So at this point, P0's write to 'a' has propagated to P1, right? But
> > P0's write to 'x' hasn't, even there is a lwsync between them, right?
> > Doesn't the lwsync prevent this from happening?
>=20
> No, because lwsync is quite a bit weaker than sync aside from just
> the store-load ordering.
>=20

Understood, I've tried the ppcmem, much clear now ;-)

> > If at this point P0's write to 'a' hasn't propagated then when?
>=20
> Later.  At the very end of the test, in this case.  ;-)
>=20

Hmm.. I tried exactly this sequence in ppcmem, seems propagation of P0's
write to 'a' is never an option...

> Why not try creating a longer litmus test that requires P0's write to
> "a" to propagate to P1 before both processes complete?
>=20

I will try to write one, but to be clear, you mean we still observe=20

0:r3 =3D=3D 0 && a =3D=3D 2 && 1:r3 =3D=3D 0=20

at the end, right? Because I understand that if P1's write to 'a'
doesn't override P0's, P0's write to 'a' will propagate.

Regards,
Boqun

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWHy//AAoJEEl56MO1B/q4ivcH/0Eqe2xbOaoLQuXRoCA8MjnW
2NLORBNUsWq5WddJezSxA5wzQEnXt2OeimA00rUCmMNJ8gBLHAoSTaWBpAWAcDru
izwBd+bzbODIhRNt5/6FCg7fwo+qgE7R9T93ovbeMZCmaRj/lb9C6QPeFoGnowXH
YcV1iy5xSWX5LJr7e8snyBj+KLrd5nLFYCmGc/aRAi2BiLeHyQVBooKWsHOrrzSA
gV9KERmNp0Zndn+0wvUZKt9zYFhvyI4VFTRJ8W1xE7sg+8jAADZU6CilEeuN6ncN
KevnzUgmxZOUF0inEkSn0PLBayIvcE67A9y3kqeRtDue9ojuqvTpPyR9a336CoM=
=VBTi
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
