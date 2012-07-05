Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8B0902C01EA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 21:40:05 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [RFC PATCH 06/17] KVM: PPC: e500: Add emulation helper for
 getting instruction ea
Date: Thu, 5 Jul 2012 11:39:57 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF15B1B3@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-7-git-send-email-mihai.caraman@freescale.com>
 <3307E7D5-838B-462D-AFE9-B8BC107496CD@suse.de>
In-Reply-To: <3307E7D5-838B-462D-AFE9-B8BC107496CD@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: kvm-ppc-owner@vger.kernel.org [mailto:kvm-ppc-
> owner@vger.kernel.org] On Behalf Of Alexander Graf
> Sent: Wednesday, July 04, 2012 4:56 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
> Subject: Re: [RFC PATCH 06/17] KVM: PPC: e500: Add emulation helper for
> getting instruction ea
>=20
>=20
> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>=20
> > Add emulation helper for getting instruction ea and refactor tlb
> instruction
> > emulation to use it.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> > arch/powerpc/kvm/e500.h         |    6 +++---
> > arch/powerpc/kvm/e500_emulate.c |   21 ++++++++++++++++++---
> > arch/powerpc/kvm/e500_tlb.c     |   23 ++++++-----------------
> > 3 files changed, 27 insertions(+), 23 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
> > index 3e31098..70bfed4 100644
> > --- a/arch/powerpc/kvm/e500.h
> > +++ b/arch/powerpc/kvm/e500.h
> > @@ -130,9 +130,9 @@ int kvmppc_e500_emul_mt_mmucsr0(struct
> kvmppc_vcpu_e500 *vcpu_e500,
> > 				ulong value);
> > int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu);
> > int kvmppc_e500_emul_tlbre(struct kvm_vcpu *vcpu);
> > -int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, int ra, int rb);
> > -int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, int
> rb);
> > -int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, int rb);
> > +int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, gva_t ea);
> > +int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, gva_t ea);
> > +int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, gva_t ea);
> > int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500);
> > void kvmppc_e500_tlb_uninit(struct kvmppc_vcpu_e500 *vcpu_e500);
> >
> > diff --git a/arch/powerpc/kvm/e500_emulate.c
> b/arch/powerpc/kvm/e500_emulate.c
> > index 8b99e07..81288f7 100644
> > --- a/arch/powerpc/kvm/e500_emulate.c
> > +++ b/arch/powerpc/kvm/e500_emulate.c
> > @@ -82,6 +82,17 @@ static int kvmppc_e500_emul_msgsnd(struct kvm_vcpu
> *vcpu, int rb)
> > }
> > #endif
> >
> > +static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int
> ra, int rb)
> > +{
> > +	ulong ea;
> > +
> > +	ea =3D kvmppc_get_gpr(vcpu, rb);
> > +	if (ra)
> > +		ea +=3D kvmppc_get_gpr(vcpu, ra);
> > +
> > +	return ea;
> > +}
> > +
>=20
> Please move this one to arch/powerpc/include/asm/kvm_ppc.h.

Yep. This is similar with what I had in my internal version before emulatio=
n
refactoring took place upstream. The only difference is that I split the em=
bedded
and server implementation touching this files:
	arch/powerpc/include/asm/kvm_booke.h
	arch/powerpc/include/asm/kvm_book3s.h

Which approach do you prefer?

>=20
> > int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
> >                            unsigned int inst, int *advance)
> > {
> > @@ -89,6 +100,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run,
> struct kvm_vcpu *vcpu,
> > 	int ra =3D get_ra(inst);
> > 	int rb =3D get_rb(inst);
> > 	int rt =3D get_rt(inst);
> > +	gva_t ea;
> >
> > 	switch (get_op(inst)) {
> > 	case 31:
> > @@ -113,15 +125,18 @@ int kvmppc_core_emulate_op(struct kvm_run *run,
> struct kvm_vcpu *vcpu,
> > 			break;
> >
> > 		case XOP_TLBSX:
> > -			emulated =3D kvmppc_e500_emul_tlbsx(vcpu,rb);
> > +			ea =3D kvmppc_get_ea_indexed(vcpu, ra, rb);
> > +			emulated =3D kvmppc_e500_emul_tlbsx(vcpu, ea);
> > 			break;
> >
> > 		case XOP_TLBILX:
> > -			emulated =3D kvmppc_e500_emul_tlbilx(vcpu, rt, ra, rb);
> > +			ea =3D kvmppc_get_ea_indexed(vcpu, ra, rb);
> > +			emulated =3D kvmppc_e500_emul_tlbilx(vcpu, rt, ea);
>=20
> What's the point in hiding ra+rb, but not rt? I like the idea of hiding
> the register semantics, but please move rt into a local variable that
> gets passed as pointer to kvmppc_e500_emul_tlbilx.

Why to send it as a pointer? rt which should be rather named t in this case
is an [in] value for tlbilx, according to section 6.11.4.9 in the PowerISA =
2.06b.

-Mike
