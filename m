Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 660692C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 02:09:29 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH 4/6] KVM: PPC: Book3E: Add AltiVec support
Date: Wed, 3 Jul 2013 16:09:01 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF0A2A3D41@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-5-git-send-email-mihai.caraman@freescale.com>
 <BE4790D6-AC7E-4483-9853-139B8BFBCFD7@suse.de>
In-Reply-To: <BE4790D6-AC7E-4483-9853-139B8BFBCFD7@suse.de>
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

> > + * Simulate AltiVec unavailable fault to load guest state
> > + * from thread to AltiVec unit.
> > + * It requires to be called with preemption disabled.
> > + */
> > +static inline void kvmppc_load_guest_altivec(struct kvm_vcpu *vcpu)
> > +{
> > +	if (kvmppc_supports_altivec()) {
> > +		if (!(current->thread.regs->msr & MSR_VEC)) {
> > +			load_up_altivec(NULL);
> > +			current->thread.regs->msr |=3D MSR_VEC;
>=20
> Does this ensure that the kernel saves / restores all altivec state on
> task switch? Does it load it again when it schedules us in? Would
> definitely be worth a comment.

These units are _LAZY_ !!! Only SMP kernel save the state when it schedules=
 out.

>=20
> > +		}
> > +	}
> > +}
> > +
> > +/*
> >  * Helper function for "full" MSR writes.  No need to call this if only
> >  * EE/CE/ME/DE/RI are changing.
> >  */
> > @@ -678,6 +706,12 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run,
> struct kvm_vcpu *vcpu)
> > 	u64 fpr[32];
> > #endif
> >
> > +#ifdef CONFIG_ALTIVEC
> > +	vector128 vr[32];
> > +	vector128 vscr;
> > +	int used_vr =3D 0;
>=20
> bool

Why don't you ask first to change the type of used_vr member in
/include/asm/processor.h?

>=20
> > +#endif
> > +
> > 	if (!vcpu->arch.sane) {
> > 		kvm_run->exit_reason =3D KVM_EXIT_INTERNAL_ERROR;
> > 		return -EINVAL;
> > @@ -716,6 +750,22 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run,
> struct kvm_vcpu *vcpu)
> > 	kvmppc_load_guest_fp(vcpu);
> > #endif
> >
> > +#ifdef CONFIG_ALTIVEC
>=20
> /* Switch from user space Altivec to guest Altivec state */
>=20
> > +	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
>=20
> Why not use your kvmppc_supports_altivec() helper here?

Give it a try ... because Linus guarded this members with CONFIG_ALTIVEC :)

>=20
> > +		/* Save userspace VEC state in stack */
> > +		enable_kernel_altivec();
>=20
> Can't you hide this in the load function? We only want to enable kernel
> altivec for a short time while we shuffle the registers around.
>=20
> > +		memcpy(vr, current->thread.vr, sizeof(current->thread.vr));
>=20
> vr =3D current->thread.vr;

Are you kidding, be more careful with arrays :)=20

>=20
> > +		vscr =3D current->thread.vscr;
> > +		used_vr =3D current->thread.used_vr;
> > +
> > +		/* Restore guest VEC state to thread */
> > +		memcpy(current->thread.vr, vcpu->arch.vr, sizeof(vcpu-
> >arch.vr));
>=20
> current->thread.vr =3D vcpu->arch.vr;
>=20
> > +		current->thread.vscr =3D vcpu->arch.vscr;
> > +
> > +		kvmppc_load_guest_altivec(vcpu);
> > +	}
>=20
> Do we need to do this even when the guest doesn't use Altivec? Can't we
> just load it on demand then once we fault? This code path really should
> only be a prefetch enable when MSR_VEC is already set in guest context.

No we can't, read 6/6.=20

>=20
> > +#endif
> > +
> > 	ret =3D __kvmppc_vcpu_run(kvm_run, vcpu);
> >
> > 	/* No need for kvm_guest_exit. It's done in handle_exit.
> > @@ -736,6 +786,23 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run,
> struct kvm_vcpu *vcpu)
> > 	current->thread.fpexc_mode =3D fpexc_mode;
> > #endif
> >
> > +#ifdef CONFIG_ALTIVEC
>=20
> /* Switch from guest Altivec to user space Altivec state */
>=20
> > +	if (cpu_has_feature(CPU_FTR_ALTIVEC)) {
> > +		/* Save AltiVec state to thread */
> > +		if (current->thread.regs->msr & MSR_VEC)
> > +			giveup_altivec(current);
> > +
> > +		/* Save guest state */
> > +		memcpy(vcpu->arch.vr, current->thread.vr, sizeof(vcpu-
> >arch.vr));
> > +		vcpu->arch.vscr =3D current->thread.vscr;
> > +
> > +		/* Restore userspace state */
> > +		memcpy(current->thread.vr, vr, sizeof(current->thread.vr));
> > +		current->thread.vscr =3D vscr;
> > +		current->thread.used_vr =3D used_vr;
> > +	}
>=20
> Same comments here. If the guest never touched Altivec state, don't
> bother restoring it, as it's still good.

LOL, the mighty guest kernel does whatever he wants with AltiVec and
doesn't inform us.

-Mike
