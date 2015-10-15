Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 52CC01A0583
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 12:22:53 +1100 (AEDT)
Received: by pabrc13 with SMTP id rc13so70152226pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 18:22:51 -0700 (PDT)
Date: Thu, 15 Oct 2015 09:22:26 +0800
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
Message-ID: <20151015012226.GC14305@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151014210419.GY3604@twins.programming.kicks-ass.net>
 <20151014214453.GC3910@linux.vnet.ibm.com>
 <20151015005321.GB29432@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
In-Reply-To: <20151015005321.GB29432@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2015 at 08:53:21AM +0800, Boqun Feng wrote:
> On Wed, Oct 14, 2015 at 02:44:53PM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 14, 2015 at 11:04:19PM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 14, 2015 at 01:19:17PM -0700, Paul E. McKenney wrote:
> > > > Suppose we have something like the following, where "a" and "x" are=
 both
> > > > initially zero:
> > > >=20
> > > > 	CPU 0				CPU 1
> > > > 	-----				-----
> > > >=20
> > > > 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> > > > 	r3 =3D xchg(&a, 1);		smp_mb();
> > > > 					r3 =3D READ_ONCE(x);
> > > >=20
> > > > If xchg() is fully ordered, we should never observe both CPUs'
> > > > r3 values being zero, correct?
> > > >=20
> > > > And wouldn't this be represented by the following litmus test?
> > > >=20
> > > > 	PPC SB+lwsync-RMW2-lwsync+st-sync-leading
> > > > 	""
> > > > 	{
> > > > 	0:r1=3D1; 0:r2=3Dx; 0:r3=3D3; 0:r10=3D0 ; 0:r11=3D0; 0:r12=3Da;
> > > > 	1:r1=3D2; 1:r2=3Dx; 1:r3=3D3; 1:r10=3D0 ; 1:r11=3D0; 1:r12=3Da;
> > > > 	}
> > > > 	 P0                 | P1                 ;
> > > > 	 stw r1,0(r2)       | stw r1,0(r12)      ;
> > > > 	 lwsync             | sync               ;
> > > > 	 lwarx  r11,r10,r12 | lwz r3,0(r2)       ;
> > > > 	 stwcx. r1,r10,r12  | ;
> > > > 	 bne Fail0          | ;
> > > > 	 mr r3,r11          | ;
> > > > 	 Fail0:             | ;
> > > > 	exists
> > > > 	(0:r3=3D0 /\ a=3D2 /\ 1:r3=3D0)
> > > >=20
> > > > I left off P0's trailing sync because there is nothing for it to or=
der
> > > > against in this particular litmus test.  I tried adding it and veri=
fied
> > > > that it has no effect.
> > > >=20
> > > > Am I missing something here?  If not, it seems to me that you need
> > > > the leading lwsync to instead be a sync.
>=20
> I'm afraid more than that, the above litmus also shows that
>=20

I mean there will be more things we need to fix, perhaps even smp_wmb()
need to be sync then..

Regards,
Boqun

