Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Build fix for powerpc KVM
In-reply-to: <1350389744-24627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1350389744-24627-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 17 Oct 2012 09:15:21 +1100
Message-ID: <26771.1350425721@neuling.org>
Cc: schwab@linux-m68k.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com> wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Fix build failure for powerpc KVM

What was the failure?

> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_book3s_32.h |    1 +
>  arch/powerpc/kvm/book3s_32_mmu_host.c    |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_book3s_32.h b/arch/powerpc/include/asm/kvm_book3s_32.h
> index 38040ff..ce0ef6c 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_32.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_32.h
> @@ -42,5 +42,6 @@ static inline void svcpu_put(struct kvmppc_book3s_shadow_vcpu *svcpu)
>  #define SID_SHIFT	28
>  #define ESID_MASK	0xf0000000
>  #define VSID_MASK	0x00fffffff0000000ULL
> +#define VPN_SHIFT	12

Is this the fix?

>  
>  #endif /* __ASM_KVM_BOOK3S_32_H__ */
> diff --git a/arch/powerpc/kvm/book3s_32_mmu_host.c b/arch/powerpc/kvm/book3s_32_mmu_host.c
> index 00aa612..b0f625a 100644
> --- a/arch/powerpc/kvm/book3s_32_mmu_host.c
> +++ b/arch/powerpc/kvm/book3s_32_mmu_host.c
> @@ -173,8 +173,8 @@ int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *orig_pte)
>  	BUG_ON(!map);
>  
>  	vsid = map->host_vsid;
> -	vpn = (vsid << (SID_SHIFT - VPN_SHIFT)) | ((eaddr & ~ESID_MASK) >> VPN_SHIFT)
> -
> +	vpn = (vsid << (SID_SHIFT - VPN_SHIFT)) |
> +		((eaddr & ~ESID_MASK) >> VPN_SHIFT);

This just seems to be a white space change.

Mikey

>  next_pteg:
>  	if (rr == 16) {
>  		primary = !primary;
> -- 
> 1.7.10
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
