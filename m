Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A940B2C008A
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Dec 2012 00:42:33 +1100 (EST)
Subject: Re: [PATCH 09/12] KVM: PPC: bookehv: Add guest computation mode for
 irq delivery
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1349972009-23027-10-git-send-email-mihai.caraman@freescale.com>
Date: Sat, 1 Dec 2012 14:42:27 +0100
Message-Id: <678C6938-BC19-46B1-8D63-7FD91F7ED2FE@suse.de>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
 <1349972009-23027-10-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.10.2012, at 18:13, Mihai Caraman wrote:

> When delivering guest IRQs, update MSR computation mode according to =
guest
> interrupt computation mode found in EPCR.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> v1: added intermediate msr variable.
>=20
> arch/powerpc/kvm/booke.c |    9 ++++++++-
> 1 files changed, 8 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 7c9c389..86f0d0d 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -312,6 +312,7 @@ static int kvmppc_booke_irqprio_deliver(struct =
kvm_vcpu *vcpu,
> 	bool crit;
> 	bool keep_irq =3D false;
> 	enum int_class int_class;
> +	ulong new_msr =3D vcpu->arch.shared->msr;
>=20
> 	/* Truncate crit indicators in 32 bit mode */
> 	if (!(vcpu->arch.shared->msr & MSR_SF)) {
> @@ -407,7 +408,13 @@ static int kvmppc_booke_irqprio_deliver(struct =
kvm_vcpu *vcpu,
> 			set_guest_esr(vcpu, vcpu->arch.queued_esr);
> 		if (update_dear =3D=3D true)
> 			set_guest_dear(vcpu, vcpu->arch.queued_dear);
> -		kvmppc_set_msr(vcpu, vcpu->arch.shared->msr & msr_mask);
> +
> +		new_msr &=3D msr_mask;
> +#if defined(CONFIG_64BIT) && defined(CONFIG_KVM_BOOKE_HV)

Why the dependency on booke_hv? This is booke code and according to =
booke, ICM declares the interrupt mode a guest will be in, right?

I'll just remove the BOOKE_HV ifdef bit.


Alex
