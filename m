Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1A032C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Dec 2012 01:02:15 +1100 (EST)
Subject: Re: [PATCH 11/12] KVM: PPC: booke: Add EPCR support in sregs
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1349972009-23027-12-git-send-email-mihai.caraman@freescale.com>
Date: Sat, 1 Dec 2012 15:02:09 +0100
Message-Id: <7891EF0B-FAC6-4023-B650-82B9F1A001E1@suse.de>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
 <1349972009-23027-12-git-send-email-mihai.caraman@freescale.com>
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

> Add KVM_SREGS_E_64 feature and EPCR spr support in get/set sregs for 64-bit
> hosts.

Why would we need this if we have a proper ONE_REG interface for EPCR?


Alex

> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kvm/booke.c |    7 +++++++
> 1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index e6159f5..d396374 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1215,6 +1215,9 @@ static void get_sregs_base(struct kvm_vcpu *vcpu,
> 	u64 tb = get_tb();
> 
> 	sregs->u.e.features |= KVM_SREGS_E_BASE;
> +#ifdef CONFIG_64BIT
> +	sregs->u.e.features |= KVM_SREGS_E_64;
> +#endif
> 
> 	sregs->u.e.csrr0 = vcpu->arch.csrr0;
> 	sregs->u.e.csrr1 = vcpu->arch.csrr1;
> @@ -1226,6 +1229,9 @@ static void get_sregs_base(struct kvm_vcpu *vcpu,
> 	sregs->u.e.dec = kvmppc_get_dec(vcpu, tb);
> 	sregs->u.e.tb = tb;
> 	sregs->u.e.vrsave = vcpu->arch.vrsave;
> +#if defined(CONFIG_64BIT) && defined(CONFIG_KVM_BOOKE_HV)
> +	sregs->u.e.epcr = vcpu->arch.epcr;
> +#endif
> }
> 
> static int set_sregs_base(struct kvm_vcpu *vcpu,
> @@ -1241,6 +1247,7 @@ static int set_sregs_base(struct kvm_vcpu *vcpu,
> 	set_guest_dear(vcpu, sregs->u.e.dear);
> 	vcpu->arch.vrsave = sregs->u.e.vrsave;
> 	kvmppc_set_tcr(vcpu, sregs->u.e.tcr);
> +	kvmppc_set_epcr(vcpu, sregs->u.e.epcr);
> 
> 	if (sregs->u.e.update_special & KVM_SREGS_E_UPDATE_DEC) {
> 		vcpu->arch.dec = sregs->u.e.dec;
> -- 
> 1.7.4.1
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
