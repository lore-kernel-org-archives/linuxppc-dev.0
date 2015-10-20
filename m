Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x22d.google.com (mail-io0-x22d.google.com
 [IPv6:2607:f8b0:4001:c06::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FF081A0730
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 18:15:58 +1100 (AEDT)
Received: by iow1 with SMTP id 1so12490881iow.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 00:15:56 -0700 (PDT)
Date: Tue, 20 Oct 2015 15:15:32 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
In-Reply-To: <20151014201916.GB3910@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2015 at 01:19:17PM -0700, Paul E. McKenney wrote:
>=20
> Am I missing something here?  If not, it seems to me that you need
> the leading lwsync to instead be a sync.
>=20
> Of course, if I am not missing something, then this applies also to the
> value-returning RMW atomic operations that you pulled this pattern from.
> If so, it would seem that I didn't think through all the possibilities
> back when PPC_ATOMIC_EXIT_BARRIER moved to sync...  In fact, I believe
> that I worried about the RMW atomic operation acting as a barrier,
> but not as the load/store itself.  :-/
>=20

Paul, I know this may be difficult, but could you recall why the
__futex_atomic_op() and futex_atomic_cmpxchg_inatomic() also got
involved into the movement of PPC_ATOMIC_EXIT_BARRIER to "sync"?

I did some search, but couldn't find the discussion of that patch.

I ask this because I recall Peter once bought up a discussion:

https://lkml.org/lkml/2015/8/26/596

Peter's conclusion seems to be that we could(though didn't want to) live
with futex atomics not being full barriers.


Peter, just be clear, I'm not in favor of relaxing futex atomics. But if
I make PPC_ATOMIC_ENTRY_BARRIER being "sync", it will also strengthen
the futex atomics, just wonder whether such strengthen is a -fix- or
not, considering that I want this patch to go to -stable tree.


Of course, in the meanwhile of waiting for your answer, I will try to
figure out this by myself ;-)

Regards,
Boqun

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWJeoQAAoJEEl56MO1B/q49RsH/jQvYe8mK6e8u1Wb5wgNIw+e
57MbdqPsSpFEaopknDe7ZqHCGI9pyv1u29kfIpFLYiRkNj8hYKOpyILmcpSqMw57
NZzKgAxs/9M3K7oLWNnw1jl14emDu/uT3kw9aZfEH/Z4JeAnhq1JK45F/aj+NcwC
AgsEJt9pNyWMOyWuGirWp6PK0fnhZrxfAeI3MLJV3Qj/b+Fykt2pqqKOT7YVEAJl
QVMEBcJczfRlWrPLZnmYSDAIaZsHdA1/n5yD3RmK07L1NWN1BzZ9YBVupBIOVg1i
WqcocQYyVkLCLu6rVvUGWZ62Xk3eLFGpGfAnj6iYAICz6NfQqiHrpN/7+jdlfLw=
=UI8A
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
