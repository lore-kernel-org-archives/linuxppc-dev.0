Return-Path: <boqun.feng@gmail.com>
Received: from mail-ob0-x236.google.com (mail-ob0-x236.google.com
 [IPv6:2607:f8b0:4003:c01::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42CD11A0064
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2015 18:23:27 +1000 (AEST)
Received: by obbbh8 with SMTP id bh8so64045280obb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2015 01:23:25 -0700 (PDT)
Date: Sun, 20 Sep 2015 16:23:03 +0800
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
Message-ID: <20150920082303.GA1166@fixme-laptop.cn.ibm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-4-git-send-email-boqun.feng@gmail.com>
 <20150918165902.GF12837@arm.com>
 <20150919153310.GB20458@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
In-Reply-To: <20150919153310.GB20458@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2015 at 11:33:10PM +0800, Boqun Feng wrote:
> Hi Will,
>=20
> On Fri, Sep 18, 2015 at 05:59:02PM +0100, Will Deacon wrote:
> > On Wed, Sep 16, 2015 at 04:49:31PM +0100, Boqun Feng wrote:
> > > On powerpc, we don't need a general memory barrier to achieve acquire=
 and
> > > release semantics, so __atomic_op_{acquire,release} can be implemented
> > > using "lwsync" and "isync".
> >=20
> > I'm assuming isync+ctrl isn't transitive, so we need to get to the bott=
om
>=20
> Actually the transitivity is still guaranteed here, I think ;-)
>=20
> (Before I put my reasoning, I have to admit I just learned about the
> cumulativity recently, so my reasoning may be wrong. But the good thing
> is that we have our POWER experts in the CCed. In case I'm wrong, they
> could correct me.)
>=20
> The thing is, on POWER, transitivity is implemented by a similar but
> slightly different concept, cumulativity, and as said in the link:
>=20
> http://www.rdrop.com/users/paulmck/scalability/paper/N2745r.2011.03.04a.h=
tml
>=20
> """
> The ordering done by a memory barrier is said to be =E2=80=9Ccumulative=
=E2=80=9D if it
> also orders storage accesses that are performed by processors and
> mechanisms other than P1, as follows.
>=20
> *	A includes all applicable storage accesses by any such processor
> 	or mechanism that have been performed with respect to P1 before
> 	the memory barrier is created.
>=20
> *	B includes all applicable storage accesses by any such processor
> 	or mechanism that are performed after a Load instruction
> 	executed by that processor or mechanism has returned the value
> 	stored by a store that is in B.
> """
>=20
> Please note that the set B can be extended indefinitely without any
> other cumulative barrier.
>=20
> So for a RELEASE+ACQUIRE pair to a same variable, as long as the barrier
> in the RELEASE operation is cumumlative, the transitivity is guaranteed.
> And lwsync is cumulative, so we are fine here.
>=20
>=20
> I also wrote a herd litmus to test this. Due to the tool's limitation, I
> use the xchg_release and xchg_acquire to test. And since herd doesn't

Hmm.. I think I wanted to say atomic_xchg_release and
atomic_xchg_acquire here, sorry about that inaccuracy..

> support backward branching, some tricks are used here to work around:
>=20

And I check again, herd does suppor backward branching, the problem is
just if we use backward branching, there will be a lot more states the
tool need to check, but it seems there are not too many in this case, so
I modify the litmus a little bit as follow:

PPC lwsync+isync-transitivity
""
{
0:r1=3D1; 0:r2=3Dx; 0:r3=3D1; 0:r10=3D0 ; 0:r11=3D0; 0:r12=3Da;
1:r1=3D9; 1:r2=3Dx; 1:r3=3D1; 1:r10=3D0 ; 1:r11=3D0; 1:r12=3Da;
2:r1=3D9; 2:r2=3Dx; 2:r3=3D2; 2:r10=3D0 ; 2:r11=3D0; 2:r12=3Da;
}
 P0           | P1                  | P2                  ;
 stw r1,0(r2) | lwz r1,0(r2)        | Fail2:              ;
              | lwsync              | lwarx r11, r10, r12 ;
              | Fail1:              | stwcx. r3, r10, r12 ;
              | lwarx  r11,r10,r12  | bne Fail2           ;
              | stwcx. r3,r10,r12   | isync               ;
              | bne Fail1           | lwz r1, 0(r2)       ;=20

exists
(1:r1=3D1 /\ 1:r11=3D0 /\ 2:r11=3D1 /\ 2:r1 =3D 0)

which is actually:

CPU 0			CPU 1				CPU 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D		=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
{int x =3D 0, atomic_t a =3D ATOMIC_INIT(0)}
WRITE_ONCE(x,1);	t1 =3D READ_ONCE(x);		t2 =3D atomic_xchg_acquire(&a, 2);
			atomic_xchg_release(&a, 1);	t3 =3D READ_ONCE(x);

exists
(t1 =3D=3D 1 && t2 =3D=3D 1 && t3 =3D=3D 0)


The result is still(it may take a while to get the result):

Test lwsync+isync-transitivity Allowed
States 11
1:r1=3D0; 1:r11=3D0; 2:r1=3D0; 2:r11=3D0;
1:r1=3D0; 1:r11=3D0; 2:r1=3D0; 2:r11=3D1;
1:r1=3D0; 1:r11=3D0; 2:r1=3D1; 2:r11=3D0;
1:r1=3D0; 1:r11=3D0; 2:r1=3D1; 2:r11=3D1;
1:r1=3D0; 1:r11=3D2; 2:r1=3D0; 2:r11=3D0;
1:r1=3D0; 1:r11=3D2; 2:r1=3D1; 2:r11=3D0;
1:r1=3D1; 1:r11=3D0; 2:r1=3D0; 2:r11=3D0;
1:r1=3D1; 1:r11=3D0; 2:r1=3D1; 2:r11=3D0;
1:r1=3D1; 1:r11=3D0; 2:r1=3D1; 2:r11=3D1;
1:r1=3D1; 1:r11=3D2; 2:r1=3D0; 2:r11=3D0;
1:r1=3D1; 1:r11=3D2; 2:r1=3D1; 2:r11=3D0;
Loop No
Witnesses
Positive: 0 Negative: 198
Condition exists (1:r1=3D1 /\ 1:r11=3D0 /\ 2:r11=3D1 /\ 2:r1=3D0)
Observation lwsync+isync-transitivity Never 0 198

, which means transitivity is guaranteed.


And I think it deserves more analysis based on cumulativity:

Initially, for the lwsync on P1(CPU 1), we have set A and B of the
storage accesses on the same processor which lwsync orders:

A includes:
	on CPU 1:
		lwz r1, 0(r2) // t1 =3D READ_ONCE(x);=20

B includes:
	on CPU 1:
		lwarx  r11,r10,r12 // atomic_xchg_release();
		stwcx. r3,r10,r12

and as t1 =3D=3D 1, which means before lwsync, P1 perceives the STORE of x
on CPU 0, which makes another storage access is included in A:

A now includes:
	on CPU 0:
		stw r1, 0(r) // WRITE_ONCE(x,1);
	on CPU 1:
		lwz r1, 0(r2) // t1 =3D READ_ONCE(x);=20

B now includes:
	on CPU 1:
		lwarx  r11,r10,r12 // atomic_xchg_release();
		stwcx. r3,r10,r12

and as t2 =3D=3D 1, which means on CPU 2, "lwarx  r11,r10,r12" in
atomic_xchg_acqurie() reads the value stored by "stwcx. r3,r10,r12" in
atomic_xchg_release() on CPU 1, that makes all storage accesses
performed after atomic_xchg_acquire() get included in set B:

A now includes:
	on CPU 0:
		stw r1, 0(r) // WRITE_ONCE(x,1);
	on CPU 1:
		lwz r1, 0(r2) // t1 =3D READ_ONCE(x);=20

B now includes:
	on CPU 1:
		lwarx  r11,r10,r12 // atomic_xchg_release();
		stwcx. r3,r10,r12
	on CPU 2:
		lwz r1, 0(r2) // t3 =3D READ_ONCE(x);

Therefore the STORE of x on CPU 0 and the LOAD of x on CPU 2 can not be
reordered in this case, which means transitivity guaranteed.

Regards,
Boqun

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV/mzgAAoJEEl56MO1B/q42swH+wcORJyQO96WvZ+06ArD8g2U
zIrmqcFkN96rCWeLXLreyjvogPjL2I+s4tS94JRUzNcDwn0TQw3oz8lmX0vAx7HS
V9jqvype8vTs3moNMxuTeD7RlQ/0Je1+paFnHe0VEPA/zATWvI4dcQ3UqQeTfxTT
RhTmedb9UTiaSjZBmTrk13On9sn59egNTGoHHFDXIbQN2U0kg2FRplYpk8DBJ7Jy
ZBbBL1m7G7ppGjPsfRPKe520S2TkY8B1abUHCj4BUiAUZqlqveR0guhdl2NV2Hmv
gkfJ/pLx2z52h8O2Jw4jGR+Sbddt4iWxUAc9oRqwbQ2a987PXMuKpvgBB7QJXW8=
=4m7K
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
