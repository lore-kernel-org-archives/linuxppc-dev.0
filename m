Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 359371A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 01:59:00 +1100 (AEDT)
Received: by pabve7 with SMTP id ve7so24063256pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 07:58:58 -0700 (PDT)
Date: Tue, 13 Oct 2015 22:58:30 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 6/6] powerpc: atomic: Implement cmpxchg{,64}_* and
 atomic{,64}_cmpxchg_* variants
Message-ID: <20151013145830.GC23991@fixme-laptop.cn.ibm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444659246-24769-7-git-send-email-boqun.feng@gmail.com>
 <20151013132404.GI21550@arm.com>
 <20151013143259.GB23991@fixme-laptop.cn.ibm.com>
 <20151013144333.GN21550@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
In-Reply-To: <20151013144333.GN21550@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2015 at 03:43:33PM +0100, Will Deacon wrote:
> On Tue, Oct 13, 2015 at 10:32:59PM +0800, Boqun Feng wrote:
[snip]
> >=20
> > Mostly because of the comments in include/linux/atomic.h:
> >=20
> >  * For compound atomics performing both a load and a store, ACQUIRE
> >  * semantics apply only to the load and RELEASE semantics only to the
> >  * store portion of the operation. Note that a failed cmpxchg_acquire
> >  * does -not- imply any memory ordering constraints.
> >=20
> > so I thought only the barrier in cmpxchg_acquire() is conditional, and
> > the barrier in cmpxchg_release() is not. Maybe we'd better call it out
> > that cmpxchg *family* doesn't have any order guarantee if cmp fails, as
> > a complement of
> >=20
> > ed2de9f74ecb ("locking/Documentation: Clarify failed cmpxchg() memory o=
rdering semantics")
> >=20
> > Because it seems this commit only claims that the barriers in fully
> > ordered version are conditional.
>=20
> I didn't think this was ambiguous... A failed cmpxchg_release doesn't
> perform a store, so because the RELEASE semantics only apply to the
> store portion of the operation, it therefore doesn't have any ordering
> guarantees. Acquire is called out as a special case because it *does*
> actually perform a load on the failure case.
>=20

Make sense.

> > If cmpxchg_release doesn't have order guarantee when failed, I guess I
> > can implement it with a barrier in the middle as you mentioned:
> >=20
> > 	unsigned int prev;
> >=20
> > 	__asm__ __volatile__ (
> > "1:	lwarx	%0,0,%2	=09
> > 	cmpw	0,%0,%3\n\
> > 	bne-	2f\n"
> > 	PPC_RELEASE_BARRIER
> > "	stwcx.	%4,0,%2\n\
> > 	bne-	1b"
> > 	"\n\
> > 2:"
> > 	: "=3D&r" (prev), "+m" (*p)
> > 	: "r" (p), "r" (old), "r" (new)
> > 	: "cc", "memory");
> >=20
> > 	return prev;
> >=20
> >=20
> > However, I need to check whether the architecture allows this and any
> > other problem exists.
> >=20
> > Besides, I don't think it's a good idea to do the "put barrier in the
> > middle" thing in this patchset, because that seems a premature
> > optimization and if we go further, I guess we can also replace the
> > PPC_RELEASE_BARRIER above with a "sync" to implement a fully ordered
> > version cmpxchg(). Too much needs to investigate then..
>=20
> Putting a barrier in the middle of that critical section is probably a
> terrible idea, and that's why I thought you were avoiding it (hence my

The fact is that I haven't thought of that way to implement
cmpxchg_release before you ask that question ;-) And I'm not going to do
that for now and probably not in the future.

> original question). Perhaps just add a comment to that effect, since I

Are you suggesting if I put a barrier in the middle I'd better to add a
comment, right? So if I don't do that, it's OK to let this patch as it.

Regards,
Boqun

> fear adding more words to memory-barriers.txt is just likely to create
> further confusion.
>=20
> Will

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWHRwTAAoJEEl56MO1B/q4GjoH/0Be18F+YOmyNvniyITCIO8J
Kz6Bp6jBy+8OE2cYHiBJuG857TyRasUlWAKAGEQVSYcGtWlDublvB4qYfDcRRvHP
kkp9MSOVQ/bfEs5oBCB3bHkFhwVvt8XSLrw6hitTA3Fo//k/LL7TGmdm0AtO6WS2
cLRFuzcJV3Yxw6W7LfztbkFrYkETUxfMvfQ3RIOO9d4HNXiKE6PNvj76J3DGzoXW
T9ukel/liNI/trBDtClHqaaYNgNVFCWuD1qWlhuCLTjrfeygPcoMVemtOjyL09U0
+51UjJUWxL9POiRgCsmguX1FpIYtE6K+I+qf4mdIIBfKNNC/MuM8KPRNrx8cgUM=
=Kx/f
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
