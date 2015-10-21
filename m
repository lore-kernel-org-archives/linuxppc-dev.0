Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x22d.google.com (mail-oi0-x22d.google.com
 [IPv6:2607:f8b0:4003:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09F0A1A0248
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 19:45:30 +1100 (AEDT)
Received: by oiad129 with SMTP id d129so24829282oia.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 01:45:28 -0700 (PDT)
Date: Wed, 21 Oct 2015 16:45:03 +0800
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
Message-ID: <20151021084503.GE17714@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
In-Reply-To: <20151020212835.GH5105@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2015 at 02:28:35PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 20, 2015 at 11:21:47AM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 20, 2015 at 03:15:32PM +0800, Boqun Feng wrote:
> > > On Wed, Oct 14, 2015 at 01:19:17PM -0700, Paul E. McKenney wrote:
> > > >=20
> > > > Am I missing something here?  If not, it seems to me that you need
> > > > the leading lwsync to instead be a sync.
> > > >=20
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
> > > >=20
> > >=20
> > > Paul, I know this may be difficult, but could you recall why the
> > > __futex_atomic_op() and futex_atomic_cmpxchg_inatomic() also got
> > > involved into the movement of PPC_ATOMIC_EXIT_BARRIER to "sync"?
> > >=20
> > > I did some search, but couldn't find the discussion of that patch.
> > >=20
> > > I ask this because I recall Peter once bought up a discussion:
> > >=20
> > > https://lkml.org/lkml/2015/8/26/596
> > >=20
> > > Peter's conclusion seems to be that we could(though didn't want to) l=
ive
> > > with futex atomics not being full barriers.
>=20
> I have heard of user-level applications relying on unlock-lock being a
> full barrier.  So paranoia would argue for the full barrier.
>=20

Understood.

So a full barrier on one side of these operations is enough, I think.
IOW, there is no need to strengthen these operations.

> > > Peter, just be clear, I'm not in favor of relaxing futex atomics. But=
 if
> > > I make PPC_ATOMIC_ENTRY_BARRIER being "sync", it will also strengthen
> > > the futex atomics, just wonder whether such strengthen is a -fix- or
> > > not, considering that I want this patch to go to -stable tree.
> >=20
> > So Linus' argued that since we only need to order against user accesses
> > (true) and priv changes typically imply strong barriers (open) we might
> > want to allow archs to rely on those instead of mandating they have
> > explicit barriers in the futex primitives.
> >=20
> > And I indeed forgot to follow up on that discussion.
> >=20
> > So; does PPC imply full barriers on user<->kernel boundaries? If so, its
> > not critical to the futex atomic implementations what extra barriers are
> > added.
> >=20
> > If not; then strengthening the futex ops is indeed (probably) a good
> > thing :-)

Peter, that's probably a good thing, but I'm not that familiar with
futex right now, so I won't touch that part if unnecessary in this
series.

Regards,
Boqun

>=20
> I am not seeing a sync there, but I really have to defer to the
> maintainers on this one.  I could easily have missed one.
>=20
> 							Thanx, Paul
>=20

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWJ1CLAAoJEEl56MO1B/q4H1sH/0035ijoSUx0KX7eQ6iadgix
JiYuExgRt/4P04w6CWGQcqTp3JXk0XoIr7M3rpwhUXQsXLA16GVO3FZVt1oUmzhi
HNLYwFOjizWFy7ZyjWS37eo+WIavFskUk/JkDCt5diyJ4/d9NgQRMtFt2WmIYR1w
qNdMU+o1LUFJ5agr0itBHM+1hhaPSa8c8YAixLgHI8XemATtlCnW8TAQMfdH70nI
cVC05yrQM8uUYMjPRtj7r6DRfQ9JEiZMEpfQbhHx+1hnUQO6P44zrGWE/gczEpcN
16Z8N3rYx89R9l5Cym8Un0IJEJww9jbebEF1VykFvo3oZPOV5v8peXfqwEGjYY4=
=eECa
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
