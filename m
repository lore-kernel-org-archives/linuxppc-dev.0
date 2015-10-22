Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x22e.google.com (mail-ob0-x22e.google.com
 [IPv6:2607:f8b0:4003:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D5431A04A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 23:07:45 +1100 (AEDT)
Received: by obctp1 with SMTP id tp1so38835000obc.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 05:07:43 -0700 (PDT)
Date: Thu, 22 Oct 2015 20:07:16 +0800
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
Message-ID: <20151022120716.GA1481@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
 <20151021084503.GE17714@fixme-laptop.cn.ibm.com>
 <20151021193523.GT5105@linux.vnet.ibm.com>
 <20151021194825.GH2508@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
In-Reply-To: <20151021194825.GH2508@worktop.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2015 at 09:48:25PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 21, 2015 at 12:35:23PM -0700, Paul E. McKenney wrote:
> > > > > > I ask this because I recall Peter once bought up a discussion:
> > > > > >=20
> > > > > > https://lkml.org/lkml/2015/8/26/596
>=20
> > > So a full barrier on one side of these operations is enough, I think.
> > > IOW, there is no need to strengthen these operations.
> >=20
> > Do we need to also worry about other futex use cases?
>=20
> Worry, always!
>=20
> But yes, there is one more specific usecase, which is that of a
> condition variable.
>=20
> When we go sleep on a futex, we might want to assume visibility of the
> stores done by the thread that woke us by the time we wake up.
>=20

But the thing is futex atomics in PPC are already RELEASE(pc)+ACQUIRE
and imply a full barrier, is an RELEASE(sc) semantics really needed
here?

Further more, is this condition variable visibility guaranteed by other
part of futex? Because in futex_wake_op:

	futex_wake_op()
	  ...
	  double_unlock_hb(hb1, hb2);  <- RELEASE(pc) barrier here.
	  wake_up_q(&wake_q);

and in futex_wait():

	futex_wait()
	  ...
	  futex_wait_queue_me(hb, &q, to); <- schedule() here
	  ...
	  unqueue_me(&q)
	    drop_futex_key_refs(&q->key);
	    	iput()/mmdrop(); <- a full barrier
	 =20

The RELEASE(pc) barrier pairs with the full barrier, therefore the
userspace wakee can observe the condition variable modification.

>=20
>=20
> And.. aside from the thoughts I outlined in the email referenced above,
> there is always the chance people accidentally rely on the strong
> ordering on their x86 CPU and find things come apart when ran on their
> ARM/MIPS/etc..
>=20
> There are a fair number of people who use the raw futex call and we have
> 0 visibility into many of them. The assumed and accidental ordering
> guarantees will forever remain a mystery.
>=20

Understood. That's truely a potential problem. Considering not all the
architectures imply a full barrier at user<->kernel boundries, maybe we
can use one bit in the opcode of the futex system call to indicate
whether userspace treats futex as fully ordered. Like:

#define FUTEX_ORDER_SEQ_CST  0
#define FUTEX_ORDER_RELAXED  64 (bit 7 and bit 8 are already used)

Therefore all existing code will run with a strong ordering version of
futex(of course, we need to check and modify kernel code first to
guarantee that), and if userspace code uses FUTEX_ORDER_RELAXED, it must
not rely on futex() for the strong ordering, and should add memory
barriers itself if necessary.

Regards,
Boqun

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWKNFwAAoJEEl56MO1B/q4Mz4H/RSnO/4vV3a0kTbwuwktNrqK
XadOBtde+TaJot6ag0+9RJ8xVZpMEbPW5SBXuS/clenljmMWHsjgdtOLZDWc3ug/
kJLE87FWtaEfB5/O+ftJmmWsCpZXXLACY2JInSf6qlPKDTn9Vz6ENxtVdsT2KGjQ
8EVAOAAp1/vaEavIGNEPKVMG5MWKuxkhw2Ik3bSLA0fxv2ae8rIYmzyid8ASNupN
bHMXwsOtxa9mBbIRZe+a6IkxKFBrmMpFcAKWoHOnlnD4aHXjgld3hlxP/nMNO3vn
/UbfuJXFcvOvZayV5oric7tkrcSLoGaqhdps6Pk1J/oVS1RWMtaf5+H3S118cVY=
=AWbt
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
