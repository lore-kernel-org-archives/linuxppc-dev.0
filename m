Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x22a.google.com (mail-ob0-x22a.google.com
 [IPv6:2607:f8b0:4003:c01::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6904E1A00EE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Dec 2015 11:31:09 +1100 (AEDT)
Received: by mail-ob0-x22a.google.com with SMTP id ba1so131964891obb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Dec 2015 16:31:09 -0800 (PST)
Date: Mon, 28 Dec 2015 08:30:29 +0800
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
Message-ID: <20151228003028.GA5104@fixme-laptop.cn.ibm.com>
References: <1450189457-10589-1-git-send-email-boqun.feng@gmail.com>
 <1450838405.5036.6.camel@ellerman.id.au>
 <20151223105410.GA18401@fixme-laptop.cn.ibm.com>
 <1451202819.29722.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
In-Reply-To: <1451202819.29722.1.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 27, 2015 at 06:53:39PM +1100, Michael Ellerman wrote:
> On Wed, 2015-12-23 at 18:54 +0800, Boqun Feng wrote:
> > On Wed, Dec 23, 2015 at 01:40:05PM +1100, Michael Ellerman wrote:
> > > On Tue, 2015-12-15 at 22:24 +0800, Boqun Feng wrote:
> > > > Hi all,
> > > >=20
> > > > This is v6 of the series.
> > > >=20
> > > > Link for v1: https://lkml.org/lkml/2015/8/27/798
> > > > Link for v2: https://lkml.org/lkml/2015/9/16/527
> > > > Link for v3: https://lkml.org/lkml/2015/10/12/368
> > > > Link for v4: https://lkml.org/lkml/2015/10/14/670
> > > > Link for v5: https://lkml.org/lkml/2015/10/26/141
> > > >=20
> > > >=20
> > > > Changes since v5:
> > > >=20
> > > > *	rebase on the next branch of powerpc.
> > > >=20
> > > > *	pull two fix and one testcase patches out, which are already
> > > > 	sent separately
> > > >=20
> > > > *	some clean up or code format fixing.
> > > >=20
> > > >=20
> > > > Paul, Peter and Will, thank you for your comments and suggestions i=
n the review
> > > > of previous versions. From this version on, This series is against =
the next
> > > > branch of powerpc tree, because most of the code touch arch/powerpc=
/*.
> > >=20
> > >=20
> > > Sorry if we already discussed this, but did we decide how we were goi=
ng to
> > > merge this? There's the one patch to generic code and then three powe=
rpc
> > > patches.
> > >=20
> > > It'd make most sense for it to go via powerpc I think. Given that the=
 change to
> > > generic code is relatively trivial I'll plan to merge this unless som=
eone
> > > objects.
> > >=20
> > > Also it is pretty late in the -next cycle for something like this. Bu=
t AFAICS
> > > there are no users of these "atomic*relaxed" variants yet other than =
arm64 code
> > > and qspinlocks, neither of which are used on powerpc. So adding them =
should be
> > > pretty harmless.
> > >=20
> >=20
> > There is one thing we should be aware of, that is the bug:
> >=20
> > http://lkml.kernel.org/r/5669D5F2.5050004@caviumnetworks.com
> >=20
> > which though has been fixed by:
> >=20
> > http://lkml.kernel.org/r/20151217160549.GH6344@twins.programming.kicks-=
ass.net
> >=20
> > but the fix is not in powerpc/next right now. As this patchset makes
> > atomic_xchg_acquire a real ACQUIRE, so we will also trigger that bug if
> > this series gets merged in the next branch of powerpc tree, though
> > that's not the problem of this patchset.
> >=20
> > Not sure whether this is a problem for your maintence, but just think
> > it's better to make you aware of this ;-)
>=20
> Yes that's pretty important thank you :)
>=20
> It's not so much that bug that's important, but the fact that I completely
> forget about the acquire/release implementations. Those are used already =
in
> mainline and so we don't want to add implementations this late in the cyc=
le
> without wider testing.
>=20

Understood.

> So I'll have to push this series until 4.6 so it can get some time in -ne=
xt.
> Sorry!
>=20

That's fine, thank you!

Regards,
Boqun

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWgIKdAAoJEEl56MO1B/q4y+4H/0dXjsYhc1nrIFPjyDYeYex7
Z+LBfwcCURewMOHvXAGjiZ6J8Qpg1WEIty3fHCzgrR8smkH7WoFXQJd6erQCbqZe
DF0Ohwkhn2wnPQBmzPEbahmXobBApB50O4wIBRJkw8DdvlCKv4fsniEA6nnnf7x9
BQvr4y+zgo5e8/FxzmmHd7sURp6uuk3R6U4NTO6gLcI5c2+zhggq3CUlpjlbT/pq
x3q4bTTc5gBtt1ODAu3QqGjHo9ZzD8wEtBU8jSjHs762QngmFRGHUPqu6C8lA5FZ
nlVI5y7SFYn9in4+6Vbz38hXOj/MDa1N2bdqlitEjtFW+aLLLMRNpPhpZH4tLWw=
=e+iI
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
