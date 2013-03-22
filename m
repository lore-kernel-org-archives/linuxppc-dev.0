Return-Path: <gleb@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 621D52C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2013 18:21:17 +1100 (EST)
Date: Fri, 22 Mar 2013 09:21:03 +0200
From: Gleb Natapov <gleb@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] KVM: fix powerpc build error for !CONFIG_KVM
Message-ID: <20130322072102.GL9382@redhat.com>
References: <20130322143550.c7ebe79c9fd97ec7a385ea16@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130322143550.c7ebe79c9fd97ec7a385ea16@canb.auug.org.au>
Cc: Phil Carmody <pc+lkml@asdf.org>, Kevin Hilman <khilman@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 22, 2013 at 02:35:50PM +1100, Stephen Rothwell wrote:
> Fixes these build error when CONFIG_KVM is not defined:
> 
> In file included from arch/powerpc/include/asm/kvm_ppc.h:33:0,
>                  from arch/powerpc/kernel/setup_64.c:67:
> arch/powerpc/include/asm/kvm_book3s.h:65:20: error: field 'pte' has incomplete type
> arch/powerpc/include/asm/kvm_book3s.h:69:18: error: field 'vcpu' has incomplete type
> arch/powerpc/include/asm/kvm_book3s.h:98:34: error: 'HPTEG_HASH_NUM_PTE' undeclared here (not in a function)
> arch/powerpc/include/asm/kvm_book3s.h:99:39: error: 'HPTEG_HASH_NUM_PTE_LONG' undeclared here (not in a function)
> arch/powerpc/include/asm/kvm_book3s.h:100:35: error: 'HPTEG_HASH_NUM_VPTE' undeclared here (not in a function)
> arch/powerpc/include/asm/kvm_book3s.h:101:40: error: 'HPTEG_HASH_NUM_VPTE_LONG' undeclared here (not in a function)
> arch/powerpc/include/asm/kvm_book3s.h:129:4: error: 'struct kvm_run' declared inside parameter list [-Werror]
> arch/powerpc/include/asm/kvm_book3s.h:129:4: error: its scope is only this definition or declaration, which is probably not what you want [-Werror]
> 
> ... and so on ...
> 
> This was introduced by commit f445f11eb2cc265dd47da5b2e864df46cd6e5a82
> "KVM: allow host header to be included even for !CONFIG_KVM"
> 
This will re-introduce the problem that Kevin tried to fix with his
original patch. The problem is that kernel/context_tracking.c includes
linux/kvm_host.h unconditionally and the later includes asm/kvm_host.h
and this breaks on archs without KVM.

I think the correct solution is to not include linux/kvm_host.h in
kernel/context_tracking.c unconditionally. The patch by Kevin is here:
http://lkml.org/lkml/2013/3/21/745

> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/linux/kvm_host.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> Kevin, does this still fix the error that commit
> f445f11eb2cc265dd47da5b2e864df46cd6e5a82 was fixing?
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index a942863..90ebec0 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1,8 +1,6 @@
>  #ifndef __KVM_HOST_H
>  #define __KVM_HOST_H
>  
> -#if IS_ENABLED(CONFIG_KVM)
> -
>  /*
>   * This work is licensed under the terms of the GNU GPL, version 2.  See
>   * the COPYING file in the top-level directory.
> @@ -751,6 +749,7 @@ static inline int kvm_deassign_device(struct kvm *kvm,
>  }
>  #endif /* CONFIG_IOMMU_API */
>  
> +#if IS_ENABLED(CONFIG_KVM)
>  static inline void __guest_enter(void)
>  {
>  	/*
> @@ -770,6 +769,10 @@ static inline void __guest_exit(void)
>  	vtime_account_system(current);
>  	current->flags &= ~PF_VCPU;
>  }
> +#else
> +static inline void __guest_enter(void) { return; }
> +static inline void __guest_exit(void) { return; }
> +#endif /* IS_ENABLED(CONFIG_KVM) */
>  
>  #ifdef CONFIG_CONTEXT_TRACKING
>  extern void guest_enter(void);
> @@ -1057,8 +1060,4 @@ static inline bool kvm_vcpu_eligible_for_directed_yield(struct kvm_vcpu *vcpu)
>  }
>  
>  #endif /* CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT */
> -#else
> -static inline void __guest_enter(void) { return; }
> -static inline void __guest_exit(void) { return; }
> -#endif /* IS_ENABLED(CONFIG_KVM) */
>  #endif
> -- 
> 1.8.1
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au



--
			Gleb.
