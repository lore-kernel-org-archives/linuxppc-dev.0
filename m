Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/15] celleb: interfaces to the hypervisor of Celleb
Date: Tue, 12 Dec 2006 21:13:32 +0100
References: <200612121121.kBCBLMBI029593@toshiba.co.jp>
In-Reply-To: <200612121121.kBCBLMBI029593@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612122113.32985.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 December 2006 12:21, Ishizaki Kou wrote:
> From: Jeremy Kerr <jk@ozlabs.org>
> Subject: Re: [PATCH 4/15] celleb: interfaces to the hypervisor of Celleb
> Date: Tue, 12 Dec 2006 14:50:40 +1100
>=20
> > > +static inline int64_t beat_allocate_memory(uint64_t __in0, uint64_t
> > > __in1, uint64_t __in2, uint64_t __in3,void** __out0,uint64_t* __out1)
> > > { +=A0 =A0 register uint64_t __reg0 __asm__("r3");
> > > + register uint64_t __reg1 __asm__("r4");
> > > + register uint64_t __reg2 __asm__("r5");
> > > + register uint64_t __reg3 __asm__("r6");
> > > + register uint64_t __sn __asm__("r11") =3D (0UL);
> > > + __reg0 =3D (uint64_t)__in0;
> > > + __reg1 =3D (uint64_t)__in1;
> > > + __reg2 =3D (uint64_t)__in2;
> > > + __reg3 =3D (uint64_t)__in3;
> > > + __asm__ __volatile__("or 2,2,2\n.long 0x44000022"
> > > + : "=3D&r"(__sn), "=3D&r"(__reg0), "=3D&r"(__reg1), "=3D&r"(__reg2),
> > > "=3D&r"(__reg3) + =A0: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg=
2),
> > > "4"(__reg3) + : "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*__out0 =3D (void*)__reg1;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0*__out1 =3D (uint64_t)__reg2;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if(__reg0) beat_errno =3D __reg0;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return __reg0;
> > > +}
>=20
> > Wow.
>=20
> > I'd start by implementing these in assembler, rather than making C look=
=20
> > like assembler. You'll be able to throw out the input argument=20
> > assignments, because (according to the ABI) your arguments will already=
=20
> > be in the registers you're assigning them to. You'll just need a little=
=20
> > post-call glue to assign the output arguments.
>=20
> Thanks, I understand that. The above code is written only to embed
> call-ups into inline function in C.
> So I think 'inlining hypervisor call' is thrown away from Linux.
> Is this correct?
>=20
> Anyway, we have no reason to divert implementation too far from that of
> pSeries, so we will make change the code.

I believe that if you change the hcall code to work like pseries,
it will be identical to the ps3 version (that we don't have yet).
Consequently, we should only have one copy of it. You can
probably start by copying arch/powerpc/platforms/pseries/hvCall.S
to arch/powerpc/kernel/cell-hvcall.S (anyone know a better name
for it?) and just change the register assignment.

The result should probably be something like this:

_GLOBAL(beat_hcall)
_GLOBAL(lv1_hcall)
	HMT_MEDIUM

	mfcr	r0
	stw	r0,8(r1)

	HCALL_INST_PRECALL

	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */

	mr      r11,r3
	mr	r3,r5
	mr	r4,r6
	mr	r5,r7
	mr	r6,r8
	mr	r7,r9
	mr	r8,r10

	HVSC				/* invoke the hypervisor */

	ld	r12,STK_PARM(r4)(r1)
	std	r4,  0(r12)
	std	r5,  8(r12)
	std	r6, 16(r12)
	std	r7, 24(r12)

	HCALL_INST_POSTCALL

	lwz	r0,8(r1)
	mtcrf	0xff,r0
	blr				/* return r3 =3D status */

	Arnd <><
