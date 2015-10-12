Return-Path: <boqun.feng@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FBEA1A0682
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 12:18:17 +1100 (AEDT)
Received: by pablk4 with SMTP id lk4so139077613pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Oct 2015 18:18:15 -0700 (PDT)
Date: Mon, 12 Oct 2015 09:17:50 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 4/7] powerpc: atomic: Implement xchg_* and
 atomic{,64}_xchg_* variants
Message-ID: <20151012011749.GD27351@fixme-laptop.cn.ibm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-5-git-send-email-boqun.feng@gmail.com>
 <20151001122440.GP2881@worktop.programming.kicks-ass.net>
 <20151001150909.GC4043@linux.vnet.ibm.com>
 <20151001171304.GX3816@twins.programming.kicks-ass.net>
 <20151001180301.GJ4043@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
In-Reply-To: <20151001180301.GJ4043@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Thu, Oct 01, 2015 at 11:03:01AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 01, 2015 at 07:13:04PM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 01, 2015 at 08:09:09AM -0700, Paul E. McKenney wrote:
> > > On Thu, Oct 01, 2015 at 02:24:40PM +0200, Peter Zijlstra wrote:
> >=20
> > > > I must say I'm somewhat surprised by this level of relaxation, I had
> > > > expected to only loose SMP barriers, not the program order ones.
> > > >=20
> > > > Is there a good argument for this?
> > >=20
> > > Yes, when we say "relaxed", we really mean relaxed.  ;-)
> > >=20
> > > Both the CPU and the compiler are allowed to reorder around relaxed
> > > operations.
> >=20
> > Is this documented somewhere, because I completely missed this part.
>=20
> Well, yes, these need to be added to the documentation.  I am assuming

Maybe it's good time for us to call it out which operation should be
a compiler barrier or a CPU barrier?

I had something in my mind while I was working on this series, not
really sure whether it's correct, but probably a start point:

All global and local atomic operations are at least atomic(no one can
observe the middle state) and volatile(compilers can't optimize out the
memory access). Based on this, there are four strictness levels, one
can rely on them:

RELAXED: neither a compiler barrier or a CPU barrier
LOCAL: a compiler barrier
PARTIAL: both a compiler barrier and a CPU barrier but not transitive
FULL: both compiler barrier and a CPU barrier, and transitive.

RELAXED includes all _relaxed variants and non-return atomics, LOCAL
includes all local atomics(local_* and {cmp}xchg_local), PARTIAL
includes _acquire and _release operations and FULL includes all fully
ordered global atomic operations.

Thoughts?

Regards,
Boqun

> that Will is looking to have the same effect as C11 memory_order_relaxed,
> which is relaxed in this sense.  If he has something else in mind,
> he needs to tell us what it is and why.  ;-)
>=20
> 							Thanx, Paul
>=20

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWGwo5AAoJEEl56MO1B/q49IUH/08kIxilvP51/o9NCa7x6RZg
PPiBZhgdiZQjighMobyoRmdzNHdWin20m2SpVrFwQc13wV40f/MmLFQP4WGWP32s
doVK5CJnlN31SG6jjX8P0Q+YeoIzcSg6XQAemt/cVvTx5cRgtQuM9oJyB/fHRjcz
8LzNyH8bDn+Ixj2zFr8EiE3kxfMWLNp4q5pjxRYw0eGuT8yLrxeevqcR7EsayUaw
/KpukSAhE4y2RzO890RRrG3ou3BBBp7gI43sf8EYBQ+7WlExLfxt/EpZ9YOGBnZe
vVX3SaFnlKe6OfE3FkQVEfcSrb8qoamNB3vXUiN9bP0ZOd61fASXTIGhVNMCP60=
=64m0
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
