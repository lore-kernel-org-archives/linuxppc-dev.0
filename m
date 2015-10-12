Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x22e.google.com (mail-ob0-x22e.google.com
 [IPv6:2607:f8b0:4003:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9A131A06BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 18:03:47 +1100 (AEDT)
Received: by obbda8 with SMTP id da8so101074400obb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 00:03:45 -0700 (PDT)
Date: Mon, 12 Oct 2015 15:03:18 +0800
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
Message-ID: <20151012070317.GE27351@fixme-laptop.cn.ibm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-6-git-send-email-boqun.feng@gmail.com>
 <20151001122715.GQ2881@worktop.programming.kicks-ass.net>
 <20151010015805.GA946@fixme-laptop.cn.ibm.com>
 <20151011102520.GB27351@fixme-laptop.cn.ibm.com>
 <20151012064621.GL3604@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FFoLq8A0u+X9iRU8"
In-Reply-To: <20151012064621.GL3604@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--FFoLq8A0u+X9iRU8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2015 at 08:46:21AM +0200, Peter Zijlstra wrote:
> On Sun, Oct 11, 2015 at 06:25:20PM +0800, Boqun Feng wrote:
> > On Sat, Oct 10, 2015 at 09:58:05AM +0800, Boqun Feng wrote:
> > > Hi Peter,
> > >=20
> > > Sorry for replying late.
> > >=20
> > > On Thu, Oct 01, 2015 at 02:27:16PM +0200, Peter Zijlstra wrote:
> > > > On Wed, Sep 16, 2015 at 11:49:33PM +0800, Boqun Feng wrote:
> > > > > Unlike other atomic operation variants, cmpxchg{,64}_acquire and
> > > > > atomic{,64}_cmpxchg_acquire don't have acquire semantics if the c=
mp part
> > > > > fails, so we need to implement these using assembly.
> > > >=20
> > > > I think that is actually expected and documented. That is, a cmpxchg
> > > > only implies barriers on success. See:
> > > >=20
> > > >   ed2de9f74ecb ("locking/Documentation: Clarify failed cmpxchg() me=
mory ordering semantics")
> > >=20
> > > I probably didn't make myself clear here, my point is that if we use
> > > __atomic_op_acquire() to built *_cmpchg_acquire(For ARM and PowerPC),
> > > the barrier will be implied _unconditionally_, meaning no matter cmp
> > > fails or not, there will be a barrier after the cmpxchg operation.
> > > Therefore we have to use assembly to implement the operations right n=
ow.
>=20
> See later, but no, you don't _have_ to.
>=20
> > Or let me try another way to explain this. What I wanted to say here is
> > that unlike the implementation of xchg family, which needs only to
> > implement _relaxed version and *remove* the fully ordered version, the
> > implementation of cmpxchg family needs to *remain* the fully ordered
> > version and implement the _acquire version in assembly. Because if we
> > use __atomic_op_*(), the barriers in the cmpxchg family will be implied
> > *unconditionally*, for example:
>=20
> So the point that confused me, and which is still valid for the above,
> is your use of 'need'.
>=20

Indeed, my apologies for confusing more..

> You don't need to omit the barrier at all. Its perfectly valid to issue
> too many barriers (pointless and a waste of time, yes; incorrect, no).
>=20

Agreed.

> So what you want to say is: "Optimize cmpxchg_acquire() to avoid
> superfluous barrier".

Yes. I would like to implement a cmpxchg_acquire that really has no
barrier if cmp failed, which became my 'need' for the implementation.
But you are right, we don't have to omit the barrier. I will modify the
commit log to explain this clear in the next version. Thank you!

Regards,
Boqun

--FFoLq8A0u+X9iRU8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWG1swAAoJEEl56MO1B/q4+NMH/jt9uYjYIMY0Uw0IfJcmKod/
l+tWnwLsHmtxFjstK1deUk7uNDqUlt4SZwnToPfaVCDyBXqRKDtxWEw9goWt1bOm
bzEIz7PW4aCPD93MTthz7Ywo7fMXNDe00fyTciaAdDQIacfWwOSqRevh5Svhkiml
hG0v4ofYaZBqZjXLAydHX1UGuS8XZliJCFXTLF6Qp+Z2Df6KCZ2gtwCrODldY+u4
z3YlrNQHRpcjaU1OCqHrXMDEfAdv4mRd6n7IY6FeQEkDpGlw86PMXJvamJRP0zOs
JPu2DC4pIZZhMxTQJKHUsHUhlAtYTPmRNRGxj88aXcX8RKRoMEEdwdlNciUIz38=
=Cp19
-----END PGP SIGNATURE-----

--FFoLq8A0u+X9iRU8--
