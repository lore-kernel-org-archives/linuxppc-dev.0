Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x234.google.com (mail-io0-x234.google.com
 [IPv6:2607:f8b0:4001:c06::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD6A81A0549
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 12:47:58 +1100 (AEDT)
Received: by iodv82 with SMTP id v82so40843237iod.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 18:47:56 -0700 (PDT)
Date: Wed, 14 Oct 2015 09:47:35 +0800
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
Message-ID: <20151014014735.GF23991@fixme-laptop.cn.ibm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444659246-24769-7-git-send-email-boqun.feng@gmail.com>
 <20151013132404.GI21550@arm.com>
 <20151013143259.GB23991@fixme-laptop.cn.ibm.com>
 <20151013144333.GN21550@arm.com>
 <20151013145830.GC23991@fixme-laptop.cn.ibm.com>
 <20151013150427.GP21550@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Y1L3PTX8QE8cb2T+"
In-Reply-To: <20151013150427.GP21550@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Y1L3PTX8QE8cb2T+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2015 at 04:04:27PM +0100, Will Deacon wrote:
> On Tue, Oct 13, 2015 at 10:58:30PM +0800, Boqun Feng wrote:
> > On Tue, Oct 13, 2015 at 03:43:33PM +0100, Will Deacon wrote:
> > > Putting a barrier in the middle of that critical section is probably a
> > > terrible idea, and that's why I thought you were avoiding it (hence my
> >=20
> > The fact is that I haven't thought of that way to implement
> > cmpxchg_release before you ask that question ;-) And I'm not going to do
> > that for now and probably not in the future.
> >=20
> > > original question). Perhaps just add a comment to that effect, since I
> >=20
> > Are you suggesting if I put a barrier in the middle I'd better to add a
> > comment, right? So if I don't do that, it's OK to let this patch as it.
>=20
> No, I mean put a comment in your file to explain the reason why you
> override _relaxed and _acquire, but not _release (because overriding

You mean overriding _acquire and fully order version, right?

> _release would introduce this weird barrier in the middle of the critical
> section, which would likely cause the conditional store to fail).
>=20
> Will

--Y1L3PTX8QE8cb2T+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWHbQzAAoJEEl56MO1B/q4JjIH/RtHBt8z/IElLm3upnFrejIp
ffZQmRxcGNDLtreAd/xNgY2clOVWTdC1jV6J1N2aHSRj21+tdlJk/1+hed1Zj3Oj
8F/gHk35UW0J++Yg7ID8YdLF14C+hoEHJjxiAgAuSuOrp6b2tFFbB8MlVVxKOr51
9PdghSihyAaFnNO3FXQC0qoj66sdzORUAwCt/aMVKqQlSzJkaLbYrNYv8oMCwDCP
P6KHtSkmvPXxfDgmKHbw3hx0zWB/LhSUXWtD6+i9H2vBNpMgwHMXAoSoNMqgBRE1
yWkMAMiSwG4wrkM70fhu2nnVwGIWnSVc6be/XavrILZJhUU4HSSmp7ArQ/OQMc8=
=ptoz
-----END PGP SIGNATURE-----

--Y1L3PTX8QE8cb2T+--
