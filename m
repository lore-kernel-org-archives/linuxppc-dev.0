Return-Path: <mihai.caraman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 548881A02C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 19:05:39 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Alexander Graf <agraf@suse.de>, "kvm-ppc@vger.kernel.org"
 <kvm-ppc@vger.kernel.org>
Subject: RE: [PATCH v5 4/5] KVM: PPC: Alow kvmppc_get_last_inst() to fail
Date: Fri, 18 Jul 2014 09:05:32 +0000
Message-ID: <9905fb7c7f604bcb966478e3722e8bfc@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1405596148-1507-1-git-send-email-mihai.caraman@freescale.com>
 <1405596148-1507-5-git-send-email-mihai.caraman@freescale.com>
 <53C7DBC3.2060104@suse.de>
In-Reply-To: <53C7DBC3.2060104@suse.de>
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
> Sent: Thursday, July 17, 2014 5:21 PM
> To: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org
> Cc: kvm@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH v5 4/5] KVM: PPC: Alow kvmppc_get_last_inst() to fail
>=20
>=20
> On 17.07.14 13:22, Mihai Caraman wrote:
> > On book3e, guest last instruction is read on the exit path using load
> > external pid (lwepx) dedicated instruction. This load operation may
> fail
> > due to TLB eviction and execute-but-not-read entries.
> >
> > This patch lay down the path for an alternative solution to read the
> guest
> > last instruction, by allowing kvmppc_get_lat_inst() function to fail.
> > Architecture specific implmentations of kvmppc_load_last_inst() may
> read
> > last guest instruction and instruct the emulation layer to re-execute
> the
> > guest in case of failure.
> >
> > Make kvmppc_get_last_inst() definition common between architectures.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---

...

> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h
> b/arch/powerpc/include/asm/kvm_ppc.h
> > index e2fd5a1..7f9c634 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -47,6 +47,11 @@ enum emulation_result {
> >   	EMULATE_EXIT_USER,    /* emulation requires exit to user-space */
> >   };
> >
> > +enum instruction_type {
> > +	INST_GENERIC,
> > +	INST_SC,		/* system call */
> > +};
> > +
> >   extern int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu
> *vcpu);
> >   extern int __kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu
> *vcpu);
> >   extern void kvmppc_handler_highmem(void);
> > @@ -62,6 +67,9 @@ extern int kvmppc_handle_store(struct kvm_run *run,
> struct kvm_vcpu *vcpu,
> >   			       u64 val, unsigned int bytes,
> >   			       int is_default_endian);
> >
> > +extern int kvmppc_load_last_inst(struct kvm_vcpu *vcpu,
> > +				 enum instruction_type type, u32 *inst);
> > +
> >   extern int kvmppc_emulate_instruction(struct kvm_run *run,
> >                                         struct kvm_vcpu *vcpu);
> >   extern int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu
> *vcpu);
> > @@ -234,6 +242,23 @@ struct kvmppc_ops {
> >   extern struct kvmppc_ops *kvmppc_hv_ops;
> >   extern struct kvmppc_ops *kvmppc_pr_ops;
> >
> > +static inline int kvmppc_get_last_inst(struct kvm_vcpu *vcpu,
> > +					enum instruction_type type, u32 *inst)
> > +{
> > +	int ret =3D EMULATE_DONE;
> > +
> > +	/* Load the instruction manually if it failed to do so in the
> > +	 * exit path */
> > +	if (vcpu->arch.last_inst =3D=3D KVM_INST_FETCH_FAILED)
> > +		ret =3D kvmppc_load_last_inst(vcpu, type, &vcpu-
> >arch.last_inst);
> > +
> > +
> > +	*inst =3D (ret =3D=3D EMULATE_DONE && kvmppc_need_byteswap(vcpu)) ?
> > +		swab32(vcpu->arch.last_inst) : vcpu->arch.last_inst;
>=20
> This makes even less sense than the previous version. Either you treat
> inst as "definitely overwritten" or as "preserves previous data on
> failure".

Both v4 and v5 versions treat inst as "definitely overwritten".

>=20
> So either you unconditionally swap like you did before

If we make abstraction of its symmetry, KVM_INST_FETCH_FAILED is operated
in host endianness, so it doesn't need byte swap.

I agree with your reasoning if last_inst is initialized and compared with
data in guest endianess, which is not the case yet for KVM_INST_FETCH_FAILE=
D.

> or you do
>=20
> if (ret =3D=3D EMULATE_DONE)
>      *inst =3D kvmppc_need_byteswap(vcpu) ? swab32(vcpu->arch.last_inst) =
:
> vcpu->arch.last_inst;

-Mike
