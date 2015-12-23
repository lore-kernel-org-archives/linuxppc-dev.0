Return-Path: <boqun.feng@gmail.com>
Received: from mail-oi0-x231.google.com (mail-oi0-x231.google.com
 [IPv6:2607:f8b0:4003:c06::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABC331A0320
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 21:54:47 +1100 (AEDT)
Received: by mail-oi0-x231.google.com with SMTP id o62so116586422oif.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 02:54:47 -0800 (PST)
Date: Wed, 23 Dec 2015 18:54:10 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH powerpc/next v6 0/4] atomics: powerpc: Implement
 relaxed/acquire/release variants
Message-ID: <20151223105410.GA18401@fixme-laptop.cn.ibm.com>
References: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
 <1450838405.5036.6.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
In-Reply-To: <1450838405.5036.6.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2015 at 01:40:05PM +1100, Michael Ellerman wrote:
> On Tue, 2015-12-15 at 22:24 +0800, Boqun Feng wrote:
>=20
> > Hi all,
> >=20
> > This is v6 of the series.
> >=20
> > Link for v1: https://lkml.org/lkml/2015/8/27/798
> > Link for v2: https://lkml.org/lkml/2015/9/16/527
> > Link for v3: https://lkml.org/lkml/2015/10/12/368
> > Link for v4: https://lkml.org/lkml/2015/10/14/670
> > Link for v5: https://lkml.org/lkml/2015/10/26/141
> >=20
> >=20
> > Changes since v5:
> >=20
> > *	rebase on the next branch of powerpc.
> >=20
> > *	pull two fix and one testcase patches out, which are already
> > 	sent separately
> >=20
> > *	some clean up or code format fixing.
> >=20
> >=20
> > Paul, Peter and Will, thank you for your comments and suggestions in th=
e review
> > of previous versions. From this version on, This series is against the =
next
> > branch of powerpc tree, because most of the code touch arch/powerpc/*.
>=20
>=20
> Sorry if we already discussed this, but did we decide how we were going to
> merge this? There's the one patch to generic code and then three powerpc
> patches.
>=20
> It'd make most sense for it to go via powerpc I think. Given that the cha=
nge to
> generic code is relatively trivial I'll plan to merge this unless someone
> objects.
>=20
> Also it is pretty late in the -next cycle for something like this. But AF=
AICS
> there are no users of these "atomic*relaxed" variants yet other than arm6=
4 code
> and qspinlocks, neither of which are used on powerpc. So adding them shou=
ld be
> pretty harmless.
>=20

There is one thing we should be aware of, that is the bug:

http://lkml.kernel.org/r/5669D5F2.5050004@caviumnetworks.com

which though has been fixed by:

http://lkml.kernel.org/r/20151217160549.GH6344@twins.programming.kicks-ass.=
net

but the fix is not in powerpc/next right now. As this patchset makes
atomic_xchg_acquire a real ACQUIRE, so we will also trigger that bug if
this series gets merged in the next branch of powerpc tree, though
that's not the problem of this patchset.

Not sure whether this is a problem for your maintence, but just think
it's better to make you aware of this ;-)

Regards,
Boqun

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWen1OAAoJEEl56MO1B/q4mfAH/jXkGfs2mONANM5kkhBPZkhr
+tcwQKLduYFfdYsrtz4rI661GoIyBgIdOBa/6STpXGRsqO7vTpfRkOzmqJYy1d7P
LSvIMUvS5R5GZlNrRi9mrP4HURs/6e3qlC4T46ZP9qebFJ190f5UvvQ5R7CYzgmy
5OLZY5+sKFFVkfcWaDq7U2O+iayH8TvTqcn3bV08N+W/WcQHeavV+1+/Z1ZQaqsu
GgJNjAUFTaFkFDIi+cCPXvH0r0nQppZAZxX21fk8FtXudMjorVULhxJb0bxlMriN
NRFMrJGdwUEWJePOH4s/2C+8ch/sjmUqmnr7Zx9aPXUD9i79DTtmZqLpcF+quZQ=
=CZBL
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
