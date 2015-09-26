Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x22a.google.com (mail-ob0-x22a.google.com
 [IPv6:2607:f8b0:4003:c01::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1A73C1A03A8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2015 12:18:57 +1000 (AEST)
Received: by obbda8 with SMTP id da8so94982440obb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 19:18:54 -0700 (PDT)
Date: Sat, 26 Sep 2015 10:18:29 +0800
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
Message-ID: <20150926021829.GB1814@fixme-laptop.cn.ibm.com>
References: <1442418575-12297-4-git-send-email-boqun.feng@gmail.com>
 <20150918165902.GF12837@arm.com>
 <20150919153310.GB20458@fixme-laptop.cn.ibm.com>
 <20150920082303.GA1166@fixme-laptop.cn.ibm.com>
 <20150921222427.GG7356@arm.com>
 <20150921232656.GC970@fixme-laptop.cn.ibm.com>
 <20150921233704.GD970@fixme-laptop.cn.ibm.com>
 <20150922152540.GO4029@linux.vnet.ibm.com>
 <20150923000754.GB27867@fixme-laptop.cn.ibm.com>
 <20150925212904.GC30373@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
In-Reply-To: <20150925212904.GC30373@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2015 at 02:29:04PM -0700, Paul E. McKenney wrote:
> On Wed, Sep 23, 2015 at 08:07:55AM +0800, Boqun Feng wrote:
> > On Tue, Sep 22, 2015 at 08:25:40AM -0700, Paul E. McKenney wrote:
> > > On Tue, Sep 22, 2015 at 07:37:04AM +0800, Boqun Feng wrote:
> > > > On Tue, Sep 22, 2015 at 07:26:56AM +0800, Boqun Feng wrote:
> > > > > On Mon, Sep 21, 2015 at 11:24:27PM +0100, Will Deacon wrote:
> > > > > > Hi Boqun,
> > > > > >=20
> > > > > > On Sun, Sep 20, 2015 at 09:23:03AM +0100, Boqun Feng wrote:
> > > > > > > On Sat, Sep 19, 2015 at 11:33:10PM +0800, Boqun Feng wrote:
> > > > > > > > On Fri, Sep 18, 2015 at 05:59:02PM +0100, Will Deacon wrote:
> > > > > > > > > On Wed, Sep 16, 2015 at 04:49:31PM +0100, Boqun Feng wrot=
e:
> > > > > > > > > > On powerpc, we don't need a general memory barrier to a=
chieve acquire and
> > > > > > > > > > release semantics, so __atomic_op_{acquire,release} can=
 be implemented
> > > > > > > > > > using "lwsync" and "isync".
> > > > > > > > >=20
> > > > > > > > > I'm assuming isync+ctrl isn't transitive, so we need to g=
et to the bottom
> > > > > > > >=20
> > > > > > > > Actually the transitivity is still guaranteed here, I think=
 ;-)
> > > > > >=20
> > > > > > The litmus test I'm thinking of is:
> > > > > >=20
> > > > > >=20
> > > > > > {
> > > > > > 0:r2=3Dx;
> > > > > > 1:r2=3Dx; 1:r5=3Dz;
> > > > > > 2:r2=3Dz; 2:r4=3Dx;
> > > > > > }
> > > > > >  P0           | P1            | P2           ;
> > > > > >  li r1,1      | lwz r1,0(r2)  | lwz r1,0(r2) ;
> > > > > >  stw r1,0(r2) | cmpw r1,r1    | cmpw r1,r1   ;
> > > > > >               | beq LC00      | beq  LC01    ;
> > > > > >               | LC00:         | LC01:        ;
> > > > > >               | isync         | isync        ;
> > > > > >               | li r4,1       | lwz r3,0(r4) ;
> > > > > >               | stw r4,0(r5)  |              ;
> > > > > > exists
> > > > > > (1:r1=3D1 /\ 2:r1=3D1 /\ 2:r3=3D0)
> > > > > >=20
> > > > > >=20
> > > > > > Which appears to be allowed. I don't think you need to worry ab=
out backwards
> > > > > > branches for the ctrl+isync construction (none of the current e=
xample do,
> > > > > > afaict).
> > > > > >=20
> > > > >=20
> > > > > Yes.. my care of backwards branches is not quite related to the t=
opic, I
> > > > > concerned that mostly because my test is using atomic operation, =
and I
> > > > > just want to test the exact asm code.
> > > > >=20
> > > > > > Anyway, all the problematic cases seem to arise when we start m=
ixing
> > > > > > ACQUIRE/RELEASE accesses with relaxed accesses (i.e. where an a=
ccess from
> > > > > > one group reads from an access in the other group). It would be=
 simplest
> > > > > > to say that this doesn't provide any transitivity guarantees, a=
nd that
> > > > > > an ACQUIRE must always read from a RELEASE if transitivity is r=
equired.
> > > > > >=20
> > > > >=20
> > > > > Agreed. RELEASE alone doesn't provide transitivity and transitivi=
ty is
> > > >           ^^^^^^^
> > > > This should be ACQUIRE...
> > > >=20
> > > > > guaranteed only if an ACQUIRE read from a RELEASE. That's exactly=
 the
> > > > > direction which the link (https://lkml.org/lkml/2015/9/15/836) is
> > > > > heading to. So I think we are fine here to use ctrl+isync here, r=
ight?
> > >=20
> > > We are going to have to err on the side of strictness, that is, having
> > > the documentation place more requirements on the developer than the u=
nion
> > > of the hardware does.  Besides, I haven't heard any recent complaints
> > > that memory-barriers.txt is too simple.  ;-)
> >=20
> > Agreed ;-)
> >=20
> > For atomic operations, using isync in ACQUIRE operations does gaurantee
> > that a pure RELEASE/ACQUIRE chain provides transitivity. So, again, I
> > think we are fine here to use isync in ACQUIRE atomic operations,
> > unless you think we need to be more strict, i.e, making ACQUIRE itself
> > provide transitivy?
>=20
> As I understand it, either isync or lwsync suffices, with the choice
> depending on the hardware.  The kernel will rewrite itself at boot time
> if you use the appropriate macro.  ;-)
>=20

Yep ;-)

Thank you and Will both for your comments. To be honest, I just began to
learn about these transitivity and cumulativity things recently. That's
a lot of fun to discuss these with you, Peter and Will, and the
herdtools you suggested and the N2745 document you wrote really helped a
lot. Thank you again!

Regards,
Boqun

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWBgBuAAoJEEl56MO1B/q42QwH/1kBixM6PrsET/ev+uZboyJC
bMSfPvToIS6WoiKHh0dX9RTKtlpvO1xm0IfTV/4r/geeqWrAoIrnaH0LIijH+2gs
qgGEFVsYOidoWoQQ9JcbL72CEenWf+1Y6Dijnd/51PFE/1F6vCZYFkoyTWDt0UVO
S+FCg1k1ymSmJC/EuFL93oxNVzjeraupTUiEQ2ElXWcfPEjoVpbG9KPnwqN/9Lmb
TofEr0lbboSdhaRiXYZw0QJMJV2K8HKybX9aQMerWfuIinF2UemgWiRsaePul3F0
Im7oW+4Y/ZYJrUQOCzIkuoBS1JrVwS/CENf0Ci7xFtEI0LJRqRaS37cp/waPnkk=
=0QrP
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
