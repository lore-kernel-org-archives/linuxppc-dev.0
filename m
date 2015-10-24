Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x233.google.com (mail-ob0-x233.google.com
 [IPv6:2607:f8b0:4003:c01::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 769401A08DD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 22:54:27 +1100 (AEDT)
Received: by obbwb3 with SMTP id wb3so112460860obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 04:54:24 -0700 (PDT)
Date: Sat, 24 Oct 2015 19:53:56 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151024115356.GA8545@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
 <20151021084503.GE17714@fixme-laptop.cn.ibm.com>
 <20151021193523.GT5105@linux.vnet.ibm.com>
 <20151021194825.GH2508@worktop.programming.kicks-ass.net>
 <20151022120716.GA1481@fixme-laptop.cn.ibm.com>
 <20151024102627.GH17308@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
In-Reply-To: <20151024102627.GH17308@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2015 at 12:26:27PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 22, 2015 at 08:07:16PM +0800, Boqun Feng wrote:
> > On Wed, Oct 21, 2015 at 09:48:25PM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 21, 2015 at 12:35:23PM -0700, Paul E. McKenney wrote:
> > > > > > > > I ask this because I recall Peter once bought up a discussi=
on:
> > > > > > > >=20
> > > > > > > > https://lkml.org/lkml/2015/8/26/596
> > >=20
> > > > > So a full barrier on one side of these operations is enough, I th=
ink.
> > > > > IOW, there is no need to strengthen these operations.
> > > >=20
> > > > Do we need to also worry about other futex use cases?
> > >=20
> > > Worry, always!
> > >=20
> > > But yes, there is one more specific usecase, which is that of a
> > > condition variable.
> > >=20
> > > When we go sleep on a futex, we might want to assume visibility of the
> > > stores done by the thread that woke us by the time we wake up.
> > >=20
> >=20
> > But the thing is futex atomics in PPC are already RELEASE(pc)+ACQUIRE
> > and imply a full barrier, is an RELEASE(sc) semantics really needed
> > here?
>=20
> For this, no, the current code should be fine I think.
>=20
> > Further more, is this condition variable visibility guaranteed by other
> > part of futex? Because in futex_wake_op:
> >=20
> > 	futex_wake_op()
> > 	  ...
> > 	  double_unlock_hb(hb1, hb2);  <- RELEASE(pc) barrier here.
> > 	  wake_up_q(&wake_q);
> >=20
> > and in futex_wait():
> >=20
> > 	futex_wait()
> > 	  ...
> > 	  futex_wait_queue_me(hb, &q, to); <- schedule() here
> > 	  ...
> > 	  unqueue_me(&q)
> > 	    drop_futex_key_refs(&q->key);
> > 	    	iput()/mmdrop(); <- a full barrier
> > 	 =20
> >=20
> > The RELEASE(pc) barrier pairs with the full barrier, therefore the
> > userspace wakee can observe the condition variable modification.
>=20
> Right, futexes are a pain; and I think we all agreed we didn't want to
> go rely on implementation details unless we absolutely _have_ to.
>=20

Agreed.

Besides, after I have read why futex_wake_op(the caller of
futex_atomic_op_inuser()) is introduced, I think your worries are quite
reasonable. I thought the futex_atomic_op_inuser() only operated on
futex related variables, but it turns out it can actually operate any
userspace variable if userspace code likes, therefore we don't have
control of all memory ordering guarantee of the variable. So if PPC
doesn't provide a full barrier at user<->kernel boundries, we should
make futex_atomic_op_inuser() fully ordered.


Still looking into futex_atomic_cmpxchg_inatomic() ...

> > > And.. aside from the thoughts I outlined in the email referenced abov=
e,
> > > there is always the chance people accidentally rely on the strong
> > > ordering on their x86 CPU and find things come apart when ran on their
> > > ARM/MIPS/etc..
> > >=20
> > > There are a fair number of people who use the raw futex call and we h=
ave
> > > 0 visibility into many of them. The assumed and accidental ordering
> > > guarantees will forever remain a mystery.
> > >=20
> >=20
> > Understood. That's truely a potential problem. Considering not all the
> > architectures imply a full barrier at user<->kernel boundries, maybe we
> > can use one bit in the opcode of the futex system call to indicate
> > whether userspace treats futex as fully ordered. Like:
> >=20
> > #define FUTEX_ORDER_SEQ_CST  0
> > #define FUTEX_ORDER_RELAXED  64 (bit 7 and bit 8 are already used)
>=20
> Not unless there's an actual performance problem with any of this.
> Futexes are painful enough as is.

Make sense, and we still have choices like modifying the userspace code
if there is actually a performance problem ;-)

Regards,
Boqun

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWK3FQAAoJEEl56MO1B/q4meEIAK3B5zFB+SIybIU96slixIUa
Cyfw3TPHYiF98y2cpih0MRYkmX/1T35+bSt9bzLaR7NhXYbtqM49B7GdNx/QvBde
CH0tPEq0MFdfLsO5nesuq4/Z9EWqdZ0CrQ6YZ1k0grlwg+/HqpWhbI6W0yIml8+b
xlqdavzUqLlkwn1Q6CAkL8ipyG78XJ5Fk9O/g4XDcXSpdG3VvTvQoOEnnFc3LorU
pMy0WZzbCgiQXnJSpiMg6TBVP/4rR2qYrOH8dp8C2pEyqe29j/hom+hZCKf8ZizQ
K/32zK/ZBZQtKo79wPceGCgbGFDJBho+cpzfRWm+/7BxOYDWb10cb2J33aj1bqM=
=G9Gh
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
