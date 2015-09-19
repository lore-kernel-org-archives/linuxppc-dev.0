Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x22f.google.com (mail-ob0-x22f.google.com
 [IPv6:2607:f8b0:4003:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DAB41A03D4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2015 01:33:36 +1000 (AEST)
Received: by obbzf10 with SMTP id zf10so56730814obb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 08:33:34 -0700 (PDT)
Date: Sat, 19 Sep 2015 23:33:10 +0800
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
Message-ID: <20150919153310.GB20458@fixme-laptop.cn.ibm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-4-git-send-email-boqun.feng@gmail.com>
 <20150918165902.GF12837@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="24zk1gE8NUlDmwG9"
In-Reply-To: <20150918165902.GF12837@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Fri, Sep 18, 2015 at 05:59:02PM +0100, Will Deacon wrote:
> On Wed, Sep 16, 2015 at 04:49:31PM +0100, Boqun Feng wrote:
> > On powerpc, we don't need a general memory barrier to achieve acquire a=
nd
> > release semantics, so __atomic_op_{acquire,release} can be implemented
> > using "lwsync" and "isync".
>=20
> I'm assuming isync+ctrl isn't transitive, so we need to get to the bottom

Actually the transitivity is still guaranteed here, I think ;-)

(Before I put my reasoning, I have to admit I just learned about the
cumulativity recently, so my reasoning may be wrong. But the good thing
is that we have our POWER experts in the CCed. In case I'm wrong, they
could correct me.)

The thing is, on POWER, transitivity is implemented by a similar but
slightly different concept, cumulativity, and as said in the link:

http://www.rdrop.com/users/paulmck/scalability/paper/N2745r.2011.03.04a.html

"""
The ordering done by a memory barrier is said to be =E2=80=9Ccumulative=E2=
=80=9D if it
also orders storage accesses that are performed by processors and
mechanisms other than P1, as follows.

*	A includes all applicable storage accesses by any such processor
	or mechanism that have been performed with respect to P1 before
	the memory barrier is created.

*	B includes all applicable storage accesses by any such processor
	or mechanism that are performed after a Load instruction
	executed by that processor or mechanism has returned the value
	stored by a store that is in B.
"""

Please note that the set B can be extended indefinitely without any
other cumulative barrier.

So for a RELEASE+ACQUIRE pair to a same variable, as long as the barrier
in the RELEASE operation is cumumlative, the transitivity is guaranteed.
And lwsync is cumulative, so we are fine here.


I also wrote a herd litmus to test this. Due to the tool's limitation, I
use the xchg_release and xchg_acquire to test. And since herd doesn't
support backward branching, some tricks are used here to work around:


PPC lwsync+isync-transitivity
""
{
0:r1=3D1; 0:r2=3Dx; 0:r3=3D1; 0:r10=3D0 ; 0:r11=3D0; 0:r12=3Da;
1:r1=3D9; 1:r2=3Dx; 1:r3=3D1; 1:r10=3D0 ; 1:r11=3D0; 1:r12=3Da;
2:r1=3D9; 2:r2=3Dx; 2:r3=3D2; 2:r10=3D0 ; 2:r11=3D0; 2:r12=3Da;
}
 P0           | P1                  | P2                  ;
 stw r1,0(r2) | lwz r1,0(r2)        |                     ;
              | lwsync              | lwarx r11, r10, r12 ;
              | lwarx  r11,r10,r12  | stwcx. r3, r10, r12 ;
              | stwcx. r3,r10,r12   | bne Fail            ;
              |                     | isync               ;
              |                     | lwz r1, 0(r2)       ;
              |                     | Fail:               ;

exists
(1:r1=3D1 /\ 1:r11=3D0 /\ 2:r11=3D1 /\ 2:r1 =3D 0)


And the result of this litmus is that:

Test lwsync+isync-transitivity Allowed
States 15
1:r1=3D0; 1:r11=3D0; 2:r1=3D0; 2:r11=3D0;
1:r1=3D0; 1:r11=3D0; 2:r1=3D0; 2:r11=3D1;
1:r1=3D0; 1:r11=3D0; 2:r1=3D1; 2:r11=3D0;
1:r1=3D0; 1:r11=3D0; 2:r1=3D1; 2:r11=3D1;
1:r1=3D0; 1:r11=3D0; 2:r1=3D9; 2:r11=3D0;
1:r1=3D0; 1:r11=3D0; 2:r1=3D9; 2:r11=3D1;
1:r1=3D0; 1:r11=3D2; 2:r1=3D0; 2:r11=3D0;
1:r1=3D0; 1:r11=3D2; 2:r1=3D1; 2:r11=3D0;
1:r1=3D1; 1:r11=3D0; 2:r1=3D0; 2:r11=3D0;
1:r1=3D1; 1:r11=3D0; 2:r1=3D1; 2:r11=3D0;
1:r1=3D1; 1:r11=3D0; 2:r1=3D1; 2:r11=3D1;
1:r1=3D1; 1:r11=3D0; 2:r1=3D9; 2:r11=3D0;
1:r1=3D1; 1:r11=3D0; 2:r1=3D9; 2:r11=3D1;
1:r1=3D1; 1:r11=3D2; 2:r1=3D0; 2:r11=3D0;
1:r1=3D1; 1:r11=3D2; 2:r1=3D1; 2:r11=3D0;
No
Witnesses
Positive: 0 Negative: 29
Condition exists (1:r1=3D1 /\ 1:r11=3D0 /\ 2:r11=3D1 /\ 2:r1=3D0)
Observation lwsync+isync-transitivity Never 0 29

,which means transitivity is guaranteed.

Regards,
Boqun

> of the s390 thread you linked me to before we start spreading this
> further:
>=20
>   https://lkml.org/lkml/2015/9/15/836
>=20
> Will

--24zk1gE8NUlDmwG9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV/YAyAAoJEEl56MO1B/q4yjYIAIE20S89bHV1SyFhi+8LD1Cj
79lafRnPkt26aj8nl3J80Y/VZ4amq4tYVss8DSzYIfg+dVfhi6/jf/BxoJIoHDtk
zFIqRV4Ep1uAGV+o9ozIx/ySfl1sc8ozwDRJN+R3A/FOPPBQKgD6hrPGLo8WiCF0
yaUwNreln+yS1zcYnRxUFt9hPlWv4PACYKCf39TgrD9yrR7qkRvex2R2vP1TsDaf
rKr8iZ1fbrYLxTXXWdvJm2XtQI6XpvqSRCXS9rbQe6mbszI2uCiSkXrtOTlkuD5B
qIM8AU6k6y7ji6z9hBRmU5Ek5wBYSnr+S0mQeElt5/t7wjiXUSbP/GTWSx70pko=
=W6P6
-----END PGP SIGNATURE-----

--24zk1gE8NUlDmwG9--
