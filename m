Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 070FA2C01BC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 23:40:41 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 04/17] KVM: PPC64: booke: Add guest
 computation mode for irq delivery
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1340627195-11544-5-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 4 Jul 2012 15:40:34 +0200
Message-Id: <E29E8A28-9993-4E6C-B41A-7C0AA51945F3@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-5-git-send-email-mihai.caraman@freescale.com>
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

> When delivering guest IRQs, update MSR computaion

computation

> mode according to guest
> interrupt computation mode found in EPCR.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kvm/booke.c |    8 +++++++-
> 1 files changed, 7 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index d15c4b5..93b48e0 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -287,6 +287,7 @@ static int kvmppc_booke_irqprio_deliver(struct =
kvm_vcpu *vcpu,
> 	bool crit;
> 	bool keep_irq =3D false;
> 	enum int_class int_class;
> +	ulong msr_cm =3D 0;
>=20
> 	/* Truncate crit indicators in 32 bit mode */
> 	if (!(vcpu->arch.shared->msr & MSR_SF)) {
> @@ -299,6 +300,10 @@ static int kvmppc_booke_irqprio_deliver(struct =
kvm_vcpu *vcpu,
> 	/* ... and we're in supervisor mode */
> 	crit =3D crit && !(vcpu->arch.shared->msr & MSR_PR);
>=20
> +#ifdef CONFIG_64BIT
> +	msr_cm =3D vcpu->arch.epcr & SPRN_EPCR_ICM ? MSR_CM : 0;
> +#endif

No need for the ifdef, no?. Just mask EPCR_ICM out in the 32-bit host =
case, then this check is always false on 32-bit hosts.

> +
> 	if (priority =3D=3D BOOKE_IRQPRIO_EXTERNAL_LEVEL) {
> 		priority =3D BOOKE_IRQPRIO_EXTERNAL;
> 		keep_irq =3D true;
> @@ -381,7 +386,8 @@ static int kvmppc_booke_irqprio_deliver(struct =
kvm_vcpu *vcpu,
> 			set_guest_esr(vcpu, vcpu->arch.queued_esr);
> 		if (update_dear =3D=3D true)
> 			set_guest_dear(vcpu, vcpu->arch.queued_dear);
> -		kvmppc_set_msr(vcpu, vcpu->arch.shared->msr & msr_mask);
> +		kvmppc_set_msr(vcpu, (vcpu->arch.shared->msr & msr_mask)
> +				| msr_cm);

Please split this computation out into its own variable and apply the =
masking regardless. Something like

ulong new_msr =3D vcpu->arch.shared->msr;
if (vcpu->arch.epcr & SPRN_EPCR_ICM)
    new_msr |=3D MSR_CM;
new_msr &=3D msr_mask;
kvmppc_set_msr(vcpu, new_msr);

Alex
