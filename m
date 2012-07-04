Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 335E92C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 00:05:55 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 07/17] KVM: PPC: e500: Mask ea's high
 32-bits in 32/64 instr emulation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <78A34E01-4FF9-46F2-8D12-BD27AA44BC37@suse.de>
Date: Wed, 4 Jul 2012 16:05:49 +0200
Message-Id: <1443F28E-2B7F-4F9E-864B-18BDECEBE446@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-8-git-send-email-mihai.caraman@freescale.com>
 <78A34E01-4FF9-46F2-8D12-BD27AA44BC37@suse.de>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, qemu-ppc@nongnu.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.07.2012, at 16:00, Alexander Graf wrote:

>=20
> On 25.06.2012, at 14:26, Mihai Caraman wrote:
>=20
>> Mask high 32 bits of effective address in emulation layer, for guests =
running
>> in 32-bit mode.
>> MAS2's high-order 32 bits represents the upper 32 bits of the =
effective address
>> of the page. Mask it too for tlbwe instruction emulation.
>=20
> Ah, there is the tlbwe masking :). Please split this into 2 patches.
>=20
>>=20
>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>> ---
>> arch/powerpc/kvm/e500_emulate.c |    5 ++++-
>> arch/powerpc/kvm/e500_tlb.c     |    2 ++
>> 2 files changed, 6 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kvm/e500_emulate.c =
b/arch/powerpc/kvm/e500_emulate.c
>> index 81288f7..94305db 100644
>> --- a/arch/powerpc/kvm/e500_emulate.c
>> +++ b/arch/powerpc/kvm/e500_emulate.c
>> @@ -1,5 +1,5 @@
>> /*
>> - * Copyright (C) 2008-2011 Freescale Semiconductor, Inc. All rights =
reserved.
>> + * Copyright (C) 2008-2012 Freescale Semiconductor, Inc. All rights =
reserved.
>> *
>> * Author: Yu Liu, <yu.liu@freescale.com>
>> *
>> @@ -90,6 +90,9 @@ static inline ulong kvmppc_get_ea_indexed(struct =
kvm_vcpu *vcpu, int ra, int rb)
>> 	if (ra)
>> 		ea +=3D kvmppc_get_gpr(vcpu, ra);
>>=20
>> +	if (!(vcpu->arch.shared->msr & MSR_CM))
>> +		ea &=3D 0xffffffffUL;
>=20
> Since this will be in generic code, please guard it with an #ifdef =
CONFIG_BOOKE.

Oh and do the same check for MSR_SF on Book3s :). Maybe something like

ulong msr_64bit =3D 0;

#if defined(CONFIG_PPC_BOOK3E_64)
msr_64bit =3D MSR_CM;
#elif defined(CONFIG_PPC_BOOK3S_64)
msr_64bit =3D MSR_SF;
#endif

if (!(vcpu->arch.shared->msr & msr_64bit))
    ea =3D (uint32_t)ea;


Alex
