Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC9142C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 23:21:52 +1000 (EST)
Subject: Re: [RFC PATCH 02/17] KVM: PPC64: booke: Add EPCR support in
 mtspr/mfspr emulation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1340627195-11544-3-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 4 Jul 2012 15:21:45 +0200
Message-Id: <868ABA98-C55B-435B-BC09-01DC4067A3BE@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-3-git-send-email-mihai.caraman@freescale.com>
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

> Add EPCR support in booke mtspr/mfspr emulation. EPCR register is =
defined
> only for 64-bit and HV categories, so it shoud be available only on =
64-bit
> virtual processors. Undefine the support for 32-bit builds.
> Define a reusable setter function for vcpu's EPCR.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kvm/booke.c         |   12 +++++++++++-
> arch/powerpc/kvm/booke.h         |    6 ++++++
> arch/powerpc/kvm/booke_emulate.c |   13 ++++++++++++-
> 3 files changed, 29 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 72f13f4..f9fa260 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -13,7 +13,7 @@
>  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  =
02110-1301, USA.
>  *
>  * Copyright IBM Corp. 2007
> - * Copyright 2010-2011 Freescale Semiconductor, Inc.
> + * Copyright 2010-2012 Freescale Semiconductor, Inc.
>  *
>  * Authors: Hollis Blanchard <hollisb@us.ibm.com>
>  *          Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> @@ -1243,6 +1243,16 @@ void kvmppc_core_commit_memory_region(struct =
kvm *kvm,
> {
> }
>=20
> +#ifdef CONFIG_64BIT
> +void kvmppc_set_epcr(struct kvm_vcpu *vcpu, u32 new_epcr)
> +{
> +	vcpu->arch.epcr =3D new_epcr;
> +	vcpu->arch.shadow_epcr &=3D ~SPRN_EPCR_GICM;
> +	if (vcpu->arch.epcr  & SPRN_EPCR_ICM)
> +		vcpu->arch.shadow_epcr |=3D SPRN_EPCR_GICM;

Why would the setter be #ifdef CONFIG_64BIT? EPCR exists on e500mc too, =
no? Please only #ifdef the GICM bits out.


Alex
