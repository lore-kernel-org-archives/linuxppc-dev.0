Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x243.google.com (mail-ob0-x243.google.com
 [IPv6:2607:f8b0:4003:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CE101A0B1A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 11:57:19 +1100 (AEDT)
Received: by obbhq1 with SMTP id hq1so2610501obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 17:57:17 -0700 (PDT)
Date: Fri, 30 Oct 2015 08:56:34 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Peter Zijlstra <peterz@infradead.org>,
 Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [RESEND, tip/locking/core, v5, 1/6] powerpc: atomic: Make
 _return atomics and *{cmp}xchg fully ordered
Message-ID: <20151030005633.GA2792@fixme-laptop.cn.ibm.com>
References: <1445854536-22645-1-git-send-email-boqun.feng@gmail.com>
 <20151027023347.6178D140E31@ozlabs.org>
 <20151027030652.GB26372@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <20151027030652.GB26372@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2015 at 11:06:52AM +0800, Boqun Feng wrote:
> On Tue, Oct 27, 2015 at 01:33:47PM +1100, Michael Ellerman wrote:
> > On Mon, 2015-26-10 at 10:15:36 UTC, Boqun Feng wrote:
> > > This patch fixes two problems to make value-returning atomics and
> > > {cmp}xchg fully ordered on PPC.
> >=20
> > Hi Boqun,
> >=20
> > Can you please split this into two patches. One that does the cmpxchg c=
hange
> > and one that changes PPC_ATOMIC_ENTRY_BARRIER.
> >=20
>=20
> OK, make sense ;-)
>=20
> > Also given how pervasive this change is I'd like to take it via the pow=
erpc
> > next tree, so can you please send this patch (which will be two after y=
ou split
> > it) as powerpc patches. And the rest can go via tip?
> >=20
>=20
> One problem is that patch 5 will remove __xchg_u32 and __xchg_64
> entirely, which are modified in this patch(patch 1), so there will be
> some conflicts if two branch get merged, I think.
>=20
> Alternative way is that all this series go to powerpc next tree as most
> of the dependent patches are already there. I just need to remove
> inc/dec related code and resend them when appropriate. Besides, I can
> pull patch 2 out and send it as a tip patch because it's general code
> and no one depends on this in this series.
>=20
> To summerize:
>=20
> patch 1(split to two), 3, 4(remove inc/dec implementation), 5, 6 sent as
> powerpc patches for powerpc next, patch 2(unmodified) sent as tip patch
> for locking/core.
>=20
> Peter and Michael, this works for you both?
>=20

Thoughts? ;-)

Regards,
Boqun

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWMsA+AAoJEEl56MO1B/q4X5gIALAKp08K8aGyse4orFvWuraL
wbX83E99D6vU3GyXxaCEclu0Xcf6Iz88r1lsbSX5hKoZ6Gr9fUsDNjbNLZBEXUXT
cAIjKvg6Kn+XFDT3xi1IsQ/zzy1AtqW1eG0u72l5KhC+CTw+pSupyOr23H52Ehqf
0CPJRQSUsaaEYoS9CyhvejonMwSQi2QH1hTBs2wnvWk1qYrgZxTJtU1vHX3/7BFS
oW4GPyDB7nX7STb0TGt9+cytaC1fTxtqPP4DBncGpd/QJE8zPPSHP/6EqacXPYyv
mamCKQMGMktdxgGgO3DR5vsLdqJYugGPXcLMJzvLMKwZ1w5VOiX5PytdRPYwscI=
=o9j1
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
