Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (unknown [212.105.56.243])
	by ozlabs.org (Postfix) with ESMTP id 04CD1688D6
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2005 02:11:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Sun, 11 Dec 2005 16:11:30 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D939486E9A@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <linuxppc-dev@ozlabs.org>
Subject: RE: Linux process ABI broken in 2.6?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>=20
> > On Fri, 2005-12-09 at 00:07 +0100, Tjernlund wrote:
> > > Seems like ppc32 kernel pass the application entry point address
> > > in r7 and MSR in r8 when starting the application. The=20
> source might be
> > > ret_from_syscall, in entry.S:=20
> > > 	...
> > > 	lwz	r7,_NIP(r1)
> > >  	lwz	r8,_MSR(r1)
> > >  	FIX_SRR1(r8, r0)
> > >  	lwz	r2,GPR2(r1)
> > > 	lwz	r1,GPR1(r1)
> > > 	mtspr	SPRN_SRR0,r7
> > > 	mtspr	SPRN_SRR1,r8
> > > 	SYNC
> > > 	RFI
> > > I am not convinced this is the source, but a non zero r7
> > > breaks static apps in uClibc.
> > >=20
> > > Is this on purpose and why?
> > >=20
> > > Secion 8.4.1 in
> > >=20
> http://refspecs.freestandards.org/LSB_3.1.0/LSB-Core-PPC32/LSB
> -Core-PPC32.html#PROCESSINITIALIZATION
> > >=20
> > > says:
> > > "Contrary to what is stated in the Registers part of=20
> chapter 3 of the System V Application Binary Interface=20
> PowerPC Processor
> > > Supplement there are no values set in registers r3, r4,=20
> r5, r6 and r7. Instead the values specified to appear in all of those
> > > registers except r7 are placed on the stack. The value to=20
> be placed into register r7, the termination function pointer=20
> is not passed
> > > to the process."
> > >=20
> > > How do one not pass a termination function in r7 other=20
> than setting
> > > r7 to zero?
> >
> > Just ignore those registers on entry. The semantics of a=20
> syscall are to
> > clobber all volatile registers and there is no point doing anything
> > else.
> >
> > Ben.
>=20
> [Sorry to break the thread, but I mailed from the wrong=20
> account which I can't reach ATM]
>=20
> Sure, but this syscall is a bit special as it has to prepare=20
> the runtime env. for the new process.
> Not having any defined value for register at process startup feels ..
>=20
> An undefined r7 register makes it hard to differ between=20
> dynamic and static apps in crt1.
> I now understand why glibc has its own non standard=20
> __libc_start function and I really don't
> want that in uClibc. Is it too much trouble to define r7 to=20
> always have a zero
> value at process startup?
>=20
> As far as I can tell 2.4 has all unused registers zeroed.

The only way to pass any info from ld.so to crt is to mess with the
stack, write a NULL word
before argc and set the stack ptr to point to it. Then let crt test for
a null word, if null
then crt will know that this is a dynamic app, if not then it is a
static app with no rtld_fini
function.

I feel the messing with the stack in this way not ideal, so I would like
to see a better
exec ABI where at least one register,r7, will be zero.

The fix is trivial, just swap r7 to r9 in the above assembler code.

Is that feasible?

 Jocke
