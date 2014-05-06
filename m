Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0242.outbound.protection.outlook.com [207.46.163.242])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5406A14029E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 05:06:50 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH v2 3/4] KVM: PPC: Alow kvmppc_get_last_inst() to fail
Date: Tue, 6 May 2014 19:06:43 +0000
Message-ID: <f5c0d1ca058346edb91f347eeb399cac@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1398905152-18091-1-git-send-email-mihai.caraman@freescale.com>
 <1398905152-18091-4-git-send-email-mihai.caraman@freescale.com>
 <53636B71.2020103@suse.de>
In-Reply-To: <53636B71.2020103@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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
> From: Alexander Graf [mailto:agraf@suse.de]
> Sent: Friday, May 02, 2014 12:55 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org
> Subject: Re: [PATCH v2 3/4] KVM: PPC: Alow kvmppc_get_last_inst() to fail
>=20
> On 05/01/2014 02:45 AM, Mihai Caraman wrote:
...
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h
> b/arch/powerpc/include/asm/kvm_ppc.h
> > index 4096f16..6e7c358 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -72,6 +72,8 @@ extern int kvmppc_sanity_check(struct kvm_vcpu
> *vcpu);
> >   extern int kvmppc_subarch_vcpu_init(struct kvm_vcpu *vcpu);
> >   extern void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu);
> >
> > +extern int kvmppc_get_last_inst(struct kvm_vcpu *vcpu, u32 *inst);
>=20
> Phew. Moving this into a separate function sure has some performance
> implications. Was there no way to keep it in a header?
>=20
> You could just move it into its own .h file which we include after
> kvm_ppc.h. That way everything's available. That would also help me a
> lot with the little endian port where I'm also struggling with header
> file inclusion order and kvmppc_need_byteswap().

Great, I will do this.

