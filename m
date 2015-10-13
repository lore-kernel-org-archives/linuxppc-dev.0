Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 321BF1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 01:47:18 +1100 (AEDT)
Received: by pabve7 with SMTP id ve7so23793738pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 07:47:15 -0700 (PDT)
Date: Tue, 13 Oct 2015 22:46:52 +0800
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
Message-ID: <20151013144652.GA14305@fixme-laptop.cn.ibm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444659246-24769-7-git-send-email-boqun.feng@gmail.com>
 <20151013132404.GI21550@arm.com>
 <20151013143259.GB23991@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
In-Reply-To: <20151013143259.GB23991@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2015 at 10:32:59PM +0800, Boqun Feng wrote:
> On Tue, Oct 13, 2015 at 02:24:04PM +0100, Will Deacon wrote:
> > On Mon, Oct 12, 2015 at 10:14:06PM +0800, Boqun Feng wrote:
> > > Implement cmpxchg{,64}_relaxed and atomic{,64}_cmpxchg_relaxed, based=
 on
> > > which _release variants can be built.
> > >=20
> > > To avoid superfluous barriers in _acquire variants, we implement these
> > > operations with assembly code rather use __atomic_op_acquire() to bui=
ld
> > > them automatically.
> >=20
> > The "superfluous barriers" are for the case where the cmpxchg fails, ri=
ght?
>=20
> Yes.
>=20
> > And you don't do the same thing for release, because you want to avoid a
> > barrier in the middle of the critical section?
> >=20
>=20
> Mostly because of the comments in include/linux/atomic.h:
>=20
>  * For compound atomics performing both a load and a store, ACQUIRE
>  * semantics apply only to the load and RELEASE semantics only to the
>  * store portion of the operation. Note that a failed cmpxchg_acquire
>  * does -not- imply any memory ordering constraints.
>=20
> so I thought only the barrier in cmpxchg_acquire() is conditional, and
> the barrier in cmpxchg_release() is not. Maybe we'd better call it out
> that cmpxchg *family* doesn't have any order guarantee if cmp fails, as
> a complement of
>=20
> ed2de9f74ecb ("locking/Documentation: Clarify failed cmpxchg() memory ord=
ering semantics")
>=20
> Because it seems this commit only claims that the barriers in fully
> ordered version are conditional.
>=20
>=20
> If cmpxchg_release doesn't have order guarantee when failed, I guess I
> can implement it with a barrier in the middle as you mentioned:
>=20
> 	unsigned int prev;
>=20
> 	__asm__ __volatile__ (
> "1:	lwarx	%0,0,%2	=09
> 	cmpw	0,%0,%3\n\
> 	bne-	2f\n"
> 	PPC_RELEASE_BARRIER
> "	stwcx.	%4,0,%2\n\
> 	bne-	1b"
> 	"\n\
> 2:"
> 	: "=3D&r" (prev), "+m" (*p)
> 	: "r" (p), "r" (old), "r" (new)
> 	: "cc", "memory");
>=20
> 	return prev;
>=20
>=20
> However, I need to check whether the architecture allows this and any
> other problem exists.
>=20
> Besides, I don't think it's a good idea to do the "put barrier in the
> middle" thing in this patchset, because that seems a premature
> optimization and if we go further, I guess we can also replace the
> PPC_RELEASE_BARRIER above with a "sync" to implement a fully ordered

Correction: we can't just put the sync in the middle to implement a
fully ordered version. Sorry for that mistake..

Regards,
Boqun

> version cmpxchg(). Too much needs to investigate then..
>=20
> > (just checking I understand your reasoning).
> >=20
>=20
> That actually helps me find a probably better implementation if allowed,
> thank you ;-)
>=20
> Regards,
> Boqun

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWHRlZAAoJEEl56MO1B/q4RJsIAKpd2eHf50kfIiM+LCXT+ham
H74krzZDIkDevu7IZxlwlZgDxt/Z46f+mgHJ+mlkb3cx0U812EzbvkLGYi1BDz0c
L9Mzspx7Gz8/wnnnYBaxDDiTt6ahWffuBVw8fz4hlq/RZSzPSdl6idqqpKMgM0uC
2/PePTr20WsZQ3i32/a9/zixWYgPr3aKF3K9d7ujPmk9gwT6ib+SVO42j9WcOnv5
EFu1xkBstovOdJGcnSazYK6qpti6yab6osMdI+srwcSWVv2YEFA3bG3lON32OCRR
NLNZaU3nwTQe9e1jCzX2OXipP8qIu110v5ATjcCK+oj3X1WoeaJSfYFYLLyB50k=
=JI+s
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
