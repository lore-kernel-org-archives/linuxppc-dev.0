Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AE681A0736
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 22:05:38 +1100 (AEDT)
Subject: Re: [PATCH] KVM: powerpc: kvmppc_visible_gpa can be boolean
To: Yaowei Bai <baiyaowei@cmss.chinamobile.com>, agraf@suse.sz,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 gleb@kernel.org
References: <1447643424-4058-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <564C5B6B.8070305@redhat.com>
Date: Wed, 18 Nov 2015 12:05:15 +0100
MIME-Version: 1.0
In-Reply-To: <1447643424-4058-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/11/2015 04:10, Yaowei Bai wrote:
> In another patch kvm_is_visible_gfn is maken return bool due to this
> function only returns zero or one as its return value, let's also make
> kvmppc_visible_gpa return bool to keep consistent.
> 
> No functional change.
> 
> Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> ---
>  arch/powerpc/kvm/book3s_pr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 64891b0..70fb08d 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -512,7 +512,7 @@ static void kvmppc_patch_dcbz(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte)
>  	put_page(hpage);
>  }
>  
> -static int kvmppc_visible_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
> +static bool kvmppc_visible_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
>  {
>  	ulong mp_pa = vcpu->arch.magic_page_pa;
>  
> @@ -521,7 +521,7 @@ static int kvmppc_visible_gpa(struct kvm_vcpu *vcpu, gpa_t gpa)
>  
>  	gpa &= ~0xFFFULL;
>  	if (unlikely(mp_pa) && unlikely((mp_pa & KVM_PAM) == (gpa & KVM_PAM))) {
> -		return 1;
> +		return true;
>  	}
>  
>  	return kvm_is_visible_gfn(vcpu->kvm, gpa >> PAGE_SHIFT);
> 

Applied all three patches to kvm/queue, thanks.

Paolo