> > diff --git a/arch/powerpc/kvm/book3s_pr.c
> b/arch/powerpc/kvm/book3s_pr.c
> > index c5c052a..b7fffd1 100644
> > --- a/arch/powerpc/kvm/book3s_pr.c
> > +++ b/arch/powerpc/kvm/book3s_pr.c
> > @@ -608,12 +608,9 @@ void kvmppc_giveup_ext(struct kvm_vcpu *vcpu,
> ulong msr)
> >
> >   static int kvmppc_read_inst(struct kvm_vcpu *vcpu)
> >   {
> > -	ulong srr0 =3D kvmppc_get_pc(vcpu);
> > -	u32 last_inst =3D kvmppc_get_last_inst(vcpu);
> > -	int ret;
> > +	u32 last_inst;
> >
> > -	ret =3D kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
> > -	if (ret =3D=3D -ENOENT) {
> > +	if (kvmppc_get_last_inst(vcpu, &last_inst) =3D=3D -ENOENT) {
>=20
> ENOENT?

You have to tell us :) Why does kvmppc_ld() mix emulation_result
enumeration with generic errors? Do you want to change that and
use EMULATE_FAIL instead?

>=20
> >   		ulong msr =3D vcpu->arch.shared->msr;
> >
> >   		msr =3D kvmppc_set_field(msr, 33, 33, 1);
> > @@ -867,15 +864,18 @@ int kvmppc_handle_exit_pr(struct kvm_run *run,
> struct kvm_vcpu *vcpu,
> >   	{
> >   		enum emulation_result er;
> >   		ulong flags;
> > +		u32 last_inst;
> >
> >   program_interrupt:
> >   		flags =3D vcpu->arch.shadow_srr1 & 0x1f0000ull;
> > +		kvmppc_get_last_inst(vcpu, &last_inst);
>=20
> No check for the return value?

Should we queue a program exception and resume guest?

>=20
> >
> >   		if (vcpu->arch.shared->msr & MSR_PR) {
> >   #ifdef EXIT_DEBUG
> > -			printk(KERN_INFO "Userspace triggered 0x700 exception
> at 0x%lx (0x%x)\n", kvmppc_get_pc(vcpu), kvmppc_get_last_inst(vcpu));
> > +			pr_info("Userspace triggered 0x700 exception at\n"
> > +			    "0x%lx (0x%x)\n", kvmppc_get_pc(vcpu), last_inst);
> >   #endif
> > -			if ((kvmppc_get_last_inst(vcpu) & 0xff0007ff) !=3D
> > +			if ((last_inst & 0xff0007ff) !=3D
> >   			    (INS_DCBZ & 0xfffffff7)) {
> >   				kvmppc_core_queue_program(vcpu, flags);
> >   				r =3D RESUME_GUEST;
> > @@ -894,7 +894,7 @@ program_interrupt:
> >   			break;
> >   		case EMULATE_FAIL:
> >   			printk(KERN_CRIT "%s: emulation at %lx failed
> (%08x)\n",
> > -			       __func__, kvmppc_get_pc(vcpu),
> kvmppc_get_last_inst(vcpu));
> > +			       __func__, kvmppc_get_pc(vcpu), last_inst);
> >   			kvmppc_core_queue_program(vcpu, flags);
> >   			r =3D RESUME_GUEST;
> >   			break;
> > @@ -911,8 +911,12 @@ program_interrupt:
> >   		break;
> >   	}
> >   	case BOOK3S_INTERRUPT_SYSCALL:
> > +	{
> > +		u32 last_sc;
> > +
> > +		kvmppc_get_last_sc(vcpu, &last_sc);
>=20
> No check for the return value?

The existing code does not handle KVM_INST_FETCH_FAILED.=20
How should we continue if papr is enabled and last_sc fails?

>=20
> >   		if (vcpu->arch.papr_enabled &&
> > -		    (kvmppc_get_last_sc(vcpu) =3D=3D 0x44000022) &&
> > +		    (last_sc =3D=3D 0x44000022) &&
> >   		    !(vcpu->arch.shared->msr & MSR_PR)) {
> >   			/* SC 1 papr hypercalls */
> >   			ulong cmd =3D kvmppc_get_gpr(vcpu, 3);
> > @@ -957,6 +961,7 @@ program_interrupt:
> >   			r =3D RESUME_GUEST;
> >   		}
> >   		break;
> > +	}
> >   	case BOOK3S_INTERRUPT_FP_UNAVAIL:
> >   	case BOOK3S_INTERRUPT_ALTIVEC:
> >   	case BOOK3S_INTERRUPT_VSX:
> > @@ -985,15 +990,20 @@ program_interrupt:
> >   		break;
> >   	}
> >   	case BOOK3S_INTERRUPT_ALIGNMENT:
> > +	{
> > +		u32 last_inst;
> > +
> >   		if (kvmppc_read_inst(vcpu) =3D=3D EMULATE_DONE) {
> > -			vcpu->arch.shared->dsisr =3D kvmppc_alignment_dsisr(vcpu,
> > -				kvmppc_get_last_inst(vcpu));
> > -			vcpu->arch.shared->dar =3D kvmppc_alignment_dar(vcpu,
> > -				kvmppc_get_last_inst(vcpu));
> > +			kvmppc_get_last_inst(vcpu, &last_inst);
>=20
> I think with an error returning kvmppc_get_last_inst we can just use
> completely get rid of kvmppc_read_inst() and only use
> kvmppc_get_last_inst() instead.

The only purpose of kvmppc_read_inst() function is to generate an
instruction storage interrupt in case of load failure. It is also called
from kvmppc_check_ext(). Do you suggest to get rid of this logic? Or to
duplicate it in order to avoid kvmppc_get_last_inst() redundant call?

>=20
> > +			vcpu->arch.shared->dsisr =3D
> > +				kvmppc_alignment_dsisr(vcpu, last_inst);
> > +			vcpu->arch.shared->dar =3D
> > +				kvmppc_alignment_dar(vcpu, last_inst);
> >   			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
> >   		}
> >   		r =3D RESUME_GUEST;
> >   		break;
> > +	}
> >   	case BOOK3S_INTERRUPT_MACHINE_CHECK:
> >   	case BOOK3S_INTERRUPT_TRACE:
> >   		kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> > index ab62109..df25db0 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -752,6 +752,9 @@ static int emulation_exit(struct kvm_run *run,
> struct kvm_vcpu *vcpu)
> >   		 * they were actually modified by emulation. */
> >   		return RESUME_GUEST_NV;
> >
> > +	case EMULATE_AGAIN:
> > +		return RESUME_GUEST;
> > +
> >   	case EMULATE_DO_DCR:
> >   		run->exit_reason =3D KVM_EXIT_DCR;
> >   		return RESUME_HOST;
> > @@ -1911,6 +1914,17 @@ void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
> >   	vcpu->kvm->arch.kvm_ops->vcpu_put(vcpu);
> >   }
> >
> > +int kvmppc_get_last_inst(struct kvm_vcpu *vcpu, u32 *inst)
> > +{
> > +	int result =3D EMULATE_DONE;
> > +
> > +	if (vcpu->arch.last_inst =3D=3D KVM_INST_FETCH_FAILED)
> > +		result =3D kvmppc_ld_inst(vcpu, &vcpu->arch.last_inst);
> > +	*inst =3D vcpu->arch.last_inst;
>=20
> This function looks almost identical to the book3s one. Can we share the
> same code path here? Just always return false for
> kvmppc_needs_byteswap() on booke.

Sounds good.

-Mike
