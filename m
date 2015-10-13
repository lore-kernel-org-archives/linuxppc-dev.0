Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC5781A0976
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 01:33:26 +1100 (AEDT)
Received: by pabrc13 with SMTP id rc13so23319138pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 07:33:24 -0700 (PDT)
Date: Tue, 13 Oct 2015 22:32:59 +0800
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
Message-ID: <20151013143259.GB23991@fixme-laptop.cn.ibm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444659246-24769-7-git-send-email-boqun.feng@gmail.com>
 <20151013132404.GI21550@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
In-Reply-To: <20151013132404.GI21550@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2015 at 02:24:04PM +0100, Will Deacon wrote:
> On Mon, Oct 12, 2015 at 10:14:06PM +0800, Boqun Feng wrote:
> > Implement cmpxchg{,64}_relaxed and atomic{,64}_cmpxchg_relaxed, based on
> > which _release variants can be built.
> >=20
> > To avoid superfluous barriers in _acquire variants, we implement these
> > operations with assembly code rather use __atomic_op_acquire() to build
> > them automatically.
>=20
> The "superfluous barriers" are for the case where the cmpxchg fails, righ=
t?

Yes.

> And you don't do the same thing for release, because you want to avoid a
> barrier in the middle of the critical section?
>=20

Mostly because of the comments in include/linux/atomic.h:

 * For compound atomics performing both a load and a store, ACQUIRE
 * semantics apply only to the load and RELEASE semantics only to the
 * store portion of the operation. Note that a failed cmpxchg_acquire
 * does -not- imply any memory ordering constraints.

so I thought only the barrier in cmpxchg_acquire() is conditional, and
the barrier in cmpxchg_release() is not. Maybe we'd better call it out
that cmpxchg *family* doesn't have any order guarantee if cmp fails, as
a complement of

ed2de9f74ecb ("locking/Documentation: Clarify failed cmpxchg() memory order=
ing semantics")

Because it seems this commit only claims that the barriers in fully
ordered version are conditional.


If cmpxchg_release doesn't have order guarantee when failed, I guess I
can implement it with a barrier in the middle as you mentioned:

	unsigned int prev;

	__asm__ __volatile__ (
"1:	lwarx	%0,0,%2	=09
	cmpw	0,%0,%3\n\
	bne-	2f\n"
	PPC_RELEASE_BARRIER
"	stwcx.	%4,0,%2\n\
	bne-	1b"
	"\n\
2:"
	: "=3D&r" (prev), "+m" (*p)
	: "r" (p), "r" (old), "r" (new)
	: "cc", "memory");

	return prev;


However, I need to check whether the architecture allows this and any
other problem exists.

Besides, I don't think it's a good idea to do the "put barrier in the
middle" thing in this patchset, because that seems a premature
optimization and if we go further, I guess we can also replace the
PPC_RELEASE_BARRIER above with a "sync" to implement a fully ordered
version cmpxchg(). Too much needs to investigate then..

> (just checking I understand your reasoning).
>=20

That actually helps me find a probably better implementation if allowed,
thank you ;-)

Regards,
Boqun

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWHRYYAAoJEEl56MO1B/q4P9wIALikvsbiu8Aw3Ahivu+FBaLE
oNAN+8CPOOiV/uchhqHs+JjcjYE4outU44zuIhbVeWYd2KAVBSxJMk3ZWiQEGdA4
dSLbS/TGUHeMIGRdGC4AfU9MQV3ybRayPRWUlzHiiSHaWtHkkgkS5vVB/tjXIwV4
FMNsEkPuNf2hcDRAB9ky86I2mROjUyolC8DyC32MqapC5wDrrdxoOX0gUB1RbB7U
yYCM0ZN6xQlnP50oVIhQJyJmYBockJFl9e2at2VqYfhR9SUpxsSt/lpUGyp+H8Sa
CtUmasniAzIJphMqvPUsXT5SX5H9dWEuo2sjErdzT3vLzYVg05kP/cW4VYaoUms=
=kHh8
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
