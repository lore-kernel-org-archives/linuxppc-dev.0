Return-Path: <boqun.feng@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DA54E1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 01:41:19 +1100 (AEDT)
Received: by iodv82 with SMTP id v82so8670181iod.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 07:41:17 -0700 (PDT)
Date: Thu, 15 Oct 2015 22:40:52 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151015144052.GD29432@fixme-laptop.cn.ibm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151014210419.GY3604@twins.programming.kicks-ass.net>
 <20151014214453.GC3910@linux.vnet.ibm.com>
 <20151015103510.GA27524@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
In-Reply-To: <20151015103510.GA27524@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2015 at 11:35:44AM +0100, Will Deacon wrote:
>=20
> So arm64 is ok. Doesn't lwsync order store->store observability for PPC?
>=20

I did some litmus and put the result here. My understanding might be
wrong, and I think Paul can explain the lwsync and store->store order
better ;-)


When a store->lwsync->store pairs with load->lwsync->load, according to
herd, YES.

    PPC W+lwsync+W-R+lwsync+R
    "
      2015-10-15
      herds said (1:r1=3D0 /\ 1:r2=3D2) doesn't exist,
      so if P1 observe the write to 'b', it must also observe P0's write
      to 'a'
    "
    {
    0:r1=3D1; 0:r2=3D2; 0:r12=3Da; 0:r13=3Db;
    1:r1=3D0; 1:r2=3D0; 1:r12=3Da; 1:r13=3Db;
    }
   =20
     P0              | P1             ;
     stw r1, 0(r12)  | lwz r2, 0(r13) ;
     lwsync          | lwsync         ;
     stw r2, 0(r13)  | lwz r1, 0(r12) ;
   =20
    exists
    (1:r1=3D0 /\ 1:r2=3D2)


If observation also includes "a write on one CPU -override- another
write on another CPU", then

when a store->lwsync->store pairs(?) with store->sync->load, according
to herd, NO(?).

    PPC W+lwsync+W-W+sync+R
    "
      2015-10-15
      herds said (1:r1=3D0 /\ b=3D3) exists sometimes,
      so if P1 observe P0's write to 'b'(by 'overriding' this write to
      'b'), it may not observe P0's write to 'a'.
    "
    {
    0:r1=3D1; 0:r2=3D2; 0:r12=3Da; 0:r13=3Db;
    1:r1=3D0; 1:r2=3D3; 1:r12=3Da; 1:r13=3Db;
    }
   =20
     P0              | P1             ;
     stw r1, 0(r12)  | stw r2, 0(r13) ;
     lwsync          | sync         ;
     stw r2, 0(r13)  | lwz r1, 0(r12) ;
   =20
    exists
    (1:r1=3D0 /\ b=3D3)


Regards,
Boqun

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWH7rwAAoJEEl56MO1B/q4XJAH/1XJDZVoudfZ07wOz0JiZb5I
fjzLr3qKs7SbMxgciczRoMtzd3pBI9mylT7tbGGHF7EkNv70Lgt4CBWFKkn/zR6A
VmkEyDNZ0BzqXl2cwtgJjfJob/WRVXWIgu/yea13jEe0kWbaXgE9Kt07dPaYpInc
dEHXf0bzA+3PDP2NGkKBLNNWoIRcrnRCTvysFmvQbzDghjo8wOLG/2zWLC2Qp86O
Sx9tnHPZ2vikHDX4pm4Q/2FotbWu409Hzqp46WEHHYKMBmp1ib0Qdx5oZmjibGVZ
5VLjjDyArr2gytJRAj5yTtjYjivIVMJD7dJwLFwic6/lHjeRbD4qpi9C6wdZYnw=
=RQvd
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
