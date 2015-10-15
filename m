Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B50C11A0583
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 14:11:29 +1100 (AEDT)
Received: by pabws5 with SMTP id ws5so8971798pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 20:11:27 -0700 (PDT)
Date: Thu, 15 Oct 2015 11:11:01 +0800
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
Message-ID: <20151015031101.GD14305@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151014210419.GY3604@twins.programming.kicks-ass.net>
 <20151014214453.GC3910@linux.vnet.ibm.com>
 <20151015005321.GB29432@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
In-Reply-To: <20151015005321.GB29432@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Thu, Oct 15, 2015 at 08:53:21AM +0800, Boqun Feng wrote:
> On Wed, Oct 14, 2015 at 02:44:53PM -0700, Paul E. McKenney wrote:
[snip]
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

Hmm.. I played around ppcmem, and figured out what happens to
propagation of P0's write to 'a':

At this point, or some point after store 'a' to 1 and before sync on
P1 finish, writes to 'a' reachs a coherence point which 'a' is 2, so
P0's write to 'a' "fails" and will not propagate.


I probably misunderstood the word "propagate", which actually means an
already coherent write gets seen by another CPU, right?

So my question should be:

As lwsync can order P0's write to 'a' happens after P0's write to 'x',
why P0's write to 'x' isn't seen by P1 after P1's write to 'a' overrides
P0's?

But ppcmem gave me the answer ;-) lwsync won't wait under P0's write to
'x' gets propagated, and if P0's write to 'a' "wins" in write coherence,
lwsync will guarantee propagation of 'x' happens before that of 'a', but
if P0's write to 'a' "fails", there will be no propagation of 'a' from
P0. So that lwsync can't do anything here.

Regards,
Boqun

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

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWHxlBAAoJEEl56MO1B/q4G0UH/3Xl1Niv2WI+t941LQruVGyC
OMjvIMg3cIKvU8DMZBUeQiSmzykAhoUfX6g/5Nry1YGHUf4kepcrRfX95Ai8Wp/Q
HzkL//mmgRrxAwvtwDnklJsxNma9P8HmeXkrYAw2KIEymL9CV2m0ELExIVV+mYel
aI7WTuBsKuYAmnKGxkK6Yxrqe/We2+HS8eKViDM/dJgi1uNstd7upoKkaegMJEoV
9K1oT/+kx4qwaPB7Gr1y4kwBjN49e5Nn9PQB/er6CnulhOaHHFQNHQOWMM1Cgn2U
76XCKZBiMR2q0p1rcX89Ir1XcT6v3mJWuBxPyjJ91vikm1paz/LsI9hHDF2rEbY=
=kHcB
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
