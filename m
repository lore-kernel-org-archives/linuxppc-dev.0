Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x22c.google.com (mail-oi0-x22c.google.com
 [IPv6:2607:f8b0:4003:c06::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 612A11A060F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2015 21:25:43 +1100 (AEDT)
Received: by oiak8 with SMTP id k8so49574302oia.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2015 03:25:41 -0700 (PDT)
Date: Sun, 11 Oct 2015 18:25:20 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 5/7] powerpc: atomic: Implement cmpxchg{,64}_* and
 atomic{,64}_cmpxchg_* variants
Message-ID: <20151011102520.GB27351@fixme-laptop.cn.ibm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-6-git-send-email-boqun.feng@gmail.com>
 <20151001122715.GQ2881@worktop.programming.kicks-ass.net>
 <20151010015805.GA946@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <20151010015805.GA946@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2015 at 09:58:05AM +0800, Boqun Feng wrote:
> Hi Peter,
>=20
> Sorry for replying late.
>=20
> On Thu, Oct 01, 2015 at 02:27:16PM +0200, Peter Zijlstra wrote:
> > On Wed, Sep 16, 2015 at 11:49:33PM +0800, Boqun Feng wrote:
> > > Unlike other atomic operation variants, cmpxchg{,64}_acquire and
> > > atomic{,64}_cmpxchg_acquire don't have acquire semantics if the cmp p=
art
> > > fails, so we need to implement these using assembly.
> >=20
> > I think that is actually expected and documented. That is, a cmpxchg
> > only implies barriers on success. See:
> >=20
> >   ed2de9f74ecb ("locking/Documentation: Clarify failed cmpxchg() memory=
 ordering semantics")
>=20
> I probably didn't make myself clear here, my point is that if we use
> __atomic_op_acquire() to built *_cmpchg_acquire(For ARM and PowerPC),
> the barrier will be implied _unconditionally_, meaning no matter cmp
> fails or not, there will be a barrier after the cmpxchg operation.
> Therefore we have to use assembly to implement the operations right now.
>=20

Or let me try another way to explain this. What I wanted to say here is
that unlike the implementation of xchg family, which needs only to
implement _relaxed version and *remove* the fully ordered version, the
implementation of cmpxchg family needs to *remain* the fully ordered
version and implement the _acquire version in assembly. Because if we
use __atomic_op_*(), the barriers in the cmpxchg family will be implied
*unconditionally*, for example:

cmpxchg() on PPC will be(built by my version of __atomic_op_fence()):

	smp_lwsync();
	cmpxchg_relaxed(...);
	smp_mb__after_atomic(); // a full barrier regardless of success
				// or failure.

In order to have a conditional barrier, we need a way to jump out of a
ll/sc loop, which could only(?) be done by assembly code.

My commit log surely failed to explain this clearly, I will modifiy that
in next series. In the meanwhile, looking forwards to suggestion on the
implementation of cmpxchg familiy ;-)

BTW, Will, could you please check whether the barriers in cmpxchg family
are unconditional or not in the current implementation of ARM? IIUC,
they are currently unconditional, right?

Regards,
Boqun

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWGjkMAAoJEEl56MO1B/q4+tQH/3vuGJsfSQ5kbTaaAsmzdeCH
Jg7Ltl1+KseO/5HmRrBnfnUdLQw9jLYHslLOyZGR6s8vNWmGT6n6N2lWoppuurBE
8PgLSUmL/H/Vn0t3glpW2CGzf6wZEyLGIasP5HwAkglC89V+BPPI27ljXtzqJcB2
MJHhN7VYVwVgY+9ifFlHGYuuYE61V7jK92fCZhpNWlQv6gABY3iWOWORsH2pkPq1
s4knxHlzadZvnqZurZ/eyDbbXzpofP0FjkmrwHfdVbUW9z21Ig2PKALBqTvnLN8p
u5BnD/jHCzzOvdLs7TTCje2GCkVeWqIy7K4mV34Hobd5g7TZBCdITB8FzFA1hyY=
=vieX
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
