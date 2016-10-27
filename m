Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4PlB3QPqzDvL3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Oct 2016 22:28:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 agraf@suse.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/kvm: Update kvmppc_set_arch_compat() for ISA
 v3.00
In-Reply-To: <1477549169-3649-3-git-send-email-sjitindarsingh@gmail.com>
References: <1477549169-3649-1-git-send-email-sjitindarsingh@gmail.com>
 <1477549169-3649-3-git-send-email-sjitindarsingh@gmail.com>
Date: Thu, 27 Oct 2016 22:28:02 +1100
Message-ID: <871sz23ubh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 3686471..f9ae3fb 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -311,24 +311,38 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
>  			 * If an arch bit is set in PCR, all the defined
>  			 * higher-order arch bits also have to be set.
>  			 */
> -			pcr = PCR_ARCH_206 | PCR_ARCH_205;
> +			pcr = PCR_ARCH_207 | PCR_ARCH_206 | PCR_ARCH_205;
>  			break;
>  		case PVR_ARCH_206:
>  		case PVR_ARCH_206p:
> -			pcr = PCR_ARCH_206;
> +			/* Must be at least v2.06 to emulate it */
> +			if (!cpu_has_feature(CPU_FTR_ARCH_206))
> +				return -EINVAL;
> +			pcr = PCR_ARCH_207 | PCR_ARCH_206;
>  			break;
>  		case PVR_ARCH_207:
> +			/* Must be at least v2.07 to emulate it */
> +			if (!cpu_has_feature(CPU_FTR_ARCH_207S))
> +				return -EINVAL;
> +			pcr = PCR_ARCH_207;
>  			break;
> +		case PVR_ARCH_300:
> +			/* Must be at least v3.00 to emulate it */
> +			if (!cpu_has_feature(CPU_FTR_ARCH_300))
> +				return -EINVAL;
>  		default:
>  			return -EINVAL;
>  		}
>  
> -		if (!cpu_has_feature(CPU_FTR_ARCH_207S)) {
> -			/* POWER7 can't emulate POWER8 */
> -			if (!(pcr & PCR_ARCH_206))
> -				return -EINVAL;
> -			pcr &= ~PCR_ARCH_206;
> -		}
> +		/*
> +		 * Mask the pcr bits which the current processor knows about
> +		 * v2.06 and above knows about the v2.05 compat bit
> +		 * v2,07 and above knows about the v2.06 compat bit
> +		 * v3.00 and above knows about the v2.07 compat bit
> +		 */
> +		pcr &= (cpu_has_feature(CPU_FTR_ARCH_300) << 3) |
> +			(cpu_has_feature(CPU_FTR_ARCH_207S) << 2) |
> +			(cpu_has_feature(CPU_FTR_ARCH_206) << 1);

cpu_has_feature() returns a bool, so shifting the result of it is
dubious. It also uses jump labels these days, so I have no idea what
code that is going to generate.

Better to just do it the simple way IMHO.

cheers
