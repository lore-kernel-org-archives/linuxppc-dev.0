Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1F191A003D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 10:08:22 +1000 (AEST)
Received: by obbbh8 with SMTP id bh8so21315155obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 17:08:19 -0700 (PDT)
Date: Wed, 23 Sep 2015 08:07:55 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 3/7] powerpc: atomic: Implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150923000754.GB27867@fixme-laptop.cn.ibm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-4-git-send-email-boqun.feng@gmail.com>
 <20150918165902.GF12837@arm.com>
 <20150919153310.GB20458@fixme-laptop.cn.ibm.com>
 <20150920082303.GA1166@fixme-laptop.cn.ibm.com>
 <20150921222427.GG7356@arm.com>
 <20150921232656.GC970@fixme-laptop.cn.ibm.com>
 <20150921233704.GD970@fixme-laptop.cn.ibm.com>
 <20150922152540.GO4029@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
In-Reply-To: <20150922152540.GO4029@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2015 at 08:25:40AM -0700, Paul E. McKenney wrote:
> On Tue, Sep 22, 2015 at 07:37:04AM +0800, Boqun Feng wrote:
> > On Tue, Sep 22, 2015 at 07:26:56AM +0800, Boqun Feng wrote:
> > > On Mon, Sep 21, 2015 at 11:24:27PM +0100, Will Deacon wrote:
> > > > Hi Boqun,
> > > >=20
> > > > On Sun, Sep 20, 2015 at 09:23:03AM +0100, Boqun Feng wrote:
> > > > > On Sat, Sep 19, 2015 at 11:33:10PM +0800, Boqun Feng wrote:
> > > > > > On Fri, Sep 18, 2015 at 05:59:02PM +0100, Will Deacon wrote:
> > > > > > > On Wed, Sep 16, 2015 at 04:49:31PM +0100, Boqun Feng wrote:
> > > > > > > > On powerpc, we don't need a general memory barrier to achie=
ve acquire and
> > > > > > > > release semantics, so __atomic_op_{acquire,release} can be =
implemented
> > > > > > > > using "lwsync" and "isync".
> > > > > > >=20
> > > > > > > I'm assuming isync+ctrl isn't transitive, so we need to get t=
o the bottom
> > > > > >=20
> > > > > > Actually the transitivity is still guaranteed here, I think ;-)
> > > >=20
> > > > The litmus test I'm thinking of is:
> > > >=20
> > > >=20
> > > > {
> > > > 0:r2=3Dx;
> > > > 1:r2=3Dx; 1:r5=3Dz;
> > > > 2:r2=3Dz; 2:r4=3Dx;
> > > > }
> > > >  P0           | P1            | P2           ;
> > > >  li r1,1      | lwz r1,0(r2)  | lwz r1,0(r2) ;
> > > >  stw r1,0(r2) | cmpw r1,r1    | cmpw r1,r1   ;
> > > >               | beq LC00      | beq  LC01    ;
> > > >               | LC00:         | LC01:        ;
> > > >               | isync         | isync        ;
> > > >               | li r4,1       | lwz r3,0(r4) ;
> > > >               | stw r4,0(r5)  |              ;
> > > > exists
> > > > (1:r1=3D1 /\ 2:r1=3D1 /\ 2:r3=3D0)
> > > >=20
> > > >=20
> > > > Which appears to be allowed. I don't think you need to worry about =
backwards
> > > > branches for the ctrl+isync construction (none of the current examp=
le do,
> > > > afaict).
> > > >=20
> > >=20
> > > Yes.. my care of backwards branches is not quite related to the topic=
, I
> > > concerned that mostly because my test is using atomic operation, and I
> > > just want to test the exact asm code.
> > >=20
> > > > Anyway, all the problematic cases seem to arise when we start mixing
> > > > ACQUIRE/RELEASE accesses with relaxed accesses (i.e. where an acces=
s from
> > > > one group reads from an access in the other group). It would be sim=
plest
> > > > to say that this doesn't provide any transitivity guarantees, and t=
hat
> > > > an ACQUIRE must always read from a RELEASE if transitivity is requi=
red.
> > > >=20
> > >=20
> > > Agreed. RELEASE alone doesn't provide transitivity and transitivity is
> >           ^^^^^^^
> > This should be ACQUIRE...
> >=20
> > > guaranteed only if an ACQUIRE read from a RELEASE. That's exactly the
> > > direction which the link (https://lkml.org/lkml/2015/9/15/836) is
> > > heading to. So I think we are fine here to use ctrl+isync here, right?
>=20
> We are going to have to err on the side of strictness, that is, having
> the documentation place more requirements on the developer than the union
> of the hardware does.  Besides, I haven't heard any recent complaints
> that memory-barriers.txt is too simple.  ;-)
>=20

Agreed ;-)

For atomic operations, using isync in ACQUIRE operations does gaurantee
that a pure RELEASE/ACQUIRE chain provides transitivity. So, again, I
think we are fine here to use isync in ACQUIRE atomic operations,
unless you think we need to be more strict, i.e, making ACQUIRE itself
provide transitivy?

Regards,
Boqun

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWAe1PAAoJEEl56MO1B/q4pzsIAIbwTkBihCuuZXHm7rJt05tS
9ZB35n4mEeIaRK8rqJ+r12GChB4uSKX5XMcshN6Hd/49kXKyK78vxY/7xBmrziK7
WvgDJoI0CiXuUSGF3Uo6wW6d07G7kuAU4QHmAXNrLc1sGuPv5ky6VmwavC1bmboJ
TlD34E4MXdTw5wu3p1bqKBeVWafP03pQ0Rze1rTg2FpW+kXmNIhpM4vawaMXbtvH
cJPe6vr3m63rYNuF0+iG1NsBvDVl1h6KBKaZj2DcLuJdvGyRsBAFfTijc9aOIiH0
uTpAh/DPmcTFrOeCp4j1KVWlm/HLlEsE0Qs2KSG0931xjie09xktsvFQlg92uxM=
=nr2I
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
