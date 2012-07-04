Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E7C72C007A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 00:01:02 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 07/17] KVM: PPC: e500: Mask ea's high
 32-bits in 32/64 instr emulation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1340627195-11544-8-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 4 Jul 2012 16:00:54 +0200
Message-Id: <78A34E01-4FF9-46F2-8D12-BD27AA44BC37@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-8-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 25.06.2012, at 14:26, Mihai Caraman wrote:

> Mask high 32 bits of effective address in emulation layer, for guests =
running
> in 32-bit mode.
> MAS2's high-order 32 bits represents the upper 32 bits of the =
effective address
> of the page. Mask it too for tlbwe instruction emulation.

Ah, there is the tlbwe masking :). Please split this into 2 patches.

>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kvm/e500_emulate.c |    5 ++++-
> arch/powerpc/kvm/e500_tlb.c     |    2 ++
> 2 files changed, 6 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/e500_emulate.c =
b/arch/powerpc/kvm/e500_emulate.c
> index 81288f7..94305db 100644
> --- a/arch/powerpc/kvm/e500_emulate.c
> +++ b/arch/powerpc/kvm/e500_emulate.c
> @@ -1,5 +1,5 @@
> /*
> - * Copyright (C) 2008-2011 Freescale Semiconductor, Inc. All rights =
reserved.
> + * Copyright (C) 2008-2012 Freescale Semiconductor, Inc. All rights =
reserved.
>  *
>  * Author: Yu Liu, <yu.liu@freescale.com>
>  *
> @@ -90,6 +90,9 @@ static inline ulong kvmppc_get_ea_indexed(struct =
kvm_vcpu *vcpu, int ra, int rb)
> 	if (ra)
> 		ea +=3D kvmppc_get_gpr(vcpu, ra);
>=20
> +	if (!(vcpu->arch.shared->msr & MSR_CM))
> +		ea &=3D 0xffffffffUL;

Since this will be in generic code, please guard it with an #ifdef =
CONFIG_BOOKE.


Alex
