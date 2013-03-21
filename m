Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92D4E2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 22:02:29 +1100 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Alexander Graf <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] KVM: PPC: e500: Expose MMU registers via ONE_REG
Date: Thu, 21 Mar 2013 11:02:19 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF37304B@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1363713985.16671.12@snotra>
 <5F65F205-3B81-4154-B9E0-43FA1100A3FD@suse.de>
In-Reply-To: <5F65F205-3B81-4154-B9E0-43FA1100A3FD@suse.de>
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
> Sent: Thursday, March 21, 2013 12:07 PM
> To: Wood Scott-B07421
> Cc: Caraman Mihai Claudiu-B02008; kvm-ppc@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; kvm@vger.kernel.org
> Subject: Re: [PATCH] KVM: PPC: e500: Expose MMU registers via ONE_REG
>=20
>=20
> On 19.03.2013, at 18:26, Scott Wood wrote:
>=20
> > On 03/19/2013 12:17:11 PM, Mihai Caraman wrote:
> >> diff --git a/arch/powerpc/kvm/e500_mmu.c b/arch/powerpc/kvm/e500_mmu.c
> >> index 66b6e31..b77b855 100644
> >> --- a/arch/powerpc/kvm/e500_mmu.c
> >> +++ b/arch/powerpc/kvm/e500_mmu.c
> >> @@ -596,6 +596,95 @@ int kvmppc_set_sregs_e500_tlb(struct kvm_vcpu
> *vcpu, struct kvm_sregs *sregs)
> >> 	return 0;
> >> }
> >> +int kvmppc_get_one_reg_500_tlb(struct kvm_vcpu *vcpu, u64 id,
> >> +				union kvmppc_one_reg *val)
> >
> > s/500/e500/
> >
> >> +int kvmppc_set_one_reg_500_tlb(struct kvm_vcpu *vcpu, u64 id,
> >> +			       union kvmppc_one_reg *val)
> >> +{
> >> +	int r =3D 0;
> >> +	long int i;
> >> +
> >> +	switch (id) {
> >> +	case KVM_REG_PPC_MAS0:
> >> +		vcpu->arch.shared->mas0 =3D set_reg_val(id, *val);
> >> +		break;
> >> +	case KVM_REG_PPC_MAS1:
> >> +		vcpu->arch.shared->mas1 =3D set_reg_val(id, *val);
> >> +		break;
> >> +	case KVM_REG_PPC_MAS2:
> >> +		vcpu->arch.shared->mas2 =3D set_reg_val(id, *val);
> >> +		break;
> >> +	case KVM_REG_PPC_MAS7_3:
> >> +		vcpu->arch.shared->mas7_3 =3D set_reg_val(id, *val);
> >> +		break;
> >> +	case KVM_REG_PPC_MAS4:
> >> +		vcpu->arch.shared->mas4 =3D set_reg_val(id, *val);
> >> +		break;
> >> +	case KVM_REG_PPC_MAS6:
> >> +		vcpu->arch.shared->mas6 =3D set_reg_val(id, *val);
> >> +		break;
> >> +	case KVM_REG_PPC_MMUCFG: {
> >> +		u32 mmucfg =3D set_reg_val(id, *val);
> >> +		vcpu->arch.mmucfg =3D mmucfg & ~MMUCFG_LPIDSIZE;
> >> +		break;
> >> +	}
> >
> > Do we really want to allow arbitrary MMUCFG changes?  It won't
> magically make us able to support larger RAs, PIDs, different MAVN, etc.

Not magically, some changes e.g TLBnCFG_IND or TLBnPS require just a kvm
check other changes e.g. TLBnCFG_MAVN require additional support and we
might not implement all of them. Until then this code should do the job:

	/* MMU registers can be set only to the configuration supported by KVM */
	case KVM_REG_PPC_MMUCFG: {
		if (set_reg_val(id, *val) !=3D vcpu->arch.mmucfg)
			r =3D -EINVAL;
		break;
	}

>=20
> Only if we update the actual shadow mmu configuration as well.

These registers (MMUCFG, EPTCFG, TLBnCFG, TLBnPS) are read-only (and shared
between e6500 threads), we can only emulate them.

-Mike
