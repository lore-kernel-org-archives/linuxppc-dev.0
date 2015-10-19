Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com
 [IPv6:2607:f8b0:4001:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9C411A062A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 11:20:23 +1100 (AEDT)
Received: by iofz202 with SMTP id z202so1667970iof.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2015 17:20:21 -0700 (PDT)
Date: Mon, 19 Oct 2015 08:19:52 +0800
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
Message-ID: <20151019001952.GA924@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151014210419.GY3604@twins.programming.kicks-ass.net>
 <20151014214453.GC3910@linux.vnet.ibm.com>
 <20151015005321.GB29432@fixme-laptop.cn.ibm.com>
 <20151015030705.GD3910@linux.vnet.ibm.com>
 <20151015044803.GC29432@fixme-laptop.cn.ibm.com>
 <20151015163040.GJ3910@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <20151015163040.GJ3910@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2015 at 09:30:40AM -0700, Paul E. McKenney wrote:
> On Thu, Oct 15, 2015 at 12:48:03PM +0800, Boqun Feng wrote:
> > On Wed, Oct 14, 2015 at 08:07:05PM -0700, Paul E. McKenney wrote:
[snip]
> >=20
> > > Why not try creating a longer litmus test that requires P0's write to
> > > "a" to propagate to P1 before both processes complete?
> > >=20
> >=20
> > I will try to write one, but to be clear, you mean we still observe=20
> >=20
> > 0:r3 =3D=3D 0 && a =3D=3D 2 && 1:r3 =3D=3D 0=20
> >=20
> > at the end, right? Because I understand that if P1's write to 'a'
> > doesn't override P0's, P0's write to 'a' will propagate.
>=20
> Your choice.  My question is whether you can come up with a similar
> litmus test where lwsync is allowing the behavior here, but clearly
> is affecting some other aspect of ordering.
>=20

Got it, though my question about the propagation of P0's write to 'a'
was originally aimed at understanding the hardware behavior(or model) in
your sequence of events ;-)

To be clear, by "some other aspect of ordering", you mean something like
a paired RELEASE+ACQUIRE senario(i.e. P1 observes P0's write to 'a' via
a load, which means P0's write to 'a' propagates at some point), right?

If so I haven't yet came up with one, and I think there's probably none,
so my worry about "lwsync" in other places is likely unnecessary.

Regards,
Boqun

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWJDcjAAoJEEl56MO1B/q4FxsIAIAtOHoaTEWrZOHR7Y5Gjtst
Xd6Z8jtNhm1/YxrgrnywO87AkG6Nl9zxNv5jJDu52y8qY6BOEiTHKhTx0m7ZroTE
N2tru0xGAWkoDoUbZ+WoD1aUpfrYofWW5uHHr3H3+xwIkqzYUPmQiN+skNYv2OcJ
0q3PiHPMYYX60g4qCe/vpbuuCmosa3IBo1e0augpPBE20LyDoW+DTe2CHxC+WTFx
fhZGSWZpe16W9mbU9hiQhNgc2LUykhzthTeBDad2jRRNuePaKpeoYGFkz+t326Fb
0z4+8V0CCsKRJEfu4iNCJoVP+b89sah//ykQ3v5o60QS6p9fB0BJmQBRgzTCISU=
=7pCK
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
