Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BFE21A0003
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 02:18:26 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>, "kvm-ppc@vger.kernel.org"
 <kvm-ppc@vger.kernel.org>
Subject: RE: [PATCH 3/5 v4] KVM: PPC: Book3s: Remove kvmppc_read_inst()
 function
Date: Thu, 3 Jul 2014 16:18:18 +0000
Message-ID: <830562c87cb84ad1a02aded69f5b3e51@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1403909347-31622-1-git-send-email-mihai.caraman@freescale.com>
 <1403909347-31622-4-git-send-email-mihai.caraman@freescale.com>
 <53B55C81.8040300@suse.de>
In-Reply-To: <53B55C81.8040300@suse.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
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
> Sent: Thursday, July 03, 2014 4:37 PM
> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH 3/5 v4] KVM: PPC: Book3s: Remove kvmppc_read_inst()
> function
>=20
>=20
> On 28.06.14 00:49, Mihai Caraman wrote:
> > In the context of replacing kvmppc_ld() function calls with a version
> of
> > kvmppc_get_last_inst() which allow to fail, Alex Graf suggested this:
> >
> > "If we get EMULATE_AGAIN, we just have to make sure we go back into the
> guest.
> > No need to inject an ISI into  the guest - it'll do that all by itself.
> > With an error returning kvmppc_get_last_inst we can just use completely
> > get rid of kvmppc_read_inst() and only use kvmppc_get_last_inst()
> instead."
> >
> > As a intermediate step get rid of kvmppc_read_inst() and only use
> kvmppc_ld()
> > instead.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> > v4:
> >   - new patch
> >
> >   arch/powerpc/kvm/book3s_pr.c | 85 ++++++++++++++++++-----------------
> ---------
> >   1 file changed, 35 insertions(+), 50 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_pr.c
> b/arch/powerpc/kvm/book3s_pr.c
> > index 15fd6c2..d247d88 100644
> > --- a/arch/powerpc/kvm/book3s_pr.c
> > +++ b/arch/powerpc/kvm/book3s_pr.c
> > @@ -665,42 +665,6 @@ static void kvmppc_giveup_fac(struct kvm_vcpu
> *vcpu, ulong fac)
> >   #endif
> >   }
> >
> > -static int kvmppc_read_inst(struct kvm_vcpu *vcpu)
> > -{
> > -	ulong srr0 =3D kvmppc_get_pc(vcpu);
> > -	u32 last_inst =3D kvmppc_get_last_inst(vcpu);
> > -	int ret;
> > -
> > -	ret =3D kvmppc_ld(vcpu, &srr0, sizeof(u32), &last_inst, false);
> > -	if (ret =3D=3D -ENOENT) {
> > -		ulong msr =3D kvmppc_get_msr(vcpu);
> > -
> > -		msr =3D kvmppc_set_field(msr, 33, 33, 1);
> > -		msr =3D kvmppc_set_field(msr, 34, 36, 0);
> > -		msr =3D kvmppc_set_field(msr, 42, 47, 0);
> > -		kvmppc_set_msr_fast(vcpu, msr);
> > -		kvmppc_book3s_queue_irqprio(vcpu,
> BOOK3S_INTERRUPT_INST_STORAGE);
> > -		return EMULATE_AGAIN;
> > -	}
> > -
> > -	return EMULATE_DONE;
> > -}
> > -
> > -static int kvmppc_check_ext(struct kvm_vcpu *vcpu, unsigned int
> exit_nr)
> > -{
> > -
> > -	/* Need to do paired single emulation? */
> > -	if (!(vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE))
> > -		return EMULATE_DONE;
> > -
> > -	/* Read out the instruction */
> > -	if (kvmppc_read_inst(vcpu) =3D=3D EMULATE_DONE)
> > -		/* Need to emulate */
> > -		return EMULATE_FAIL;
> > -
> > -	return EMULATE_AGAIN;
> > -}
> > -
> >   /* Handle external providers (FPU, Altivec, VSX) */
> >   static int kvmppc_handle_ext(struct kvm_vcpu *vcpu, unsigned int
> exit_nr,
> >   			     ulong msr)
> > @@ -1101,31 +1065,51 @@ program_interrupt:
> >   	case BOOK3S_INTERRUPT_VSX:
> >   	{
> >   		int ext_msr =3D 0;
> > +		int emul;
> > +		ulong pc;
> > +		u32 last_inst;
> >
> > -		switch (exit_nr) {
> > -		case BOOK3S_INTERRUPT_FP_UNAVAIL: ext_msr =3D MSR_FP;  break;
> > -		case BOOK3S_INTERRUPT_ALTIVEC:    ext_msr =3D MSR_VEC; break;
> > -		case BOOK3S_INTERRUPT_VSX:        ext_msr =3D MSR_VSX; break;
> > -		}
> > +		if (!(vcpu->arch.hflags & BOOK3S_HFLAG_PAIRED_SINGLE)) {
>=20
> Please make paired single emulation the unusual, if()'ed case, not the
> normal exit path :).

Huh ... do you have more Book3s specific requests, it will be strange if
it will still work after all this blind changes :)

-Mike
