Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 432781A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 04:21:29 +1000 (EST)
Message-ID: <1404152404.2435.132.camel@snotra.buserror.net>
Subject: Re: [PATCH] KVM: PPC: e500: Emulate power management control SPR
From: Scott Wood <scottwood@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Date: Mon, 30 Jun 2014 13:20:04 -0500
In-Reply-To: <1404132929-27308-1-git-send-email-mihai.caraman@freescale.com>
References: <1404132929-27308-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-06-30 at 15:55 +0300, Mihai Caraman wrote:
> For FSL e6500 core the kernel uses power management SPR register (PWRMGTCR0)
> to enable idle power down for cores and devices by setting up the idle count
> period at boot time. With the host already controlling the power management
> configuration the guest could simply benefit from it, so emulate guest request
> as nop.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/kvm/e500_emulate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
> index 002d517..98a22e5 100644
> --- a/arch/powerpc/kvm/e500_emulate.c
> +++ b/arch/powerpc/kvm/e500_emulate.c
> @@ -250,6 +250,10 @@ int kvmppc_core_emulate_mtspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong spr_va
>  				spr_val);
>  		break;
>  
> +	case SPRN_PWRMGTCR0:
> +		/* Guest relies on host power management configurations */
> +		break;
> +
>  	/* extra exceptions */
>  	case SPRN_IVOR32:
>  		vcpu->arch.ivor[BOOKE_IRQPRIO_SPE_UNAVAIL] = spr_val;
> @@ -355,6 +359,10 @@ int kvmppc_core_emulate_mfspr_e500(struct kvm_vcpu *vcpu, int sprn, ulong *spr_v
>  		*spr_val = 0;
>  		break;
>  
> +	case SPRN_PWRMGTCR0:
> +		*spr_val = 0;
> +		break;
> +
>  	case SPRN_MMUCFG:
>  		*spr_val = vcpu->arch.mmucfg;
>  		break;

When reading, is it better to return zero, or the current host value, or
the value last written by the guest (even though it wasn't written to
hardware)?

-Scott
