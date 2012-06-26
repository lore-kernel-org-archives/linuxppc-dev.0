Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BA64B6F5A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 08:34:57 +1000 (EST)
Message-ID: <4FEA3907.8080500@freescale.com>
Date: Tue, 26 Jun 2012 17:34:47 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>
Subject: Re: [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR support in sregs
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-4-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-4-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
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

On 06/25/2012 07:26 AM, Mihai Caraman wrote:
> Add KVM_SREGS_E_64 feature and EPCR spr support in get/set sregs
> for 64-bit hosts.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/kvm/booke.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index f9fa260..d15c4b5 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1052,6 +1052,9 @@ static void get_sregs_base(struct kvm_vcpu *vcpu,
>  	u64 tb = get_tb();
>  
>  	sregs->u.e.features |= KVM_SREGS_E_BASE;
> +#ifdef CONFIG_64BIT
> +	sregs->u.e.features |= KVM_SREGS_E_64;0
> +#endif
>  
>  	sregs->u.e.csrr0 = vcpu->arch.csrr0;
>  	sregs->u.e.csrr1 = vcpu->arch.csrr1;
> @@ -1063,6 +1066,9 @@ static void get_sregs_base(struct kvm_vcpu *vcpu,
>  	sregs->u.e.dec = kvmppc_get_dec(vcpu, tb);
>  	sregs->u.e.tb = tb;
>  	sregs->u.e.vrsave = vcpu->arch.vrsave;
> +#ifdef CONFIG_64BIT
> +	sregs->u.e.epcr = vcpu->arch.epcr;
> +#endif
>  }
>  
>  static int set_sregs_base(struct kvm_vcpu *vcpu,
> @@ -1071,6 +1077,11 @@ static int set_sregs_base(struct kvm_vcpu *vcpu,
>  	if (!(sregs->u.e.features & KVM_SREGS_E_BASE))
>  		return 0;
>  
> +#ifdef CONFIG_64BIT
> +	if (!(sregs->u.e.features & KVM_SREGS_E_64))
> +		return 0;
> +#endif

This means that a QEMU targeting a 32-bit guest won't be able to set any
special registers, if it sets feature bits manually rather than getting
them from GET_SREGS.

This check should only qualify whether we look at sregs.u.e.epcr, not
whether this function works at all.

BTW, shouldn't the BASE check return an error rather than silently no-op?

-Scott