> 	CPU 0				CPU 1
> 	-----				-----
>=20
> 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> 	r3 =3D xchg_release(&a, 1);	smp_mb();
> 					r3 =3D READ_ONCE(x);
>=20
> 	(0:r3 =3D=3D 0 && 1:r3 =3D=3D 0 && a =3D=3D 2) is not prohibitted
>=20
> in the implementation of this patchset, which should be disallowed by
> the semantics of RELEASE, right?
>=20
> And even:
>=20
> 	CPU 0				CPU 1
> 	-----				-----
>=20
> 	WRITE_ONCE(x, 1);		WRITE_ONCE(a, 2);
> 	smp_store_release(&a, 1);	smp_mb();
> 					r3 =3D READ_ONCE(x);
>=20
> 	(1:r3 =3D=3D 0 && a =3D=3D 2) is not prohibitted
>=20
> shows by:
>=20
> 	PPC weird-lwsync
> 	""
> 	{
> 	0:r1=3D1; 0:r2=3Dx; 0:r3=3D3; 0:r12=3Da;
> 	1:r1=3D2; 1:r2=3Dx; 1:r3=3D3; 1:r12=3Da;
> 	}
> 	 P0                 | P1                 ;
> 	 stw r1,0(r2)       | stw r1,0(r12)      ;
> 	 lwsync             | sync               ;
> 	 stw  r1,0(r12)	    | lwz r3,0(r2)       ;
> 	exists
> 	(a=3D2 /\ 1:r3=3D0)
>=20
>=20
> Please find something I'm (or the tool is) missing, maybe we can't use
> (a =3D=3D 2) as a indication that STORE on CPU 1 happens after STORE on C=
PU
> 0?
>=20
> And there is really something I find strange, see below.
>=20
> > >=20
> > > So the scenario that would fail would be this one, right?
> > >=20
> > > a =3D x =3D 0
> > >=20
> > > 	CPU0				CPU1
> > >=20
> > > 	r3 =3D load_locked (&a);
> > > 					a =3D 2;
> > > 					sync();
> > > 					r3 =3D x;
> > > 	x =3D 1;
> > > 	lwsync();
> > > 	if (!store_cond(&a, 1))
> > > 		goto again
> > >=20
> > >=20
> > > Where we hoist the load way up because lwsync allows this.
> >=20
> > That scenario would end up with a=3D=3D1 rather than a=3D=3D2.
> >=20
> > > I always thought this would fail because CPU1's store to @a would fail
> > > the store_cond() on CPU0 and we'd do the 'again' thing, re-issuing the
> > > load and now seeing the new value (2).
> >=20
> > The stwcx. failure was one thing that prevented a number of other
> > misordering cases.  The problem is that we have to let go of the notion
> > of an implicit global clock.
> >=20
> > To that end, the herd tool can make a diagram of what it thought
> > happened, and I have attached it.  I used this diagram to try and force
> > this scenario at https://www.cl.cam.ac.uk/~pes20/ppcmem/index.html#PPC,
> > and succeeded.  Here is the sequence of events:
> >=20
> > o	Commit P0's write.  The model offers to propagate this write
> > 	to the coherence point and to P1, but don't do so yet.
> >=20
> > o	Commit P1's write.  Similar offers, but don't take them up yet.
> >=20
> > o	Commit P0's lwsync.
> >=20
> > o	Execute P0's lwarx, which reads a=3D0.  Then commit it.
> >=20
> > o	Commit P0's stwcx. as successful.  This stores a=3D1.
> >=20
> > o	Commit P0's branch (not taken).
> >=20
>=20
> So at this point, P0's write to 'a' has propagated to P1, right? But
> P0's write to 'x' hasn't, even there is a lwsync between them, right?
> Doesn't the lwsync prevent this from happening?
>=20
> If at this point P0's write to 'a' hasn't propagated then when?
>=20
> Regards,
> Boqun
>=20
> > o	Commit P0's final register-to-register move.
> >=20
> > o	Commit P1's sync instruction.
> >=20
> > o	There is now nothing that can happen in either processor.
> > 	P0 is done, and P1 is waiting for its sync.  Therefore,
> > 	propagate P1's a=3D2 write to the coherence point and to
> > 	the other thread.
> >=20
> > o	There is still nothing that can happen in either processor.
> > 	So pick the barrier propagate, then the acknowledge sync.
> >=20
> > o	P1 can now execute its read from x.  Because P0's write to
> > 	x is still waiting to propagate to P1, this still reads
> > 	x=3D0.  Execute and commit, and we now have both r3 registers
> > 	equal to zero and the final value a=3D2.
> >=20
> > o	Clean up by propagating the write to x everywhere, and
> > 	propagating the lwsync.
> >=20
> > And the "exists" clause really does trigger: 0:r3=3D0; 1:r3=3D0; [a]=3D=
2;
> >=20
> > I am still not 100% confident of my litmus test.  It is quite possible
> > that I lost something in translation, but that is looking less likely.
> >=20
> > > > Of course, if I am not missing something, then this applies also to=
 the
> > > > value-returning RMW atomic operations that you pulled this pattern =
=66rom.
> > > > If so, it would seem that I didn't think through all the possibilit=
ies
> > > > back when PPC_ATOMIC_EXIT_BARRIER moved to sync...  In fact, I beli=
eve
> > > > that I worried about the RMW atomic operation acting as a barrier,
> > > > but not as the load/store itself.  :-/
> > >=20
> > > AARGH64 does something very similar; it does something like:
> > >=20
> > > 	ll
> > > 	...
> > > 	sc-release
> > >=20
> > > 	mb
> > >=20
> > > Which I assumed worked for the same reason, any change to the variable
> > > would fail the sc, and we go for round 2, now observing the new value.
> >=20
> > I have to defer to Will on this one.  You are right that ARM and PowerPC
> > do have similar memory models, but there are some differences.
> >=20
> > 							Thanx, Paul
>=20
>=20

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWHv/OAAoJEEl56MO1B/q4f8YIALV8ZH6hYbktFJulWwyVIQVC
bB4Wo05CZUDf503QTBrHXJD+dj6ztuzPSNQ3wsL4buIMw0RfPk1UC9p40m/TvcP4
A6ksYBOmEtDVo5LhQSL0rcCgMDhTMywDoYpDXFRPt3N7XXorDsmWVbEn4Qe6mTE1
E59qR8cu9/1s7utR5P5xWN6/vK9wZCdsLfhFrJIki4BD+OURm48axAtdzmDQ4mpG
/4/BfE5ZOYv0R7d4m/Ee5EBcHmJEZcXlITaSZJoi6S6XuRVzsEHDE2MSOLsqTasi
1yGsyFeBPMJXANnl8SduRxGIncAxSatIOanyUZzD8AUn333xYKufF1eE2pb2e0c=
=njiA
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
