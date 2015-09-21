Return-Path: <boqun.feng@gmail.com>
Received: from mail-ig0-x22e.google.com (mail-ig0-x22e.google.com
 [IPv6:2607:f8b0:4001:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 889751A031B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 09:27:21 +1000 (AEST)
Received: by igxx6 with SMTP id x6so160215igx.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:27:19 -0700 (PDT)
Date: Tue, 22 Sep 2015 07:26:56 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 3/7] powerpc: atomic: Implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150921232656.GC970@fixme-laptop.cn.ibm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-4-git-send-email-boqun.feng@gmail.com>
 <20150918165902.GF12837@arm.com>
 <20150919153310.GB20458@fixme-laptop.cn.ibm.com>
 <20150920082303.GA1166@fixme-laptop.cn.ibm.com>
 <20150921222427.GG7356@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
In-Reply-To: <20150921222427.GG7356@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2015 at 11:24:27PM +0100, Will Deacon wrote:
> Hi Boqun,
>=20
> On Sun, Sep 20, 2015 at 09:23:03AM +0100, Boqun Feng wrote:
> > On Sat, Sep 19, 2015 at 11:33:10PM +0800, Boqun Feng wrote:
> > > On Fri, Sep 18, 2015 at 05:59:02PM +0100, Will Deacon wrote:
> > > > On Wed, Sep 16, 2015 at 04:49:31PM +0100, Boqun Feng wrote:
> > > > > On powerpc, we don't need a general memory barrier to achieve acq=
uire and
> > > > > release semantics, so __atomic_op_{acquire,release} can be implem=
ented
> > > > > using "lwsync" and "isync".
> > > >=20
> > > > I'm assuming isync+ctrl isn't transitive, so we need to get to the =
bottom
> > >=20
> > > Actually the transitivity is still guaranteed here, I think ;-)
>=20
> The litmus test I'm thinking of is:
>=20
>=20
> {
> 0:r2=3Dx;
> 1:r2=3Dx; 1:r5=3Dz;
> 2:r2=3Dz; 2:r4=3Dx;
> }
>  P0           | P1            | P2           ;
>  li r1,1      | lwz r1,0(r2)  | lwz r1,0(r2) ;
>  stw r1,0(r2) | cmpw r1,r1    | cmpw r1,r1   ;
>               | beq LC00      | beq  LC01    ;
>               | LC00:         | LC01:        ;
>               | isync         | isync        ;
>               | li r4,1       | lwz r3,0(r4) ;
>               | stw r4,0(r5)  |              ;
> exists
> (1:r1=3D1 /\ 2:r1=3D1 /\ 2:r3=3D0)
>=20
>=20
> Which appears to be allowed. I don't think you need to worry about backwa=
rds
> branches for the ctrl+isync construction (none of the current example do,
> afaict).
>=20

Yes.. my care of backwards branches is not quite related to the topic, I
concerned that mostly because my test is using atomic operation, and I
just want to test the exact asm code.

> Anyway, all the problematic cases seem to arise when we start mixing
> ACQUIRE/RELEASE accesses with relaxed accesses (i.e. where an access from
> one group reads from an access in the other group). It would be simplest
> to say that this doesn't provide any transitivity guarantees, and that
> an ACQUIRE must always read from a RELEASE if transitivity is required.
>=20

Agreed. RELEASE alone doesn't provide transitivity and transitivity is
guaranteed only if an ACQUIRE read from a RELEASE. That's exactly the
direction which the link (https://lkml.org/lkml/2015/9/15/836) is
heading to. So I think we are fine here to use ctrl+isync here, right?

Regards,
Boqun

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWAJI8AAoJEEl56MO1B/q4zqkH/3dzlyiyx73GLcYs4Fh6gJd8
saKcJe0ELVCGM+jjXjpbFqv5ZEP9i7wf8XbjxXniT65v+E2wY3bRS9VgVvLWfNGe
srgNIB14JauxakgdBotqE9wAovTsodBDXqp5CSVUNdZpBQsgvVAYAmmi2lG9IV1o
BpAKcH0lm500cgMZ+iUZCk6zdl9T+hMhdbhZ6jNrsUB+h/z2u3rmEToTvv1brWPN
JwzwbVpthT0YXPDDdMbD2q10A/edy9jIXBivl7BJRWNwdhNITZ4g9eEX77d8n4t5
5GshAvUVgT+QxnLSPjq60+R7dTW2XMkrUH/IV4biW7MYxCzrLGalrpsIE1LjGoM=
=Ofmi
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
