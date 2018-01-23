Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQh4d4KsxzDr0M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 19:17:53 +1100 (AEDT)
Date: Tue, 23 Jan 2018 19:17:45 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 18/26] KVM: PPC: Book3S PR: make mtspr/mfspr emulation
 behavior based on active TM SPRs
Message-ID: <20180123081745.GJ3924@fergus.ozlabs.ibm.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-19-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515665499-31710-19-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2018 at 06:11:31PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> The mfspr/mtspr on TM SPRs(TEXASR/TFIAR/TFHAR) are non-privileged
> instructions and can be executed at PR KVM guest without trapping
> into host in problem state. We only emulate mtspr/mfspr
> texasr/tfiar/tfhar at guest PR=0 state.
> 
> When we are emulating mtspr tm sprs at guest PR=0 state, the emulation
> result need to be visible to guest PR=1 state. That is, the actual TM
> SPR val should be loaded into actual registers.
> 
> We already flush TM SPRs into vcpu when switching out of CPU, and load
> TM SPRs when switching back.
> 
> This patch corrects mfspr()/mtspr() emulation for TM SPRs to make the
> actual source/dest based on actual TM SPRs.
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> ---
>  arch/powerpc/kvm/book3s_emulate.c | 35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
> index e096d01..c2836330 100644
> --- a/arch/powerpc/kvm/book3s_emulate.c
> +++ b/arch/powerpc/kvm/book3s_emulate.c
> @@ -521,13 +521,26 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
>  		break;
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  	case SPRN_TFHAR:
> -		vcpu->arch.tfhar = spr_val;
> -		break;
>  	case SPRN_TEXASR:
> -		vcpu->arch.texasr = spr_val;
> -		break;
>  	case SPRN_TFIAR:
> -		vcpu->arch.tfiar = spr_val;
> +		if (MSR_TM_ACTIVE(kvmppc_get_msr(vcpu))) {
> +			/* it is illegal to mtspr() TM regs in
> +			 * other than non-transactional state.
> +			 */
> +			kvmppc_core_queue_program(vcpu, SRR1_PROGTM);
> +			emulated = EMULATE_AGAIN;
> +			break;
> +		}

We also need to check that the guest has TM enabled in the guest MSR,
and give them a facility unavailable interrupt if not.

> +
> +		tm_enable();
> +		if (sprn == SPRN_TFHAR)
> +			mtspr(SPRN_TFHAR, spr_val);
> +		else if (sprn == SPRN_TEXASR)
> +			mtspr(SPRN_TEXASR, spr_val);
> +		else
> +			mtspr(SPRN_TFIAR, spr_val);
> +		tm_disable();

I haven't seen any checks that we are on a CPU that has TM.  What
happens if a guest does a mtmsrd with TM=1 and then a mtspr to TEXASR
when running on a POWER7 (assuming the host kernel was compiled with
CONFIG_PPC_TRANSACTIONAL_MEM=y)?

Ideally, if the host CPU does not have TM functionality, these mtsprs
would be treated as no-ops and attempts to set the TM or TS fields in
the guest MSR would be ignored.

> +
>  		break;
>  #endif
>  #endif
> @@ -674,13 +687,19 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
>  		break;
>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>  	case SPRN_TFHAR:
> -		*spr_val = vcpu->arch.tfhar;
> +		tm_enable();
> +		*spr_val = mfspr(SPRN_TFHAR);
> +		tm_disable();
>  		break;
>  	case SPRN_TEXASR:
> -		*spr_val = vcpu->arch.texasr;
> +		tm_enable();
> +		*spr_val = mfspr(SPRN_TEXASR);
> +		tm_disable();
>  		break;
>  	case SPRN_TFIAR:
> -		*spr_val = vcpu->arch.tfiar;
> +		tm_enable();
> +		*spr_val = mfspr(SPRN_TFIAR);
> +		tm_disable();
>  		break;

These need to check MSR_TM in the guest MSR, and become no-ops on
machines without TM capability.

Paul.
