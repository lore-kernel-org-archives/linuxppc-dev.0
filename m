Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 7E5362C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 21:07:01 +1100 (EST)
Subject: Re: [PATCH] KVM: PPC: e500: Expose MMU registers via ONE_REG
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1363713985.16671.12@snotra>
Date: Thu, 21 Mar 2013 11:06:57 +0100
Message-Id: <5F65F205-3B81-4154-B9E0-43FA1100A3FD@suse.de>
References: <1363713985.16671.12@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 19.03.2013, at 18:26, Scott Wood wrote:

> On 03/19/2013 12:17:11 PM, Mihai Caraman wrote:
>> diff --git a/arch/powerpc/kvm/e500_mmu.c =
b/arch/powerpc/kvm/e500_mmu.c
>> index 66b6e31..b77b855 100644
>> --- a/arch/powerpc/kvm/e500_mmu.c
>> +++ b/arch/powerpc/kvm/e500_mmu.c
>> @@ -596,6 +596,95 @@ int kvmppc_set_sregs_e500_tlb(struct kvm_vcpu =
*vcpu, struct kvm_sregs *sregs)
>> 	return 0;
>> }
>> +int kvmppc_get_one_reg_500_tlb(struct kvm_vcpu *vcpu, u64 id,
>> +				union kvmppc_one_reg *val)
>=20
> s/500/e500/
>=20
>> +int kvmppc_set_one_reg_500_tlb(struct kvm_vcpu *vcpu, u64 id,
>> +			       union kvmppc_one_reg *val)
>> +{
>> +	int r =3D 0;
>> +	long int i;
>> +
>> +	switch (id) {
>> +	case KVM_REG_PPC_MAS0:
>> +		vcpu->arch.shared->mas0 =3D set_reg_val(id, *val);
>> +		break;
>> +	case KVM_REG_PPC_MAS1:
>> +		vcpu->arch.shared->mas1 =3D set_reg_val(id, *val);
>> +		break;
>> +	case KVM_REG_PPC_MAS2:
>> +		vcpu->arch.shared->mas2 =3D set_reg_val(id, *val);
>> +		break;
>> +	case KVM_REG_PPC_MAS7_3:
>> +		vcpu->arch.shared->mas7_3 =3D set_reg_val(id, *val);
>> +		break;
>> +	case KVM_REG_PPC_MAS4:
>> +		vcpu->arch.shared->mas4 =3D set_reg_val(id, *val);
>> +		break;
>> +	case KVM_REG_PPC_MAS6:
>> +		vcpu->arch.shared->mas6 =3D set_reg_val(id, *val);
>> +		break;
>> +	case KVM_REG_PPC_MMUCFG: {
>> +		u32 mmucfg =3D set_reg_val(id, *val);
>> +		vcpu->arch.mmucfg =3D mmucfg & ~MMUCFG_LPIDSIZE;
>> +		break;
>> +	}
>=20
> Do we really want to allow arbitrary MMUCFG changes?  It won't =
magically make us able to support larger RAs, PIDs, different MAVN, etc.

Only if we update the actual shadow mmu configuration as well.

>=20
>> +	case KVM_REG_PPC_TLB0CFG:
>> +	case KVM_REG_PPC_TLB1CFG:
>> +	case KVM_REG_PPC_TLB2CFG:
>> +	case KVM_REG_PPC_TLB3CFG: {
>> +		u32 tlbncfg =3D set_reg_val(id, *val);			=09=

>> +		u32 geometry_mask =3D TLBnCFG_N_ENTRY | TLBnCFG_ASSOC;
>> +		i =3D id - KVM_REG_PPC_TLB0CFG;
>> +
>> +		/* MMU geometry (way/size) can be set only using SW_TLB =
*/
>> +		if ((vcpu->arch.tlbcfg[i] & geometry_mask) !=3D
>> +		    (tlbncfg & geometry_mask))
>> +			r =3D -EINVAL;
>> +
>> +		vcpu->arch.tlbcfg[i] =3D set_reg_val(id, *val);
>> +		break;
>> +	}
>=20
> Likewise -- just because QEMU sets a bit here doesn't mean KVM can =
support it.
>=20
> I thought the initial plan for setting these config registers was to =
accept it if it exactly matches what KVM already has, and give an error =
otherwise -- thus allowing for the possibliity of accepting certain =
specific updates in the future.

Yes, that was the idea :).


Alex
