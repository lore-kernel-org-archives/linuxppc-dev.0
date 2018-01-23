Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQhMK31DYzDr4w
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 19:30:37 +1100 (AEDT)
Date: Tue, 23 Jan 2018 19:30:33 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: wei.guo.simon@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 19/26] KVM: PPC: Book3S PR: always fail transaction in
 guest privilege state
Message-ID: <20180123083033.GK3924@fergus.ozlabs.ibm.com>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-20-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515665499-31710-20-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 11, 2018 at 06:11:32PM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Currently kernel doesn't use transaction memory.
> And there is an issue for privilege guest that:
> tbegin/tsuspend/tresume/tabort TM instructions can impact MSR TM bits
> without trap into PR host. So following code will lead to a false mfmsr
> result:
> 	tbegin	<- MSR bits update to Transaction active.
> 	beq 	<- failover handler branch
> 	mfmsr	<- still read MSR bits from magic page with
> 		transaction inactive.
> 
> It is not an issue for non-privilege guest since its mfmsr is not patched
> with magic page and will always trap into PR host.
> 
> This patch will always fail tbegin attempt for privilege guest, so that
> the above issue is prevented. It is benign since currently (guest) kernel
> doesn't initiate a transaction.
> 
> Test case:
> https://github.com/justdoitqd/publicFiles/blob/master/test_tbegin_pr.c
> 
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

You need to handle the case where MSR_TM is not set in the guest MSR,
and give the guest a facility unavailable interrupt.

[snip]

> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -255,7 +255,7 @@ static inline void kvmppc_save_tm_sprs(struct kvm_vcpu *vcpu)
>  	tm_disable();
>  }
>  
> -static inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu)
> +inline void kvmppc_restore_tm_sprs(struct kvm_vcpu *vcpu)

You should probably remove the 'inline' here too.

Paul.
